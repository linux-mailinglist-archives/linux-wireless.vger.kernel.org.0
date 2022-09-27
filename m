Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63645EB8F2
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 05:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiI0DmB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Sep 2022 23:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiI0Dl5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Sep 2022 23:41:57 -0400
Received: from smtp12.infineon.com (smtp12.infineon.com [217.10.52.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B08ACA0F
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 20:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664250114; x=1695786114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oFM2uhYPRUF0wpUQfUjmHmeBa7D8iHYyJsyi+cvFRTg=;
  b=GBF1aaKgp4BE85gKgaOqMMxKyH/ORzjNjCiHGU3jY2qOv1LPzCx0Ljoc
   c5GumFiv9TBBtlskIuTcXG/O7+OG7TRcf9Rabth5DYRsK6qqCweo4D1VF
   27oRTEsY6L2zAaAJMI6kp9DV3Y+/47C0WFOhZgb+7pft9g4Z6jPNzQqqI
   U=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="319072544"
X-IronPort-AV: E=Sophos;i="5.93,348,1654552800"; 
   d="scan'208";a="319072544"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 05:41:53 +0200
Received: from MUCSE812.infineon.com (MUCSE812.infineon.com [172.23.29.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 05:41:52 +0200 (CEST)
Received: from MUCSE804.infineon.com (172.23.29.30) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 27 Sep
 2022 05:41:52 +0200
Received: from mailrelay-cypress4.infineon.com (172.23.18.56) by
 SMTP-MailRelay1.infineon.com (172.23.29.5) with Microsoft SMTP Server id
 15.2.986.29; Tue, 27 Sep 2022 05:41:51 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="260700533"
X-IronPort-AV: E=Sophos;i="5.93,348,1654552800"; 
   d="scan'208";a="260700533"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress4.infineon.com with ESMTP; 27 Sep 2022 05:41:51 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Mon, 26 Sep 2022
 22:41:49 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 3EB1C1004E1;
        Mon, 26 Sep 2022 22:41:50 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 39B719807FB; Mon, 26 Sep 2022 22:41:50 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH v3 5/5] brcmfmac: fix P2P device discovery failure
Date:   Mon, 26 Sep 2022 22:41:38 -0500
Message-ID: <20220927034138.20463-6-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220927034138.20463-1-ian.lin@infineon.com>
References: <20220927034138.20463-1-ian.lin@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>

Commit 2de64ca7c9fa ("brcmfmac: p2p: Deal with set but unused
variables") removed the setting of vif for p2p device discovery in
brcmf_p2p_scan_prep(), causing the discovery failure.

Add back the setting to brcmf_p2p_scan_prep() to fix this.

Fixes: 2de64ca7c9fa ("brcmfmac: p2p: Deal with set but unused variables")
Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index b3d706a2e68c..068f8fe0e0c4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -912,6 +912,8 @@ int brcmf_p2p_scan_prep(struct wiphy *wiphy,
 		if (err)
 			return err;
 
+		vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
+
 		/* override .run_escan() callback. */
 		cfg->escan_info.run = brcmf_p2p_run_escan;
 	}
-- 
2.25.0

