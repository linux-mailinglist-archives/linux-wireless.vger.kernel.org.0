Return-Path: <linux-wireless+bounces-33979-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UL60MtJHxWkU8wQAu9opvQ
	(envelope-from <linux-wireless+bounces-33979-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 15:50:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBB83370F1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 15:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29D8D3065E40
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 14:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211A03FBEBA;
	Thu, 26 Mar 2026 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="RyUzgg3e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from courrier.aliel.fr (pouet.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D365B3FB7DC;
	Thu, 26 Mar 2026 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536489; cv=none; b=R+8kMdgD+MYC3nZLTlEW74ATHyMs3Rlo3P8+JakZtO/5t6cJjDmCj9kspevbXTeLfiPqSPvMXG+htjg/qMHXYkTpLxYXnt7+oFg8Vo74BjczdMpGlvGI6NrC1vmUQqeCJvyhY8eBik7xYMT3zMCQ9zWrIaHzLvr4Qc+rHjoo9Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536489; c=relaxed/simple;
	bh=FBbOEtraBZrzdPUqt4ykZNnNoMl1XmHPJmVczv0lLqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oui6fCh9Mu8BIPQT3OpXMTiBHmPHPWjWMstJEnfP8zTh05gELF8cPmb6aIECkpgqP8Z4k29Qq63nz2r1pVg522bWeIXG/J4GIsD3O1/8fSyN7hdKoJQZDIbyB1MLRrmvQEGlGRnz8zIRW2/IqqGx/KBqdIAgtfrW3M+l6PN8fUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=RyUzgg3e; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1774536483;
	bh=FBbOEtraBZrzdPUqt4ykZNnNoMl1XmHPJmVczv0lLqY=;
	h=From:Date:Subject:To:Cc;
	b=RyUzgg3eRdX8bcyf11TYNaCJeZImIPFmgp9rnHujPyPR6CQBDCZ7ksG5J8NABrr1L
	 yBhwGI3WHzd7gJwtfYNSgbliyYaQ1taOzp2AL+YDnn2fMnzTzl8D+FAqUTPfrfZYYq
	 PE7TioH3RHBlEQ1UzkxuWvdPoAq0vroHfCkSqUtA=
Date: Thu, 26 Mar 2026 15:47:32 +0100
Subject: [PATCH net-next] dt-bindings: net: wireless: brcm: Add compatible
 for bcm43752
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-add-bcm43752-compatible-v1-1-b3b9a58ab38b@aliel.fr>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBA0avIrDtgJzGhvUpxMSZjO1CjJKEI4
 t0bXL7F/wcUySoFnt0BWX5adE0N91sH4cPpLaixGagn1xtyyDHiFBZr/EAY1mXjqtNXUMhZtrN
 /eMPQ6i3LrPt1fkGSikn2CuN5/gFIkAxScwAAAA==
X-Change-ID: 20260326-add-bcm43752-compatible-e264a4f7973a
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1774536482; l=1453;
 i=linux-kernel-dev@aliel.fr; s=id_ed25519; h=from:subject:message-id;
 bh=FBbOEtraBZrzdPUqt4ykZNnNoMl1XmHPJmVczv0lLqY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgMGec55oxeeisqykQiUedekMYyOnR9
 BG9E/7rDWyqdNoAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QE/s/b+2azgaHAK0vMh6M6Z5KpH4VxXVnh+GiQ6mdtN/UMNGfF6MmNomP1scfvB+Qn+YTm8GCgi
 IBYw3yWpPUQc=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openssh;
 fpr=SHA256:kch4osYZ6A1BrPps5AUs6KnfdE2wm4ocMtyTc8TmZMs
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[aliel.fr:s=courrier-s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33979-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DMARC_NA(0.00)[aliel.fr];
	DKIM_TRACE(0.00)[aliel.fr:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux-kernel-dev@aliel.fr,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8EBB83370F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add bcm43752 compatible with its bcm4329 compatible fallback.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
The Khadas VIM4 board based on Amlogic A311D2 aka T7 features an AP6275s Wi-Fi/Bluetooth module with a BCM43752 chipset.
This patch aims to add this chipset with its fallback to bcm4329 compatible.

The original patch series is here:
https://lore.kernel.org/r/20260326-add-emmc-t7-vim4-v5-0-d3f182b48e9d@aliel.fr
---
 Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index 3be7576787644..81fd3e37452a6 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -42,6 +42,7 @@ properties:
               - brcm,bcm4356-fmac
               - brcm,bcm4359-fmac
               - brcm,bcm4366-fmac
+              - brcm,bcm43752-fmac
               - cypress,cyw4373-fmac
               - cypress,cyw43012-fmac
               - infineon,cyw43439-fmac

---
base-commit: 45b2b84ac6fde39c427018d6cdf7d44258938faa
change-id: 20260326-add-bcm43752-compatible-e264a4f7973a

Best regards,
-- 
Ronald Claveau <linux-kernel-dev@aliel.fr>


