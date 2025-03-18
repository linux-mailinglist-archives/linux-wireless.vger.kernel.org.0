Return-Path: <linux-wireless+bounces-20512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E09A67D79
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 20:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3853881F21
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 19:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D4D212FAA;
	Tue, 18 Mar 2025 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DggrOUB1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34C821146F;
	Tue, 18 Mar 2025 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327809; cv=none; b=iQvusyYHIa++ZTSrLbBkmP/cwbvc9GRPvkganlhWqsnnXNmyZFFQ6APO2174fIxvNAxiLNIUyQgEKoSvx1y8D8TF6jtxIr9/qjAjpHwdqHGCXudqP04WQGqptuq07K1rarmOi/Z6Ln9jEsJ5atp6tWxIwq9vKSpg5bMYfFqDeBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327809; c=relaxed/simple;
	bh=7W8QpbQv5teMaSOlvTSkrQIpc6ejHxAGQeFyZZG7vrs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LLAk5NpbYQbDoFMxmAfIwRrAtJ1AjNEXlLXW1D1yxRCux6XU7H20d3Q6z1yK5SvBPDbLjSthdZHZ8oSw0NC+wo0Cw9GYYekuNq6QxYXjrhhemyNNNuBvGVFEIzZaunaiirn/hHJXIGT5cNmYzVwBiX8c2LvVy942f4954tejlW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DggrOUB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55730C4CEDD;
	Tue, 18 Mar 2025 19:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742327808;
	bh=7W8QpbQv5teMaSOlvTSkrQIpc6ejHxAGQeFyZZG7vrs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DggrOUB1gdJaIsgIr/99/XkexdFtR4WgUpBoqFSe6BwLuh69f/KafDRtNNKzC6RdT
	 vjwiiKSxNBUQb8fO7NZjHu6YJs0pFN/M2z/5MlxMql5dM7Q4OPePfhRqJlqzg48+WJ
	 dqfNuKl33tB74NRiNLZljPIuZ+wcN9ucGFX+wTr7YimUqOMN8+AKi0TziL0T7XNlVP
	 3b77TzFbD7UfDKLL6Lctv2l4UpEOmRo5DHWNUwj/M1qtutSvuLNBknSdFdL1/AGkWN
	 94UoNs84lyJVJk0eLW1AP/DXl8mDVPdM2rPPpOfjlm9cpVFAnun+/SeqzlwMfx2PFo
	 UTzh56iCzQgOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7E1C282EC;
	Tue, 18 Mar 2025 19:56:48 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v3 0/5] dt-bindings: net: Add network-class.yaml schema
Date: Tue, 18 Mar 2025 20:56:43 +0100
Message-Id: <20250318-dt-bindings-network-class-v3-0-4d8d04ddfb61@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPvP2WcC/42OzQrCMBCEX6Xk7Mp2Y/88+R7iIU2WNiopJLEip
 e/u1pu3noaBmW9mUYmj56TOxaIizz75KYjRh0LZ0YSBwTvxipA0EmpwGXofnA9DgsD5PcUH2Kd
 JCVpdN+xc3XSOlPR7kxj6aIIdNwIigpMFyzkyQ27LkoS2JUef8hQ/vxNzKXLdszeXgHCqiFE3F
 SG6y92EYF5HiambYGfajaIN1XV1K+8rbPQfal3XL+TR8NAoAQAA
X-Change-ID: 20230203-dt-bindings-network-class-8367edd679d2
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2490; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=7W8QpbQv5teMaSOlvTSkrQIpc6ejHxAGQeFyZZG7vrs=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2c/+j6DMvXwXlPePgX3PHddA4M1piRIGjZllm
 N+DF+5cZ62JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9nP/gAKCRBgAj/E00kg
 chroD/9vAs2g7yo2x2daiSwFvP2LReGaABPJ+K/Kmjr5AS+X+QJkFZXeJr3xzmKxGjzv4HRisY1
 0CFZPU+EiE4tulRle9WoXr7ayonKJtFnuzmd0nLMYQtJpqfabPolWqAIXSmUqPtjgaUwUPvoVll
 S1SKbU5tPNORhH6lwFbqdjb9Wqg9OkN/3bELAVEhXgXCoXFJ17fA46N+vkPWXRdsem0gijUAOUF
 0UWJNNEMrC3T6BB7gLOxjAp0L+k093wSflp+3FPH2QHR+07SMFKTnr/qHcHEfvWPjpwQuB78uOh
 V5DSLc4zt9dokk9ZP7lmYi3x1HuGDt9/yjrH3ymPgXuU39+sSP79iwzojlf56igEry4RkKVVF47
 a00kqS1PDZx4UZRsbIEoio7fKlnXNEBZf7pilWxqlE5OdzaDvwLLh9wAV8UgHLjyfgcZWuxDEgw
 ix5RM75HA/ZpzORoDGCGydOavRc/eXRGS4ZYIzDABpgPvmmlsTHiPMP6owT0lU8uG4/qhOO1ki9
 MBi4+L1v3NoyEh/pe1zYh8zYy5nZ6yHYxlRIpfSqTSH1OVQ+AdEa01n+dUafH7mDFPPj/CLeDwe
 SZPCS73I+WI72g/GsJsBVuUzOR5Dt6snywG0Tt2ClvDhP5JT2+8MR9WTUQMvHt+O+k0ym+7f7E+
 frkEV2LqN7wTNTA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

The Devicetree Specification, Release v0.3 specifies in section 4.3.1
a "Network Class Binding". This covers MAC address and maximal frame
size properties. "local-mac-address" and "mac-address" with a fixed
"address-size" of 48 bits are already in the ethernet-controller.yaml
schema so move those over.

Keep "address-size" fixed to 48 bits as it's unclear if network protocols
using 64-bit mac addresses like ZigBee, 6LoWPAN and others are relevant for
this binding. This allows mac address array size validation for ethernet
and wireless lan devices.

"max-frame-size" in the Devicetree Specification is written to cover the
whole layer 2 ethernet frame but actual use for this property is the
payload size. Keep the description from ethernet-controller.yaml which
specifies the property as MTU.

Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v3:
- Incorporated wireless-controller.yaml suggestion (Andrew)
- Link to v2: https://lore.kernel.org/r/20230203-dt-bindings-network-class-v2-0-499686795073@jannau.net

Changes in v2:
- Added "max-frame-size" with the description from ethernet-controller.yaml
- Restrict "address-size" to 48-bits
- Fix the mac-address array size to 6 bytes
- Drop duplicate default value from "max-frame-size" description
- Link to v1: https://lore.kernel.org/r/20230203-dt-bindings-network-class-v1-0-452e0375200d@jannau.net

---
David Heidelberg (2):
      dt-bindings: net: Add generic wireless controller
      dt-bindings: wireless: qcom,wcnss: Use wireless-controller.yaml

Janne Grunau (3):
      dt-bindings: net: Add network-class schema for mac-address properties
      dt-bindings: wireless: bcm4329-fmac: Use wireless-controller.yaml schema
      dt-bindings: wireless: silabs,wfx: Use wireless-controller.yaml

 .../bindings/net/ethernet-controller.yaml          | 25 +-----------
 .../devicetree/bindings/net/network-class.yaml     | 44 ++++++++++++++++++++++
 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml   |  2 +-
 .../bindings/net/wireless/silabs,wfx.yaml          |  5 +--
 .../bindings/net/wireless/wireless-controller.yaml | 23 +++++++++++
 .../devicetree/bindings/soc/qcom/qcom,wcnss.yaml   |  5 ++-
 6 files changed, 74 insertions(+), 30 deletions(-)
---
base-commit: c4d4884b67802c41fd67399747165d65c770621a
change-id: 20230203-dt-bindings-network-class-8367edd679d2

Best regards,
-- 
David Heidelberg <david@ixit.cz>



