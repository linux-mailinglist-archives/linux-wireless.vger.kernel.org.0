Return-Path: <linux-wireless+bounces-33938-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGYIGc0KxWma5wQAu9opvQ
	(envelope-from <linux-wireless+bounces-33938-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:30:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BDF333601
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9D3331FC251
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA413E4C6E;
	Thu, 26 Mar 2026 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="oGrkkFd1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from courrier.aliel.fr (pouet.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6863BFE2B;
	Thu, 26 Mar 2026 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519319; cv=none; b=VudjX3PXhthRHp0ip/loiksytTriTepvsJN8zgcFvNmP/RQ5VI9NERlqM1J4ibEO/fGNYg00ZyQD7cfSoxkGV3m8ghx0dzIFEZkwV+9BYUIsrgGxOIPmkdKcrou5EO25Ued1GN6QWZhpsXFmMaKMWA0Z6bQguzpXgfpI9YltNYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519319; c=relaxed/simple;
	bh=4WK30/mE0MGHHvTXMGsXTEKwE0mrHfTNI8g5HO+FiMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kxn57dMa/Cs8O+KJVp7SQdS1nmq8DuEKVxCcWpSawcG9sjt7k0k707GNzhBzEgI5X/anjMmn/V7fSELSuwuyhHv2MgF9ERByWsbEbZG6/Mikr4KRpagqfRuXrIQ5MQMItH5UOhH8SOTg4MCz3imDziITXSsOcBjf7TcXCWRDkYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=oGrkkFd1; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1774519316;
	bh=4WK30/mE0MGHHvTXMGsXTEKwE0mrHfTNI8g5HO+FiMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oGrkkFd1zOs3ySzdOwyRM9EVn7n8QnnMAkuq/Bh+hlp8R/GKlC79PjVCw/Wy+GGKC
	 wy3l35Cg8swFuEQgw+tGIauuCUe+5n831a8UoaOO4JG+qqHSHyg/CQ1XmUSczc3QcP
	 XX2wDr4aP382F+na6GGdbYdcFnEooZj2VEoOlxWA=
Date: Thu, 26 Mar 2026 10:59:13 +0100
Subject: [PATCH v5 2/9] dt-bindings: mmc: amlogic: Add compatible for T7
 mmc
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-add-emmc-t7-vim4-v5-2-d3f182b48e9d@aliel.fr>
References: <20260326-add-emmc-t7-vim4-v5-0-d3f182b48e9d@aliel.fr>
In-Reply-To: <20260326-add-emmc-t7-vim4-v5-0-d3f182b48e9d@aliel.fr>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1774519311; l=1102;
 i=linux-kernel-dev@aliel.fr; s=id_ed25519; h=from:subject:message-id;
 bh=4WK30/mE0MGHHvTXMGsXTEKwE0mrHfTNI8g5HO+FiMg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgMGec55oxeeisqykQiUedekMYyOnR9
 BG9E/7rDWyqdNoAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHjtzkCO+mbkgAitvZ1hKC/yMPbECLq55c68kPiBCAxtp5xAebFbUsp3xd3zSw1A9HKigUyGO8z
 qiIdWRfulZwg=
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
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33938-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux-kernel-dev@aliel.fr,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[aliel.fr:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amlogic.com:email,microchip.com:email,aliel.fr:dkim,aliel.fr:email,aliel.fr:mid]
X-Rspamd-Queue-Id: B0BDF333601
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add amlogic,t7-mmc compatible string, falling back to amlogic,meson-axg-mmc
as the T7 MMC controller is compatible with the AXG implementation.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
index 57646575a13f8..976f36de2091c 100644
--- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
@@ -19,6 +19,10 @@ allOf:
 properties:
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - amlogic,t7-mmc
+          - const: amlogic,meson-axg-mmc
       - const: amlogic,meson-axg-mmc
       - items:
           - const: amlogic,meson-gx-mmc

-- 
2.49.0


