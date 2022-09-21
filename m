Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C6E5BF33F
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Sep 2022 04:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiIUCEq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 22:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiIUCEn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 22:04:43 -0400
Received: from smtp12.infineon.com (smtp12.infineon.com [217.10.52.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D4E11A29
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 19:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1663725882; x=1695261882;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=guAvUiYyxUxSo4+uJ/yxHXQaabETbxkWZIEidVuxsEw=;
  b=m89foYQQkQXAg4YJ0NwWOk5qd1LKC6bhbW4kBAxFNnnSmXCxyMdXrc7W
   Oe4peODNfLBtZWa+REkZZDC5IPq297Iwug/ukffPsXZwJz8cDxwFBm4CA
   EJiW4AY3dxT2tHt+Hb3b5O9n9jaSv9zaicGlRDgefLP07RYZYDsqTbbXQ
   I=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="318191312"
X-IronPort-AV: E=Sophos;i="5.93,332,1654552800"; 
   d="scan'208";a="318191312"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 04:04:40 +0200
Received: from MUCSE812.infineon.com (MUCSE812.infineon.com [172.23.29.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 04:04:39 +0200 (CEST)
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 21 Sep
 2022 04:04:39 +0200
Received: from mailrelay-cypress4.infineon.com (172.23.18.56) by
 SMTP-MailRelay2.infineon.com (172.23.29.9) with Microsoft SMTP Server id
 15.2.986.29; Wed, 21 Sep 2022 04:04:39 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="258959940"
X-IronPort-AV: E=Sophos;i="5.93,332,1654552800"; 
   d="scan'208";a="258959940"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress4.infineon.com with ESMTP; 21 Sep 2022 04:04:38 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Tue, 20 Sep 2022
 21:04:37 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 462CE10038C;
        Tue, 20 Sep 2022 21:00:35 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 3D0C29806AB; Tue, 20 Sep 2022 21:00:35 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH 0/3] brcmfmac: Support DPP feature series
Date:   Tue, 20 Sep 2022 20:59:48 -0500
Message-ID: <20220921015951.16178-1-ian.lin@infineon.com>
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

Support DPP feature and related fix.

Kurt Lee (3):
  brcmfmac: Support DPP feature
  brcmfmac: Fix interoperating DPP and other encryption network access
  brcmfmac: Fix connecting enterprise AP failure

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 152 ++++++++++--------
 .../broadcom/brcm80211/brcmfmac/p2p.c         |  77 +++++++--
 .../broadcom/brcm80211/brcmfmac/p2p.h         |   4 +-
 .../broadcom/brcm80211/include/brcmu_wifi.h   |   5 +
 4 files changed, 158 insertions(+), 80 deletions(-)

-- 
2.25.0

