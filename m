Return-Path: <linux-wireless+bounces-20782-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA134A6E185
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 18:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D3D17A20DF
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 17:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FF2267B92;
	Mon, 24 Mar 2025 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UM1CUWpv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF06267718;
	Mon, 24 Mar 2025 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838103; cv=none; b=tIuVuGmgqk6/P4prhX/XP9sL5q4eLLsJlRQ2OJUloKy3hmP5TZ9xVCgtD7TKDuoaJ+M9UA9Obx39aLCOqlRIddb0dhnQvKeB0caW7idHy9gQm2NSCsNMPpvaWN28inxxT3nnk14FRmGxaU1f5Rnispm8+xvT16YrYgzsReRTcvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838103; c=relaxed/simple;
	bh=eUFaq+yugIuksyG03BYSR72DIzc5mCrpziXwrV7Qk88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nNDElK9KBf9QVqY1XhvSwDEgNAxkvHoDfXxiQDqgUT222Dr8ILt/bnIOlfrbSdSc0yUxs9XuKwa7hrHByjqc1PP+vOREge3NPY6bJVfeoJ+mQ0TPRQOO8ZhfVgVz1K5LU5Y1VD3gNnALtL7NFXtC964HSyuDJcfcvsJTREBYxr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UM1CUWpv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5DD4C4CEF3;
	Mon, 24 Mar 2025 17:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742838102;
	bh=eUFaq+yugIuksyG03BYSR72DIzc5mCrpziXwrV7Qk88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UM1CUWpvVSEW6wS3JIFbX8YAbP+JaY4SD5GiSG4Zz6CB1zgKOyAhCB3AgB/HH+FN8
	 44d2lmFCoAPEtkLYdURCEYv5a1foMznp81ItNJATSwLPsb74qsLhujdwfurwixlTKL
	 5VlN7nmxRc6ZWe40mmTWRhkCcUKIBiepjDEFJebQxigxi/2ocLJXwVXZLIR0L9Ctjr
	 wOzjglyhSFNojAC0Czd8m+ynxmC7U1fhAi7NqHSeRp4zsWa5JMN6uF7va0YcLUZq2X
	 MLYjG5o5/pV0l/msILpbJZo7BC89SMb7By6AflujkGTHe7lY+EGmkERn32cGQdG2pw
	 R/lv99dP0yFCw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF18C36008;
	Mon, 24 Mar 2025 17:41:42 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 24 Mar 2025 18:41:42 +0100
Subject: [PATCH v5 5/5] dt-bindings: wireless: qcom,wcnss: Use
 wireless-controller.yaml
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-dt-bindings-network-class-v5-5-f5c3fe00e8f0@ixit.cz>
References: <20250324-dt-bindings-network-class-v5-0-f5c3fe00e8f0@ixit.cz>
In-Reply-To: <20250324-dt-bindings-network-class-v5-0-f5c3fe00e8f0@ixit.cz>
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
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn4ZlU7W6DvkU/GtU/5mgv1mJEVjM4fMdd4lFLB
 YEnkBz9O4aJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ+GZVAAKCRBgAj/E00kg
 cjZWD/9gYT52tWM4Pj6Xa1C9vE5/lk54/lUY/gSgvswdtF7p8i7iEfWQ1TAp6bESqwxYpp3QaZ/
 hDpevbVV/KiBcnkL9XCOImWcaGNBM+KgPmZHmgj/dChDYuhxtBhSCGTAJlPA+fsBnwuP/le9X67
 wYDmWqJAvJOdRRvDosljxZoMoCMde9D0xEQ58b8wkKvEJIALE4hDmkMTrkNAcQ9kbQs0V8WqnHu
 FakuiaHdvBiRxln3b1Jb62vC9QdJFZvut36ORsLRJNj8bkeQOyFuybIodr6Pd1URNMBulafo76t
 /knBV1EuMz2KjnvNF7kC0r2sd8K3ZK6E81Kbpb+7zci+JShAdz6vm1VUbX83FTJKTled2L3ronh
 S1QR7GJKiJ2DLaqHiaBr+S5H9Bfwa+1Y6nGZgo0GAzRBFP5+ecG++alMEjCFaqPI0g0veZ5nN8a
 iduChlEKGZSwqVVXbQofOQ9f5IRZb/zqYbEydRIb25SeOei0XaF+kbl12j5ykx6Mu9MrTFPxXby
 RpL1Jp10Zox9eYFqfnYgiz+FN9D0a8sEyYS/BAUb/6z3hPxpnBIf+NMuNh0ulyQe81F7UOq1qdK
 WYWHmwXAOpdxaBuugB3TAwIt33DuRlAmS+8X9IMWwnjOd3RrsWW+P2mxZiXHFmBed4PbPg9Swvc
 1gEwu7ZdbzaosRg==
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



