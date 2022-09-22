Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FB65E6010
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 12:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiIVKmV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 06:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiIVKmS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 06:42:18 -0400
Received: from smtp3.infineon.com (smtp3.infineon.com [217.10.52.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC73A6ADD
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 03:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1663843338; x=1695379338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kNR9wU5Vm6vcqABxsSLd05mCCgqaP8bKlj11QZd8VRk=;
  b=k6J70q3MvpzlcwXNxMC31jCgwse1Ry2GS5O9CIkw6G2xpmNJeV+M2DAj
   UMQogol61yjBQ3QYPFp4ZcPqJ8gR3kWCXY/kvidD1r6obGeUW0KdZXkiI
   EgQQL9f/4vmLjKPEr8HtNuxasuNg8MIIDcVRY+Oo/R5nJI6+Yry/X/5n4
   c=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="1444097"
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="1444097"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 12:42:16 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 12:42:15 +0200 (CEST)
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 22 Sep
 2022 12:42:14 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay2.infineon.com (172.23.29.9) with Microsoft SMTP Server id
 15.2.986.29; Thu, 22 Sep 2022 12:42:14 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="262244380"
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="262244380"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 22 Sep 2022 12:42:13 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Thu, 22 Sep 2022
 05:42:13 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 0526D1004E5;
        Thu, 22 Sep 2022 05:42:13 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 030D59807D1; Thu, 22 Sep 2022 05:42:13 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH v2 3/4] brcmfmac: increase dcmd maximum buffer size
Date:   Thu, 22 Sep 2022 05:41:39 -0500
Message-ID: <20220922104140.11889-4-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220922104140.11889-1-ian.lin@infineon.com>
References: <20220922104140.11889-1-ian.lin@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: "Lo(Double)Hsiang Lo" <double.lo@cypress.com>

Increase dcmd maximum buffer size to match firmware
configuration for new chips.

Signed-off-by: Lo(Double)Hsiang Lo <double.lo@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c
index 02a56edf08ba..9ec0c60b6da1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c
@@ -87,6 +87,8 @@ struct brcmf_proto_bcdc_header {
 					 * plus any space that might be needed
 					 * for bus alignment padding.
 					 */
+#define ROUND_UP_MARGIN 2048
+
 struct brcmf_bcdc {
 	u16 reqid;
 	u8 bus_header[BUS_HEADER_LEN];
@@ -470,7 +472,7 @@ int brcmf_proto_bcdc_attach(struct brcmf_pub *drvr)
 
 	drvr->hdrlen += BCDC_HEADER_LEN + BRCMF_PROT_FW_SIGNAL_MAX_TXBYTES;
 	drvr->bus_if->maxctl = BRCMF_DCMD_MAXLEN +
-			sizeof(struct brcmf_proto_bcdc_dcmd);
+			sizeof(struct brcmf_proto_bcdc_dcmd) + ROUND_UP_MARGIN;
 	return 0;
 
 fail:
-- 
2.25.0

