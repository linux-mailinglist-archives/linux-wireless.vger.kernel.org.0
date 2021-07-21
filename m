Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EA23D17F8
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 22:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhGUTjT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 15:39:19 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24463 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232740AbhGUTjS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 15:39:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626898794; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=xEjx6vNY4DZDrWYKr0YXN0qNDte/uAq7gYFF9drHb64=; b=sV49banNLyq3ymMnQ8R/q5IYVM1qAnReYPO2JqljjTpVUd4otrTeJo6KmfHpfEy14a8zSUor
 TKYEv449X/zG3DxfXlfP471denN4x1G3UuuOHa1TfzKUjBVbo4Rc8KjzCbpj5RppKa0pCV+z
 tcOaTDfsY7/8Mem5ONOEYEejcsc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60f8816afcf9fe7b7821c6c4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 20:19:54
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0C488C433D3; Wed, 21 Jul 2021 20:19:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E7F3C433F1;
        Wed, 21 Jul 2021 20:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E7F3C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH 0/4] ath11k: Add caldata download support from file/EEPROM
Date:   Wed, 21 Jul 2021 23:19:23 +0300
Message-Id: <20210721201927.100369-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anilkumar Kolli <akolli@codeaurora.org>

Clean up BDF download functions to add caldata load support from EEPROM. 
Remove unnecessary macros. 
Write common function to send QMI BDF download request.
Allow caldata file load support for multiple PCI devices.

Anilkumar Kolli (4):
  ath11k: use hw_params to access board_size and cal_offset
  ath11k: clean up BDF download functions
  ath11k: add caldata file for multiple radios
  ath11k: add caldata download support from EEPROM

 drivers/net/wireless/ath/ath11k/core.c |  10 +-
 drivers/net/wireless/ath/ath11k/hw.h   |   2 +-
 drivers/net/wireless/ath/ath11k/qmi.c  | 330 +++++++++++++++++++--------------
 drivers/net/wireless/ath/ath11k/qmi.h  |  18 +-
 4 files changed, 207 insertions(+), 153 deletions(-)

-- 
2.7.4

