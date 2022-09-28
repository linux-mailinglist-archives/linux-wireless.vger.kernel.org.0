Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E025ED8C3
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 11:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiI1JWh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 05:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbiI1JWf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 05:22:35 -0400
Received: from smtp12.infineon.com (smtp12.infineon.com [217.10.52.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E20065252
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 02:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664356955; x=1695892955;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Uwv0B34npPxqeRghqODRdWl0YdEpe8KfpzNWS81PrN8=;
  b=kIR285szx8M/aLCsoHtAC67W7n3XW9MAlA3pYKUFyXt+ZYxmzZIUwShf
   W0k63su4FszK0C7nJuQTLuzrW0qY5Re3zUFCHZ0H3YBHivmNSnpSdIH7X
   D2ok/8Sese9D1nnfSdKMMQ9Y13s73HKGgvFQgzYuYzTIa6i/qwEvqv+1u
   o=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="319323002"
X-IronPort-AV: E=Sophos;i="5.93,351,1654552800"; 
   d="scan'208";a="319323002"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 11:22:32 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 11:22:31 +0200 (CEST)
Received: from MUCSE804.infineon.com (172.23.29.30) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 11:22:31 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay1.infineon.com (172.23.29.5) with Microsoft SMTP Server id
 15.2.986.29; Wed, 28 Sep 2022 11:22:31 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="263927557"
X-IronPort-AV: E=Sophos;i="5.93,351,1654552800"; 
   d="scan'208";a="263927557"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 28 Sep 2022 11:22:30 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Wed, 28 Sep 2022
 04:22:30 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id D10E610038C;
        Wed, 28 Sep 2022 04:22:29 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 BD41E9807EB; Wed, 28 Sep 2022 04:22:29 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH v2 0/4] brcmfmac: Add dump_survey cfg80211 ops series
Date:   Wed, 28 Sep 2022 04:22:19 -0500
Message-ID: <20220928092223.22673-1-ian.lin@infineon.com>
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

Add dump_survey cfg80211 ops for HostApd AutoChannelSelection.
And fix related bug.

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

