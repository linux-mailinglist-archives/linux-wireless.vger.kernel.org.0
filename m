Return-Path: <linux-wireless+bounces-34053-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ1wCE5Qxmk2IgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34053-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:39:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0899F341DE1
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 736FD3096050
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 09:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275943D6684;
	Fri, 27 Mar 2026 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="FgkXKXD9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from courrier.aliel.fr (pouet.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77D9379EC4;
	Fri, 27 Mar 2026 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604253; cv=none; b=YhEizAxG4RTcqXYx4+oY9VLsDP9lTJw2DZEXz7Ek7eraNAXfL9qho8QX4E2VGnWRcjZHb9Ilh1BnE4g7mpqfMx7LT+RY9ft7cBEzc409163ScqNkmLMoy70YnK4B6K+hbhb7WaSG9SdmwvNyHkg3Sx2zHhX+xebU45iHFKON8D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604253; c=relaxed/simple;
	bh=cCrKuuyOz5qG2rFBsp37cnDOUzhVXzOLst/bIvh8j+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hyIUSlx4DI6iMEn67ojhYCiWrfpUhapiQlSMi5mhlFbrbfhF9OAGQEZ/puNT5U4TD3a/aTxh7du08IkYq7SEfQvTYTRm6cvbN4zUV8baq6aEmP36VJ8P8hcu0OLGy/xuM6YA4rpZq8URAic+pQdtLm+8GqQEu6qjjlkMOlxXbvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=FgkXKXD9; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1774604242;
	bh=cCrKuuyOz5qG2rFBsp37cnDOUzhVXzOLst/bIvh8j+A=;
	h=From:Date:Subject:To:Cc;
	b=FgkXKXD9iXLEZQAnfELBmS7V93ht232DzX+JEbXFdYBrm7ChAVeXfp3e4l57j1nwF
	 itc5IBJlAL5t32cDWr7w6uKj4Ex9MEMNkSR3ohDEzo08OzlnzPUWyMBIhP+pjWCLTk
	 /7TdBBtXGuD8ux8M36dd/At3l4EklgM1VU9pg7eQ=
Date: Fri, 27 Mar 2026 10:36:26 +0100
Subject: [PATCH net-next v2] dt-bindings: net: wireless: brcm: Add
 compatible for bcm43752
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-add-bcm43752-compatible-v2-1-5b28e6637101@aliel.fr>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQqDMBBGryKz7hRN/F/1HsXFRMc6oFGSIBbx7
 g1eoMvH43vfCZ6dsIc2OcHxLl5WG0E9Eugnsh9GGSKDSlWZalUiDQOafsl1VSjs12WjIGZmZFX
 mlI9VU2mCuN4cj3Lc5TdYDmj5CNBFM4kPq/vel3t2+7/1PcMMjTYNFTUZXZsXzcLzc3TQXdf1A
 yPTs3THAAAA
X-Change-ID: 20260326-add-bcm43752-compatible-e264a4f7973a
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1774604241; l=1596;
 i=linux-kernel-dev@aliel.fr; s=id_ed25519; h=from:subject:message-id;
 bh=cCrKuuyOz5qG2rFBsp37cnDOUzhVXzOLst/bIvh8j+A=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgMGec55oxeeisqykQiUedekMYyOnR9
 BG9E/7rDWyqdNoAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIfB4fa5UnaYIw0QLG9SkKH5Df9Rhm2DOTJfIGNKliU28PbcrWWyEMIDqEabsSl4xy16qD9S7fD
 B1ndbnYkdBgI=
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-34053-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[aliel.fr];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[aliel.fr:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux-kernel-dev@aliel.fr,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,aliel.fr:dkim,aliel.fr:email,aliel.fr:mid,microchip.com:email]
X-Rspamd-Queue-Id: 0899F341DE1
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
Changes in v2:
- Add netdev in CC.
- Link to v1: https://lore.kernel.org/r/20260326-add-bcm43752-compatible-v1-1-b3b9a58ab38b@aliel.fr
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


