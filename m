Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659E65B7F6C
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Sep 2022 05:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiINDcs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 23:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiINDcq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 23:32:46 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Sep 2022 20:32:45 PDT
Received: from smtp15.infineon.com (smtp15.infineon.com [217.10.52.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321035A8B0
        for <linux-wireless@vger.kernel.org>; Tue, 13 Sep 2022 20:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1663126366; x=1694662366;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/CPD5B7tt30qDpzYG4cFuizNOhLyTr/H2gK875rlL/I=;
  b=APRM8v0C2LmLVOYdFQ0f3/GD5sbcX5VFCQIPBmaS/0vnEupabREuvuhw
   sMc3ojh3luXaWbBeERqbNK5xImuWoPLAh1EXhHwHIdXxKxgCmYCVJeePR
   HB9JlT2Ece+lY8W6nnVNLtfpSyCTflWmiCgRnsQ+fRGJqKVX3+XCwxgTf
   E=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="141111480"
X-IronPort-AV: E=Sophos;i="5.93,313,1654552800"; 
   d="scan'208";a="141111480"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 05:31:41 +0200
Received: from MUCSE803.infineon.com (MUCSE803.infineon.com [172.23.29.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Wed, 14 Sep 2022 05:31:40 +0200 (CEST)
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 05:31:39 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay2.infineon.com (172.23.29.9) with Microsoft SMTP Server id
 15.2.986.29; Wed, 14 Sep 2022 05:31:39 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="258419510"
X-IronPort-AV: E=Sophos;i="5.93,313,1654552800"; 
   d="scan'208";a="258419510"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 14 Sep 2022 05:31:38 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Tue, 13 Sep 2022
 22:31:36 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id C8D1D100243;
        Tue, 13 Sep 2022 22:31:36 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 C23D4980794; Tue, 13 Sep 2022 22:31:36 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH 0/5] New chip support and update fw capabilities series 
Date:   Tue, 13 Sep 2022 22:30:57 -0500
Message-ID: <20220914033102.27893-1-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Support 54591 and 89459.
Update usage of dcmd buffer, dtim_assoc and WOWL pattern due to fw
capabilities change.

Double Lo (1):
  brcmfmac: add 54591 PCIE device

Lo(Double)Hsiang Lo (1):
  brcmfmac: increase dcmd maximum buffer size

Ramesh Rangavittal (1):
  brcmfmac: Remove the call to "dtim_assoc" IOVAR

Ryohei Kondo (1):
  brcmfmac: increase default max WOWL patterns to 16

alep@cypress.com (1):
  brcmfmac: Support 89459 pcie

 .../broadcom/brcm80211/brcmfmac/bcdc.c        |  4 ++-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 26 +------------------
 .../broadcom/brcm80211/brcmfmac/chip.c        |  3 +++
 .../broadcom/brcm80211/brcmfmac/fwil_types.h  |  2 +-
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 26 +++++++++++++++++--
 .../broadcom/brcm80211/include/brcm_hw_ids.h  |  6 ++++-
 6 files changed, 37 insertions(+), 30 deletions(-)

-- 
2.25.0

