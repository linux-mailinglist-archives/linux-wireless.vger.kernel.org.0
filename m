Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D37F7C0B7
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 14:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfGaMHN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 08:07:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35026 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfGaMHN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 08:07:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 87FCF60256; Wed, 31 Jul 2019 12:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564574832;
        bh=rVH9V3it4LEiKudkuZmS2VzM+fb6oDu0Rom01crhfjs=;
        h=From:To:Cc:Subject:Date:From;
        b=aHryC/htmsQ1cZvVBJU8qHnrHRif6DN/gPTC1mgzBh81Wwfq1p2qIrky35siO1h3G
         s6OjR9ZTn5qY1Y67OpQbJ2OejeazLS5mUVp7p8lJHQTpoBDYhBWwQaqDJEgVxLdJaY
         OG9juiLhStUgu6nHze9ve/5FyoOd8QNwkrJDInCU=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C7276047C;
        Wed, 31 Jul 2019 12:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564574832;
        bh=rVH9V3it4LEiKudkuZmS2VzM+fb6oDu0Rom01crhfjs=;
        h=From:To:Cc:Subject:Date:From;
        b=aHryC/htmsQ1cZvVBJU8qHnrHRif6DN/gPTC1mgzBh81Wwfq1p2qIrky35siO1h3G
         s6OjR9ZTn5qY1Y67OpQbJ2OejeazLS5mUVp7p8lJHQTpoBDYhBWwQaqDJEgVxLdJaY
         OG9juiLhStUgu6nHze9ve/5FyoOd8QNwkrJDInCU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C7276047C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH v2] arm64: dts: qcom: qcs404: Add wifi rails in QCS404 dt node for proxy votes
Date:   Wed, 31 Jul 2019 17:37:04 +0530
Message-Id: <20190731120704.7039-1-govinds@codeaurora.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add wifi regulators in qcs404 dt node for proxy vote. Proxy votes are
required for handling driver recovery scenarios to prevent
un-clocked register access during driver recovery.

Signed-off-by: Govind Singh <govinds@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 11c0a7137823..2289b01ee9f0 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -270,6 +270,9 @@
 
 &wifi {
 	status = "okay";
+	vdd-0.8-cx-mx-supply = <&vreg_l2_1p275>;
+	vdd-1.8-xo-supply = <&vreg_l5_1p8>;
+	vdd-1.3-rfa-supply = <&vreg_l1_1p3>;
 };
 
 /* PINCTRL - additions to nodes defined in qcs404.dtsi */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

