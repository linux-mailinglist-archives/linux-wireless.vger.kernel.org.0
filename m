Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65B4B5DD2B
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2019 05:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfGCD5Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Jul 2019 23:57:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38554 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfGCD5Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Jul 2019 23:57:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 11878606DC; Wed,  3 Jul 2019 03:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562126244;
        bh=lT+3JP6Q5Qzd8cH72nFr7WWzGlN+4tb3P640dP5zzwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MiNwKyVlmQvbxlJnk/JXOUsAy9aC0fwQsvvKHsHPUz+eT6cMTjFfRyX2RpzvOwlh3
         ijymBO0F5V5hNsJMZAvifj/OyM6qCrLX54JBkFMl/M9l5+4rHfWDNzEIRjQoC7xwUq
         mLqADnJTIhf6GVBogPnV7D7nIHlSbjzLmDm1z3JY=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0059D608FF;
        Wed,  3 Jul 2019 03:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562126243;
        bh=lT+3JP6Q5Qzd8cH72nFr7WWzGlN+4tb3P640dP5zzwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QzQJqv3gGuhq1avojbYfdCY5zmmXBQmXD+9r486Sd0P/gl21hRVDBnlkzBzmcG1RD
         wfMhLsGaiTPN0I15D41hrxLIEyttaa24+atCXSozWvjo7nVvOuK/rHrDDkGaXpTsGV
         lO1fhQrEFpVqlSHz+9OfIHC8RReNF+ozab5zEY+o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0059D608FF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Govind Singh <govinds@codeaurora.org>
Subject: [PATCH 3/3] arm64: dts: qcom: qcs404: Modify wifi dt node for SDM845/QCS404 devices
Date:   Wed,  3 Jul 2019 09:27:11 +0530
Message-Id: <20190703035711.25592-4-govinds@codeaurora.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703035711.25592-1-govinds@codeaurora.org>
References: <20190703035711.25592-1-govinds@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Modify the compatible string of wifi node for SDM845/QCS404 devices.
Add wifi regulators in qcs404 dt node for proxy vote. Proxy votes are
required for handling driver recovery scenarios to prevent
un-clocked register access during driver recovery.

Signed-off-by: Govind Singh <govinds@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 3 +++
 arch/arm64/boot/dts/qcom/qcs404.dtsi     | 2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi     | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 50b3589c7f15..ff81b9c5b057 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -190,6 +190,9 @@
 
 &wifi {
 	status = "okay";
+	vdd-0.8-cx-mx-supply = <&vreg_l2_1p275>;
+	vdd-1.8-xo-supply = <&vreg_l5_1p8>;
+	vdd-1.3-rfa-supply = <&vreg_l1_1p3>;
 };
 
 /* PINCTRL - additions to nodes defined in qcs404.dtsi */
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index e8fd26633d57..d9e2173cd3e9 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -480,7 +480,7 @@
 		};
 
 		wifi: wifi@a000000 {
-			compatible = "qcom,wcn3990-wifi";
+			compatible = "qcom,qcs40x-wcn39xx-wifi";
 			reg = <0xa000000 0x800000>;
 			reg-names = "membase";
 			memory-region = <&wlan_msa_mem>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 5308f1671824..fdb5fcd814f4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2235,7 +2235,7 @@
 		};
 
 		wifi: wifi@18800000 {
-			compatible = "qcom,wcn3990-wifi";
+			compatible = "qcom,sdm845-wcn39xx-wifi";
 			status = "disabled";
 			reg = <0 0x18800000 0 0x800000>;
 			reg-names = "membase";
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

