Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BCB3AC96C
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 13:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbhFRLHN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 07:07:13 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48276 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233950AbhFRLHJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 07:07:09 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBx6-001YXx-HU; Fri, 18 Jun 2021 13:42:22 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:49 +0300
Message-Id: <iwlwifi.20210618133832.316e32d136a9.I2a12e51814258e1e1b526103894f4b9f19a91c8d@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618104156.747775-1-luca@coelho.fi>
References: <20210618104156.747775-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 24/31] mac80211: reset profile_periodicity/ema_ap
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Apparently we never clear these values, so they'll remain set
since the setting of them is conditional. Clear the values in
the relevant other cases.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/mlme.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 3eee75571650..a0d77539d1d9 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3993,10 +3993,14 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 		if (elems.mbssid_config_ie)
 			bss_conf->profile_periodicity =
 				elems.mbssid_config_ie->profile_periodicity;
+		else
+			bss_conf->profile_periodicity = 0;
 
 		if (elems.ext_capab_len >= 11 &&
 		    (elems.ext_capab[10] & WLAN_EXT_CAPA11_EMA_SUPPORT))
 			bss_conf->ema_ap = true;
+		else
+			bss_conf->ema_ap = false;
 
 		/* continue assoc process */
 		ifmgd->assoc_data->timeout = jiffies;
@@ -5734,12 +5738,16 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 					      beacon_ies->data, beacon_ies->len);
 		if (elem && elem->datalen >= 3)
 			sdata->vif.bss_conf.profile_periodicity = elem->data[2];
+		else
+			sdata->vif.bss_conf.profile_periodicity = 0;
 
 		elem = cfg80211_find_elem(WLAN_EID_EXT_CAPABILITY,
 					  beacon_ies->data, beacon_ies->len);
 		if (elem && elem->datalen >= 11 &&
 		    (elem->data[10] & WLAN_EXT_CAPA11_EMA_SUPPORT))
 			sdata->vif.bss_conf.ema_ap = true;
+		else
+			sdata->vif.bss_conf.ema_ap = false;
 	} else {
 		assoc_data->timeout = jiffies;
 		assoc_data->timeout_started = true;
-- 
2.32.0

