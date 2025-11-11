Return-Path: <linux-wireless+bounces-28840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5B2C4DC3E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 13:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 992184E9FC1
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 12:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5DA3A9BEC;
	Tue, 11 Nov 2025 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv5UA32i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8263D3A8D7E;
	Tue, 11 Nov 2025 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864464; cv=none; b=XJr0vAIs63S4SxniErxXC0AG7SK4oExyJrxyxIY6SaGmxfgsJ4xxmk6gpI+frmwxGEqUvP+5TP6DHD7PXetRAfKHOCPZBIjUnxT7ip9vhlgy9XxySgIYt34frDWMC1GU4sZ4hbtJd/K06jMd7pZnn1b4965pPU+VHFdDN2oxTxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864464; c=relaxed/simple;
	bh=SpMO8rNLi4WnoDG3Yi9fIqh/wGiw/wFnS+65N5FsU7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bp7pvzIOfLxKeAsJtNiajrvJQFNOg8qWLAmtnYU0rAhq6wXItRxnHSpz0SMevbt3kW7P8tZ+Z2drI8ASWhNAbQlCi9T6s0mAiJoRn6xt/2dWwx3QPB9D4PM+FhmEvin2lO+UQ1FwxzeLCxCBHzaIz8VIfWxLHDVe1heOq1OEFRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv5UA32i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF47AC19421;
	Tue, 11 Nov 2025 12:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762864463;
	bh=SpMO8rNLi4WnoDG3Yi9fIqh/wGiw/wFnS+65N5FsU7Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Bv5UA32ic1+AjfNmANErYBXXeWiQb91m1+Z8kdWhtxuQ4JyrwNHlXVY6k3YDmMU/g
	 dNtxJYIZWStZVaqZB6hmdcH52dup0MFgNSqh3sOVI8P9Q9JIFKQniON3LfOxMnyGh7
	 eG8UHSoNQDI+WzoXT6VfZQ1PpYhCmVfyt2E5ywyPLmPMb1PvdEHxyrWH+fJe3nHliC
	 Zn4LJsLw7IRQ0t9SHrWyWMoPL01YMgaAEdkcFBL1mAxjmYv9pxKAZpYnCRQvtn13VE
	 v2z+sFRBxmqnvr7zWkWo4FyQYNK4lJYDuYQ9uwU6Z+KQLIDWUv1D944lohfgU+Ep7c
	 G0vngCkqpMYqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44D1CCFA1E;
	Tue, 11 Nov 2025 12:34:23 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Tue, 11 Nov 2025 13:34:23 +0100
Subject: [PATCH 2/2] arm64: dts: qcom: xiaomi-beryllium: Add firmware-name
 qualifier to WiFi node
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-xiaomi-beryllium-firmware-v1-2-836b9c51ad86@ixit.cz>
References: <20251111-xiaomi-beryllium-firmware-v1-0-836b9c51ad86@ixit.cz>
In-Reply-To: <20251111-xiaomi-beryllium-firmware-v1-0-836b9c51ad86@ixit.cz>
To: Jeff Johnson <jjohnson@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Selvaraj <foss@joelselvaraj.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=833; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=PLFjs1iQMEpbEN9hhCiOw/xCedAmYh/qG3YE5NSot4M=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpEy1Okb3cPXX9Y89695Vx+MeosWDF6xW2cVz7g
 tOCsy9+c/2JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaRMtTgAKCRBgAj/E00kg
 chboD/9HkOnD7mNoc5x0SjLwvUIyjfP/XAyPuo2/fo+b0CgXiafeRyWnTQfk1HQIvAIpTHLaSaY
 cxSWPVxwlrYuaMN41qSBgsCA5GMp0CqGE7v4W/AU3jdEPe5dcueeVM++tDa9cJ1aQPmKG9QQR8d
 fg0pcCErXfEGhm8kXen5sMS2cDj0dd1EolMARMjpAfQW4P8Eq9CcjXq47NiDr6NNooZ2NEEVoMS
 qWLuB4EOYaNe35it/XMxsvrIZ73JIEavQOsvIr/MOZf0rIKhq1wRN+D3AIC0IcC/5VcCncOlTYm
 jy1qEeriVgzGlsaTHX+Mi7C2C1fGhjLy/LUj3yxldJ5c0nNMoQjSAUDOHkBgZ80t8Z5+7esNeAv
 p7OboW1JODXeyNpjQsIT3KcUEoRZaLQmeLkx1AA+FoAXTl1W1HW6htvZHorBr5/dy9aW9p64L3i
 AITU84iFvvuUJ4QrZkItmSdy6CyUfRDsJCezzrs2mgQLurZcCN+kddATl68a3feqzK7bt5tJaeE
 ObeaBHO7sulWi4kFy2keGxX8pzjY+R4shMHOMua/KF7820ouNQJpV0kxYdcYY6E074EVxgEZdrM
 DWeaMLM/4VTt+yd+GZiAHXgfHXRwSPZw0K4cfRocMljeo09chzWtM6cJ31EavNaBaRcUvC8fIAG
 0N5XwRaWjFwru2Q==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Add firmware-name property to the WiFi device tree node to specify
board-specific lookup directory.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index 785006a15e979..9b0b0446f4ad3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -631,6 +631,8 @@ &wcd9340 {
 &wifi {
 	status = "okay";
 
+	firmware-name "sdm845/Xiaomi/beryllium";
+
 	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
 	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
 	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;

-- 
2.51.0



