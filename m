Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C8C5E6012
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 12:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiIVKmp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 06:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiIVKmo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 06:42:44 -0400
Received: from smtp12.infineon.com (smtp12.infineon.com [217.10.52.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30648AA358
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 03:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1663843364; x=1695379364;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3Ya2Ybe9ubQXGJlXH+nT6EPFPBPIcnY1hiQ3YRwzzDQ=;
  b=SZNqK0IGut3Jbl9r6H8ZExxnsun2G6EEaYrpEK7qtpyE8vjxFS02qeuk
   pGJPGvrUBYMol6Z/KZ2icBtYLDlvQp4D6akcllbBvUJdctmNSfCl/r/SG
   7jE/q/lsU+ic1P/rrjbU1dlPoQZmY26uc/arYLMOwUGx++VC+FgqoR4rP
   8=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="318452621"
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="318452621"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 12:42:42 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 12:42:41 +0200 (CEST)
Received: from MUCSE804.infineon.com (172.23.29.30) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 22 Sep
 2022 12:42:41 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay1.infineon.com (172.23.29.5) with Microsoft SMTP Server id
 15.2.986.29; Thu, 22 Sep 2022 12:42:41 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="262244480"
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="262244480"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 22 Sep 2022 12:42:40 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Thu, 22 Sep 2022
 05:42:39 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 7CA7C10038C;
        Thu, 22 Sep 2022 05:42:39 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 7A8259807D1; Thu, 22 Sep 2022 05:42:39 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH v2 0/5] Fix connect/p2p issue series
Date:   Thu, 22 Sep 2022 05:42:24 -0500
Message-ID: <20220922104229.12119-1-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
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

Fix several connect and p2p issues.

Changes in v2:
  - fix email address mismatch with s-o-b
  - remove unnecessary type casting

Brian Henriquez (1):
  brcmfmac: correctly remove all p2p vif

Chung-Hsien Hsu (1):
  brcmfmac: fix P2P device discovery failure

Prasanna Kerekoppa (1):
  brcmfmac: Avoiding Connection delay

Syed Rafiuddeen (1):
  brcmfmac: Update SSID of hidden AP while informing its bss to cfg80211
    layer

Wataru Gohda (1):
  brcmfmac: Fix for when connect request is not success

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 31 +++++++++++++++++--
 .../broadcom/brcm80211/brcmfmac/p2p.c         | 10 ++++--
 2 files changed, 36 insertions(+), 5 deletions(-)

-- 
2.25.0

