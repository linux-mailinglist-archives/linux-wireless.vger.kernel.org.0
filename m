Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BA343AB0C
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 06:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhJZETA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 00:19:00 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:57628 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhJZESz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 00:18:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635221791; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=pG7GbOM48JCa3FPG5h4IkjmU+DyMJAn5xzgQw7KY/nw=; b=Uo0HjAOu/MPn8lY9aU6SrtMI7NTSKbdbArRnAZ8xWBkZ2KrKdWJxRmHm7NSHBTa+tDojGcc9
 Yedq+yAa9MKE3pwLWbHNSPaOJdSZSV8wgaghY+JGva96XTjdj3hJlCpgd+7TNofmn+zhDlcA
 bsIt59IYLW/kveD7o0uoqTHZw+I=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6177811ffd91319f0fc2b14a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 Oct 2021 04:16:31
 GMT
Sender: bqiang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2888BC43460; Tue, 26 Oct 2021 04:16:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from bqiang-Celadon-RN.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bqiang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2E697C4338F;
        Tue, 26 Oct 2021 04:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 2E697C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Baochen Qiang <bqiang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 0/7] ath11k: support one MSI vector
Date:   Tue, 26 Oct 2021 12:16:16 +0800
Message-Id: <20211026041616.4956-1-bqiang@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch set is to support one MSI vector for QCA6390.

Depends-On:
  1. ath11k: Fix crash caused by uninitialized TX ring
  https://patchwork.kernel.org/project/linux-wireless/patch/20211026011605.58615-1-quic_bqiang@quicinc.com/

Baochen Qiang (1):
  ath11k: Set IRQ affinity to CPU0 in case of one MSI vector

Carl Huang (6):
  ath11k: get msi_data again after request_irq is called
  ath11k: add CE and ext IRQ flag to indicate irq_handler
  ath11k: use ATH11K_PCI_IRQ_DP_OFFSET for DP IRQ
  ath11k: refactor multiple MSI vector implementation
  ath11k: supports one MSI vector
  ath11k: do not restore ASPM in case of single MSI vector

 drivers/net/wireless/ath/ath11k/core.h |   2 +
 drivers/net/wireless/ath/ath11k/mhi.c  |  14 +-
 drivers/net/wireless/ath/ath11k/pci.c  | 181 +++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/pci.h  |   3 +
 4 files changed, 173 insertions(+), 27 deletions(-)

-- 
2.25.1

