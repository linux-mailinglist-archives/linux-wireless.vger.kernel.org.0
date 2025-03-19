Return-Path: <linux-wireless+bounces-20533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B3AA68604
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 08:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113A53ACDB5
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 07:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0B12512D7;
	Wed, 19 Mar 2025 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxyomQA8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000F0250BF3;
	Wed, 19 Mar 2025 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742370179; cv=none; b=LN6UtUYsGTg6fQxSIlUlXKpjn0tjXzZDvb8UnThgpH5vwI4GM73njQVL5kXT+4e5Gtd3bjDfhN5JS15iAaAYzFKLKdAqCbcGhivVnVEw/SNAGYKR5FCvb2RehPl+IyBcqYLyCN3jGYxRKl5lWvfh3ImerPOTqjoQ9j1ptPZc7I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742370179; c=relaxed/simple;
	bh=uPUDwmK0g4Vh1dFePnVTJtquk72HlpJiUb5fITlcanQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jDMTPF5Gk5r7ZR+m3Uas5oqe8ZwPxwtxxo1vYV2EcD3fTcPF1AbU9GfINkiSZKuZxKi1kkv7vSQtHS1avn7tn1Jrac+nwXmlzR6b+frtA7SGCvZQO3OKiDtXg2n9+LrJ9TdJczMTaIxwLV8zAJXe5DfSpvcSNaC+uPAoaXrobt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxyomQA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80D30C113CF;
	Wed, 19 Mar 2025 07:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742370178;
	bh=uPUDwmK0g4Vh1dFePnVTJtquk72HlpJiUb5fITlcanQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uxyomQA8RUYnswlcxPhpjTy0IoBmAw7IN2db3zCQj7loOiIDPUBnGC4+Ebj7aMmk1
	 mPs4d/7vZ30FG+/NH9MA1UIxfFixC+4E8Tl58WFxCYDe3zI47G/QiWFG64YxP2EPBO
	 VTWAHZ3zZKfjZKobesGsY8Ah7jP14PTWMD9FwHTiNQ4pCejWuzidHRTkF9hBq1+iq5
	 LVyLb3dwMfk1EK/13PQmp9zau9fVRXQVnZMQ5x6k7QZWM5ghdibDmJzulXx3KJlBrp
	 QR9LEFNRVUKpAJS5PubI5fw5NFZ1gy7N6s7l4sPSp1NxkSqAoenQI33d+Pm00lnCzJ
	 765GCI1Dm4qJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7086FC28B28;
	Wed, 19 Mar 2025 07:42:58 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 19 Mar 2025 08:42:49 +0100
Subject: [PATCH v4 4/5] dt-bindings: wireless: silabs,wfx: Use
 wireless-controller.yaml
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-dt-bindings-network-class-v4-4-2329336802b4@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=l57H1RfHi2nyRkEMHSpfv1DPteDzmkI0cH0ZxcD39cU=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2nV/GJXqP46+RluuNNyMAQKN75PZKl4HCTx7x
 wSys6q/NTaJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9p1fwAKCRBgAj/E00kg
 clWMD/0fWsWzN0SOl0+waxtXKViVHMwA9Gx4s7s80akUelEhYGg3J6k9IjJRD5dZuA7ob/mPhCw
 5awtfV37JzaaGzG/2/NpO2ce0NFK8EzZ08UATgh3DIocukcOaGA9ma8KI8ZYCK41K2QMh2n3eEa
 Ft+0IsXVu+DbVqLHZjq10lsTqjB8o4hL6TI+M3vSbPtr5WkajIwE/6YR06eI9Z5Ie4e46kGLJda
 GVEgTeW1fCtYj9QJRbtFRJlMUhQZChWZFP1lan2tDTIqvSdd1Sv5ApIXaHlh2JnF3/Fvg013D+c
 9WYHyT82B4PmMl4U3ZEW64+KemjRhf1MjIBPc/vj2JYEzagLETQ3rm5LMOaP5ZjlX27eSzaA6Dz
 Yg2ZIjONDWzp159N6AEYlXQL4oZLH34k9bm5k7UwumWwFDXQlDgcBvHwgWEeEunb0Zu6Z7x88oJ
 yaurc3PGvCwLcXRuVcc7bbmDzubWN1zY4vGIlDDFzZrCucQjdeYYI8QV9QErFpRNQZovLuA0L++
 IVhy88Cqwpy8mjlNlkl3PTYW0jmpdRUASqTCQv/BspwsPnNIHrZOAygUdYMUHAJBOTY5bY1/ksU
 KoSxQrF+bEfwJY6w2hRkg3HBLwQzPGmi1qOWEsXz8mNvSiteozBapvOWUOxd/tROsj+1ZnJbtjO
 gD5+G9Met9QwmQw==
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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



