Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90823FABA1
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Aug 2021 15:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbhH2NOQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Aug 2021 09:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbhH2NOL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Aug 2021 09:14:11 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89802C0612AD
        for <linux-wireless@vger.kernel.org>; Sun, 29 Aug 2021 06:13:18 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g13so25234793lfj.12
        for <linux-wireless@vger.kernel.org>; Sun, 29 Aug 2021 06:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L38kgQv//emLd4ZPZWGNBDSkLJU2AA0/25feolL0iIY=;
        b=PKOPo4eo6O7r2pbSVyV6dlmRizAKPHv8Gsi1JEwGmBrBuRsuag0tYpek2/JgmUOwQI
         eVFwhDETUXPLgR8sqFRnl1Q/NXsfBaalYtozrjVt1zSW4vhaaLwkiOkdqVy7n4hNzstj
         4Kr8V+J00IjPN7i9vl4uwT7qwydvj33nnjbnDXSIVf2runmfYgKiJ5rbl7rGo4kWgT8/
         QARJ+34wCmWZT3/MmpDRYMF8tOsKV8N5bV8r1nh60A0q4JBOwdzpM7PkX0YVIWfwTzIS
         cu/p6/61SkR9cLiDvx36/rJC00sTqlp+HtOapdQaMvI53wVJlbTYPoF/YZz5nllo64ET
         MjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L38kgQv//emLd4ZPZWGNBDSkLJU2AA0/25feolL0iIY=;
        b=iqHnkOnSYJFE7IzlIZmmpDRmyPyluIgw4vyZsn3MeLQDJ+puag1x7J6S983b2HMR39
         rCo/5/youF7vnPexR8Y+69eg42/HLjb964mv0JX6P4Vk8Zgsz248HG+qSUr8VvTdkZny
         HxHStKo0KmlIXQZsEwIxDJYU23OioBFdl/aArIch/5KHblEXeJjaJGKCsYPprHb7VmEk
         hlxrG2LrsM6u2VPGOEFXU5QlOrrAzSWp8rIGPEdtdYjVWC/5B75uoXWRrh7BHB1VGJcW
         FuGrNF5is94lYHuvCNLCkIRhurPKq1uhYVpJeazh4Da1QFebYkfsvWhUMj1X2EhKtwnF
         b/lw==
X-Gm-Message-State: AOAM532UduanLn6ZSWUUJJvgu6ub7nmySlJpLevROjEML2sMJ8zzsLfE
        WiI5NdinzdMuy0fHQLcM2q3ldQ==
X-Google-Smtp-Source: ABdhPJzdn7I12oW46O5UIXj/wovt7fy2VV2ahAwxWW+a4IFWY/AUt0BBSKGBtjDcX3VqOkSXoXKlaQ==
X-Received: by 2002:ac2:4c41:: with SMTP id o1mr10394337lfk.52.1630242796938;
        Sun, 29 Aug 2021 06:13:16 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id x13sm712503lfq.262.2021.08.29.06.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 06:13:16 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [RFC v2 09/13] arm64: dts: qcom: sdm845-db845c: switch bt+wifi to qca power sequencer
Date:   Sun, 29 Aug 2021 16:13:01 +0300
Message-Id: <20210829131305.534417-10-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210829131305.534417-1-dmitry.baryshkov@linaro.org>
References: <20210829131305.534417-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Switch sdm845-db845c device tree to use new power sequencer driver
rather than separate regulators.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 21 ++++++++++++++-------
 arch/arm64/boot/dts/qcom/sdm845.dtsi       |  6 ++++++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 2d5533dd4ec2..a6a34a959a91 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -629,6 +629,16 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+&qca_pwrseq {
+	status = "okay";
+
+	vddio-supply = <&vreg_s4a_1p8>;
+
+	vddxo-supply = <&vreg_l7a_1p8>;
+	vddrf-supply = <&vreg_l17a_1p3>;
+	vddch0-supply = <&vreg_l25a_3p3>;
+};
+
 &sdhc_2 {
 	status = "okay";
 
@@ -916,10 +926,8 @@ &uart6 {
 	bluetooth {
 		compatible = "qcom,wcn3990-bt";
 
-		vddio-supply = <&vreg_s4a_1p8>;
-		vddxo-supply = <&vreg_l7a_1p8>;
-		vddrf-supply = <&vreg_l17a_1p3>;
-		vddch0-supply = <&vreg_l25a_3p3>;
+		bt-pwrseq = <&qca_pwrseq 1>;
+
 		max-speed = <3200000>;
 	};
 };
@@ -1036,9 +1044,8 @@ &wifi {
 	status = "okay";
 
 	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
-	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
-	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
-	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
+
+	wifi-pwrseq = <&qca_pwrseq 0>;
 
 	qcom,snoc-host-cap-8bit-quirk;
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0a86fe71a66d..78e889b2c8dd 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1051,6 +1051,12 @@ psci {
 		method = "smc";
 	};
 
+	qca_pwrseq: qca-pwrseq {
+		compatible = "qcom,wcn3990-pwrseq";
+		#pwrseq-cells = <1>;
+		status = "disabled";
+	};
+
 	soc: soc@0 {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.33.0

