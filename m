Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EED8B13147B
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 16:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgAFPKc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 10:10:32 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:41884 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgAFPKb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 10:10:31 -0500
Received: from localhost.localdomain (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 0C6C4580074;
        Mon,  6 Jan 2020 16:10:30 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 4/4] iw: info: add missing extended flags for 5.5
Date:   Mon,  6 Jan 2020 16:10:24 +0100
Message-Id: <20200106151024.124315-5-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106151024.124315-1-markus.theil@tu-ilmenau.de>
References: <20200106151024.124315-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add missing flags and reorder TXQ and airtime related flags
next to each other again. (Thanks Toke for the hint).
---
 info.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/info.c b/info.c
index 0f24dae..04f4bd7 100644
--- a/info.c
+++ b/info.c
@@ -679,6 +679,10 @@ broken_combination:
 		ext_feat_print(tb, ACK_SIGNAL_SUPPORT,
 			       "ack signal level support");
 		ext_feat_print(tb, TXQS, "FQ-CoDel-enabled intermediate TXQs");
+		ext_feat_print(tb, AIRTIME_FAIRNESS,
+			       "airtime fairness scheduling");
+		ext_feat_print(tb, AQL,
+			       "Airtime Queue Limits (AQL)");
 		ext_feat_print(tb, SCAN_RANDOM_SN,
 			       "use random sequence numbers in scans");
 		ext_feat_print(tb, SCAN_MIN_PREQ_CONTENT,
@@ -687,8 +691,6 @@ broken_combination:
 			       "can safely replace PTK 0 when rekeying");
 		ext_feat_print(tb, ENABLE_FTM_RESPONDER,
 			       "enable FTM (Fine Time Measurement) responder");
-		ext_feat_print(tb, AIRTIME_FAIRNESS,
-			       "airtime fairness scheduling");
 		ext_feat_print(tb, AP_PMKSA_CACHING,
 			       "PMKSA caching supported in AP mode");
 		ext_feat_print(tb, SCHED_SCAN_BAND_SPECIFIC_RSSI_THOLD,
@@ -696,6 +698,7 @@ broken_combination:
 		ext_feat_print(tb, EXT_KEY_ID, "extended key ID support");
 		ext_feat_print(tb, STA_TX_PWR, "TX power control per station");
 		ext_feat_print(tb, SAE_OFFLOAD, "SAE offload support");
+		ext_feat_print(tb, VLAN_OFFLOAD, "VLAN offload support");
 	}
 
 	if (tb_msg[NL80211_ATTR_COALESCE_RULE]) {
-- 
2.24.1

