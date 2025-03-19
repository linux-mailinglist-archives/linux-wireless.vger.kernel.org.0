Return-Path: <linux-wireless+bounces-20534-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA42A6860A
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 08:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5D817C548
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 07:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C442517B2;
	Wed, 19 Mar 2025 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iw/oyxKl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBB8250C1E;
	Wed, 19 Mar 2025 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742370179; cv=none; b=XhzLsAy3tBnPQPRtCOdA8e5K46AA64PUYoA9JizuUmmmbAXeqR+0RrC/HQt50EnX6tR25WuuXGMf8TmIA7CJHWz8CMyMaNKsNF1S9kZKgvQxQAcHgB/snyrgDFTbz3lWIIl+MkbUSeG+9F6DTcWVwh7yfDIrt6tcCPpdnJxN3l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742370179; c=relaxed/simple;
	bh=eUFaq+yugIuksyG03BYSR72DIzc5mCrpziXwrV7Qk88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rAYK8OSNlK83iAwiiCM8VRNEqBICzl++kvfMHvsNowwOeM5nxtC6YOwRyHGKhFSh++2CtK9kzC9zCYyITCiJKBqfLgrvft0tKf4UhFkorV4BgSToQzlYki3tSe1jJTUDuZ3YRkrM5JFjPOFDSnAMQjGueMyg0I8ievwJnMEWKvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iw/oyxKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A973DC19423;
	Wed, 19 Mar 2025 07:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742370178;
	bh=eUFaq+yugIuksyG03BYSR72DIzc5mCrpziXwrV7Qk88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Iw/oyxKlws1yVmd2DHhyikObyRB0XV42JQrCHI7pEx7GMPGYWhT9UvZSgG1A7RIIg
	 K5hEoKEzwNT2aydxSWxOz9cy3z8Qyg7dmckL9cPX1+6B7ucRXGsKIpi9dB9GyyQPJl
	 rZ47jLZ6uck2NKVBKkwCSebFT3BcF9EPUnEKNP61w1pQCo40q5bW2S2is0CMISGXeE
	 RUXV/8cRGphO7efxW3O71nDE6YtC9wfbJQyg0JVsf7wGzxveHgnIlL+WKF4PwNO3/o
	 e023M190/37raBssA1ZzelYzwEKkOTlI3I5UGjfNjx4PGP1n7j8znkfOaEIgwxTT+Q
	 6qeU+c1eggajQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B23C35FFA;
	Wed, 19 Mar 2025 07:42:58 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 19 Mar 2025 08:42:50 +0100
Subject: [PATCH v4 5/5] dt-bindings: wireless: qcom,wcnss: Use
 wireless-controller.yaml
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-dt-bindings-network-class-v4-5-2329336802b4@ixit.cz>
References: <20250319-dt-bindings-network-class-v4-0-2329336802b4@ixit.cz>
In-Reply-To: <20250319-dt-bindings-network-class-v4-0-2329336802b4@ixit.cz>
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
 Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>, 
 Mailing List <devicetree-spec@vger.kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Janne Grunau <j@jannau.net>, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=8m+TP7dhDaz8he9N9bMiZ3ZhzlbMMMqDKwJGp281Vxg=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2nV/BlN6S2VBiO/H/JLDX9kUOJ7EEhXpItnbg
 zzJrbNHsx+JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9p1fwAKCRBgAj/E00kg
 cgLDD/9LvfI9zTcWOn4Qin6qT0LBWSbGHrBABqoX5Cr7vQ9qld/bLsXSBsehlJik+HdtJD2KiJY
 SfTNFtoPYKiY1LQ2ozg9aoHo6Mn52fvz26J54KQwSILEoONum+Jnoq1SHiD+jNaHbkSBOx/P05P
 rebiMzprJ9tHL6us7qW3pQo4Znx75ZiBmesBz7wlHhVk1e0GbzSHuN3nJsXrTWaAMUS+jjwZUZB
 nwcEINBaPSE3ufSjuRBbQWXrGYBG08HYHp25Y2Q05cmfpqAvhXc+sIFtgD/etQTgtI9Bh9ZjHJN
 5OSeQCoZ+2j4WEovbTfGBbJfdfP/eWXbD4GShnKVCGZYZGlT0khJXgyFLTJtCZifTMNiCWmrsdE
 nU0xWUf9Nu4lkO3sJXvhVvIYy+hlJiGyxlJp4ug/yZ2yWN7Q07nwjJYw65+vMZPs+j/h9dpV7EC
 oZhhexHCOk8RYnfdY6kZJk3sI+rhMj6lSH4sodiZQS+fpbO0uoNka+4BHL+Q+BJxXjdgrglPRIw
 OAVeaKoj1kz5FBmtAbRWOXQggoXCNSmX6ofWT0wQ6eC6jtZdSJdcFyIcrjijnwpG8qkylrbIFQJ
 qJ6aLHmu0rMbTKEM0Brx8ob17dZEToD3GrPIahWf9O/sBkfmgfi8yMERRIqOPEUrh87B0uLKduE
 qp84mMbuGPTrcjw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Reference wireless-controller.yaml schema, so we can use properties
as local-mac-address or mac-address.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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



