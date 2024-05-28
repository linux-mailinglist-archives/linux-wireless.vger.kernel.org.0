Return-Path: <linux-wireless+bounces-8202-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AF98D1D56
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 15:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0EF11F2360C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 13:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A1F16F0F6;
	Tue, 28 May 2024 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIIXfed2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AFF11187;
	Tue, 28 May 2024 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903985; cv=none; b=CIUVjG1yg8yn5da1H+L81lHrR2oHjfhuMsjGLSzy/NHJJuIWxlOo062vYiFfFceq4VeJJWTjmSjrvhywwDXmfOnRS3B6PK4BK/x3U+Vq9NR1UnuJTUhTFahBSl4atQKVFeqJJTlsVoN3883jj3o69J9TknDact8yz6N/n3gL1Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903985; c=relaxed/simple;
	bh=Ts9yUWNKtkjmp8jkRt/lYz8+oFlaYVa9VT7q+TSy+GA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H/HfQxeOj39qfCEhlp4MeiweLMuwrSoR9sXA6fCBta4JiTC0b1s2Ty0795KtaYY52nkq5V54BH7JcWPm0DXjhAcSH0rZ2/49XSOIRc4Bggjdzz/pzkPr0v6o/8KV53Gt8JT5XJh2uYPD9uxpwFgGfaoc2Bscx9BDXrrv4bYsIXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIIXfed2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EA6C3277B;
	Tue, 28 May 2024 13:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716903984;
	bh=Ts9yUWNKtkjmp8jkRt/lYz8+oFlaYVa9VT7q+TSy+GA=;
	h=From:To:Cc:Subject:Date:From;
	b=jIIXfed2H9nZ3neZm7Uy5Y4sQ5Kij55dKAmJaqx4068TDpoLN2N9onFvTKo7AV51p
	 t4BfzcZqr+fmT3b0D+o41yznt/cIcfvJPGZxG6aBMdFfxvS76mP9FdFA3/0lvQpv+Z
	 vC28fE2X6+8jVIfzkCjJk780MmrUWUzvKVSnvJGo+abTi7Adna192KwVeg5pROLzzq
	 BMgbafBsQj4BT4/LJj/O/NduHqm5lZupm0As1xch35eClyUEiHKwv33/BKYqOa74Vl
	 2e7LapBvTLYw6lOqvJP3Wtv2vVkEblQ35Wems/zYBv6W1oPStgh/G54XOS9N2Q/G4L
	 AxONyfICITszA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kalle Valo <kvalo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: net: wireless: ath11k: Drop "qcom,ipq8074-wcss-pil" from example
Date: Tue, 28 May 2024 08:46:09 -0500
Message-ID: <20240528134610.4075204-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convention for examples is to only show what's covered by the binding,
so drop the provider "qcom,ipq8074-wcss-pil". It is also not documented
by a schema which caused a warning.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/net/wireless/qcom,ath11k.yaml    | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index a2d55bf4c7a5..ff5763dc66a8 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -265,15 +265,6 @@ allOf:
 
 examples:
   - |
-
-    q6v5_wcss: remoteproc@cd00000 {
-        compatible = "qcom,ipq8074-wcss-pil";
-        reg = <0xcd00000 0x4040>,
-              <0x4ab000 0x20>;
-        reg-names = "qdsp6",
-                    "rmb";
-    };
-
     wifi0: wifi@c000000 {
         compatible = "qcom,ipq8074-wifi";
         reg = <0xc000000 0x2000000>;
-- 
2.43.0


