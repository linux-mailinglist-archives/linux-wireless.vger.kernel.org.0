Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AB85EB8F0
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 05:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiI0Dl5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Sep 2022 23:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiI0Dlz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Sep 2022 23:41:55 -0400
Received: from smtp15.infineon.com (smtp15.infineon.com [217.10.52.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AEDAD9A5
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 20:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664250113; x=1695786113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VV0Rrh4cn4/2qBioJqMSXObJwlgp7EAifYshsGdRMZU=;
  b=PyqQDZ0o1qSFFFA41im89T6zbxKrNawMvIOQrGn/V6oqQOVY5I0ng+mm
   r0nd+rCxQN9sosz1Y1m8qInmirCUqSEYdCaq5LAwJNlK9cPtyBkTV5vuZ
   swe8TK8rhN4YQJcy9Ym8qkc9baI/S43jsHPFvNWuKSv96aLLGUKqRFEzd
   c=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="142910467"
X-IronPort-AV: E=Sophos;i="5.93,348,1654552800"; 
   d="scan'208";a="142910467"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 05:41:51 +0200
Received: from MUCSE814.infineon.com (MUCSE814.infineon.com [172.23.29.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 05:41:50 +0200 (CEST)
Received: from MUCSE824.infineon.com (172.23.29.55) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 27 Sep
 2022 05:41:50 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay3.infineon.com (172.23.29.16) with Microsoft SMTP Server id
 15.2.986.29; Tue, 27 Sep 2022 05:41:50 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="263480692"
X-IronPort-AV: E=Sophos;i="5.93,348,1654552800"; 
   d="scan'208";a="263480692"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 27 Sep 2022 05:41:49 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Mon, 26 Sep 2022
 22:41:48 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id EF8B21004DF;
        Mon, 26 Sep 2022 22:41:48 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 EB0E89807FB; Mon, 26 Sep 2022 22:41:48 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH v3 4/5] brcmfmac: Update SSID of hidden AP while informing its bss to cfg80211 layer
Date:   Mon, 26 Sep 2022 22:41:37 -0500
Message-ID: <20220927034138.20463-5-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220927034138.20463-1-ian.lin@infineon.com>
References: <20220927034138.20463-1-ian.lin@infineon.com>
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
 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c   | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 6c37da42e61b..3560afe0ccfe 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -3003,6 +3003,7 @@ static s32 brcmf_inform_single_bss(struct brcmf_cfg80211_info *cfg,
 	u8 *notify_ie;
 	size_t notify_ielen;
 	struct cfg80211_inform_bss bss_data = {};
+	struct brcmf_tlv *ssid;
 
 	if (le32_to_cpu(bi->length) > WL_BSS_INFO_MAX) {
 		bphy_err(drvr, "Bss info is larger than buffer. Discarding\n");
@@ -3032,6 +3033,13 @@ static s32 brcmf_inform_single_bss(struct brcmf_cfg80211_info *cfg,
 	notify_ielen = le32_to_cpu(bi->ie_length);
 	bss_data.signal = (s16)le16_to_cpu(bi->RSSI) * 100;
 
+	ssid = (struct brcmf_tlv *)
+		brcmf_parse_tlvs(notify_ie, notify_ielen, WLAN_EID_SSID);
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

