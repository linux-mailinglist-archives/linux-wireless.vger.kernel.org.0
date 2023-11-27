Return-Path: <linux-wireless+bounces-131-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 378247FACDF
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 22:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E568A281B8E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 21:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E754654A;
	Mon, 27 Nov 2023 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="CamcQrz2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC87BD;
	Mon, 27 Nov 2023 13:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
	t=1701122146; bh=aZFnOe6ebFNkRtbhg0CAmUQplZKhqM8Szl6+FvW/pp0=;
	h=From:Date:Subject:To:Cc;
	b=CamcQrz2yOEXroTzvmlYjgHtN6DjszA87lK8wLaMTZo1ba22Wk2xO6A9xe1UDTQpJ
	 n3a/IfMMxP3WJdAamwhMiH70S1Ek3vdlb00nYnSDzJ90Gc7HoGlNpdeaLCWhh5XzS7
	 D9hY3EO9knqI+cgjC1RNUdIXLCM8g9eNjPkotrco=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Mon, 27 Nov 2023 22:55:38 +0100
Subject: [PATCH v2] arm64: dts: qcom: sdm632-fairphone-fp3: Enable
 WiFi/Bluetooth
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-fp3-wcnss-v2-1-a5154fae4768@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIAFkQZWUC/23Muw7CMAyF4VepPGNUx4pUmHgP1IEWh3pJq6SEX
 pR3J3Rm/I+Ovh2iBJUI12qHIEmjjr6EOVXQDw//EtRnaTC1YarJopsYP72PEQ1Lw11j2DoL5T8
 Fcboc1r0tPWicx7AedKLf+k9JhDVSx0TMVi5Mt439/D4v6wZtzvkLnieeUqIAAAA=
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Loic Poulain <loic.poulain@linaro.org>, 
 Kalle Valo <kvalo@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=aZFnOe6ebFNkRtbhg0CAmUQplZKhqM8Szl6+FvW/pp0=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlZRBahsQcRnXMktfZ7tsnduxK14pwkjCxeT1OR
 3jwjSJb+B+JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZWUQWgAKCRBy2EO4nU3X
 VnB5D/9es1bYCSMq40ZW5SBjfWuZN1YqbQfld+RE/83WpM8TD/n+bWrFhFQJUZq3mwYmeWrzY3u
 V6M8VZv5neVCyJcMlpPdMPY+PpP+WEA0LK99VOQWKOjT4BJ+WKORWKsktW+opePuqspGP5Gicfe
 stGsn3CnElUk4o6K4dYfyvYcODsVjCa6A0IxksuwyFYkfz3C0zqXeCrTCJSa8M2qtG2DWPpARlP
 HoqTUw5IucV3t+WhsxNUHd/nojeKKkmQUnZe4MED3qIAt/lowsBDC8WE8vFWAUpVI+HDEtWNt/B
 1h/DY+no1PqBB99QdxIlKNQgzCRvAoY1XQTe2UTOTmb+opnXDpIFtlBsDBulT0CPVA8XPbq8OSB
 2vikKmsRrlFLLQdwemqDNUNs9A947zKDVdV6fcJgq8ao2//WgVLtIWqgntjH0yaFmIjB7EZi6M4
 3Mq1gvi6Rt68v+1lGjQMxSQAye7KyeNIzoZQpnUl2qXwvqyAsiv3Bf3FOmtMpNlGVO4pffiaN/E
 UuTorY6GHFedMKD8bJpTup5BMN/rjKOJcLs5JWrw+9NrI9vq6rQGFehk+KiMrHny9Sr/1m2l/Ms
 k74Udtdhmmh6imE8nBMOFfIabNcwkSBqrWhE/2gkOq8+jnXjb6mjy0XLkGF6sbm3QUBP9nD7ZPv
 hFLuTFaRK0XXzcQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Configure and enable the WCNSS which provides WiFi and Bluetooth on this
device using the WCN3680B chip.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
- Drop patches for "wcn3680b" compatible, just use "wcn3680"
- Link to v1: https://lore.kernel.org/r/20231015-fp3-wcnss-v1-0-1b311335e931@z3ntu.xyz
---
 arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
index 301eca9a4f31..476d0d40aaf9 100644
--- a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
+++ b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
@@ -239,3 +239,18 @@ &usb3 {
 &usb3_dwc3 {
 	dr_mode = "peripheral";
 };
+
+&wcnss {
+	status = "okay";
+
+	vddpx-supply = <&pm8953_l5>;
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3680";
+
+	vddxo-supply = <&pm8953_l7>;
+	vddrfa-supply = <&pm8953_l19>;
+	vddpa-supply = <&pm8953_l9>;
+	vdddig-supply = <&pm8953_l5>;
+};

---
base-commit: 5dca35cc02999418b12ad3a86f1798d0999ce6bf
change-id: 20231015-fp3-wcnss-23e83b8235f5

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


