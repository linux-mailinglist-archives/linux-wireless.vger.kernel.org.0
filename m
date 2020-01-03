Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E1112F8E8
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2020 14:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgACNo3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jan 2020 08:44:29 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:47858 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727835AbgACNo3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jan 2020 08:44:29 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578059068; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=fNO2KuVzmU5dgBshcB7p+blPOPhtX1gtLSdkDstJNHs=; b=Cq+SSdREFikCcPC97lUlHuhIM/AjlQsJpaMp94G/c8+Ga3fnsQVx/KZ8scIdMZhx281t7iNA
 PPiP8FExXLYDftr0OpJc9uLcFuD71kaBGHSlaS7Lwp7hg1XCbruF2hB+A/cIkDv6I8F7VR7X
 wJPFVSq/h0sunHn/5f6D7IQnpao=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0f4538.7f5cddc45340-smtp-out-n03;
 Fri, 03 Jan 2020 13:44:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2BAEAC433CB; Fri,  3 Jan 2020 13:44:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from govinds-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: govinds)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D70E0C433A2;
        Fri,  3 Jan 2020 13:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D70E0C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     robh@kernel.org, devicetree@vger.kernel.org,
        ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH v3 1/2] dt: bindings: add dt entry flag to skip SCM call for msa region
Date:   Fri,  3 Jan 2020 19:14:13 +0530
Message-Id: <20200103134414.15457-2-govinds@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200103134414.15457-1-govinds@codeaurora.org>
References: <20200103134414.15457-1-govinds@codeaurora.org>
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
index 017128394a3e..633366dc33da 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
@@ -88,6 +88,9 @@ Optional properties:
 		    of the host capability QMI request
 - qcom,xo-cal-data: xo cal offset to be configured in xo trim register.
 
+- qcom,msa-fixed-perm: Boolean context flag to disable SCM call for statically
+		       mapped msa region.
+
 Example (to supply PCI based wifi block details):
 
 In this example, the node is defined as child node of the PCI controller.
@@ -185,4 +188,5 @@ wifi@18000000 {
 		vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
 		memory-region = <&wifi_msa_mem>;
 		iommus = <&apps_smmu 0x0040 0x1>;
+		qcom,msa-fixed-perm;
 };
-- 
2.22.0
