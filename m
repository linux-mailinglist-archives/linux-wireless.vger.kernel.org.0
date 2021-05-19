Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB2E38971D
	for <lists+linux-wireless@lfdr.de>; Wed, 19 May 2021 21:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhEST55 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 15:57:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38710 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232233AbhEST55 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 15:57:57 -0400
X-UUID: fb981334ad6d41c1b13fd02542db989f-20210520
X-UUID: fb981334ad6d41c1b13fd02542db989f-20210520
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1035569857; Thu, 20 May 2021 03:56:33 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 May 2021 03:56:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 May 2021 03:56:26 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [RFC PATCH 2/4] mac80211: minstrel_ht: fix minstrel_aggr_check for encap offload
Date:   Thu, 20 May 2021 03:56:22 +0800
Message-ID: <4e50d38c98c407825c6897a034fee3ba6366b0ad.1621453091.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <a959135d3fe21118f38c33fc9ffb18124c1ef7ce.1621453091.git.ryder.lee@mediatek.com>
References: <a959135d3fe21118f38c33fc9ffb18124c1ef7ce.1621453091.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Avoid checking ieee80211_hdr to support encap offload.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 net/mac80211/rc80211_minstrel_ht.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 6487b05da6fa..55ff93c803ac 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1179,19 +1179,24 @@ static void
 minstrel_aggr_check(struct ieee80211_sta *pubsta, struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
 	u16 tid;
 
 	if (skb_get_queue_mapping(skb) == IEEE80211_AC_VO)
 		return;
 
-	if (unlikely(!ieee80211_is_data_qos(hdr->frame_control)))
+	if (unlikely(!pubsta->wme))
+		return;
+
+	if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
+	    unlikely(!ieee80211_is_data_qos(hdr->frame_control)))
 		return;
 
 	if (unlikely(skb->protocol == cpu_to_be16(ETH_P_PAE)))
 		return;
 
-	tid = ieee80211_get_tid(hdr);
+	tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
 	if (likely(sta->ampdu_mlme.tid_tx[tid]))
 		return;
 
-- 
2.18.0

