Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BFF3ABD9D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 22:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhFQUlX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 16:41:23 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:59612 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232573AbhFQUlW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 16:41:22 -0400
X-UUID: 3193de31d3c642adadadacdb2e7e7bb5-20210618
X-UUID: 3193de31d3c642adadadacdb2e7e7bb5-20210618
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 663607349; Fri, 18 Jun 2021 04:39:09 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Jun 2021 04:39:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Jun 2021 04:39:02 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 1/3] mac80211: check per vif offload_flags in Tx path
Date:   Fri, 18 Jun 2021 04:38:59 +0800
Message-ID: <177785418cf407808bf3a44760302d0647076990.1623961575.git.ryder.lee@mediatek.com>
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
v2: drop a TX_FRAG_LIST condition
---
 net/mac80211/tx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 0a4bc9e08637..db0d26d19f91 100644
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
 
-- 
2.18.0

