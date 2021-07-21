Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AC33D18F3
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 23:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhGUUka (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 16:40:30 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24942 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229715AbhGUUka (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 16:40:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626902466; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=vArDi1udIpplxBRZqopeIC7gjgAL4qDN+Saz0J9AB0c=; b=F7g0GjXrv1Xl7oejLzKRAQkQIGIkLd/rhEi0P7piCSjr7THqp6nuaz9W9WinD4Au32KH5rwR
 tjyA45oX7/ilcrgZNnQsd56oEqnwT4njrcHoAZUCGxtxl6xmUQdlyzB/ZHKaZ43dbMT3JQo2
 GYT2qp2iLfcrqva65+zm51A+pSk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60f88fc11dd16c8788c38983 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 21:21:05
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9B80FC0091D; Wed, 21 Jul 2021 21:21:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DD544C4338A;
        Wed, 21 Jul 2021 21:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD544C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 08/12] ath11k: Avoid "No VIF found" warning message
Date:   Thu, 22 Jul 2021 00:20:25 +0300
Message-Id: <20210721212029.142388-8-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721212029.142388-1-jouni@codeaurora.org>
References: <20210721212029.142388-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Karthikeyan Periyasamy <periyasa@codeaurora.org>

Facing below warning prints when we do wifi down in multiple VAPs scenario.

warning print:

ath11k c000000.wifi: No VIF found for vdev 2
...
ath11k c000000.wifi: No VIF found for vdev 0

In ath11k_mac_get_arvif_by_vdev_id(), we iterate all the radio to get the
arvif for the requested vdev_id through ath11k_mac_get_arvif().
ath11k_mac_get_arvif() throws a warning message if the given vdev_id is
not found in the given radio. So to avoid the warning message, add
the allocated_vdev_map cross check against the given vdev_id before using
ath11k_mac_get_arvif() to ensure that vdev_id is allocated in the
given radio.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01492-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ6018 hw1.0 AHB WLAN.HK.2.4.0.1-00330-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 20121479af6e..11276617a11f 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -500,7 +500,8 @@ struct ath11k_vif *ath11k_mac_get_arvif_by_vdev_id(struct ath11k_base *ab,
 
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = rcu_dereference(ab->pdevs_active[i]);
-		if (pdev && pdev->ar) {
+		if (pdev && pdev->ar &&
+		    (pdev->ar->allocated_vdev_map & (1LL << vdev_id))) {
 			arvif = ath11k_mac_get_arvif(pdev->ar, vdev_id);
 			if (arvif)
 				return arvif;
-- 
2.25.1

