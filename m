Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3C2428C26
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 13:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhJKLjq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 07:39:46 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:56518 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbhJKLjo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 07:39:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633952265; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=c3zgyus+zv7Ybz/SfK5e4SgGrVIHH/0iWZu4JKhgAr8=; b=Y3QN3jlhEKwqV8SszInDz8Htftrf6K4GiXi/hI5LlIwvPbqXj6oGO3p54M8167cylhBxVJF2
 cARCDRmeShx7eVV6bpVLIu7ofMaNcJNaSQ97qKcc98i7ZHECShsE8hYOroXmHqZZTdflG2p7
 pcQqVIUEwrN4RIHpcsGASEQ0MmU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 616421f5446c6db0cb56d61f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 11:37:25
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B1AFCC43617; Mon, 11 Oct 2021 11:37:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from cjhuang-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BB44C4338F;
        Mon, 11 Oct 2021 11:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 9BB44C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 0/6] ath11k: support WoW functionalities
Date:   Mon, 11 Oct 2021 15:37:44 -0400
Message-Id: <20211011193750.4891-1-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ath11k WoW basic funtionalities are merged from ath10k such
as magic-pattern, PNO, disconnect and patterns.

Hw data filter and pktlog purge are required for ath11k.

ARP and NS offload, GTK rekey offload are new WoW features
implemented on ath11k. 

Carl Huang (6):
  ath11k: Add basic WoW functionalities
  ath11k: Add WoW net-detect functionality
  ath11k: implement hw data filter
  ath11k: purge rx pktlog when entering WoW
  ath11k: support ARP and NS offload
  ath11k: support GTK rekey offload

 drivers/net/wireless/ath/ath11k/core.c  |  29 +-
 drivers/net/wireless/ath/ath11k/core.h  |  31 ++
 drivers/net/wireless/ath/ath11k/dp_rx.c |   4 +-
 drivers/net/wireless/ath/ath11k/dp_rx.h |   2 +-
 drivers/net/wireless/ath/ath11k/htc.c   |   6 +
 drivers/net/wireless/ath/ath11k/htc.h   |   1 +
 drivers/net/wireless/ath/ath11k/mac.c   | 217 +++++++++-
 drivers/net/wireless/ath/ath11k/mac.h   |   1 +
 drivers/net/wireless/ath/ath11k/wmi.c   | 593 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h   | 343 ++++++++++++++-
 drivers/net/wireless/ath/ath11k/wow.c   | 747 ++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wow.h   |  36 ++
 12 files changed, 1984 insertions(+), 26 deletions(-)

-- 
2.7.4

