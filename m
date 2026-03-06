Return-Path: <linux-wireless+bounces-32629-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIytHcixqmkhVgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32629-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 11:51:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B03621F2B2
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 11:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A168C3038AF6
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 10:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7332A37F735;
	Fri,  6 Mar 2026 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmU6y7g3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF1C3368AD;
	Fri,  6 Mar 2026 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772794279; cv=none; b=RSFfVmgufesaKyyxGvlrO/xZ9ZzR0hDNzCfvcXKc/idWHjRjm8qTA5AgrBRdHXKaHPJJk2qqVrLaTlnB/Esr61BKGOKpFzTjezTcZA+HYb99GfAWCVFdD5acKhJPjqnsPATRJQH4cS0nzkM3G3tondUZBPGAP/GPi3g5aVDW2UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772794279; c=relaxed/simple;
	bh=VulyuWgkoLsxmBOeLgDF0beLPvgQfeLav/LDt2v0t0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mItfNPjqc/Aj4mbxP9Aq0JHc7kcFVCoOB409Am8KxLO4SeQvhBdz4yOF6zcBs2h+Xsja2jywhtPG33KeelU3fmytK2XCTPNrGZsYorciYEJ3YL8y2dWTU7ZlNYocpZSPoC40YLh2V+jcvFst4qx7J/YRejqu4RPGdesqvXSRSa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmU6y7g3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135E5C4CEF7;
	Fri,  6 Mar 2026 10:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772794278;
	bh=VulyuWgkoLsxmBOeLgDF0beLPvgQfeLav/LDt2v0t0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VmU6y7g3advHug/qS723M6eJUsviyh5bVasatx5p50xDjCT09nokXcIYQQVxdk1Uh
	 IXHFoRAZ59QQXpUwxq3xBJleExhVzhTADDdniH854fSHsDs+QLroSQIXW/DPSNUro1
	 wjyv1NYmQjKE5TvnNe+/D4WwZ4VWDBXjfb1gJgEGU5osdEl+JI/AhmXy90VvD0NDNp
	 7TpYWuYuzT+yNafUWwPc2FLPUUP/842c2BBVecR6Vgt0fq9xo6pgCcqzsOpXcvcH6Y
	 rvzXVI0axUarB6ZPzjzBQuF2nqh/QuMGf5yNXBZBHPAk5+8Y5HjQwumg7DBTN8jMDO
	 l1dKtb0+CMd9g==
From: Sumit Garg <sumit.garg@kernel.org>
To: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-remoteproc@vger.kernel.org
Cc: andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robin.clark@oss.qualcomm.com,
	sean@poorly.run,
	akhilpo@oss.qualcomm.com,
	lumag@kernel.org,
	abhinav.kumar@linux.dev,
	jesszhan0024@gmail.com,
	marijn.suijten@somainline.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	vikash.garodia@oss.qualcomm.com,
	dikshita.agarwal@oss.qualcomm.com,
	bod@kernel.org,
	mchehab@kernel.org,
	elder@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jjohnson@kernel.org,
	mathieu.poirier@linaro.org,
	trilokkumar.soni@oss.qualcomm.com,
	mukesh.ojha@oss.qualcomm.com,
	pavan.kondeti@oss.qualcomm.com,
	jorge.ramirez@oss.qualcomm.com,
	tonyh@qti.qualcomm.com,
	vignesh.viswanathan@oss.qualcomm.com,
	srinivas.kandagatla@oss.qualcomm.com,
	amirreza.zarrabi@oss.qualcomm.com,
	jens.wiklander@linaro.org,
	op-tee@lists.trustedfirmware.org,
	apurupa@qti.qualcomm.com,
	skare@qti.qualcomm.com,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH 01/14] arm64: dts: qcom: kodiak: Add EL2 overlay
Date: Fri,  6 Mar 2026 16:20:14 +0530
Message-ID: <20260306105027.290375-2-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306105027.290375-1-sumit.garg@kernel.org>
References: <20260306105027.290375-1-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1B03621F2B2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32629-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

All the existing variants Kodiak boards are using Gunyah hypervisor
which means that, so far, Linux-based OS could only boot in EL1 on those
devices.  However, it is possible for us to boot Linux at EL2 on these
devices [1].

When running under Gunyah, the remote processor firmware IOMMU
streams are controlled by Gunyah. However, without Gunyah, the IOMMU is
managed by the consumer of this DeviceTree. Therefore, describe the
firmware streams for each remote processor.

Add a EL2-specific DT overlay and apply it to Kodiak IOT variant
devices to create -el2.dtb for each of them alongside "normal" dtb.

[1]
https://docs.qualcomm.com/bundle/publicresource/topics/80-70020-4/boot-developer-touchpoints.html#uefi

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
[SG: watchdog fixup]
Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile        |  2 ++
 arch/arm64/boot/dts/qcom/kodiak-el2.dtso | 35 ++++++++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/kodiak-el2.dtso

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index f80b5d9cf1e8..09a7f943190e 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -139,6 +139,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs615-ride.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-radxa-dragon-q6a.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2.dtb
+qcs6490-rb3gen2-el2-dtbs := qcs6490-rb3gen2.dtb kodiak-el2.dtbo
+dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2-el2.dtb
 
 qcs6490-rb3gen2-vision-mezzanine-dtbs := qcs6490-rb3gen2.dtb qcs6490-rb3gen2-vision-mezzanine.dtbo
 qcs6490-rb3gen2-industrial-mezzanine-dtbs := qcs6490-rb3gen2.dtb qcs6490-rb3gen2-industrial-mezzanine.dtbo
diff --git a/arch/arm64/boot/dts/qcom/kodiak-el2.dtso b/arch/arm64/boot/dts/qcom/kodiak-el2.dtso
new file mode 100644
index 000000000000..0b3a69a0d765
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/kodiak-el2.dtso
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Kodiak specific modifications required to boot in EL2.
+ */
+
+
+/dts-v1/;
+/plugin/;
+
+&gpu_zap_shader {
+	status = "disabled";
+};
+
+&remoteproc_adsp {
+	iommus = <&apps_smmu 0x1800 0x0>;
+};
+
+&remoteproc_cdsp {
+	iommus = <&apps_smmu 0x11a0 0x0400>;
+};
+
+&remoteproc_wpss {
+	iommus = <&apps_smmu 0x1c03 0x1>,
+		 <&apps_smmu 0x1c83 0x1>;
+};
+
+&venus {
+	status = "disabled";
+};
+
+&watchdog {
+	status = "okay";
+};
-- 
2.51.0


