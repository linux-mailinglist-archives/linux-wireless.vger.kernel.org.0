Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC4F666C2D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 14:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfGLMJw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 08:09:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfGLMJv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 08:09:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 721FEC01F278;
        Fri, 12 Jul 2019 12:09:51 +0000 (UTC)
Received: from localhost (unknown [10.40.205.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6B4B600CD;
        Fri, 12 Jul 2019 12:09:50 +0000 (UTC)
Date:   Fri, 12 Jul 2019 14:09:50 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Jakub Kicinski <kubakici@wp.pl>
Subject: [PATCH] mt7601u: use params->ssn value directly
Message-ID: <20190712120949.GA21396@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 12 Jul 2019 12:09:51 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There is no point to use pointer to params->ssn.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/mediatek/mt7601u/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt7601u/main.c b/drivers/net/wireless/mediatek/mt7601u/main.c
index 89a7b1234ffb..72e608cc53af 100644
--- a/drivers/net/wireless/mediatek/mt7601u/main.c
+++ b/drivers/net/wireless/mediatek/mt7601u/main.c
@@ -351,7 +351,7 @@ mt76_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct ieee80211_sta *sta = params->sta;
 	enum ieee80211_ampdu_mlme_action action = params->action;
 	u16 tid = params->tid;
-	u16 *ssn = &params->ssn;
+	u16 ssn = params->ssn;
 	struct mt76_sta *msta = (struct mt76_sta *) sta->drv_priv;
 
 	WARN_ON(msta->wcid.idx > GROUP_WCID(0));
@@ -371,7 +371,7 @@ mt76_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		break;
 	case IEEE80211_AMPDU_TX_START:
-		msta->agg_ssn[tid] = *ssn << 4;
+		msta->agg_ssn[tid] = ssn << 4;
 		ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
-- 
2.20.1

