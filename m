Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AE15EB8ED
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 05:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiI0Dlv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Sep 2022 23:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiI0Dlt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Sep 2022 23:41:49 -0400
Received: from smtp12.infineon.com (smtp12.infineon.com [217.10.52.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6EFAD991
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 20:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664250109; x=1695786109;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2ONCkk7OhZzwRGvzxtUynZ1R2RbP19JEi8VWDhjSqaI=;
  b=QSMrdfrFSRVyJW68l6a2lmdbMFxSG0n5a8/hgJRyoQIhvsM3Pa2tZPTG
   AjhGdaSLXssEQ3zFRQIYHvvei3pdBR/K8FABD2SYw/Uc0S1dn4q6YecVB
   WluzvY48c1PJc/K+r+3WVVhf9dXAWR1LyaSIFUduWmPzfAdgMXoU7Dl2S
   A=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="319072534"
X-IronPort-AV: E=Sophos;i="5.93,348,1654552800"; 
   d="scan'208";a="319072534"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 05:41:47 +0200
Received: from MUCSE812.infineon.com (MUCSE812.infineon.com [172.23.29.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 05:41:46 +0200 (CEST)
Received: from MUCSE804.infineon.com (172.23.29.30) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 27 Sep
 2022 05:41:46 +0200
Received: from mailrelay-cypress4.infineon.com (172.23.18.56) by
 SMTP-MailRelay1.infineon.com (172.23.29.5) with Microsoft SMTP Server id
 15.2.986.29; Tue, 27 Sep 2022 05:41:46 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="260700528"
X-IronPort-AV: E=Sophos;i="5.93,348,1654552800"; 
   d="scan'208";a="260700528"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress4.infineon.com with ESMTP; 27 Sep 2022 05:41:46 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Mon, 26 Sep 2022
 22:41:43 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 831DA10038C;
        Mon, 26 Sep 2022 22:41:44 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 7B5009807FB; Mon, 26 Sep 2022 22:41:44 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH v3 0/5] Fix connect/p2p issue series
Date:   Mon, 26 Sep 2022 22:41:33 -0500
Message-ID: <20220927034138.20463-1-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix several connect and p2p issues.

Note: there will be known build warning with commit
"fix P2P device discovery failure"
 - warning: parameter ‘vif’ set but not used [-Wunused-but-set-parameter]
However the purpose is to overwrite the pointer(vif) in function parameter,
and the pointer will be used ouside the function.

Changes in v3:
  - do typecast while variable assignment in brcmf_inform_single_bss()

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

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 32 +++++++++++++++++--
 .../broadcom/brcm80211/brcmfmac/p2p.c         | 10 ++++--
 2 files changed, 37 insertions(+), 5 deletions(-)

-- 
2.25.0

