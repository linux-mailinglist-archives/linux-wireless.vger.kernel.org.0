Return-Path: <linux-wireless+bounces-30011-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FD6CD23EE
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 01:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E0D530255BA
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 00:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AFD1F1534;
	Sat, 20 Dec 2025 00:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEog9GGq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B8D1D88A4;
	Sat, 20 Dec 2025 00:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766190157; cv=none; b=GPRVz3Y4vcHPG+oiNeiD6ZB+f2pKRY5V5MSSN1rGRi4oInyJ/LBVv5mnhh9LbyaZioneJKjrLMpP0YALXZ8e3PizXVSwzcayMjpDOAzBSi4Yd8FuCSZ3/QTX/BmiSgbIT8Ya+L2kozAVTY7/7ERcKjpJfO6OSt8Z8AVjUAAkmTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766190157; c=relaxed/simple;
	bh=RMpcTlpiiJR7am5aDa0+IMieq4Gs4MKgiv3QBd2GR4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L+HOZgZrYS5IgIqT5dklqzKHFnsvx/8A3RgIODKd8Q7yv1LtGPFlCptZjKoRdh21H/PuBYZv2Pf15E7KAOvP6PKc4EfOsH+Eq56Iojo3Wit5KGxEosaDzIaHm0jes5Gv3T49V9cXByuQ4ErHP2VIbHx0XhUx4GQLbEYFE+FpkvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEog9GGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AEB1C19421;
	Sat, 20 Dec 2025 00:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766190157;
	bh=RMpcTlpiiJR7am5aDa0+IMieq4Gs4MKgiv3QBd2GR4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nEog9GGqvUHMkUuFtR+F15QjUg+eMjE7WIp/Gckchak9pzcSDvxfhSk1u+Cae7CQ+
	 gcEzRftJ78yyio0XXLJEnVpX/bETUp0rzfdZWe9SUWOfcZ5/FQWkCfsIyBJL2jF8mx
	 S+VhfjVABrjTWoDzt57womFIW8T/TmyAY9glkLuvR6NyGSsm1JtI/L1+hKFhr1fTO2
	 HKgL4DYOwu6adldexQoRbUermOTTH0nNr9KMee3ZVaz657czq4LQ0UzUmP0SVL2Hi0
	 sEqlu+6iTAXZz3MC4kvbWIk5Du1ULpImPnmU/rsYgqeQo5wDBCty14n2p01G7NcP86
	 ICig6gLN9nbtA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0CED78797;
	Sat, 20 Dec 2025 00:22:37 +0000 (UTC)
From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne_via_B4_Relay?= <devnull+jerome.debretagne.gmail.com@kernel.org>
Date: Sat, 20 Dec 2025 01:22:00 +0100
Subject: [PATCH v5 3/7] dt-bindings: wireless: ath12k: Allow disable-rfkill
 property
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251220-surface-sp11-for-next-v5-3-16065bef8ef3@gmail.com>
References: <20251220-surface-sp11-for-next-v5-0-16065bef8ef3@gmail.com>
In-Reply-To: <20251220-surface-sp11-for-next-v5-0-16065bef8ef3@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Jeff Johnson <jjohnson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, ath12k@lists.infradead.org, 
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 Dale Whinham <daleyo@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766190155; l=1122;
 i=jerome.debretagne@gmail.com; s=20251217; h=from:subject:message-id;
 bh=qxUYWgrkevDrzW7E3kqpqIBVkm0S8EYbX/8Sl2i9Gas=;
 b=HDpJFAGzTzB5pyD88o+QOrEljODlF7cCgrR9SyebLystn5VxlZgYVg3uagtZgdENepJt0kLLa
 a+F3uIzqOXxBbr1R0q7/T0VtIvb3vjw3XuxLtdJu4E5cq/heNZe6IhR
X-Developer-Key: i=jerome.debretagne@gmail.com; a=ed25519;
 pk=DcPD9n3oDMsPkt+12tU96swmGb5H86cxt+yiEVcUEGk=
X-Endpoint-Received: by B4 Relay for jerome.debretagne@gmail.com/20251217
 with auth_id=580
X-Original-From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
Reply-To: jerome.debretagne@gmail.com

From: Jérôme de Bretagne <jerome.debretagne@gmail.com>

Reference the ieee80211.yaml schema to allow disable-rfkill to
be used for models that need to disable the rfkill feature,
otherwise the Wi-Fi radio is unusable.

This is required by the Surface Pro 11 with WCN7850.

Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
---
 Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
index dc68dd59988fc757e8f53e809128cb4e820d66d1..e18c87b21777bc6642e551f23feff69bfb7fb435 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
@@ -21,6 +21,8 @@ properties:
   reg:
     maxItems: 1
 
+  disable-rfkill: true
+
   firmware-name:
     maxItems: 1
     description:
@@ -69,6 +71,9 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - $ref: ieee80211.yaml#
+
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmh.h>

-- 
2.47.3



