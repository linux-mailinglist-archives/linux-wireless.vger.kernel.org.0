Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CF55EEADD
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 03:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbiI2BZi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 21:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiI2BZh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 21:25:37 -0400
Received: from smtp3.infineon.com (smtp3.infineon.com [217.10.52.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B9D20F72
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 18:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664414736; x=1695950736;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4CQKyZ6vaxFFeGMenzA2UOFjxf6iUdL+/fDeatxf0xY=;
  b=GQwJg1oR+glGmnBpuUnOIZxVKKVNDLiVp85pTJvZ5MfQYkSt5BE+bvzx
   /jdNbZL3F8QRajk+cIs0DJaMifnHXDYBQzEeX3oTfBJP/sjuHMT+uAue5
   47Ue02yVJo2EEdLixmVd/LH4j1t+I3nPB+ciZqxWjlOSxuzS5Be7VGVRu
   E=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="2355166"
X-IronPort-AV: E=Sophos;i="5.93,353,1654552800"; 
   d="scan'208";a="2355166"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 03:25:34 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 03:25:33 +0200 (CEST)
Received: from MUCSE824.infineon.com (172.23.29.55) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 03:25:33 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay3.infineon.com (172.23.29.16) with Microsoft SMTP Server id
 15.2.986.29; Thu, 29 Sep 2022 03:25:33 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="264114135"
X-IronPort-AV: E=Sophos;i="5.93,353,1654552800"; 
   d="scan'208";a="264114135"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 29 Sep 2022 03:25:33 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Wed, 28 Sep 2022
 20:25:31 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id BB4D410038C;
        Wed, 28 Sep 2022 20:25:31 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 B4B50980853; Wed, 28 Sep 2022 20:25:31 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH v3 0/4] brcmfmac: Add dump_survey cfg80211 ops series
Date:   Wed, 28 Sep 2022 20:25:23 -0500
Message-ID: <20220929012527.4152-1-ian.lin@infineon.com>
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

Add dump_survey cfg80211 ops for HostApd AutoChannelSelection.
And fix related bug.

Changes in v3:
  - refine error message in brcmf_parse_dump_obss
  - fix typo in brcmf_cfg80211_dump_survey

Changes in v2:
  - refine error handling in brcmf_parse_dump_obss
  - delare variable by using stack memory in brcmf_cfg80211_dump_survey
  - provide debug message in error case of cfg80211_set_channel
  - remove unnecessary NULL assignment in brcmf_cfg80211_attach

Double Lo (1):
  brcmfmac: fix CERT-P2P:5.1.10 failure

Ramesh Rangavittal (1):
  brcmfmac: Fix authentication latency caused by OBSS stats survey

Wright Feng (2):
  brcmfmac: Add dump_survey cfg80211 ops for HostApd
    AutoChannelSelection
  brcmfmac: fix firmware trap while dumping obss stats

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 258 ++++++++++++++++++
 .../broadcom/brcm80211/brcmfmac/feature.c     |   3 +-
 .../broadcom/brcm80211/brcmfmac/feature.h     |   4 +-
 3 files changed, 263 insertions(+), 2 deletions(-)

-- 
2.25.0

