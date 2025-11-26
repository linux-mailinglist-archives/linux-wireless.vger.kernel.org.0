Return-Path: <linux-wireless+bounces-29362-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB36BC8B1D9
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 18:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 869053491E8
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 17:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CF323D7CF;
	Wed, 26 Nov 2025 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="MxpdJt6R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED4C1F4CBB
	for <linux-wireless@vger.kernel.org>; Wed, 26 Nov 2025 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764176605; cv=none; b=kKkr0chg/VMhPm44Czr4EW9pzATuQcFG+5hT28KPtaTKUvMvSDbYwkBaVHmprlo1AbluURvQPNKfJEHwn8yhbpc/gZYRDGoVbrce9K/o0WSd6/WWkr+/YAvC6Ht/ppG6T7JHEyLIlF3x1DLsVfUj98CutG4oYl/o6XPBQEfVxpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764176605; c=relaxed/simple;
	bh=6j+jbzOlKqdDHKKPf+IwztOjhFfj+0D9HMObucyXHpg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OtHAa/f5Q3WSUErDjq5Gd/vWWLcRjAYEG3BrdESjQ/T3/Yjvm+KVi/X1yApkt63p/mecJnU1Dv7PaizWbcgFbHm8RGePscCCkXXXFh1ZbpAPnHsN1lVI2il3ckMROOET2mzeri0dR5balDBETUsk+CpmEXUIyJDyVUbTBSFtIMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=MxpdJt6R; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1764176592; x=1764435792;
	bh=6j+jbzOlKqdDHKKPf+IwztOjhFfj+0D9HMObucyXHpg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MxpdJt6R2VsFFj/eGOSFOZEOaYJimqU8m5RguipikwSm8Wh9lQ1EiLs4sxR85uo6N
	 edxINToGhvHH6rz6c2YkpfUde4G//rVThGY5+1wzLZemyClA5Bif3O/IjzldaaI2Rb
	 /aajEtMvTFBBidyYVhGST6cR+E1xEPbakABu+n+60f7lJuPzZsz7ywavnUTHZC+6Zf
	 vkgoVywBssCPmIkJN9GdnTMbZnWKSqe6bqa/wwarW9mbstZReTa02W1rVWtTQPypzz
	 kNYpoqsR6JyzfJdBmbzxU0O5Y9OKJXLs25ovpysqoNYwc0X/3dWkf3i+pE12jACtgp
	 3NGUWPdhF4E3g==
Date: Wed, 26 Nov 2025 17:03:04 +0000
To: ath12k@lists.infradead.org
From: Alexander Minchev <adminchev@proton.me>
Cc: linux-wireless@vger.kernel.org, Alexander Minchev <adminchev@proton.me>
Subject: [PATCH] wifi: ath12k: remove redundant pci_set_drvdata() call
Message-ID: <20251126170213.27959-2-adminchev@proton.me>
In-Reply-To: <20251126170213.27959-1-adminchev@proton.me>
References: <20251126170213.27959-1-adminchev@proton.me>
Feedback-ID: 99141252:user:proton
X-Pm-Message-ID: 06f2652ddaa9c14676e7e7810369f8a69366e552
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
ath12k_base is fully populated. even though exact placement is
not critical, keeping a single pci_set_drvdata() at the end of
the initialization makes it clearer that drvdata points to a
fully initialized structure and avoids confusion for future changes.

Tested on: WCN7850 hw2.0 PCI
WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

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



