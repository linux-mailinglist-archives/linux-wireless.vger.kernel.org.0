Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE9F359B0A
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 12:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhDIKHP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 06:07:15 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44304 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234412AbhDIKGT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 06:06:19 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lUnd2-000ELR-DR; Fri, 09 Apr 2021 12:40:41 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  9 Apr 2021 12:40:27 +0300
Message-Id: <iwlwifi.20210409123755.ef6c8e3dfaa6.I465afb55ca2c7d59f7bf610c6046a1fd732b4c28@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210409094028.356611-1-luca@coelho.fi>
References: <20210409094028.356611-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 14/15] mac80211: clear the beacon's CRC after channel switch
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

After channel switch, we should consider any beacon with a
CSA IE as a new switch. If the CSA IE is a leftover from
before the switch that the AP forgot to remove, we'll get
a CSA-to-Self.

This caused issues in iwlwifi where the firmware saw a beacon
with a CSA-to-Self with mode = 1 on the new channel after a
switch. The firmware considered this a new switch and closed
its queues. Since the beacon didn't change between before and
after the switch, we wouldn't handle it (the CRC is the same)
and we wouldn't let the firmware open its queues again or
disconnect if the CSA IE stays for too long.

Clear the CRC valid state after we switch to make sure that
we handle the beacon and handle the CSA IE as required.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/mlme.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 9b85adbf2cc2..792a92feeaeb 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1295,6 +1295,11 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_sub_if_data *sdata)
 
 	sdata->vif.csa_active = false;
 	ifmgd->csa_waiting_bcn = false;
+	/*
+	 * If the CSA IE is still present on the beacon after the switch,
+	 * we need to consider it as a new CSA (possibly to self).
+	 */
+	ifmgd->beacon_crc_valid = false;
 
 	ret = drv_post_channel_switch(sdata);
 	if (ret) {
-- 
2.31.0

