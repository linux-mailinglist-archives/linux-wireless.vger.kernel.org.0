Return-Path: <linux-wireless+bounces-1484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A9F824234
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 14:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3C21C23E8A
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15AE224D8;
	Thu,  4 Jan 2024 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="e1s7/3EE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343AA22313
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jan 2024 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-336c5b5c163so256516f8f.1
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jan 2024 05:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704373324; x=1704978124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQIEpNJctaz16RzA/leTZqNcUN7vsgkXc8Xvi93qAho=;
        b=e1s7/3EE+MeuNW95g+yb4nI2EfzKykj8shaTLoibDu7D3m/ffNrI6tEAU6DA6QSoTA
         mbnGXGkLbXqOvSFgn1mDXvBUqyIV91SKIGuKK7zJPhRjRXPwh4eMBYE9UOX9lndUWwPw
         fCfoSjPUPU4PGZn2Q3DO5UfmCX8Ql7GfM1BtQ4AfGNg9CxcR40b4tn5XkYVhadTUsCpJ
         TFaJULVT6u5l6SYVa9Z9hqAzB6+liviUn725RIMw31MnRlyZFwUpIjUIKQN6BF2+NDnZ
         O4CwH+t/AGZoWaEy/u3AAn2Ug/tiCKBUj4FeAjcxA/5pwS+ZB9sYFG1Zkht3aWPNu4Gl
         lncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704373324; x=1704978124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQIEpNJctaz16RzA/leTZqNcUN7vsgkXc8Xvi93qAho=;
        b=cjrqLybIohpnME7JsvQDp+8G6WQT/popTW5j8r1D94VDBXZPLcR/WxVAq5TP/SpV3p
         fK+IgY4YYGF2s7/e+PxQhpkIc8ZzCKBOoQdNx+WoswYm2TYFmXPHVjcg4VbIGKB4jpdn
         Wodlt8jKYRRsZ6od+3xEYRVYd6vrngfVvUVQasQHr3TDZ5AUH3mScfhf1kOqLPjpA4Wd
         PDwSP1MOEhOTROn2z1+1b+O+QIfvZ0j0sT1SFMkpHq0PXnR8AW1+AWgqUR12OZC6QlB8
         ERcbPmuJcYYj7osq43tdKGe2sGDjYhzo7FGTHS8tk+MWRXgGIOWSdAJejcarPaYFhkPU
         dreg==
X-Gm-Message-State: AOJu0Yxkpxjk1XyyTNPJcqyS4AbN3J1gFbJP4SON4iEkMez+Ra2eUxSl
	a1poPuL7XKG7uWAD3ljQRfUdvyio4M/fUw==
X-Google-Smtp-Source: AGHT+IEYrrjaOaf5/IBZBDz2VUcMEHweLF977kWhWHW+xRF7Tv9rMBKm8dg3stU9d6EnW3pR2nQiEQ==
X-Received: by 2002:a5d:4576:0:b0:337:4f04:933c with SMTP id a22-20020a5d4576000000b003374f04933cmr318898wrc.54.1704373323681;
        Thu, 04 Jan 2024 05:02:03 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:5b69:3768:8459:8fee])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d5445000000b0033660f75d08sm32887387wrv.116.2024.01.04.05.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 05:02:03 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peng Fan <peng.fan@nxp.com>,
	Robert Richter <rrichter@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFC 1/9] arm64: dts: qcom: sm8250: describe the PCIe port
Date: Thu,  4 Jan 2024 14:01:15 +0100
Message-Id: <20240104130123.37115-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240104130123.37115-1-brgl@bgdev.pl>
References: <20240104130123.37115-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Improve the description of the PCIe topology by defining the port node
at the SoC level.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 760501c1301a..fef9c314ce55 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2197,6 +2197,16 @@ pcie0: pcie@1c00000 {
 			dma-coherent;
 
 			status = "disabled";
+
+			pcieport0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+
+				bus-range = <0x01 0xff>;
+			};
 		};
 
 		pcie0_phy: phy@1c06000 {
-- 
2.40.1


