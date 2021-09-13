Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4F3409FB1
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Sep 2021 00:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238281AbhIMWdp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 18:33:45 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:45599 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244994AbhIMWdm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 18:33:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631572346; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=+IIrtwkfgZjcd2GkgtaMi+ekH0Vm4CAKO94p+w0YbFk=; b=a6YXY1syTG/OKhZVf3ze+Us54nSd6aH4m7iHwm0r85+0fKwHcNXQAs3QCT6bQegUaYX15gRs
 e2UwshlQgkSL7pqdjuW1nztkWeIRBpzHb61FSbibAqrQPz24hEHpgAVOtW/knS83EG9X1fot
 qzRPDB35T2fXOEKPcwDmxDTGQX8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 613fd166e0f78151d643332a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Sep 2021 22:32:06
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9AEA1C43618; Mon, 13 Sep 2021 22:32:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-72-211-nat.elisa-mobile.fi [85.76.72.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A4BFC4338F;
        Mon, 13 Sep 2021 22:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 2A4BFC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>
Subject: [PATCH 0/5] ath11k: Change htt stats display logic
Date:   Tue, 14 Sep 2021 01:31:43 +0300
Message-Id: <20210913223148.208026-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Seevalamuthu Mariappan <seevalam@codeaurora.org>

This patchsets modified htt stats display logic by removing
all temporary array usage to avoid stats truncation.

Seevalamuthu Mariappan (4):
  ath11k: Rename macro ARRAY_TO_STRING to PRINT_ARRAY_TO_BUF
  ath11k: Replace HTT_DBG_OUT with scnprintf
  ath11k: Remove htt stats fixed size array usage
  ath11k: Change masking and shifting in htt stats

Venkateswara Naralasetty (1):
  ath11k: add HTT stats support for new stats

 drivers/net/wireless/ath/ath11k/debugfs.h     |    4 +
 .../wireless/ath/ath11k/debugfs_htt_stats.c   | 4344 +++++++++--------
 .../wireless/ath/ath11k/debugfs_htt_stats.h   |  226 +
 drivers/net/wireless/ath/ath11k/debugfs_sta.c |    8 +-
 drivers/net/wireless/ath/ath11k/dp.h          |    7 +
 5 files changed, 2463 insertions(+), 2126 deletions(-)

-- 
2.25.1

