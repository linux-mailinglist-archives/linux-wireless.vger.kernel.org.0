Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28862EB751
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Jan 2021 02:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbhAFBCz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 20:02:55 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:46556 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725952AbhAFBCy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 20:02:54 -0500
X-UUID: 69ab6d3183964625b91e0cd563ee954e-20210106
X-UUID: 69ab6d3183964625b91e0cd563ee954e-20210106
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1114684851; Wed, 06 Jan 2021 09:02:09 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 Jan 2021 09:02:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 Jan 2021 09:02:06 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mac80211: check ATF flag in ieee80211_next_txq()
Date:   Wed, 6 Jan 2021 09:01:49 +0800
Message-ID: <d9aef825d186a91ff91f6a81045d49d375533b14.1609894402.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 24C95263E2E9892CB5D0A505E079E5294164C3DCAC765E6AEEA2609BA5AA4CA02000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The selected txq should be scheduled unconditionally if
NL80211_EXT_FEATURE_AIRTIME_FAIRNESS is not set by driver.

Also put the sta to the end of the active_txqs list if
deficit is negative then move on to the next txq.

Tested-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 net/mac80211/tx.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6422da6690f7..5640c9428596 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3760,14 +3760,19 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 		struct sta_info *sta = container_of(txqi->txq.sta,
 						    struct sta_info, sta);
 		bool aql_check = ieee80211_txq_airtime_check(hw, &txqi->txq);
-		s64 deficit = sta->airtime[txqi->txq.ac].deficit;
+		s64 deficit = 0;
 
 		if (aql_check)
 			found_eligible_txq = true;
 
-		if (deficit < 0)
-			sta->airtime[txqi->txq.ac].deficit +=
-				sta->airtime_weight;
+		if (wiphy_ext_feature_isset(local->hw.wiphy,
+					    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS)) {
+			deficit = sta->airtime[txqi->txq.ac].deficit;
+
+			if (deficit < 0)
+				sta->airtime[txqi->txq.ac].deficit +=
+					sta->airtime_weight;
+		}
 
 		if (deficit < 0 || !aql_check) {
 			list_move_tail(&txqi->schedule_order,
-- 
2.18.0

