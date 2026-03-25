Return-Path: <linux-wireless+bounces-33832-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPQ0Mcyqw2nAtAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33832-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 10:28:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5455932238F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 10:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B835303A8F1
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 09:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3236639F180;
	Wed, 25 Mar 2026 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="su0w4Gzc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from courrier.aliel.fr (pouet.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B176439C63D;
	Wed, 25 Mar 2026 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430335; cv=none; b=qflo49GtNm3I0Y5pjeai2jdlLlksW8/wJ4ePV70UYjgVmd1j0GAvTXBxl7xLDH/WbxqT6aL2D5kgMElAvvw3Yayzg405CifwuvJCRDYKOggXtpAIgtXzwhVumHNiyzCzfi20qjsTM+f3ZUdlBqBz8KAiGhrJfQvEbcK+6ECJyes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430335; c=relaxed/simple;
	bh=OHhaocqrcyvsfcC4nwRCQzXz7HSpal5P8Pl4jRGYs5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R+zVp/9+uUXYNrm/QYG/IODLugPGiRsslSvpJgiJqqNn2PYZ7gjwjkJ8b8YDXX2E69plkXM5ZnO9YtX7mbYKmi7H4mquDEcx1wCeX5tmGexol35+5fGW6nS1BKit9b+8gXmHj26QzckTgAlvbQQ+8tlfdCqJih38k+AwEo39Pzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=su0w4Gzc; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1774430332;
	bh=OHhaocqrcyvsfcC4nwRCQzXz7HSpal5P8Pl4jRGYs5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=su0w4GzcLxDEdFnHGE154pI2wvkr/6d5nip5OZVW7aj5WJTKkEJjCtnygqw6nuanr
	 /GKHh4iX7oEYrqXZIbOb5D4YVET0v+6XhjYJAH+4ycAcUydbkmpmLjV5hKNNhaRM2m
	 CBU18qoZuVWjYLO3kgzDhsLiFpNoYB6iBYx97VGM=
Date: Wed, 25 Mar 2026 10:15:25 +0100
Subject: [PATCH v4 7/9] arm64: dts: amlogic: t7: khadas-vim4: Add SDIO
 power sequence and WiFi clock
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-add-emmc-t7-vim4-v4-7-44c7b4a5e459@aliel.fr>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1774430324; l=1444;
 i=linux-kernel-dev@aliel.fr; s=id_ed25519; h=from:subject:message-id;
 bh=OHhaocqrcyvsfcC4nwRCQzXz7HSpal5P8Pl4jRGYs5Q=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgMGec55oxeeisqykQiUedekMYyOnR9
 BG9E/7rDWyqdNoAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEPoczoR+ZG1RJsyzEqjW47THhKI/fMaQohteOEaQPnKesTfwxSOE5RTjg9fzUCj9eJVHmfl1W5
 BpjfvYpK+cww=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openssh;
 fpr=SHA256:kch4osYZ6A1BrPps5AUs6KnfdE2wm4ocMtyTc8TmZMs
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[aliel.fr:s=courrier-s1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-33832-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux-kernel-dev@aliel.fr,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[aliel.fr:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,aliel.fr:dkim,aliel.fr:email,aliel.fr:mid]
X-Rspamd-Queue-Id: 5455932238F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the SDIO power sequence node using mmc-pwrseq-simple and a
32.768kHz PWM-based clock required by the Wi-Fi module.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts  | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
index 2450084d37642..770f06b0b16c7 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
@@ -67,6 +67,15 @@ sd_3v3: regulator-sdcard-3v3 {
 		regulator-always-on;
 	};
 
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
+		post-power-on-delay-ms = <500>;
+		power-off-delay-us = <200000>;
+		clocks = <&wifi32k>;
+		clock-names = "ext_clock";
+	};
+
 	vcc5v: regulator-vcc-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC5V";
@@ -135,6 +144,19 @@ vddio_c: regulator-gpio-c {
 		states = <1800000 1
 			  3300000 0>;
 	};
+
+	wifi32k: wifi32k {
+		compatible = "pwm-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+			pwms = <&pwm_ab 0 30518 0>;
+	};
+};
+
+&pwm_ab {
+	status = "okay";
+	pinctrl-0 = <&pwm_a_pins>;
+	pinctrl-names = "default";
 };
 
 &uart_a {

-- 
2.49.0


