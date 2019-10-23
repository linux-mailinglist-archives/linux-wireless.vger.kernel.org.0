Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28918E165E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2019 11:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403992AbfJWJkY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Oct 2019 05:40:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49010 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729191AbfJWJkY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Oct 2019 05:40:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6947460F5C; Wed, 23 Oct 2019 09:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571823623;
        bh=1FdIWU3NXZTyquxhr5b4dFgwvB9EwK3th1VnVW4Z/OY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e/YwuCJL/CpmhBsgGQ9w91bWFnh3KrJNASLMFVqXFyb5M5sht2xXYD48+RKvxrEHM
         9ynChkeDJXjLPDQBwdSISMb/Vu7xlmFau5E5M+DuDaDZPHOLvMapkchTOwHyPsMwKZ
         oPnOw210ycTx8ENRU6dsFkrVY0b4rMDrBsOvIebs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from govinds-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: govinds@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 615B560A1B;
        Wed, 23 Oct 2019 09:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571823622;
        bh=1FdIWU3NXZTyquxhr5b4dFgwvB9EwK3th1VnVW4Z/OY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SA3Q3TvW1Qxz3SwD8Mqw9y0ccWBX4PUNcNo3JVX41T+MwtOhHNvlg8BHnK4CW4i41
         lOOkrzrKG9L+NTHjUsQJAK/lZ0xwGZlI136b6YcdRReQfLQwGkOpBr9keyuJFABt6a
         OjZA5G2f24mLs/6OI2Y7bwxKDPZ1Zilr8NvOQ9dI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 615B560A1B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH 1/2] dt: bindings: add dt entry flag to skip SCM call for msa region
Date:   Wed, 23 Oct 2019 15:10:13 +0530
Message-Id: <20191023094014.28683-2-govinds@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191023094014.28683-1-govinds@codeaurora.org>
References: <20191023094014.28683-1-govinds@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add boolean context flag to disable SCM call for statically
mapped msa region.

Signed-off-by: Govind Singh <govinds@codeaurora.org>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.txt          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
index 81859507db67..0d868443375d 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
@@ -83,6 +83,9 @@ Optional properties:
 		    and "sky85803" etc.
 - qcom,xo-cal-data: xo cal offset to be configured in xo trim register.
 
+- qcom,msa_fixed_perm: Boolean context flag to disable SCM call for statically
+		       mapped msa region.
+
 Example (to supply PCI based wifi block details):
 
 In this example, the node is defined as child node of the PCI controller.
@@ -180,4 +183,5 @@ wifi@18000000 {
 		vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
 		memory-region = <&wifi_msa_mem>;
 		iommus = <&apps_smmu 0x0040 0x1>;
+		qcom,msa_fixed_perm;
 };
-- 
2.22.0

