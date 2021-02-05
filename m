Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA99311607
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Feb 2021 23:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhBEWs2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Feb 2021 17:48:28 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:45030 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232282AbhBEM4v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Feb 2021 07:56:51 -0500
X-UUID: 10d03a1a03dd4528976475067e38c23e-20210205
X-UUID: 10d03a1a03dd4528976475067e38c23e-20210205
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 527900021; Fri, 05 Feb 2021 20:55:58 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 5 Feb 2021 20:55:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 5 Feb 2021 20:55:57 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mac80211: only schedule TXQ when reasonable airtime reporting
Date:   Fri, 5 Feb 2021 20:55:54 +0800
Message-ID: <c48c3555ab2261d6b6674ac7de8203359b80b127.1612529311.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For some drivers and hardware may report faulty airtime, which ends up
with excessive hold time (~0.9s on mt7915 multiclent tests) impacting
system performance.

Although issue has been fixed in driver, but it make sense to select txqi
depends on a reasonable airtime reporting to prevent such a case from
happening again.

Tested-by: Jiao Bo <jiao.bao@mediatek.com>
Tested-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 net/mac80211/tx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6422da6690f7..0b8a8c3600f4 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3770,6 +3770,10 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 				sta->airtime_weight;
 
 		if (deficit < 0 || !aql_check) {
+			if (txqi->schedule_round == local->schedule_round[ac])
+				goto out;
+
+			txqi->schedule_round = local->schedule_round[ac];
 			list_move_tail(&txqi->schedule_order,
 				       &local->active_txqs[txqi->txq.ac]);
 			goto begin;
-- 
2.18.0

