Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CE15E601D
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 12:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiIVKnM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 06:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiIVKnI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 06:43:08 -0400
Received: from smtp3.infineon.com (smtp3.infineon.com [217.10.52.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEA1AB196
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 03:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1663843387; x=1695379387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oFM2uhYPRUF0wpUQfUjmHmeBa7D8iHYyJsyi+cvFRTg=;
  b=Fd0ut6pJcoV8Iw9LGkb7VxwUa/0h3/obx7OUg2VRWkV8+WLjnqrjpNY1
   XqV0iv2DGHY+0juQF/E14AWV0Zc7pJWVkOn+DWx+ePTcxOPTKfG/eTpD6
   W3HncXdcLM9G4mJGduixzbvvpc0a5FLwkvm+a2oUQvEj9HwNo4+Taq6kn
   c=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="1444197"
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="1444197"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 12:43:06 +0200
Received: from MUCSE812.infineon.com (MUCSE812.infineon.com [172.23.29.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 12:43:05 +0200 (CEST)
Received: from MUCSE824.infineon.com (172.23.29.55) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 22 Sep
 2022 12:43:04 +0200
Received: from mailrelay-cypress4.infineon.com (172.23.18.56) by
 SMTP-MailRelay3.infineon.com (172.23.29.16) with Microsoft SMTP Server id
 15.2.986.29; Thu, 22 Sep 2022 12:43:04 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="259403518"
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="259403518"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress4.infineon.com with ESMTP; 22 Sep 2022 12:43:04 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Thu, 22 Sep 2022
 05:43:03 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 9104A1004E5;
        Thu, 22 Sep 2022 05:42:50 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 8EDC19807D1; Thu, 22 Sep 2022 05:42:50 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH v2 5/5] brcmfmac: fix P2P device discovery failure
Date:   Thu, 22 Sep 2022 05:42:29 -0500
Message-ID: <20220922104229.12119-6-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220922104229.12119-1-ian.lin@infineon.com>
References: <20220922104229.12119-1-ian.lin@infineon.com>
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

