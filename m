Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A09C5EEC54
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 05:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiI2DKP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 23:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbiI2DKM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 23:10:12 -0400
Received: from smtp12.infineon.com (smtp12.infineon.com [217.10.52.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBC036DF7
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 20:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664421011; x=1695957011;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7DliypB7SEZybG3wOcfnFTxvu1ujq5jpYP30VJV9rYc=;
  b=QgBXXKmATbaY46f6J5HwTyVOmp8hVLHmYfO8Li/DZPkaDbjSrghJgN3T
   H8DtvwenxzEq0WgjRmA7L8aLKhrT4nzDcRjs8WjqsYKw+cKXPOZAXtup/
   /joaDB0kVj/dw+DqAj1XdUPh+XJyAE7/MoSKPwjM0NFr+n1jb9Ek9bzP/
   Q=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="319464492"
X-IronPort-AV: E=Sophos;i="5.93,353,1654552800"; 
   d="scan'208";a="319464492"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 05:10:09 +0200
Received: from MUCSE814.infineon.com (MUCSE814.infineon.com [172.23.29.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 05:10:08 +0200 (CEST)
Received: from MUCSE804.infineon.com (172.23.29.30) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 05:10:08 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay1.infineon.com (172.23.29.5) with Microsoft SMTP Server id
 15.2.986.29; Thu, 29 Sep 2022 05:10:08 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="264141842"
X-IronPort-AV: E=Sophos;i="5.93,353,1654552800"; 
   d="scan'208";a="264141842"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 29 Sep 2022 05:10:08 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Wed, 28 Sep 2022
 22:10:07 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id CB2A510038C;
        Wed, 28 Sep 2022 22:10:06 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 BF053980481; Wed, 28 Sep 2022 22:10:06 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH 0/3] brcmfmac: PCIE debug mechanism series
Date:   Wed, 28 Sep 2022 22:09:58 -0500
Message-ID: <20220929031001.9962-1-ian.lin@infineon.com>
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

Add several debug mechanism on PCIE operation.

Wright Feng (3):
  brcmfmac: add a timer to read console periodically in PCIE bus
  brcmfmac: return error when getting invalid max_flowrings from dongle
  brcmfmac: dump dongle memory when attaching failed

 .../broadcom/brcm80211/brcmfmac/bus.h         |   6 +
 .../broadcom/brcm80211/brcmfmac/core.c        |   3 +-
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 139 +++++++++++++++++-
 .../broadcom/brcm80211/brcmfmac/sdio.c        |   2 -
 4 files changed, 144 insertions(+), 6 deletions(-)

-- 
2.25.0

