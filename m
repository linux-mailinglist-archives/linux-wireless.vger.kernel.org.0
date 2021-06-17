Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CF33ABC2B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 20:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhFQSzW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 14:55:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44009 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231151AbhFQSzT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 14:55:19 -0400
X-UUID: f783e27c69a743f3bb4a1fd43f7b9146-20210618
X-UUID: f783e27c69a743f3bb4a1fd43f7b9146-20210618
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 528475718; Fri, 18 Jun 2021 02:53:08 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Jun 2021 02:53:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Jun 2021 02:53:06 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/4] mac80211: check per vif offload_flags in Tx path
Date:   Fri, 18 Jun 2021 02:53:02 +0800
Message-ID: <4718d8041f908cb3249ec68c59a6854919f00752.1623955182.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

offload_flags has been introduced to indicate encap status of each interface.
An interface can encap offload at runtime, or if it has some extra limitations
it can simply override the flags, so it's more flexible to check offload_flags
in Tx path.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 net/mac80211/tx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 0a4bc9e08637..8cb1289c704a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3267,6 +3267,9 @@ static bool ieee80211_amsdu_aggregate(struct ieee80211_sub_if_data *sdata,
 	if (!ieee80211_hw_check(&local->hw, TX_AMSDU))
 		return false;
 
+	if (sdata->vif.offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED)
+		return false;
+
 	if (skb_is_gso(skb))
 		return false;
 
@@ -3695,7 +3698,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	}
 
 	if (skb_has_frag_list(skb) &&
-	    !ieee80211_hw_check(&local->hw, TX_FRAG_LIST)) {
+	    (!ieee80211_hw_check(&local->hw, TX_FRAG_LIST) ||
+	     vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED)) {
 		if (skb_linearize(skb)) {
 			ieee80211_free_txskb(&local->hw, skb);
 			goto begin;
-- 
2.18.0

