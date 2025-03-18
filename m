Return-Path: <linux-wireless+bounces-20514-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829D8A67D84
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 20:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41991882207
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 19:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D60C2139AC;
	Tue, 18 Mar 2025 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLIQ58N2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3574A212B3E;
	Tue, 18 Mar 2025 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327809; cv=none; b=H1K/Mge31i44RW+ToE6+OaeRy0aXKIzas+Y0sa6O0tiL4oaj/gHZATNB2z016aINAq1HYJz6S0J21mVEiLQzxxV1V+vxWcuw5s3eKLaWXy1f7x5RjN0b3xhQaqg5mg2YDPqb6TH9fnoDomE/b0nPjEZtWovGax781uL2rBG+S5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327809; c=relaxed/simple;
	bh=pF99SzA09p9xmzoaSb+iJYmTcMB0v9cqEecf6PPgRP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RW9f0bAuSSEQwssp44oBhTADpuu1GrL7nfwD4NNJtmQVWsGMDHVhBf77/YYjuifjaabqOUm0sUaT7A+DrhVpoFJxRP6Hh25mZvn5zQNmSIA13kjYKfFm/c4dPbp0jzOWJPqP0RCqo8mkgOOWl7h4HVueyoF58Iwx6SwueR2Zny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLIQ58N2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB2FCC4CEF7;
	Tue, 18 Mar 2025 19:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742327808;
	bh=pF99SzA09p9xmzoaSb+iJYmTcMB0v9cqEecf6PPgRP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FLIQ58N2RehNdlBAz6WS9AxT2Pe1LweFM9kixV1OFClO+fC9Ff8IvvwEKILoag4et
	 BH5sGIAD2g/vSyh5OVQISN1fdSVAs4UoYwnalLa+BPYJCKzVeCj3B0DOsjscJx5CxL
	 4IIu2t/ottE30TpjV3zgB1KOoRkzZtyhCUBmSffJM/aPznyzJJwxfXEdH3UdxjInsv
	 IFYwTZbLl7fUG5+byZvwKWhuRK+zbuolNd8H0O3f13KdMR7R63xRG8nx9PVtmPY//Q
	 KJtoLGW1xYxHKZP1bhO3GBbKWVBjIrSjmTgp006LXGA+Dm20M2/58Yn3f1bPPYcdTx
	 7RdDQ2QEKe3yQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A50C35FF3;
	Tue, 18 Mar 2025 19:56:48 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Tue, 18 Mar 2025 20:56:47 +0100
Subject: [PATCH v3 4/5] dt-bindings: wireless: silabs,wfx: Use
 wireless-controller.yaml
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-dt-bindings-network-class-v3-4-4d8d04ddfb61@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=HBoY5S1k0e2zUg4tv3n60rntaTQrtnXEYSlk57YEgBo=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2c/+rXtH32FEFx87hHOghZXRVsarHOwhHZ93V
 X6wuntamLSJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9nP/gAKCRBgAj/E00kg
 cqjXD/0YxeBL0pOWKsiQgODzLmJj+LanjSBr4ifes0h6NEu2JaO5oIVRs23VCKcl15XHUsKzmBC
 Vk3wkMYWzA7zy3l/dQI5nffjhlcz3Nnkp8zllSYqph3R/xGq1KJwxJOmLove5mSCTRrEy+INte/
 z1vY/6+9I1DoEY3Cf2wXITLUPepUiU4sHCebIcwMhVVhnarQjDKkthed8SjG02eHZjjDjksZWil
 +lUNoYU1FGo2qOT8ea1xSKmTmRrEsktp7gVfBeSqcLQIa61p+qgBzFIzcRyRV9eBfn3s7uyKQyX
 nr9bwzBkBpVgK0gZmDua5sxmHAwmbxFIerCyvkCExkSLlUAjMPWO+a2EXy4dkFj+f5R0A6HU2Dl
 TO7qCPASb4wIiS90Hbz56SGLwLrIIufRRV/QOGBxmOYjxkaF6lcsWAxmfgQCj6FmQIxqPNV2a1e
 cplZdiHmWVVKU/JEKOhtnyaRjSJKYn0b6Hae78/60dTPNqF+HGVjzYgtNv+5PsR3Uqvf1lSxF4u
 5n5XTEWOnCoz8UBWpx3iOtzG3TdWJH/J0BWZyn6z6cSpuEuWmXyFzVuIVXeLI7QVm3Bz0e/jyjN
 FNPv1Odopp6ol8tPcbxJPDvQ2Wvapit8RuDny1ffYUxqYUFC78SBjlXmHvwl5R7OTi5dELLRsDL
 nItlsfj1qR7bRjw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Janne Grunau <j@jannau.net>

Instead listing local-mac-address and mac-address properties, reference
wireless-controller.yaml schema. The schema brings in constraints for the
property checked during `make dtbs_check`.

Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml b/Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml
index 84e5659e50ef3125b5063fbebcaf1d2b2bdb7398..6c0888ae4c4e172edf2a5f6249cb8aed5ed11681 100644
--- a/Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml
@@ -71,15 +71,12 @@ properties:
       "Platform Data Set" in Silabs jargon). Default depends of "compatible"
       string. For "silabs,wf200", the default is 'wf200.pds'.
 
-  local-mac-address: true
-
-  mac-address: true
-
 required:
   - compatible
   - reg
 
 allOf:
+  - $ref: /schemas/net/wireless/wireless-controller.yaml#
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 unevaluatedProperties: false

-- 
2.49.0



