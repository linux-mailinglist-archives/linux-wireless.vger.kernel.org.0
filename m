Return-Path: <linux-wireless+bounces-36787-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6D52A2cFEGqLSQYAu9opvQ
	(envelope-from <linux-wireless+bounces-36787-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 09:27:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C365AFFAC
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 09:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15C66303A8F0
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 07:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5D472617;
	Fri, 22 May 2026 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2i9Soqp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C76C38E8D3
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779434712; cv=none; b=qKvcHwRHKE/LqILhbh3lBYb2LhjAoj4PN04x9dzO42ko1lLapQiwfZ3eHmIYDzItgTOa44EXwF2g827mbmZfi2Jui7ieRMti4HnrTtqN0NIMlXCOBZQZogkDIwvhrgEjfk3BAsOF1MzStrFXd2YgKZMdXok+Y8XKdDxqCsZbKwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779434712; c=relaxed/simple;
	bh=Jl2nsxIoK7Iyzb1sRNo+F4RcLUpc+qqVsGAi3cNoslU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uZdJwl75Wws35nQutNvxKB24pIdm1wF3aGntUpfQ89w/q0NUfvJAjptQXgtxNE1D95im2UkL2YyNyzbRftP+Wr1l2jzk+PjPxJX8msadXP6je7B8uVbLULpFfK3Ks69xsVBDjNUx7FzAQCxW+cDWM9Ac4A3nglp0T40ZPms6LLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2i9Soqp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54E41F000E9;
	Fri, 22 May 2026 07:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779434711;
	bh=mJkyipvc3IqDM0RSCkuAPvsrzuqXuTst7xaupG3y5v4=;
	h=From:Date:Subject:To:Cc;
	b=T2i9SoqpC9ZJTEwxxzBRTBIa6nUIDPM9hRClfW9Vn1R1J2kMTyqyseFRzdlcfpkXt
	 YXRd4WbTgS4TYJget+H0U1pDJkHj43b4+pXNK2IOSXELWKYsPQ8YRNOAGEsBDJPQap
	 khJlKlIR4NvWyFBeu12k/Z5wgPQPwUaKvs1iYlKudy6udzX7Y1QjQMAcJJiRtiOVSz
	 cjq8HJ0qxYp8pSkAxNZcHVU5hHj6GLIJI4YqJTVjKoHWLS+hMn0m3+t36SWizN9CEm
	 skbodHXNJTPhhJYXIZbT2iJ+WOjukNsh5zIOqih/KQxHU4B5ofdh8/1gGlM6Uro742
	 Xgz4V+MFxCP0A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 22 May 2026 09:24:52 +0200
Subject: [PATCH] wifi: mt76: mt7996: remove redundant pdev->bus check in
 probe
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-mt7996-pdev-bus-fix-v1-1-c91716484365@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAvyI5G4gR6/IV8aA2ag4utFoE8e8Wj
 zMw84AXp+KhSR5wEtTrvkXI0gTGpd9mQbWRgYkNFcy4nmVdGzysBBwuj5PeSNJnOfFE1lQQy8N
 J1P+17d73A4IpCSRlAAAA
X-Change-ID: 20260522-mt7996-pdev-bus-fix-0ea1302f0d68
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Dan Carpenter <error27@gmail.com>, linux-wireless@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36787-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.infradead.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 64C365AFFAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Drop the unnecessary pdev->bus NULL check in mt7996_pci_probe() since
the pointer is already dereferenced earlier in mt76_pci_disable_aspm(),
making the check dead code. Silences the related Smatch warning.

Fixes: 377aa17d2aed ("wifi: mt76: mt7996: Add NPU offload support to MT7996 driver")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
index 12523ddba630..b7d9193e042f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
@@ -141,7 +141,7 @@ static int mt7996_pci_probe(struct pci_dev *pdev,
 	dev->hif2 = hif2;
 
 	mt76_npu_init(mdev, pci_resource_start(pdev, 0),
-		      pdev->bus && pci_domain_nr(pdev->bus) ? 3 : 2);
+		      pci_domain_nr(pdev->bus) ? 3 : 2);
 
 	ret = mt7996_mmio_wed_init(dev, pdev, false, &irq);
 	if (ret < 0)

---
base-commit: e9aeddfe98ebccd3761ac7dd316af4fb5de1c28a
change-id: 20260522-mt7996-pdev-bus-fix-0ea1302f0d68

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


