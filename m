Return-Path: <linux-wireless+bounces-33827-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOvkHsipw2nAtAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33827-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 10:24:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D1C322203
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 10:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 916363115DB7
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 09:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C969F358372;
	Wed, 25 Mar 2026 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="W+ci3AfO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from courrier.aliel.fr (pouet.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84630314A9F;
	Wed, 25 Mar 2026 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430331; cv=none; b=bQfxoSfNcBTB4S3drGqahBMn3NX9zG7lNTtGurboqHL9uQK2p1B83gc1pnA5s8xY2+wwEeOt2bS+k5L87T36xO+gGIy9lk0jmi/hnZzXWpIFOtFIHd0Hl5eeQhcn9OdDq9gF5R7ws+XjsRXoUzWCMePlMuYLaY8coezGIzusL0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430331; c=relaxed/simple;
	bh=qZgg2/em0UQrmXDkkNz9+fEbqFZp6rL3BaB4H4Zgk1I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EBE3tOQ5P4mM/yb7XFwbGVztuJxeYBdn6HahGFNEAEQvqxgH5YDosKcoNS3fEzpGO/MsbcxXZz5AVZuXs6WPqTofGpBY+jBJmDef/YueYaZUBtOaIyujhsOkVqpB6MaRBpsuWiIlNUJCwiUdDfo3LUpp48EXT6tlp+sRkjQegpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=W+ci3AfO; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1774430326;
	bh=qZgg2/em0UQrmXDkkNz9+fEbqFZp6rL3BaB4H4Zgk1I=;
	h=From:Subject:Date:To:Cc;
	b=W+ci3AfOQDl7PXqpLMquScKokZ9vuSF72EboAukLJvl/jienz0GZo2ElWtphU1dq3
	 WI+UojSM5L/RzwSWU+Wrn0Ry14X3kKihrNCeKCn/zwFwwEEf9apAUpX14ob5V56LIN
	 M1/HoITLfboQSg93MPeQwbya96CsesZcWJYB5Xl0=
Subject: [PATCH v4 0/9] arm64: dts: amlogic: Add MMC/SD/SDIO support for
 Khadas VIM4 (Amlogic T7)
Date: Wed, 25 Mar 2026 10:15:18 +0100
Message-Id: <20260325-add-emmc-t7-vim4-v4-0-44c7b4a5e459@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6WQ3WqEMBBGX0Vy3ZH8qauUsu9RepGacU3XxDbRY
 Fl892ZjoYVe9mbgTPjOx+RGAnqDgXTFjXiMJpjZJZAPBelH5S4IRicmnPKaCk5BaQ1obQ9LA9F
 YCbXSrMZW1kwOJMXePQ5my8rnl4M9fqzJvBxLYjEElc1d8XiImaANpZyXaUrRAIM3o1w5rmdlp
 /li+rKf7dNd/6oCQgJrlq5wuC3wbWjJvW00YZn9Z74nslyX3zk7Mcoa2paikhVNBZNx6wZX9A4
 n0BjPajI4lYPPnsj/kRU/WcHF3y+LAihUrGp1S1V7kv2v/L7vX3dLJkSVAQAA
X-Change-ID: 20260320-add-emmc-t7-vim4-6ad16e94614f
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>, Nick Xie <nick@khadas.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1774430322; l=2970;
 i=linux-kernel-dev@aliel.fr; s=id_ed25519; h=from:subject:message-id;
 bh=qZgg2/em0UQrmXDkkNz9+fEbqFZp6rL3BaB4H4Zgk1I=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgMGec55oxeeisqykQiUedekMYyOnR9
 BG9E/7rDWyqdNoAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKQVj+Pq+QZ1dPHXnx93BiJVL48LoNgsShQ9+3LoMPwrlcwyPr6axg76cgSOR3GKYLjvfenYsZv
 tjC3CZ4d9fAg=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openssh;
 fpr=SHA256:kch4osYZ6A1BrPps5AUs6KnfdE2wm4ocMtyTc8TmZMs
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[aliel.fr:s=courrier-s1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linaro.org,baylibre.com,googlemail.com,kernel.org,sipsolutions.net,broadcom.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[aliel.fr];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33827-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux-kernel-dev@aliel.fr,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[aliel.fr:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,aliel.fr:dkim,aliel.fr:email,aliel.fr:mid,amlogic.com:email]
X-Rspamd-Queue-Id: F1D1C322203
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series depends on Jian's SCMI clock patches yet to merge
https://lore.kernel.org/all/20260313070022.700437-1-jian.hu@amlogic.com/

This series adds device tree support for the MMC, SD card and SDIO
interfaces on the Amlogic T7 SoC and the Khadas VIM4 board.

The first patches add the necessary building blocks in the T7 SoC
DTSI: pinctrl nodes for pin muxing, PWM controller nodes, and MMC
controller nodes. The amlogic,t7-mmc and amlogic,t7-pwm compatible
strings are introduced with fallbacks to existing drivers, avoiding
the need for new driver code.

The remaining patches enable these interfaces on the Khadas VIM4
board, including the power regulators, the SDIO power sequence and
32.768kHz PWM clock required by the BCM43752 Wi-Fi module, and the
board-specific MMC controller configurations.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
Changes in v4:
- Address potential DT binding API break from Xianwei's feedback.
- Change underscore to dash in pinctrl nodes names from Xianwei's feedback.
- Link to v3: https://lore.kernel.org/r/20260323-add-emmc-t7-vim4-v3-0-5159d90a984c@aliel.fr

Changes in v3:
- Remove all changes about fixed pll clock from analog controller.
- Use clocks retrieved through SCMI.
- Add other MMC controllers
- Manage Wi-Fi module enablement. 
- Link to v2: https://lore.kernel.org/r/20260218101709.35450-1-linux-kernel-dev@aliel.fr

Changes in v2:
- Resend v1 patches as attached to the first patch.
- Link to v1: https://lore.kernel.org/r/20260218101709.35450-1-linux-kernel-dev@aliel.fr

---
Ronald Claveau (9):
      arm64: dts: amlogic: t7: Add eMMC, SD card and SDIO pinctrl nodes
      dt-bindings: mmc: amlogic: Add compatible for T7 mmc
      arm64: dts: amlogic: t7: Add MMC controller nodes
      arm64: dts: amlogic: t7: Add PWM pinctrl nodes
      arm64: dts: amlogic: t7: Add PWM controller nodes
      arm64: dts: amlogic: t7: khadas-vim4: Add power regulators
      arm64: dts: amlogic: t7: khadas-vim4: Add SDIO power sequence and WiFi clock
      dt-bindings: net: wireless: brcm: Add compatible for bcm43752
      arm64: dts: amlogic: t7: khadas-vim4: Add MMC nodes

 .../bindings/mmc/amlogic,meson-gx-mmc.yaml         |   4 +
 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml   |   1 +
 .../dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts  | 202 ++++++++++++-
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi        | 336 +++++++++++++++++++++
 4 files changed, 542 insertions(+), 1 deletion(-)
---
base-commit: f6eb9ae8b9fc13c3971e4a6d1e8442f253001f36
change-id: 20260320-add-emmc-t7-vim4-6ad16e94614f
prerequisite-message-id: <20260313070022.700437-1-jian.hu@amlogic.com>
prerequisite-patch-id: f03a086b4137158412b2d47b3de793b858de8dde
prerequisite-patch-id: 123970c9b29c2090440f2fd71c85d3c6fd8e36de
prerequisite-patch-id: 3e2e56b0926ba327b520f935df4ced5089bbe503

Best regards,
-- 
Ronald Claveau <linux-kernel-dev@aliel.fr>


