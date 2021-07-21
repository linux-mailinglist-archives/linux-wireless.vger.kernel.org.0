Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6036E3D1400
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 18:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhGUPlO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 11:41:14 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:49609 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232735AbhGUPlJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 11:41:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626884505; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=uutbG6TrmR5gLYGXKim4L9LyhA7a2zQk6rMTtoe8Q1s=; b=idZnT8w3bd4fVITEq07heP5mXbrCumIpR3ZbUO2LqCSQsirrIXCSBby923XmzJq67WRveePs
 ZgE1sak6Ge+GxzQgQmSmrGzMEecIvsA1LjlWTcFuEJm8dv4FAZPBnsI1xrPHyKmBpQHNjtu/
 aEbdpYY81vJ2dE53wDHAsFj1t24=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60f8497a38fa9bfe9c33a5b9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 16:21:14
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 971A2C43217; Wed, 21 Jul 2021 16:21:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 95ACEC43460;
        Wed, 21 Jul 2021 16:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 95ACEC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>
Subject: [PATCH 0/3] ath11k: Fix no data captured in monitor co-exist mode
Date:   Wed, 21 Jul 2021 19:20:50 +0300
Message-Id: <20210721162053.46290-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Seevalamuthu Mariappan <seevalam@codeaurora.org>

In AP+monitor coexistance, monitor interface is capturing only
local traffic. This patchset changes monitor mode approach to
address monitor mode issues.

Seevalamuthu Mariappan (3):
  ath11k: move static function ath11k_mac_vdev_setup_sync to top
  ath11k: add separate APIs for monitor mode
  ath11k: monitor mode clean up to use separate APIs

 drivers/net/wireless/ath/ath11k/core.h  |  10 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c |   2 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c |   9 +-
 drivers/net/wireless/ath/ath11k/mac.c   | 429 ++++++++++++++++++++++++++++----
 4 files changed, 387 insertions(+), 63 deletions(-)

-- 
2.7.4

