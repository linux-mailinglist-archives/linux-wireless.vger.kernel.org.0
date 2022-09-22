Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BF35E600E
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 12:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiIVKmQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 06:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIVKmN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 06:42:13 -0400
Received: from smtp3.infineon.com (smtp3.infineon.com [217.10.52.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D72CA6ADD
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 03:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1663843333; x=1695379333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J7XivECDc0Wq+lm9tCH9DlBL4F20XXRaFK8Sm5s8tbs=;
  b=kFCx30NMTxGG/L4ohQzXqdVxqejMadOUT+BK5l8Nc7c2UZWzzQ/HMMFf
   tOcXybhPgXeQd6m6fUVlKDsIL8vlqNDo0z3vZbus3xMGbJo7TzuidWnt6
   2ZY0Zo+Lwb6nQC+MfOAkwaXKgMngedQ5sPg9HM95RoNJpWfDiISPZ/wBa
   o=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="1444087"
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="1444087"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 12:42:12 +0200
Received: from MUCSE803.infineon.com (MUCSE803.infineon.com [172.23.29.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 12:42:11 +0200 (CEST)
Received: from MUCSE824.infineon.com (172.23.29.55) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 22 Sep
 2022 12:42:11 +0200
Received: from mailrelay-cypress4.infineon.com (172.23.18.56) by
 SMTP-MailRelay3.infineon.com (172.23.29.16) with Microsoft SMTP Server id
 15.2.986.29; Thu, 22 Sep 2022 12:42:10 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="259403048"
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="259403048"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress4.infineon.com with ESMTP; 22 Sep 2022 12:42:10 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Thu, 22 Sep 2022
 05:42:09 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 48F901004E2;
        Thu, 22 Sep 2022 05:42:09 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 22DE59807D1; Thu, 22 Sep 2022 05:42:09 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH v2 1/4] brcmfmac: increase default max WOWL patterns to 16
Date:   Thu, 22 Sep 2022 05:41:37 -0500
Message-ID: <20220922104140.11889-2-ian.lin@infineon.com>
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

From: Ryohei Kondo <ryohei.kondo@cypress.com>

4373 has support of 16 WOWL patterns thus increasing the default value

Signed-off-by: Ryohei Kondo <ryohei.kondo@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
index c87b829adb0d..f518e025d6e4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
@@ -135,7 +135,7 @@
 /* Link Down indication in WoWL mode: */
 #define BRCMF_WOWL_LINKDOWN		(1 << 31)
 
-#define BRCMF_WOWL_MAXPATTERNS		8
+#define BRCMF_WOWL_MAXPATTERNS		16
 #define BRCMF_WOWL_MAXPATTERNSIZE	128
 
 #define BRCMF_COUNTRY_BUF_SZ		4
-- 
2.25.0

