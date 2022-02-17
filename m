Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8088B4B9582
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Feb 2022 02:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiBQB0i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Feb 2022 20:26:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiBQB0i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Feb 2022 20:26:38 -0500
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 17:26:24 PST
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id C8D362E088
        for <linux-wireless@vger.kernel.org>; Wed, 16 Feb 2022 17:26:24 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1645061184; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=jmad550xJb8rdWeuXWI0Vd6FHhnAbQy2dhhVnu50hH0=; b=jly8StzfoOHb62cD4GO9SuHPIiaKIQH9b3kKn0BVErAVAJHy+JPV307ul61kbZ2lRn7WErDY
 /IaeSF64qaC0e6llbNG4bo8YeYzM5FSdORkRtFg7qQY34YCZOt8LXI7jxA4DeQZXH3oL+XV6
 NdNrqhZmius+EagBBWWBNk8C0cM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 620da3111f9ef77c946ab727 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Feb 2022 01:21:21
 GMT
Sender: pradeepc=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9025AC43617; Thu, 17 Feb 2022 01:21:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A316DC4338F;
        Thu, 17 Feb 2022 01:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A316DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH v10 0/3] ath11k: add HE radiotap header support
Date:   Wed, 16 Feb 2022 17:21:09 -0800
Message-Id: <20220217012112.31211-1-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series address review comments from previous revision:
https://patchwork.kernel.org/project/linux-wireless/list/?series=328291&state=%2A&archive=both

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01725-QCAHKSWPL_SILICONZ-1

changes in v10:
 - rebase

changes in v9:
 - maintain rate_info in local

changes in v8:
 - move ieee80211_tx_status_ext out of spin lock

changes in v7:
 - use generic radiotap HE fields from
	include/net/ieee80211_radiotap.h
 - fix converting gi and ltf enums to match nl80211 enums when
	updating radiotap headers.
 - fix sparse warnings

Pradeep Kumar Chitrapu (3):
  ath11k: switch to using ieee80211_tx_status_ext()
  ath11k: decode HE status tlv
  ath11k: translate HE status to radiotap format

 drivers/net/wireless/ath/ath11k/dp_rx.c    | 111 ++++-
 drivers/net/wireless/ath/ath11k/dp_tx.c    |  32 +-
 drivers/net/wireless/ath/ath11k/hal_desc.h |   1 +
 drivers/net/wireless/ath/ath11k/hal_rx.c   | 471 ++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/hal_rx.h   | 135 +++++-
 5 files changed, 670 insertions(+), 80 deletions(-)

-- 
2.17.1

