Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFFC5E6018
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 12:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiIVKmz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 06:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiIVKmw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 06:42:52 -0400
Received: from smtp15.infineon.com (smtp15.infineon.com [217.10.52.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CACEAB196
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 03:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1663843371; x=1695379371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eeC/mKJAucscWbHeyY3Jftm9gKUcDKRFYYHXMYtElbc=;
  b=fqVh0GC88giB6AjmWkWrTDJBbCdOI+T8IFkdQyWCEXMoa8P0l8A2I+Up
   NH4KrF04D/QVaB2yCOBH3Hyape4bJp+E/pVMnt++mdImA+jShti45zjza
   cijFxcxXhQF7q7t/xenvNINjMbAeUQOv9n1u9DGhaML6dNveGpHUF9Hwk
   8=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="142360904"
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="142360904"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 12:42:51 +0200
Received: from MUCSE814.infineon.com (MUCSE814.infineon.com [172.23.29.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 12:42:50 +0200 (CEST)
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 22 Sep
 2022 12:42:50 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay2.infineon.com (172.23.29.9) with Microsoft SMTP Server id
 15.2.986.29; Thu, 22 Sep 2022 12:42:50 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="262244527"
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="262244527"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 22 Sep 2022 12:42:49 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Thu, 22 Sep 2022
 05:42:48 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 6674C1004E2;
        Thu, 22 Sep 2022 05:42:48 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 641769807D1; Thu, 22 Sep 2022 05:42:48 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH v2 4/5] brcmfmac: Update SSID of hidden AP while informing its bss to cfg80211 layer
Date:   Thu, 22 Sep 2022 05:42:28 -0500
Message-ID: <20220922104229.12119-5-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220922104229.12119-1-ian.lin@infineon.com>
References: <20220922104229.12119-1-ian.lin@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Syed Rafiuddeen <syed.rafiuddeen@cypress.com>

cfg80211 layer on DUT STA is disconnecting ongoing connection attempt after
receiving association response, because cfg80211 layer does not have valid
AP bss information. On association response event, brcmfmac communicates
the AP bss information to cfg80211 layer, but SSID seem to be empty in AP
bss information, and cfg80211 layer prints kernel warning and then
disconnects the ongoing connection attempt.

SSID is empty in SSID IE, but 'bi->SSID' contains a valid SSID, so
updating the SSID for hidden AP while informing its bss information
to cfg80211 layer.

Signed-off-by: Syed Rafiuddeen <syed.rafiuddeen@cypress.com>
Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 6c37da42e61b..05961ef293da 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -3003,6 +3003,7 @@ static s32 brcmf_inform_single_bss(struct brcmf_cfg80211_info *cfg,
 	u8 *notify_ie;
 	size_t notify_ielen;
 	struct cfg80211_inform_bss bss_data = {};
+	const struct brcmf_tlv *ssid = NULL;
 
 	if (le32_to_cpu(bi->length) > WL_BSS_INFO_MAX) {
 		bphy_err(drvr, "Bss info is larger than buffer. Discarding\n");
@@ -3032,6 +3033,12 @@ static s32 brcmf_inform_single_bss(struct brcmf_cfg80211_info *cfg,
 	notify_ielen = le32_to_cpu(bi->ie_length);
 	bss_data.signal = (s16)le16_to_cpu(bi->RSSI) * 100;
 
+	ssid = brcmf_parse_tlvs(notify_ie, notify_ielen, WLAN_EID_SSID);
+	if (ssid && ssid->data[0] == '\0' && ssid->len == bi->SSID_len) {
+		/* Update SSID for hidden AP */
+		memcpy(ssid->data, bi->SSID, bi->SSID_len);
+	}
+
 	brcmf_dbg(CONN, "bssid: %pM\n", bi->BSSID);
 	brcmf_dbg(CONN, "Channel: %d(%d)\n", channel, freq);
 	brcmf_dbg(CONN, "Capability: %X\n", notify_capability);
-- 
2.25.0

