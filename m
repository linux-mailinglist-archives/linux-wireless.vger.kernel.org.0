Return-Path: <linux-wireless+bounces-29370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B866C8D184
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 08:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C81F4E056B
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 07:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1382254AE1;
	Thu, 27 Nov 2025 07:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FKS5E4II"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412BC12B94
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 07:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764228592; cv=none; b=mh9uobXiVxc421Hh6FyavlU1KcczbPzZ3rzsb8iip2xY7XNu57JlGsuRdNxMg2sNPvka0llBhLVNvmr9NVjz/o//IrLYVoH6QLw8bZllkezEuKfQYHYOv7YXZF/BrmMk1oZqnuykKzbkC+AEKd2xhi1CwyyEAejyH0T351LHSF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764228592; c=relaxed/simple;
	bh=aeb16qWV6LdNV6A/VkICMjQSqVLaKQ6xPsy7SacqiaE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9EG9ndLTr5zwq/pTVPjWarKj9zANQZ/acPenzOHHnUf/VV2hamNwKkH/VZErDuewtv307Dw1XYH/NhPHCO4JKzSh5jrHMm8Zo5SyMMZ7HOMeMJXwhpM66FOyp42GsbB//br/eqRGd2iUySLUZdqVJlPFcfDqNrByFrYrTAfafE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=fail smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FKS5E4II; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=yequqnhqivgkdmpuiowybaonaa.protonmail; t=1764228581; x=1764487781;
	bh=aeb16qWV6LdNV6A/VkICMjQSqVLaKQ6xPsy7SacqiaE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FKS5E4IIYGHAg2RTVKv7LIM+zEfefzPah0Bee27NEjMq/odVJdqB0YdBTN87xSXcg
	 B70Tvrt8ZwBIDBEavoPnFiJcfKHg49xQYQMHkxEMgbb9bvd5skBCQ3TCgS0CtzbZxM
	 s59QPhiudEmv9523B9OEMlOyHgfGnMmgnFkEkZy1vcjl2zSFhDQtXsKGjv4FkAr6zk
	 aNT89T+z0NzXDROTjey87wjUgM3EcPpf9lcFoVPPMU6uxwaP5JfBl2pCcja5nKw69c
	 XjkeAg9L9JfY4kKe35Xz8Zz1FlsoFQ/QrZECIEUHvC5p6U8N7UYLorkzMZQOQ2pZT6
	 wgG+gRXGlkVLg==
Date: Thu, 27 Nov 2025 07:29:37 +0000
To: ath12k@lists.infradead.org
From: Alexander Minchev <adminchev@proton.me>
Cc: linux-wireless@vger.kernel.org, Alexander Minchev <adminchev@proton.me>, Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: [PATCH v2] wifi: ath12k: remove redundant pci_set_drvdata() call
Message-ID: <20251127072839.14167-2-adminchev@proton.me>
In-Reply-To: <20251127072839.14167-1-adminchev@proton.me>
References: <20251126170213.27959-1-adminchev@proton.me> <20251127072839.14167-1-adminchev@proton.me>
Feedback-ID: 99141252:user:proton
X-Pm-Message-ID: 224bf10dde5090112663872aeb2303fe6d8ab983
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

pci_set_drvdata() is called twice in ath12k_pci_probe() with the
same pointer. Remove the earlier call so drvdata is set after
ath12k_base and ath12k_pci initialization is complete.

Having two calls might suggest that drvdata needs to be set early for
some reason, even though it is not used until after the 'ab' struct
ath12k_base is fully populated. Even though exact placement is
not critical, keeping a single pci_set_drvdata() at the end of
the initialization makes it clearer that drvdata points to a
fully initialized structure and avoids confusion for future changes.

Tested on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SIL=
ICONZ-1.115823.3

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Signed-off-by: Alexander Minchev <adminchev@proton.me>
---
 drivers/net/wireless/ath/ath12k/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/a=
th/ath12k/pci.c
index a12c8379cb46..7bf98618ac1e 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1580,7 +1580,6 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 =09}
=20
 =09ab->dev =3D &pdev->dev;
-=09pci_set_drvdata(pdev, ab);
 =09ab_pci =3D ath12k_pci_priv(ab);
 =09ab_pci->dev_id =3D pci_dev->device;
 =09ab_pci->ab =3D ab;
--=20
2.52.0



