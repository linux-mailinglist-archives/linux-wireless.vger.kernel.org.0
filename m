Return-Path: <linux-wireless+bounces-38462-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L0lrI3w2RWrd8goAu9opvQ
	(envelope-from <linux-wireless+bounces-38462-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 17:47:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5066EF5CF
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 17:47:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="LVjZS/rF";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38462-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38462-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92B773080F89
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 15:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55DD48AE20;
	Wed,  1 Jul 2026 15:42:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBF2481677
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 15:42:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782920563; cv=none; b=d334DtxBpRw2i0hg3hw6yFfeigUC2T6GK13sveAb/OWORa3ZFGRpqabi9S7LxC6C+i5humN1M/xC4adBOKmLGx98nPEMIpujkwNTOQVYdwZ8j3NEPuoGaGYZwTrN8HFNXEb1fwyuBiDYamndvP7hpODmbbbCYcJs5EcBMArxQE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782920563; c=relaxed/simple;
	bh=QYXzOp6ZTSFVPoAGAC49rhJcrcMATpYeqRLf0POJWbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IdhBlZHVZR0Vm5UQwrGlZA/xfWOGP15U3F7VkQZGrDp/NM6iY7p/HxQMrstI2KPJtslKMzf9MJeqGFKCPlSnClznjNjBr/yYhtnC/sVkib26Hj+YY5O+gHaHDjxrvlHXZaBfo1TvpsVO8hoK9ZkYadFpkykWFWtOVeQGOxIRE0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVjZS/rF; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49241dbf9c1so6412195e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 08:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782920561; x=1783525361; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b+NRBUp7hwQMTT79ULwyBxmmco53fwj7wXNTwiWQiWA=;
        b=LVjZS/rFsaf1KZkcYcqTQT1W101EIoZMl+NQYszuOCVvB6eo7ngNJ4Vo/XcKOnBQHa
         6UD+7Rv6vNAMI1Tj+RCY+6r2U381gDvUh9mdCPhrvLZpeAg6G/OOgGYRm++5YYfBFbPT
         geKyfly0x5+GlVq/RTMst891Br5FWECJE4SuFuF5aAubBGQnRij4b8PM3uAFg6OEfzhu
         U8P2EnbgdCukOX81Sa4oK/7goiZG+a7V2mkR7l3qfP6EyVJMTzeqnggi4WgcKXsEuETZ
         nvmBR/uRy3Ny95XLFLT7vvgBW46aq0dC9hGP94hHELSZ0tRON3H54Ic0m7IlqEzMZqq/
         dzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782920561; x=1783525361;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+NRBUp7hwQMTT79ULwyBxmmco53fwj7wXNTwiWQiWA=;
        b=BaFVNdX/xtk+jLvJTFb4EsTNx0fHF5VGOUr3jAOyPxgr7eSB9A9/KRWjaDJjnTLhm/
         ANmY0eXdOZM/cnYTmm4dZhpZTmsPW+wwfmb/lsggs2ToWTOQPQ4UIpZUK38S5/08ocOy
         ukq3bRwP4z/yz5k05DR8AgNxTAUlLbSgqfpeJvtBAXLjhhowJFNxaJ83IErXX7k2Z16+
         JA+UwkKacT5Rj47y6wmoc3gnt3+6W4IDWRsQEpg76z6A6wFIpCNYJAwY0zGs5i/TWiJv
         C3gtMDTvwsnnu7dWDCP2ASYpsGhwKmt35QguCPTPc05+fWdlXkxBFSkLi1AFAHFUjQq7
         eAkw==
X-Forwarded-Encrypted: i=1; AFNElJ84leyJ2EmgXeX85K4xbP7lzQOdr5QNY+BRZBudX+/n0PyKbGeG76/nEweLZEj2Qw95Jsf1yEeOB3nTm1xT8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb1rUqAzFs+p5Tti55O2CzdQ3Hr6uKIgwq7812GXo4gVkTcNgP
	5s8+xyN1um8eZnPpF8Jtx6E71PoCpDcc5bDVJ51Rxpq9nJZBFIT+n+2t
X-Gm-Gg: AfdE7clo1cyA/UC4e+g7NAy+JkkWCJYcvtoxG2qPEpTP9U8R7DP+mT5nCs0UqfFQEht
	lfMV2n4ycP6UojeIVmrrl7A03kIbtTVFVFnTvyjetD2JgmpydYnpNS1RKJ1alyr/Bcqd+S5sNop
	DS0jlTkyNaiQ2Y26E1uJYCwy6a0oAkMYZTx0OpU6aTaMjb0h6DI61M3RbzpfYMHVuOROXeHx2wi
	Y0HbDndeFGwsVbzoesoeUxNp3AxQ2ajEyw3+L3JVepyGhJe84paZb9FpOUO3l0J/TNoPMYFt3IH
	saxgYd1gApaJD/TDIKREhSGQ4zyhHFNas0pEfTbu/Y+wM9mxWagE/IeOwlMlb7+Ev4UjNr4Qn/a
	GEWwdNm/3UG943Fp8isBR3EFNJYDub5iS8TknJmqfcbVCR79i9Rp87dtlP6Ua9SCY9ySloT5Vmu
	TRtKzZe7lVPqHC1kk+pWLUdIJR0RKbjGMXIPJpo2sCSzXrYoWUXxXZGNBrbw2YJPWxpjPRxEa2I
	IlVr5gU2LAnbbw5
X-Received: by 2002:a05:600c:212:b0:493:bb2e:11a5 with SMTP id 5b1f17b1804b1-493c3cd99c9mr13791975e9.15.1782920560613;
        Wed, 01 Jul 2026 08:42:40 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4bfdd5sm148048465e9.1.2026.07.01.08.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 08:42:40 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Wed, 01 Jul 2026 17:42:24 +0200
Subject: [PATCH] dt-bindings: wireless: ath12k: allow calibration variant
 for WCN7850
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-ath12k-calibration-variant-v1-1-d3eddaabf026@toradex.com>
X-B4-Tracking: v=1; b=H4sIAF81RWoC/x3MQQqEMAxA0atI1hNoC1qZq8gsYk01KB1Jiwji3
 S0uH3z+BZlVOMO3uUD5kCz/VGE/DYSF0swoUzU44zrjjUUqi3UrBtpkVCo1x4NUKBUcfd+a6GO
 cfIA62JWjnO98+N33A+ON1apsAAAA
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 Andrew LaMarche <andrewjlamarche@gmail.com>, linux-wireless@vger.kernel.org, 
 devicetree@vger.kernel.org, ath12k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38462-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ernestvanhoecke@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:jjohnson@kernel.org,m:jeff.johnson@oss.qualcomm.com,m:andrewjlamarche@gmail.com,m:linux-wireless@vger.kernel.org,m:devicetree@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:ernest.vanhoecke@toradex.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,vger.kernel.org,lists.infradead.org,toradex.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernestvanhoecke@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,toradex.com:mid,toradex.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E5066EF5CF

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

qcom,calibration-variant selects board-specific calibration data for
systems where the bus and device IDs are not unique.

This is not specific to WSI-capable QCN9274 devices. The WSI binding
already allows the property, so allow it in the WCN7850 PCI binding too.

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
Document qcom,calibration-variant in the WCN7850 PCI binding. The
generic property is already documented for ath12k WSI devices in
qcom,ath12k-wsi.yaml, and selecting board-specific calibration data is
not specific to WSI-capable QCN9274 designs.

This complements Andrew LaMarche's ath12k driver series, which adds
driver support for reading qcom,calibration-variant from the device tree
and drops the deprecated qcom,ath12k-calibration-variant from the WSI
binding:

https://lore.kernel.org/ath12k/20260630133001.1426824-1-andrewjlamarche@gmail.com/T/#t

That series makes the generic property effective in the driver while
this patch closes the schema gap for WCN7850 devices.
---
 Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
index dc68dd59988f..cf3e1fd99c12 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
@@ -54,6 +54,12 @@ properties:
   vddpcie1p8-supply:
     description: VDD_PCIE_1P8 supply regulator handle
 
+  qcom,calibration-variant:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      String to uniquely identify variant of the calibration data for designs
+      with colliding bus and device ids
+
 required:
   - compatible
   - reg

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260701-ath12k-calibration-variant-b7850f7ffd7c

Best regards,
-- 
Ernest Van Hoecke <ernest.vanhoecke@toradex.com>


