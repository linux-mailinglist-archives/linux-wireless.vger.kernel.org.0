Return-Path: <linux-wireless+bounces-20780-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5704CA6E17B
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 18:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EB897A2CC9
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 17:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF1E26771C;
	Mon, 24 Mar 2025 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVr/9BAh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CCA2676E7;
	Mon, 24 Mar 2025 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838103; cv=none; b=jzobyr9OCMDcpUdIPzl1ihp9XdhUqKTS80gNoWA/xlqmGnnzPPkBw9gLOr+OdoOVBIxKu1qz1Y0CrcusESyx4deq0RCmSQckty9mzYZiWS10arY5+EytU8slIc9eCutHhICT1fCtcBSBa2R1RC1uKSsZAOm24ZA6gBbitq7Se48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838103; c=relaxed/simple;
	bh=vYIKKPXq6VroZXSOm/cT0IeJepkgj9rT/Kp8jmsHN7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L2xHRzak0xTalwStCS6rGHYvKriPrP6A7IFOa0jgqE8eWmLfu5LEvudcf1G9ALW/zGCRtc3BkdJPcftA6DLWOvBLCL8AiekEqPugOeO0WRq8ud5HlN+vLhrG5c8yFQlNdeFgUfweeuI1vGF743v8o+Z32ZpjThLdRGl/DFKOme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVr/9BAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 998C9C4CEF0;
	Mon, 24 Mar 2025 17:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742838102;
	bh=vYIKKPXq6VroZXSOm/cT0IeJepkgj9rT/Kp8jmsHN7c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HVr/9BAh7grFkFQOv/YZDdYhHFf12zMuiSA5r3KphrAxsWX4wiVAzpj7joU0vwDrr
	 TRBIGlhV/LW+LiuVVeaY34V+V57RfJvMo8cwPdh+dh1qW4D8jN9l/8Nq701z0uEAOT
	 8VFitPrgwGz4HtSF6tvzIy+7yGpn5xgHlk5Rrig1FZEQ7w6d8GTEi6i6OHnS2IrJto
	 pnlpVYAKvUxJt1m9/ou6OrJtksbMlCsHO/XSGLY+kyowZourjy+QfrnZlxyJpV6Lv2
	 tdjXo8eIrv3OIMwTfCobJ7F6kyDQ+aJyInTR0AozoBx24bLWKG1A5GYUH0M8o9nMLn
	 aFCFFm4XUAJvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906BCC3600D;
	Mon, 24 Mar 2025 17:41:42 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 24 Mar 2025 18:41:40 +0100
Subject: [PATCH v5 3/5] dt-bindings: wireless: bcm4329-fmac: Use
 wireless-controller.yaml schema
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-dt-bindings-network-class-v5-3-f5c3fe00e8f0@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=/39eFZ6ducpCjGUyDE9DMGHcDra7AKtjh9uaQngpN54=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn4ZlUt699Tlcv8r6WJO24J/HN3KZtO6w86vhOh
 rcHlVCjHG+JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ+GZVAAKCRBgAj/E00kg
 cmG9D/oCykoLT9XrEn6xb1Q47UpvM0WJw8+ER5SJHyw1AQ3bzSnBRHBhPZ8VDJ3TlyhVGbkWQx9
 noV3zps0Zfjl+n0BqTH3IPBPsVmXi+woMrih0R0wPjNc39dV0WlBq64G6dXCrc5SVWBB649glBu
 gx8rYGmdyDVEmBNZv4XUyez4iiL4cmGkNwRf/atqNbmzROapeQDuGRYabDPQA6q8sNf/8hk39S7
 tdZ6HYA3Xa4z+xc2DADeuoesKl7tfgtQNjxETQpOwPmYTHPhVlDTklYylklSF59YhDRSBq9KWfD
 eppNfUdMcSa6VdBSctjJkAaKqnJOpOc7wYEOO0XEWN4iQI2Ab8l0T/r0TkV1IAncai3cmPEjqdv
 ayQ45Pc2f0r/gTtGnlvWxsC7vxKcPx3qrt0iof5nuiDwYdj9XM759iCKMzXIFX9HrACDuauPZSD
 4neH2iIg3QsED31jB6f+3cx5KhMB5Z6CH6d7OSUJ9E8RPMMsNslwEcAEY8irjtblxG4zxx2PeTu
 mPL7w5j7JeXOcQ4bEbusJuAtyoSmo5Wr9yTm2PHYUlpo+pTwbIxI2lGac+zL4bGqCmR+TiFNpyn
 Tz4Av7pbr8u87LDnP5jsNZDsMCxKupIAa51N2CyEhK9nych/nWQFMuX86GbuoNma1pQXurxD93z
 eGVScAgNGtNlrBQ==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Janne Grunau <j@jannau.net>

The wireless-controller schema specifies local-mac-address as
used in the bcm4329-fmac device nodes of Apple silicon devices
(arch/arm64/boot/dts/apple).

Fixes `make dtbs_check` for those devices.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index a3607d55ef3671514cdf2c884cf5bd0ccaadb162..7c8100e59a6cd045837a2f602e367f3f79ced5ba 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -16,7 +16,7 @@ description:
   binding.
 
 allOf:
-  - $ref: ieee80211.yaml#
+  - $ref: /schemas/net/wireless/wireless-controller.yaml#
 
 properties:
   compatible:

-- 
2.49.0



