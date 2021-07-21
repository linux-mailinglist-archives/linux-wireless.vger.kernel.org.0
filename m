Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCC03D15E8
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 20:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbhGUR1z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 13:27:55 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:45445 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238022AbhGUR1x (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 13:27:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626890910; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=79qxDlEJwFygye60+Akm4By0+mwEEl8ruCbAsr0jVRY=; b=si72hNw/L1diBcV6dxooZkFgzHHssHIm/jiuljGcE3gbT2AL5T6/AajbqQvGmARp4Tof6in3
 gP6Ww2Uzvw/PbZW18ueQqtTVFYA+yJWlraUOM60hYrQkQMSn95ssD0o1LgIVlraNlZAXYtqN
 7PVRNJAN0uPT1+EHb6YCB+3DERc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60f86297e31d882d185bbab2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 18:08:23
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0AF6FC433D3; Wed, 21 Jul 2021 18:08:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2C0C5C433F1;
        Wed, 21 Jul 2021 18:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C0C5C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: [PATCH 0/4] ath11k: Add spectral scan support for QCN9074
Date:   Wed, 21 Jul 2021 21:08:05 +0300
Message-Id: <20210721180809.90960-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Karthikeyan Periyasamy <periyasa@codeaurora.org>

The following spectral parameters are different across platforms:

========================================================================
				IPQ8074	|	IPQ6018	|	QCN9074
========================================================================
FFT bin size			2	|	4	|	2		
FFT pad size			2	|	0	|	0
Maximum FFT bin count		512	|	512	|	1024
Summary report pad size		0	|	0	|	16
FFT report header length	16	|	16	|	24
========================================================================

To support the spectral scan on QCN9074, segregate these parameter as
configurable values under the hw params.

Karthikeyan Periyasamy (4):
  ath11k: Refactor spectral FFT bin size
  ath11k: Introduce spectral hw configurable param
  ath11k: Fix the spectral minimum FFT bin count
  ath11k: Add spectral scan support for QCN9074

 drivers/net/wireless/ath/ath11k/core.c     | 46 ++++++++++++++++++++++++------
 drivers/net/wireless/ath/ath11k/hw.h       |  9 +++++-
 drivers/net/wireless/ath/ath11k/spectral.c | 38 ++++++++++++------------
 drivers/net/wireless/ath/spectral_common.h |  1 -
 4 files changed, 65 insertions(+), 29 deletions(-)

-- 
2.7.4

