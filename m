Return-Path: <linux-wireless+bounces-20515-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5440EA67D8D
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 20:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D678442600F
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 19:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769152144D9;
	Tue, 18 Mar 2025 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="murbe5Fp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864542139C1;
	Tue, 18 Mar 2025 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327809; cv=none; b=nUyFbn61ax+I/5IWSMDGmyG3eLVlTqNJkJlA3WnYelZOt4O3dfpI1oj+/rSsftYT4KECkFF2OPm0A0Gl+8aSi/q7YlXnACah8ygQQAo+C6ZBYgSe/ujrKdL/STVQ6NyQrg7DvW1xvzuHRBv47tu33duKzUBYGmiZ4lpNZp5HLm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327809; c=relaxed/simple;
	bh=brPpw9Upi2pphbjic3XdO4/cXehcdzvhX6hXEGsW1PI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kfOdA4YgYbtS47g6ys/Q8rtvSDqawKx36Nn087Nw7VtaePv2pOJy2qyzjYrQibBHmxz54Xs2aKI0pBE/4yqUati0zfnCC/6EAJ/j16kHeX8teSEaTGcqjt4+/SPqLSTYGEjF4MhX5Hw6ej+wcxH9aZqlVcrUabCgg9Gh4LQ88hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=murbe5Fp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4D6DC4CEFC;
	Tue, 18 Mar 2025 19:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742327808;
	bh=brPpw9Upi2pphbjic3XdO4/cXehcdzvhX6hXEGsW1PI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=murbe5Fp4DfgdyT0waCSisCnPNhHOnQI/lv9QrNvky5W/QEO7B960DB1hexjjxuTS
	 vbfWgAtANDVahWQ+k6G9P0nYGUkUvyQDx4Lg65yvuK6r2ecGNukph3wTXKWJlqCM60
	 uvrG6HiGbu75f6s7fqOL56INdpO2tDnYJtjoGzf4seCy8zj8Ea3/56zd8MJzljHER8
	 paWuWEXvTqJR7k6jh+IrMz7efaKnm8x/YYthmIA6Pzo+E2RfwZ6ZcVlfetKZDUWcAM
	 5kb4OCy1Dp7v2bdNX2m8rrtbrUu9FtYBkLVWPHehNIhFg2LXG7pJ/GE2RxnHX73kOb
	 BDEl/NUyDCPzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA339C35FF8;
	Tue, 18 Mar 2025 19:56:48 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Tue, 18 Mar 2025 20:56:48 +0100
Subject: [PATCH v3 5/5] dt-bindings: wireless: qcom,wcnss: Use
 wireless-controller.yaml
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-dt-bindings-network-class-v3-5-4d8d04ddfb61@ixit.cz>
References: <20250318-dt-bindings-network-class-v3-0-4d8d04ddfb61@ixit.cz>
In-Reply-To: <20250318-dt-bindings-network-class-v3-0-4d8d04ddfb61@ixit.cz>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mailing List <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, van Spriel <arend@broadcom.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Pouiller?= <jerome.pouiller@silabs.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Janne Grunau <j@jannau.net>, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=gmn5ThPDUPmISVwNn4Be9D1nVjSGuTMMZ+wDLTHXKfs=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2c/+fSLSvOOP/1NrHIs5zBZKCZkCM9H07z63p
 +w64xSd1mSJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9nP/gAKCRBgAj/E00kg
 crnBD/wKnlKViZa7j9xXS4zIroJ+mYGOGFXAK8GCBybRxkEyKbEGnWWJaeZ4bxNl+bTIr1dKClS
 G2FRnubcXBSk/w0JWDQOSw4SKJk4vvWgroqj5Nv5oaCQOxbxORBuUoOzRZMgkxxcA9w1v/g9Di7
 EQmvmzRuRxbTSfVCCHTSl4fl7zsiimAUsAzgry6WO3teaoRTlwM803VC6rNg8bnvPXtThU4w4xg
 UZ+GbUFC+FJShhA6XEWuT243WnOrlnz/9Po+usChnz+tbDy/fd3F+FyuHPOh6kwCDtZFNZSRRp5
 J36Xe2Q6Q1mzXZvJpnrI1gHsPRhWpVSV/vRyOdpcytb4XIV+L4vVIuE3cYjmI1xptluh1F9cfI9
 lg/YlbxrhwydDGSlP7PmUhk0l9fCr1/4/iEkrkVRZpLbdIAD9gbCIYza3uFBGhhCK3wPjNp2/G/
 oRDz6sTt084KYiPopdK6AMaIOXftTbnv8vvJAt/puaLkfFnTP1kf6ahdP2DUz5S4rrLXmuI+d+T
 oyDrfMmoH9Pb9MuyWcotYHxqZGToxIO+1V7WWyAHkeEhERajbFsRTTOCQALg27tCA1lYl//p9zC
 AgiOOblZW6Z17xyVVHfrhDxXs13zIz2vtAR897ISRaQhgMEZQLh09eg46bmLM9Pwlb3bqmXGHbV
 bbrM2205srJAXsw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Reference wireless-controller.yaml schema, so we can use properties
as local-mac-address or mac-address.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml
index fd6db0ca98eb7e56d7399f55c408844d5e782805..4fcae6bedfffa845ad61c776ee0b70768e9a38a5 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml
@@ -54,7 +54,7 @@ properties:
       - compatible
 
   wifi:
-    additionalProperties: false
+    unevaluatedProperties: false
     type: object
     properties:
       compatible:
@@ -88,6 +88,9 @@ properties:
       - qcom,smem-states
       - qcom,smem-state-names
 
+    allOf:
+      - $ref: /schemas/net/wireless/wireless-controller.yaml#
+
 required:
   - compatible
   - qcom,mmio

-- 
2.49.0



