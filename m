Return-Path: <linux-wireless+bounces-33829-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMXUGw+qw2nAtAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33829-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 10:25:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA74F322284
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 10:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B16E30A3CB5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 09:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2FB39B4AB;
	Wed, 25 Mar 2026 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="VGI/7v6S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from courrier.aliel.fr (pouet.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAC2352C4E;
	Wed, 25 Mar 2026 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430332; cv=none; b=fWJiDiPpjNVSp6pyIP9Qv5iorUiYRWCUy2A/WukqDtcKyZereBVIn3Efv374Qd5v/9Klu59fw5VhjAoKiUhdYGgKZj509RftJlmtxtw3uZsGfloZ7n8UVSnUlWqAJRp9mLEMEQa4i6h3r5znT9gKMclyGUgkm99wkZEFzdr8FZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430332; c=relaxed/simple;
	bh=WZ2VWU8ZZjMvH1UNXGZZiw4ZemZ6mSet2kenghPyLf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gT1RHWK+Sj4Z0Pp5FQf/EVyU2i561XfuL2Pp9+Lw8KFtgH5NIVaY2x+iO2GdT47gC2p4uU0TzURXV+oC9IPcR+DulIPfbGdammPz39WBgIKLGdzVu3SO1T1Z6OWYDLX900d++zE1oBFZ40rUkBc32x7oJN3vsQ7ccjrT7fsn0s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=VGI/7v6S; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1774430329;
	bh=WZ2VWU8ZZjMvH1UNXGZZiw4ZemZ6mSet2kenghPyLf4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VGI/7v6S9Hp5hycjhI4RroFM6kUQRKcVK1DQks/Rqspe+jMfAqlRgvhBASsVFxq1M
	 Z8kArI5/aIn3gzIKREvXyhuBR/EUuGtOk5A+sFXlH10OWc46jek4dFD0xrELqfaiDt
	 hopK1ejgidDx2QVW1vVTI6JMGI9tf4DLnhw6jJ/4=
Date: Wed, 25 Mar 2026 10:15:22 +0100
Subject: [PATCH v4 4/9] arm64: dts: amlogic: t7: Add PWM pinctrl nodes
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-add-emmc-t7-vim4-v4-4-44c7b4a5e459@aliel.fr>
References: <20260325-add-emmc-t7-vim4-v4-0-44c7b4a5e459@aliel.fr>
In-Reply-To: <20260325-add-emmc-t7-vim4-v4-0-44c7b4a5e459@aliel.fr>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1774430324; l=3146;
 i=linux-kernel-dev@aliel.fr; s=id_ed25519; h=from:subject:message-id;
 bh=WZ2VWU8ZZjMvH1UNXGZZiw4ZemZ6mSet2kenghPyLf4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgMGec55oxeeisqykQiUedekMYyOnR9
 BG9E/7rDWyqdNoAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAwFbBr3FjIvDay8rQ3kHJMHy2yIGRImTzSlbpZvuzYhFmM7E5MXFCZesofPIA331o6ZTxY/61W
 CXWUMnFQd5gA=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openssh;
 fpr=SHA256:kch4osYZ6A1BrPps5AUs6KnfdE2wm4ocMtyTc8TmZMs
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[aliel.fr:s=courrier-s1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linaro.org,baylibre.com,googlemail.com,kernel.org,sipsolutions.net,broadcom.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[aliel.fr];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33829-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux-kernel-dev@aliel.fr,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[aliel.fr:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aliel.fr:dkim,aliel.fr:email,aliel.fr:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA74F322284
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These pinctrl nodes are required by the PWM drivers to configure
pin muxing at runtime.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 136 ++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index 62c87d0ef7065..eb09a26bcd0e0 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -307,6 +307,142 @@ mux {
 					};
 				};
 
+				pwm_a_pins: pwm-a {
+					mux {
+						groups = "pwm_a";
+						function = "pwm_a";
+						bias-disable;
+					};
+				};
+
+				pwm_ao_a_pins: pwm-ao-a {
+					mux {
+						groups = "pwm_ao_a";
+						function = "pwm_ao_a";
+						bias-disable;
+					};
+				};
+
+				pwm_ao_b_pins: pwm-ao-b {
+					mux {
+						groups = "pwm_ao_b";
+						function = "pwm_ao_b";
+						bias-disable;
+					};
+				};
+
+				pwm_ao_c_pins: pwm-ao-c {
+					mux {
+						groups = "pwm_ao_c";
+						function = "pwm_ao_c";
+						bias-disable;
+					};
+				};
+
+				pwm_ao_c_hiz_pins: pwm-ao-c-hiz {
+					mux {
+						groups = "pwm_ao_c_hiz";
+						function = "pwm_ao_c_hiz";
+						bias-disable;
+					};
+				};
+
+				pwm_ao_d_pins: pwm-ao-d {
+					mux {
+						groups = "pwm_ao_d";
+						function = "pwm_ao_d";
+						bias-disable;
+					};
+				};
+
+				pwm_ao_e_pins: pwm-ao-e {
+					mux {
+						groups = "pwm_ao_e";
+						function = "pwm_ao_e";
+						bias-disable;
+					};
+				};
+
+				pwm_ao_f_pins: pwm-ao-f {
+					mux {
+						groups = "pwm_ao_f";
+						function = "pwm_ao_f";
+						bias-disable;
+					};
+				};
+
+				pwm_ao_g_pins: pwm-ao-g {
+					mux {
+						groups = "pwm_ao_g";
+						function = "pwm_ao_g";
+						bias-disable;
+					};
+				};
+
+				pwm_ao_g_hiz_pins: pwm-ao-g-hiz {
+					mux {
+						groups = "pwm_ao_g_hiz";
+						function = "pwm_ao_g_hiz";
+						bias-disable;
+					};
+				};
+
+				pwm_ao_h_pins: pwm-ao-h {
+					mux {
+						groups = "pwm_ao_h";
+						function = "pwm_ao_h";
+						bias-disable;
+					};
+				};
+
+				pwm_b_pins: pwm-b {
+					mux {
+						groups = "pwm_b";
+						function = "pwm_b";
+						bias-disable;
+					};
+				};
+
+				pwm_c_pins: pwm-c {
+					mux {
+						groups = "pwm_c";
+						function = "pwm_c";
+						bias-disable;
+					};
+				};
+
+				pwm_d_pins: pwm-d {
+					mux {
+						groups = "pwm_d";
+						function = "pwm_d";
+						bias-disable;
+					};
+				};
+
+				pwm_e_pins: pwm-e {
+					mux {
+						groups = "pwm_e";
+						function = "pwm_e";
+						bias-disable;
+					};
+				};
+
+				pwm_f_pins: pwm-f {
+					mux {
+						groups = "pwm_f";
+						function = "pwm_f";
+						bias-disable;
+					};
+				};
+
+				pwm_vs_pins: pwm-vs {
+					mux {
+						groups = "pwm_vs";
+						function = "pwm_vs";
+						bias-disable;
+					};
+				};
+
 				sdcard_pins: sdcard {
 					mux {
 						groups = "sdcard_d0",

-- 
2.49.0


