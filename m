Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43207197A0B
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2020 13:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgC3LAY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Mar 2020 07:00:24 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:40240 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbgC3LAY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Mar 2020 07:00:24 -0400
Received: from sauron.tu-ilmenau.de (unknown [141.24.16.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 7D3B6580068;
        Mon, 30 Mar 2020 13:00:22 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] iw: event: log rssi value for cqm
Date:   Mon, 30 Mar 2020 13:00:27 +0200
Message-Id: <20200330110027.21541-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 event.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/event.c b/event.c
index b132b17..02e4593 100644
--- a/event.c
+++ b/event.c
@@ -122,17 +122,20 @@ static void parse_cqm_event(struct nlattr **attrs)
 
 	if (cqm[NL80211_ATTR_CQM_RSSI_THRESHOLD_EVENT]) {
 		enum nl80211_cqm_rssi_threshold_event rssi_event;
+		int32_t rssi_level = -1;
 		bool found_one = false;
 
 		rssi_event = nla_get_u32(cqm[NL80211_ATTR_CQM_RSSI_THRESHOLD_EVENT]);
+		if(cqm[NL80211_ATTR_CQM_RSSI_LEVEL])
+			rssi_level = nla_get_u32(cqm[NL80211_ATTR_CQM_RSSI_LEVEL]);
 
 		switch (rssi_event) {
 		case NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH:
-			printf("RSSI went above threshold\n");
+			printf("RSSI (%i dBm) went above threshold\n", rssi_level);
 			found_one = true;
 			break;
 		case NL80211_CQM_RSSI_THRESHOLD_EVENT_LOW:
-			printf("RSSI went below threshold\n");
+			printf("RSSI (%i dBm) went below threshold\n", rssi_level);
 			found_one = true;
 			break;
 		case NL80211_CQM_RSSI_BEACON_LOSS_EVENT:
-- 
2.26.0

