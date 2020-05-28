Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3C71E5B58
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 11:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgE1JBw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 05:01:52 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:32937 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgE1JBw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 05:01:52 -0400
Received: from legolas.fritz.box (unknown [87.147.49.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 66697580063;
        Thu, 28 May 2020 11:01:50 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 2/2] iw: print current ext feature set
Date:   Thu, 28 May 2020 11:01:39 +0200
Message-Id: <20200528090139.9879-2-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528090139.9879-1-markus.theil@tu-ilmenau.de>
References: <20200528090139.9879-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 info.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/info.c b/info.c
index 8062629..f7889fe 100644
--- a/info.c
+++ b/info.c
@@ -706,6 +706,10 @@ broken_combination:
 		ext_feat_print(tb, CONTROL_PORT_NO_PREAUTH, "disable pre-auth over nl80211 control port support");
 		ext_feat_print(tb, PROTECTED_TWT, "protected Target Wake Time (TWT) support");
 		ext_feat_print(tb, DEL_IBSS_STA, "deletion of IBSS station support");
+		ext_feat_print(tb, MULTICAST_REGISTRATIONS, "mgmt frame registration for multicast");
+		ext_feat_print(tb, BEACON_PROTECTION_CLIENT, "beacon prot. for clients support");
+		ext_feat_print(tb, SCAN_FREQ_KHZ, "scan on kHz frequency support");
+		ext_feat_print(tb, CONTROL_PORT_OVER_NL80211_TX_STATUS, "tx status for nl80211 control port support");
 	}
 
 	if (tb_msg[NL80211_ATTR_COALESCE_RULE]) {
-- 
2.26.2

