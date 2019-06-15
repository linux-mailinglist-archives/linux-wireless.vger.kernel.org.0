Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 971BD46D25
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2019 02:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfFOAN4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 20:13:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40134 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfFOAN4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 20:13:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so1629918pla.7
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2019 17:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cwvlGwWdtc9OXX8XIoL7MJN42O5n/gGoiY+jdBHrLFw=;
        b=Gpwc7KmxcHCFzB0+BYpmatSSOU7v5DgLYvKoU9yxyBCTKLWsdWwMsXpA6CU3aVAWHw
         MRrC6OGFnMvCKMt6MQUZbNfHtkJcMU6u6sKDLukckpBrxszIabf1oquOxs0OFgI3vshv
         sA0gFSN3s8/p8C48Xww5LOD0CiIhFalex48kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cwvlGwWdtc9OXX8XIoL7MJN42O5n/gGoiY+jdBHrLFw=;
        b=fjC6fm+xM5rfKjxp5hcP0ODnHSFtktB0xA1JXub2QiG04I8go0ohP6PRBjwmnq6iB0
         vGS9QiKM9HCWOaIqfSXTL7aOu4BtBTp9a2f1OIT6C1ruoHp1jz+UiyRq6gnLb5bhJ0gb
         ck93pwEOezkCrt7s2xMQmxIJTHcP7LsEbLpwk52n+6zS6UKqMtWFXWgi3d4kMTImFWCZ
         tPYU4IXpMGMVpaqz+kQq2oAa3iBaO6EDDuEITsl3pvIPlbjDlOBT4SMuDiVzROz0S/yI
         sP3zRlXwQCPRxdXwpfMkjgvvTPWpADZOQM8vJt66JamiWz0WjwnAYR5ONTHw8k7pQAmK
         GHtg==
X-Gm-Message-State: APjAAAW37topXAF8MrR77r6+C1unRL4b4nxs8kyCSGomwrZiwTF93sP/
        AEOUFxcysIesOmfCnZxoUQZufg==
X-Google-Smtp-Source: APXvYqxV+BuIRTB3LlhOar7SSqrT2kHlsPqCi2rxz45Qk1yjRW+89Ar2AxHb7NqgqTTokTpNzCgspA==
X-Received: by 2002:a17:902:2aab:: with SMTP id j40mr54366678plb.76.1560557635362;
        Fri, 14 Jun 2019 17:13:55 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id n2sm3708253pgp.27.2019.06.14.17.13.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 17:13:54 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 5.2 1/2] mwifiex: Don't abort on small, spec-compliant vendor IEs
Date:   Fri, 14 Jun 2019 17:13:20 -0700
Message-Id: <20190615001321.241808-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Per the 802.11 specification, vendor IEs are (at minimum) only required
to contain an OUI. A type field is also included in ieee80211.h (struct
ieee80211_vendor_ie) but doesn't appear in the specification. The
remaining fields (subtype, version) are a convention used in WMM
headers.

Thus, we should not reject vendor-specific IEs that have only the
minimum length (3 bytes) -- we should skip over them (since we only want
to match longer IEs, that match either WMM or WPA formats). We can
reject elements that don't have the minimum-required 3 byte OUI.

While we're at it, move the non-standard subtype and version fields into
the WMM structs, to avoid this confusion in the future about generic
"vendor header" attributes.

Fixes: 685c9b7750bf ("mwifiex: Abort at too short BSS descriptor element")
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
It appears that commit 685c9b7750bf is on its way to 5.2, so I labeled
this bugfix for 5.2 as well.

 drivers/net/wireless/marvell/mwifiex/fw.h      | 12 +++++++++---
 drivers/net/wireless/marvell/mwifiex/scan.c    | 18 +++++++++++-------
 .../net/wireless/marvell/mwifiex/sta_ioctl.c   |  4 ++--
 drivers/net/wireless/marvell/mwifiex/wmm.c     |  2 +-
 4 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index b73f99dc5a72..1fb76d2f5d3f 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -1759,9 +1759,10 @@ struct mwifiex_ie_types_wmm_queue_status {
 struct ieee_types_vendor_header {
 	u8 element_id;
 	u8 len;
-	u8 oui[4];	/* 0~2: oui, 3: oui_type */
-	u8 oui_subtype;
-	u8 version;
+	struct {
+		u8 oui[3];
+		u8 oui_type;
+	} __packed oui;
 } __packed;
 
 struct ieee_types_wmm_parameter {
@@ -1775,6 +1776,9 @@ struct ieee_types_wmm_parameter {
 	 *   Version     [1]
 	 */
 	struct ieee_types_vendor_header vend_hdr;
+	u8 oui_subtype;
+	u8 version;
+
 	u8 qos_info_bitmap;
 	u8 reserved;
 	struct ieee_types_wmm_ac_parameters ac_params[IEEE80211_NUM_ACS];
@@ -1792,6 +1796,8 @@ struct ieee_types_wmm_info {
 	 *   Version     [1]
 	 */
 	struct ieee_types_vendor_header vend_hdr;
+	u8 oui_subtype;
+	u8 version;
 
 	u8 qos_info_bitmap;
 } __packed;
diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index c269a0de9413..e2786ab612ca 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -1361,21 +1361,25 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 			break;
 
 		case WLAN_EID_VENDOR_SPECIFIC:
-			if (element_len + 2 < sizeof(vendor_ie->vend_hdr))
-				return -EINVAL;
-
 			vendor_ie = (struct ieee_types_vendor_specific *)
 					current_ptr;
 
-			if (!memcmp
-			    (vendor_ie->vend_hdr.oui, wpa_oui,
-			     sizeof(wpa_oui))) {
+			/* 802.11 requires at least 3-byte OUI. */
+			if (element_len < sizeof(vendor_ie->vend_hdr.oui.oui))
+				return -EINVAL;
+
+			/* Not long enough for a match? Skip it. */
+			if (element_len < sizeof(wpa_oui))
+				break;
+
+			if (!memcmp(&vendor_ie->vend_hdr.oui, wpa_oui,
+				    sizeof(wpa_oui))) {
 				bss_entry->bcn_wpa_ie =
 					(struct ieee_types_vendor_specific *)
 					current_ptr;
 				bss_entry->wpa_offset = (u16)
 					(current_ptr - bss_entry->beacon_buf);
-			} else if (!memcmp(vendor_ie->vend_hdr.oui, wmm_oui,
+			} else if (!memcmp(&vendor_ie->vend_hdr.oui, wmm_oui,
 				    sizeof(wmm_oui))) {
 				if (total_ie_len ==
 				    sizeof(struct ieee_types_wmm_parameter) ||
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index ebc0e41e5d3b..74e50566db1f 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -1351,7 +1351,7 @@ mwifiex_set_gen_ie_helper(struct mwifiex_private *priv, u8 *ie_data_ptr,
 			/* Test to see if it is a WPA IE, if not, then
 			 * it is a gen IE
 			 */
-			if (!memcmp(pvendor_ie->oui, wpa_oui,
+			if (!memcmp(&pvendor_ie->oui, wpa_oui,
 				    sizeof(wpa_oui))) {
 				/* IE is a WPA/WPA2 IE so call set_wpa function
 				 */
@@ -1361,7 +1361,7 @@ mwifiex_set_gen_ie_helper(struct mwifiex_private *priv, u8 *ie_data_ptr,
 				goto next_ie;
 			}
 
-			if (!memcmp(pvendor_ie->oui, wps_oui,
+			if (!memcmp(&pvendor_ie->oui, wps_oui,
 				    sizeof(wps_oui))) {
 				/* Test to see if it is a WPS IE,
 				 * if so, enable wps session flag
diff --git a/drivers/net/wireless/marvell/mwifiex/wmm.c b/drivers/net/wireless/marvell/mwifiex/wmm.c
index 407b9932ca4d..64916ba15df5 100644
--- a/drivers/net/wireless/marvell/mwifiex/wmm.c
+++ b/drivers/net/wireless/marvell/mwifiex/wmm.c
@@ -240,7 +240,7 @@ mwifiex_wmm_setup_queue_priorities(struct mwifiex_private *priv,
 	mwifiex_dbg(priv->adapter, INFO,
 		    "info: WMM Parameter IE: version=%d,\t"
 		    "qos_info Parameter Set Count=%d, Reserved=%#x\n",
-		    wmm_ie->vend_hdr.version, wmm_ie->qos_info_bitmap &
+		    wmm_ie->version, wmm_ie->qos_info_bitmap &
 		    IEEE80211_WMM_IE_AP_QOSINFO_PARAM_SET_CNT_MASK,
 		    wmm_ie->reserved);
 
-- 
2.22.0.410.gd8fdbe21b5-goog

