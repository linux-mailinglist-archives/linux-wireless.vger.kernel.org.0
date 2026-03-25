Return-Path: <linux-wireless+bounces-33828-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMUtNbCow2nAtAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33828-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 10:19:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB56732209E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 10:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C04AE30462CC
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 09:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09569359A86;
	Wed, 25 Mar 2026 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="N8kV8Ru+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from courrier.aliel.fr (pouet.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730792E8B6B;
	Wed, 25 Mar 2026 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430331; cv=none; b=iEZo2uhggYaEc3LK9bFd8gK3SC2JpVg4LEMpVvmx1RWZCzleJXXT7YRxxbVkdr7bdOh4ujihDpBRvw0thY3jyzmb5I6Ajo5ABv2i3csueYxEBdxPPlBM2Zf+aiZjdAqTSeBFgheG2NHwDdxlTCAcDL1YcYHNT/DEheLK54LdaX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430331; c=relaxed/simple;
	bh=Mv91SPp0jibHt4TPwMZ16mk6wXIXuBSAkTZzcmsns8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c1CftHB7v+M0pj1Cm6e8XOXgIAtjxnZd9sZMWvOdu4ofeBrPIkDc8lXq2orblzRFOfPYzzc8lhSUkq9xVYGxMQ/0LeGvWPL3q1RMsm3x5LK359M80yRpmWaRFWR4BDLvlJUKxUbaW3turu6oDRc3UnRk9PpLrgvhyFMTYPSuN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=N8kV8Ru+; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1774430328;
	bh=Mv91SPp0jibHt4TPwMZ16mk6wXIXuBSAkTZzcmsns8w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=N8kV8Ru+fWPp6sb0fzU55ohVhGoIbsNJXCkyBs60GR8l/+oK6yw+adJgP+FLyey8x
	 WrJBl8+/vCv/8k0Zmq5+r1jaVSBL9w0ntP+239rebthFfyDFkh+700sjNOLovhkjf8
	 ejHjx60V5jtEb77jEbcC2QyS/gZ0Mocu4UamAzng=
Date: Wed, 25 Mar 2026 10:15:21 +0100
Subject: [PATCH v4 3/9] arm64: dts: amlogic: t7: Add MMC controller nodes
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-add-emmc-t7-vim4-v4-3-44c7b4a5e459@aliel.fr>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1774430323; l=2309;
 i=linux-kernel-dev@aliel.fr; s=id_ed25519; h=from:subject:message-id;
 bh=Mv91SPp0jibHt4TPwMZ16mk6wXIXuBSAkTZzcmsns8w=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgMGec55oxeeisqykQiUedekMYyOnR9
 BG9E/7rDWyqdNoAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCGRaZVD6raCaZKAtzOqnoPQ6/EallwcInVlyyTy99CBePVkSrXO7UpYM3s0rf2NLMuYgl3ONRR
 w8zCE+laTxQI=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openssh;
 fpr=SHA256:kch4osYZ6A1BrPps5AUs6KnfdE2wm4ocMtyTc8TmZMs
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[aliel.fr:s=courrier-s1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[linaro.org,baylibre.com,googlemail.com,kernel.org,sipsolutions.net,broadcom.com];
	TAGGED_FROM(0.00)[bounces-33828-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_NA(0.00)[aliel.fr];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.39.236:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux-kernel-dev@aliel.fr,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[aliel.fr:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aliel.fr:dkim,aliel.fr:email,aliel.fr:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,8a000:email,0.1.87.192:email]
X-Rspamd-Queue-Id: DB56732209E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add device tree nodes for the three MMC controllers available
on the Amlogic T7 SoC, using amlogic,meson-axg-mmc as fallback compatible.
All nodes are disabled by default and should be
enabled in the board-specific DTS file.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 39 +++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index 016b5429c8d1b..62c87d0ef7065 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -374,6 +374,45 @@ sec_ao: ao-secure@10220 {
 				reg = <0x0 0x10220 0x0 0x140>;
 				amlogic,has-chip-id;
 			};
+
+			sd_emmc_a: mmc@88000 {
+				compatible = "amlogic,t7-mmc", "amlogic,meson-axg-mmc";
+				reg = <0x0 0x88000 0x0 0x800>;
+				interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+				clocks = <&clkc_periphs CLKID_SYS_SD_EMMC_A>,
+					 <&clkc_periphs CLKID_SD_EMMC_A>,
+					 <&scmi_clk CLKID_FCLK_DIV2>;
+				clock-names = "core", "clkin0", "clkin1";
+				assigned-clocks = <&clkc_periphs CLKID_SD_EMMC_A_SEL>;
+				assigned-clock-parents = <&xtal>;
+			};
+
+			sd_emmc_b: mmc@8a000 {
+				compatible = "amlogic,t7-mmc", "amlogic,meson-axg-mmc";
+				reg = <0x0 0x8a000 0x0 0x800>;
+				interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
+				status = "disabled";
+				clocks = <&clkc_periphs CLKID_SYS_SD_EMMC_B>,
+					 <&clkc_periphs CLKID_SD_EMMC_B>,
+					 <&scmi_clk CLKID_FCLK_DIV2>;
+				clock-names = "core", "clkin0", "clkin1";
+				assigned-clocks = <&clkc_periphs CLKID_SD_EMMC_B_SEL>;
+				assigned-clock-parents = <&xtal>;
+			};
+
+			sd_emmc_c: mmc@8c000 {
+				compatible = "amlogic,t7-mmc", "amlogic,meson-axg-mmc";
+				reg = <0x0 0x8c000 0x0 0x800>;
+				interrupts = <GIC_SPI 178 IRQ_TYPE_EDGE_RISING>;
+				status = "disabled";
+				clocks = <&clkc_periphs CLKID_SYS_SD_EMMC_C>,
+					 <&clkc_periphs CLKID_SD_EMMC_C>,
+					 <&scmi_clk CLKID_FCLK_DIV2>;
+				clock-names = "core", "clkin0", "clkin1";
+				assigned-clocks = <&clkc_periphs CLKID_SD_EMMC_C_SEL>;
+				assigned-clock-parents = <&xtal>;
+			};
 		};
 
 	};

-- 
2.49.0


