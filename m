Return-Path: <linux-wireless+bounces-33825-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIdgMqCpw2nAtAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33825-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 10:23:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 449403221D0
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 10:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DABD430C2FEC
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 09:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C54C34D4DE;
	Wed, 25 Mar 2026 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="P7p3nOyw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from courrier.aliel.fr (pouet.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD468342CB1;
	Wed, 25 Mar 2026 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430330; cv=none; b=Hq/WsBsr+MyPu8i6vjuqZt5gK0YOc21KxQ46wep3Ptfm4dcBgOnwfHQHgdI92h/Bz0J2T1X/lIXkie6ofMxu/SxxOfs+cpwlXrTjZIYJJ348HJJY9hOrmF2A5zIvCQwdJ+7W5ywbgGJD4uKHPNPGHU3hcXXuutBt0rKY8a6cnqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430330; c=relaxed/simple;
	bh=wu/b79MKo6jI6RaveGAeQqWZhXTfTOC6UghGktEKf1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rWA5Q5Zu4Xkh924GexM+cilCjuOnhh7dzbCWd+L5q6iP13BKlBT8v/Wn80QpYDtYfZ/K2JMuzwlGIU0bbSgR9z3gg6jwrzTCmw6aS7R9nFeygvRmB0D+wrGr0YC7lGugAp9xuON3e7PnnYnAmmZnfGDTtYx5Fm9DXm64ie5SFeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=P7p3nOyw; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1774430327;
	bh=wu/b79MKo6jI6RaveGAeQqWZhXTfTOC6UghGktEKf1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=P7p3nOywkhLItWRISSEl6auxw/Ol/OVmfR6SbkBiA/J4+lBN8ksXRzv4WOobA6pEN
	 fsAlL/pCoSx2nHy3D3TYX1J9jkUf7vg2ib0UW5NKFh4YpNP9dWDUJPQYY+J4g5k+Yx
	 cpENCddvDsHVcKZabN4aVo+0KwwF5ZlUYMZ4z2wk=
Date: Wed, 25 Mar 2026 10:15:19 +0100
Subject: [PATCH v4 1/9] arm64: dts: amlogic: t7: Add eMMC, SD card and SDIO
 pinctrl nodes
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-add-emmc-t7-vim4-v4-1-44c7b4a5e459@aliel.fr>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1774430323; l=2892;
 i=linux-kernel-dev@aliel.fr; s=id_ed25519; h=from:subject:message-id;
 bh=wu/b79MKo6jI6RaveGAeQqWZhXTfTOC6UghGktEKf1k=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgMGec55oxeeisqykQiUedekMYyOnR9
 BG9E/7rDWyqdNoAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPkmgpDa0m8GxQ8OFJhdlzh5ok2WolXHpWSIYqA8wBwsfT9UK6yTSsh78Hvxt2tGV5MdfGoUhvv
 lX7X/5/yFhA8=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openssh;
 fpr=SHA256:kch4osYZ6A1BrPps5AUs6KnfdE2wm4ocMtyTc8TmZMs
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[aliel.fr:s=courrier-s1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[linaro.org,baylibre.com,googlemail.com,kernel.org,sipsolutions.net,broadcom.com];
	TAGGED_FROM(0.00)[bounces-33825-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_NA(0.00)[aliel.fr];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.15.240:email,0.0.15.160:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux-kernel-dev@aliel.fr,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[aliel.fr:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,aliel.fr:dkim,aliel.fr:email,aliel.fr:mid]
X-Rspamd-Queue-Id: 449403221D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These pinctrl nodes are required by the eMMC, SD card and SDIO drivers
to configure pin muxing at runtime.

- eMMC: control, 4-bit/8-bit data, data strobe and clock gate pins
- SD card: data, clock, command and clock gate pins
- SDIO: data, clock, command and clock gate pins

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 98 +++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index 6510068bcff92..016b5429c8d1b 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -250,6 +250,104 @@ gpio: bank@4000 {
 					#gpio-cells = <2>;
 					gpio-ranges = <&periphs_pinctrl 0 0 157>;
 				};
+
+				emmc_ctrl_pins: emmc-ctrl {
+					mux-0 {
+						groups = "emmc_cmd";
+						function = "emmc";
+						bias-pull-up;
+					};
+
+					mux-1 {
+						groups = "emmc_clk";
+						function = "emmc";
+						bias-disable;
+					};
+				};
+
+				emmc_data_4b_pins: emmc-data-4b {
+					mux-0 {
+						groups = "emmc_nand_d0",
+							 "emmc_nand_d1",
+							 "emmc_nand_d2",
+							 "emmc_nand_d3";
+						function = "emmc";
+						bias-pull-up;
+					};
+				};
+
+				emmc_data_8b_pins: emmc-data-8b {
+					mux-0 {
+						groups = "emmc_nand_d0",
+							 "emmc_nand_d1",
+							 "emmc_nand_d2",
+							 "emmc_nand_d3",
+							 "emmc_nand_d4",
+							 "emmc_nand_d5",
+							 "emmc_nand_d6",
+							 "emmc_nand_d7";
+						function = "emmc";
+						bias-pull-up;
+					};
+				};
+
+				emmc_ds_pins: emmc-ds {
+					mux {
+						groups = "emmc_nand_ds";
+						function = "emmc";
+						bias-pull-down;
+					};
+				};
+
+				emmc_clk_gate_pins: emmc-clk-gate {
+					mux {
+						groups = "GPIOB_8";
+						function = "gpio_periphs";
+						bias-pull-down;
+					};
+				};
+
+				sdcard_pins: sdcard {
+					mux {
+						groups = "sdcard_d0",
+							 "sdcard_d1",
+							 "sdcard_d2",
+							 "sdcard_d3",
+							 "sdcard_clk",
+							 "sdcard_cmd";
+						function = "sdcard";
+						bias-pull-up;
+					};
+				};
+
+				sdcard_clk_gate_pins: sdcard-clk-gate {
+					mux {
+						groups = "GPIOC_4";
+						function = "gpio_periphs";
+						bias-pull-down;
+					};
+				};
+
+				sdio_pins: sdio {
+					mux-0 {
+						groups = "sdio_d0",
+							 "sdio_d1",
+							 "sdio_d2",
+							 "sdio_d3",
+							 "sdio_clk",
+							 "sdio_cmd";
+						function = "sdio";
+						bias-pull-up;
+					};
+				};
+
+				sdio_clk_gate_pins: sdio-clk-gate {
+					mux {
+						groups = "GPIOX_4";
+						function = "gpio_periphs";
+						bias-pull-up;
+					};
+				};
 			};
 
 			gpio_intc: interrupt-controller@4080 {

-- 
2.49.0


