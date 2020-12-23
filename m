Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8222E16E9
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Dec 2020 04:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbgLWDDq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Dec 2020 22:03:46 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:21764 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbgLWDDo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Dec 2020 22:03:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608692604; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=hFxlRqc3Z8RzSFW+LMfGZdI3yBx375LII+pbIEEeRvI=; b=NFevUgkPHl/NRX7kxPRSYnidHVF6JIz3qHUBkvIVUldObkeyW8lyP0uu7Y4m9Y1Eds1PEAh/
 S+9XKO55RL+pKkzsJTd89NdCtIBUj6+FpCwz7TuZQkH/oqIQVfsT8Azf33kyK7EaZLyrdP54
 b2ywIDVQy35cBdws5TEnpNTiwvs=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fe2b34a7036173f4f70901a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Dec 2020 03:02:34
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 86DDAC433ED; Wed, 23 Dec 2020 03:02:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from cjhuang-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7176CC433C6;
        Wed, 23 Dec 2020 03:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7176CC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cjhuang@codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 0/6] ath11k: support one MSI vector
Date:   Tue, 22 Dec 2020 22:02:19 -0500
Message-Id: <20201223030225.2345-1-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch set is to support one MSI vector for QCA6390.

Carl Huang (6):
  ath11k: get msi_data again after request_irq is called
  ath11k: add ce and ext irq flag to indicate irq_handler
  ath11k: use ATH11K_PCI_IRQ_DP_OFFSET for dp irqx
  ath11k: refactor mulitple msi vector implementation
  ath11k: supports one MSI vector
  ath11k: do not restore ASPM in case of single MSI vector

 drivers/net/wireless/ath/ath11k/core.h |   2 +
 drivers/net/wireless/ath/ath11k/mhi.c  |  13 ++-
 drivers/net/wireless/ath/ath11k/pci.c  | 200 +++++++++++++++++++++++++++------
 drivers/net/wireless/ath/ath11k/pci.h  |   8 ++
 4 files changed, 189 insertions(+), 34 deletions(-)

-- 
2.7.4

