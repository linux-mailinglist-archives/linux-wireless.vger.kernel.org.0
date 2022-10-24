Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C485609D2B
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Oct 2022 10:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiJXIwn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 04:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiJXIwm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 04:52:42 -0400
Received: from smtp15.infineon.com (smtp15.infineon.com [217.10.52.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DB067CA1
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 01:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1666601560; x=1698137560;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mrYITzTThKFku7ixvBXyK5kEP/jADto8/dFwrT55jbI=;
  b=VVdbLcrwUG8sOwusuQkOq4PIeZp8uXeQYyJRdwjrmpQ41ZUQhjlEp8xW
   w0oaJKQWrZeszqgSuEB5CuRxxU7N9013G4YtBTY/3ECtOpxK7146qeNo8
   VbdhXD0JryiJkoY0Ll8V6MfUGsQxzwruVsWAjh9w86osk70OiGNHaF4NR
   4=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="146689265"
X-IronPort-AV: E=Sophos;i="5.95,207,1661810400"; 
   d="scan'208";a="146689265"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 10:52:38 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 10:52:38 +0200 (CEST)
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.30; Mon, 24 Oct
 2022 10:52:37 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay2.infineon.com (172.23.29.9) with Microsoft SMTP Server id
 15.2.986.30; Mon, 24 Oct 2022 10:52:37 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="271189439"
X-IronPort-AV: E=Sophos;i="5.95,207,1661810400"; 
   d="scan'208";a="271189439"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 24 Oct 2022 10:52:37 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Mon, 24 Oct 2022
 03:52:35 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 8F1BA10038C;
        Mon, 24 Oct 2022 03:52:35 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 8923D9807CC; Mon, 24 Oct 2022 03:52:35 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH v4 0/3] Fix connect/p2p issue series
Date:   Mon, 24 Oct 2022 03:52:12 -0500
Message-ID: <20221024085215.27616-1-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
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

Fix several connect and p2p issues.

Changes in v4:
  - remove inappropriate patch "brcmfmac: Update SSID of hidden AP while informing its bss to cfg80211 layer"
  - remove inappropriate patch "brcmfmac: fix P2P device discovery failure"
  - use the correct commit message label

Changes in v3:
  - do typecast while variable assignment in brcmf_inform_single_bss()

Changes in v2:
  - fix email address mismatch with s-o-b
  - remove unnecessary type casting


Brian Henriquez (1):
  wifi: brcmfmac: correctly remove all p2p vif

Prasanna Kerekoppa (1):
  wifi: brcmfmac: Avoiding Connection delay

Wataru Gohda (1):
  wifi: brcmfmac: Fix for when connect request is not success

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 24 ++++++++++++++++---
 .../broadcom/brcm80211/brcmfmac/p2p.c         |  8 +++++--
 2 files changed, 27 insertions(+), 5 deletions(-)

-- 
2.25.0

