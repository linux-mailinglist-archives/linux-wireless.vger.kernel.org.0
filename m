Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047EE409BD6
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 20:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346546AbhIMSKh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 14:10:37 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:60966 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346508AbhIMSKg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 14:10:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631556560; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=kzM0pH05T/zXkE+vY1cg5uezgXBShFgu2/vn4EDvk6c=; b=ON6BvTnudh8Wy3UZwEphsnaOej+40aXWCEs35cyvfAgzbvLCkefFm53kb2noSRAm4+3DCET2
 7OI6mW01jy2FE3Gte+kw0hj4BGJ3OfSTNBK44nZHIx8/3ucvPeMunnnju3josXQttok/UpWW
 Uy31Tw7VHD46inyrSEP8Ppzkg7U=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 613f93ccec62f57c9a322151 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Sep 2021 18:09:16
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 23987C4360D; Mon, 13 Sep 2021 18:09:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-72-211-nat.elisa-mobile.fi [85.76.72.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 836B6C4338F;
        Mon, 13 Sep 2021 18:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 836B6C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>
Subject: [PATCH 0/3] ath11k: Add support for sram dump
Date:   Mon, 13 Sep 2021 21:08:59 +0300
Message-Id: <20210913180902.193874-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Baochen Qiang <bqiang@codeaurora.org>

On-board sram contains valuable infomation for debug, this patch adds
a new interface named "sram" in debugfs with which we can dump sram
content using following cmd:

        cat /sys/kernel/ath11k/<pdev name>/sram > sram.dump

Baochen Qiang (3):
  ath11k: Split PCI write/read functions
  ath11k: Move pdev debugfs creation ahead
  ath11k: Implement sram dump interface

 drivers/net/wireless/ath/ath11k/core.c    | 31 +++++---
 drivers/net/wireless/ath/ath11k/debugfs.c | 85 +++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/debugfs.h | 14 ++++
 drivers/net/wireless/ath/ath11k/hif.h     | 10 +++
 drivers/net/wireless/ath/ath11k/hw.c      | 10 +++
 drivers/net/wireless/ath/ath11k/hw.h      |  8 ++
 drivers/net/wireless/ath/ath11k/pci.c     | 91 ++++++++++++++++++-----
 7 files changed, 214 insertions(+), 35 deletions(-)

-- 
2.25.1

