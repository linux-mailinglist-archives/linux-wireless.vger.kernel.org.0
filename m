Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BA95B7F83
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Sep 2022 05:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiINDgi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 23:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiINDgg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 23:36:36 -0400
Received: from smtp15.infineon.com (smtp15.infineon.com [217.10.52.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77865FACC
        for <linux-wireless@vger.kernel.org>; Tue, 13 Sep 2022 20:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1663126596; x=1694662596;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=90k8s6xAZ5GUbyPeEhxGXvf69N8YeRmkPzVu9qz8fD8=;
  b=SoOCWtfT9OnHITgJGVQG1ucLCJleShi0pRDzPZb2K2/kyvpBaKNmoWbj
   UbPl14jv2Wn5cs0llMlwnfi/A1qCJnjEvsb1860vYS/w9furkDwU1n7EC
   Y2b9LdHCRunkMSna79Sl/2JXN0gkEAY/ugD6kAJ50yaaxXeFFU+p49NFT
   o=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="141112748"
X-IronPort-AV: E=Sophos;i="5.93,313,1654552800"; 
   d="scan'208";a="141112748"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 05:36:34 +0200
Received: from MUCSE812.infineon.com (MUCSE812.infineon.com [172.23.29.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Wed, 14 Sep 2022 05:36:34 +0200 (CEST)
Received: from MUCSE824.infineon.com (172.23.29.55) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 05:36:33 +0200
Received: from mailrelay-cypress4.infineon.com (172.23.18.56) by
 SMTP-MailRelay3.infineon.com (172.23.29.16) with Microsoft SMTP Server id
 15.2.986.29; Wed, 14 Sep 2022 05:36:33 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="255707207"
X-IronPort-AV: E=Sophos;i="5.93,313,1654552800"; 
   d="scan'208";a="255707207"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress4.infineon.com with ESMTP; 14 Sep 2022 05:36:33 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Tue, 13 Sep 2022
 22:36:31 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id E0AF0100243;
        Tue, 13 Sep 2022 22:36:31 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 DA807980794; Tue, 13 Sep 2022 22:36:31 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH 0/5] Fix connect/p2p issue series
Date:   Tue, 13 Sep 2022 22:36:15 -0500
Message-ID: <20220914033620.12742-1-ian.lin@infineon.com>
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

Fix several connect and p2p issues.

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

