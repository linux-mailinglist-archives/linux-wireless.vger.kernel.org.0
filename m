Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796F35E600D
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 12:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiIVKmM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 06:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIVKmL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 06:42:11 -0400
Received: from smtp3.infineon.com (smtp3.infineon.com [217.10.52.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6F2A6ADD
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 03:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1663843330; x=1695379330;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KJNgJdRVhWHy327X4o/uCiyVvPplx30pZLt6f4KYyWY=;
  b=IxZizeIvPh8cW1ERbjBXwwDCF1ZFN4oPHerL9GnA8YJPB0AqZ+qeCF+I
   ctz91V7cx6ACzSllZtufT3twqt7k+FXIzLmdtT6gnoNeVQDiVM+7PkOsA
   FhS6zvpGXh4/C76rjG09mOyvS2KK+h4A/iJcMkkChX8diWh+d4K1L/b/Y
   A=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="1444081"
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="1444081"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 12:42:09 +0200
Received: from MUCSE803.infineon.com (MUCSE803.infineon.com [172.23.29.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 12:42:08 +0200 (CEST)
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 22 Sep
 2022 12:42:07 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay2.infineon.com (172.23.29.9) with Microsoft SMTP Server id
 15.2.986.29; Thu, 22 Sep 2022 12:42:07 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="262244347"
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="262244347"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 22 Sep 2022 12:42:06 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Thu, 22 Sep 2022
 05:42:06 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id C8E0F1004E1;
        Thu, 22 Sep 2022 05:42:05 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 C34B99807D1; Thu, 22 Sep 2022 05:42:05 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH v2 0/4] New chip support and update fw capabilities series
Date:   Thu, 22 Sep 2022 05:41:36 -0500
Message-ID: <20220922104140.11889-1-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
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

Support new chip 89459.
Update usage of dcmd buffer, dtim_assoc and WOWL pattern due to fw
capabilities change.

Changes in v2:
  - rebase on latest wireless-next
  - remove commit "brcmfmac: add 54591 PCIE device" due to brcmf_bus_ops
    changed

Alexander Prutskov (1):
  brcmfmac: Support 89459 pcie

Lo(Double)Hsiang Lo (1):
  brcmfmac: increase dcmd maximum buffer size

Ramesh Rangavittal (1):
  brcmfmac: Remove the call to "dtim_assoc" IOVAR

Ryohei Kondo (1):
  brcmfmac: increase default max WOWL patterns to 16

 .../broadcom/brcm80211/brcmfmac/bcdc.c        |  4 ++-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 26 +------------------
 .../broadcom/brcm80211/brcmfmac/chip.c        |  3 +++
 .../broadcom/brcm80211/brcmfmac/fwil_types.h  |  2 +-
 .../broadcom/brcm80211/brcmfmac/pcie.c        |  4 +++
 .../broadcom/brcm80211/include/brcm_hw_ids.h  |  4 ++-
 6 files changed, 15 insertions(+), 28 deletions(-)

-- 
2.25.0

