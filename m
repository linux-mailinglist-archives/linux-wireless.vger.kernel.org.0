Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6CF5BF345
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Sep 2022 04:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiIUCFE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 22:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiIUCFB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 22:05:01 -0400
Received: from smtp3.infineon.com (smtp3.infineon.com [217.10.52.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037D242ADF
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 19:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1663725899; x=1695261899;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p92HHfdgHwH86gu5SEKQQOdiw99rxAz3mumEBOmu0jo=;
  b=m9rlqEz/KJ3JwY5C2lJt0RCQ9doxaOPKPdOAFxW4t/DcK7gw9M8+9soW
   Q+R5GYJPKSvWtbSeW27vRJmGsRJfQVlebpQkUPVRLvw37XMSgSWPnqgHf
   y19VNBBVLHRCIZ/Se2ZBWhqRVFvF6plu8EWXD1J8W6dzmvlsJjPBtpRWk
   M=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="1199186"
X-IronPort-AV: E=Sophos;i="5.93,332,1654552800"; 
   d="scan'208";a="1199186"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 04:04:57 +0200
Received: from MUCSE805.infineon.com (MUCSE805.infineon.com [172.23.29.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 04:04:56 +0200 (CEST)
Received: from MUCSE804.infineon.com (172.23.29.30) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 21 Sep
 2022 04:04:56 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay1.infineon.com (172.23.29.5) with Microsoft SMTP Server id
 15.2.986.29; Wed, 21 Sep 2022 04:04:56 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="261808004"
X-IronPort-AV: E=Sophos;i="5.93,332,1654552800"; 
   d="scan'208";a="261808004"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 21 Sep 2022 04:04:55 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Tue, 20 Sep 2022
 21:04:54 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id DF70E1004F5;
        Tue, 20 Sep 2022 21:02:00 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 A03D99806AB; Tue, 20 Sep 2022 21:01:59 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH 0/4] brcmfmac: Add dump_survey cfg80211 ops series
Date:   Tue, 20 Sep 2022 21:00:56 -0500
Message-ID: <20220921020100.16752-1-ian.lin@infineon.com>
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

Double Lo (1):
  brcmfmac: fix CERT-P2P:5.1.10 failure

Ramesh Rangavittal (1):
  brcmfmac: Fix authentication latency caused by OBSS stats survey

Wright Feng (2):
  brcmfmac: Add dump_survey cfg80211 ops for HostApd
    AutoChannelSelection
  brcmfmac: fix firmware trap while dumping obss stats

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 255 ++++++++++++++++++
 .../broadcom/brcm80211/brcmfmac/feature.c     |   3 +-
 .../broadcom/brcm80211/brcmfmac/feature.h     |   4 +-
 3 files changed, 260 insertions(+), 2 deletions(-)

-- 
2.25.0

