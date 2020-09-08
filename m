Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7462260C9C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 09:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgIHHzb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 03:55:31 -0400
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:46772
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729447AbgIHHz3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 03:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599551728;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=ceNmipynX9KLenSWZcAj8dPNeBLaC7nNG2zl//38SQM=;
        b=GhS5ndelnxcbqcllka744N6sSivyouG4Xc8a63K4HhPuXp1XM5Jfr63bBTR1PSjr
        YuisLuItA8SzA9gV/+apzVyFWmFOLl9CYpjm8qNhZbcXQmiKCP/WO0tlAP556C8DB4d
        YsYLntlz0F2gTEV2GvVt1sslKYaYLSUGoUqE3bRw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599551728;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=ceNmipynX9KLenSWZcAj8dPNeBLaC7nNG2zl//38SQM=;
        b=Vc1tYYyWlxBCTJ4P+LIUh/005c1RvtSvUCFcVqhcLYsz79N97gqXVGQzMb/ul8QC
        X0lfSpZKzE8vo8n5KdK+zmeQa/eimAxZLVyq+kFGQoPAxFuWlLbHbJXCELyitn93xnW
        LuAWD9yW/nQ/lbm6oq6gN8InZVe6zFt0f6aT0jfc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5844EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH v7 0/3] ath11k: Add IPQ6018 support
Date:   Tue, 8 Sep 2020 07:55:28 +0000
Message-ID: <010101746cb66c27-f2a6bdf7-9699-4b43-9dee-d4614ef8fd28-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
X-SES-Outgoing: 2020.09.08-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

IPQ6018 has a 5G radio and 2G radio with 2x2
and shares IPQ8074 configuration.

Tested on: IPQ6018 WLAN.HK.2.2-02134-QCAHKSWPL_SILICONZ-1
Tested on: IPQ8074 WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1 

Anilkumar Kolli (3):
  dt: bindings: net: update compatible for ath11k
  ath11k: move target ce configs to hw_params
  ath11k: add IPQ6018 support

V2:
 - Added devicetree reviewers 
V3:
 - addressed dt bindinds comments
 - Reworked on Kalles patches
 - copied ce svc configs to hw_params
V4:
 - updated dt patch (Rob)
V5:
 - Fixes errors in 'make dt_binding_check' (Rob)
V6:
 - Rebased on latest ath.git top of tree
V7:
 - Removed hw_rev check as suggested in review(Kalle, Julian)

 .../bindings/net/wireless/qcom,ath11k.yaml         |   4 +-
 drivers/net/wireless/ath/ath11k/ahb.c              | 257 +----------
 drivers/net/wireless/ath/ath11k/core.c             |  37 ++
 drivers/net/wireless/ath/ath11k/core.h             |   8 +
 drivers/net/wireless/ath/ath11k/hw.c               | 512 +++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h               |   5 +-
 drivers/net/wireless/ath/ath11k/pci.c              | 193 +-------
 7 files changed, 581 insertions(+), 435 deletions(-)

-- 
2.7.4

