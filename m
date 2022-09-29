Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42F55EED03
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 07:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbiI2FG2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Sep 2022 01:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiI2FG1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Sep 2022 01:06:27 -0400
Received: from smtp12.infineon.com (smtp12.infineon.com [217.10.52.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B79D4CA3D
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 22:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664427984; x=1695963984;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y1HHyhfu4GegXYwQ7rRenm2AZ0qT39s3m5KHDTJjZWA=;
  b=kghQZSZNhYFEfmX+ihjW/tIIxsSrQc9iL3ofPxUipQ65eLf9y12MkzNa
   X4+qd59j9xMHIZSuXzluom7A6KlucOsfxyWwwEFKqvM874QTike3LEES/
   q6OXTaIfMX84jOBpcdvj0sv7Bpv9GPq8R8kKkgvNRJxkZ7Xy5/kaB9B4l
   E=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="319475401"
X-IronPort-AV: E=Sophos;i="5.93,354,1654552800"; 
   d="scan'208";a="319475401"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 07:06:21 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 07:06:21 +0200 (CEST)
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 07:06:21 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay2.infineon.com (172.23.29.9) with Microsoft SMTP Server id
 15.2.986.29; Thu, 29 Sep 2022 07:06:20 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="264162883"
X-IronPort-AV: E=Sophos;i="5.93,354,1654552800"; 
   d="scan'208";a="264162883"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 29 Sep 2022 07:06:20 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Thu, 29 Sep 2022
 00:06:19 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 70F3310038C;
        Thu, 29 Sep 2022 00:06:19 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 40CE89807D1; Thu, 29 Sep 2022 00:06:19 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH 0/4] brcmfmac: Support multiple station interface series
Date:   Thu, 29 Sep 2022 00:06:10 -0500
Message-ID: <20220929050614.31518-1-ian.lin@infineon.com>
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

Support create multiple station interface.
And fix related issues.

Prasanna Kerekoppa (1):
  brcmfmac: Fix AP interface delete issue

Ting-Ying Li (1):
  brcmfmac: revise SoftAP channel setting

Wright Feng (2):
  brcmfmac: add creating station interface support
  brcmfmac: support station interface creation version 1, 2 and 3

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 306 ++++++++++++++++--
 .../broadcom/brcm80211/brcmfmac/core.h        |   1 +
 2 files changed, 272 insertions(+), 35 deletions(-)

-- 
2.25.0

