Return-Path: <linux-wireless+bounces-29988-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF83CD1D68
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 21:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CB033003FA8
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 20:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53A9341AB6;
	Fri, 19 Dec 2025 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SJ0ZO+GM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E9D2E093E
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 20:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766177427; cv=none; b=AnN4cqViL0lvRo6B9FejcAQ0IMZYgAruL5GcKz/N19WC4VBgePyEmYONL05ZlTtnpdQcGL6anfP4gNRsOW3OBuXIV/6sOeRrF9yREsqoC6vUv7A7kuEtE4uvIEzaS7q8nmOjbRDoFNTH5qarRUVR6Uw+xgS7btRhmiOyCQ1AJ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766177427; c=relaxed/simple;
	bh=LgO+Zt6JaQWb39Yj1QsW4A1EaI3Ls/K898yAdxRAz2A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FDdC5prfI7X3f8jfh82Z8YtkqvHzSo7+3mOWBPhuHw/aVwFKCtZM9fCCBoroZvzzycFqxgkqHeZZyeo7cDrvYgozAyGl4FRpbLfFM3NcfqHJuj1OMEgCvYshpMChySRRlg9+ZPwKgBWtNzcY2ZlfdHgzuW0j1CcAuYPPAXycPl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SJ0ZO+GM; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766177416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LgO+Zt6JaQWb39Yj1QsW4A1EaI3Ls/K898yAdxRAz2A=;
	b=SJ0ZO+GMFeFboBd/whRfMpOQq3lufle+NcG9y7I0VXiB5ZDNRO1qGMbcgBVoG99JAM3ECL
	vEA2Ih8CrTNwT4RqJ0JekLOhxQPaje+ypt+yXhnI+DChKaONIm98CcnYm62wJSqXaEjaDz
	k3iCFBuc0TVBDAc2nJpzT+v+duZGLW4=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.11\))
Subject: Re: [PATCH v2] wifi: mt76: Fix strscpy buffer overflow in
 mt76_connac2_load_patch
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <20251205161202.48409-1-mikhail.v.gavrilov@gmail.com>
Date: Fri, 19 Dec 2025 12:49:50 -0800
Cc: Mario Limonciello <superm1@kernel.org>,
 Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 linux-wireless@vger.kernel.org,
 linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B33EA87-6175-472E-AFA3-88A08ADE1E27@linux.dev>
References: <CABXGCsMeAZyNJ-Axt_CUCXgyieWPV3rrcLpWsveMPT8R0YPGnQ@mail.gmail.com>
 <20251205161202.48409-1-mikhail.v.gavrilov@gmail.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
X-Migadu-Flow: FLOW_OUT



> On Dec 5, 2025, at 8:12=E2=80=AFAM, Mikhail Gavrilov =
<mikhail.v.gavrilov@gmail.com> wrote:
>=20
> Commit f804a5895eba ("wifi: mt76: Strip whitespace from build ddate") =
introduced
> a kernel panic/WARN on systems using MediaTek MT7921e (and potentially =
others
> using mt76_connac_lib) due to an incorrect buffer size calculation.
>=20
> The error logged is:
> "strnlen: detected buffer overflow: 17 byte read of buffer size 16"
>=20
> This occurs because the field 'hdr->build_date' is a fixed-size array =
of 16 bytes.
> The patch allocated a 17-byte local buffer 'build_date' but used =
'sizeof(build_date)'
> (17) as the read limit for strscpy, causing Fortify Source to =
correctly detect
> an attempt to read 17 bytes from the 16-byte source field.
>=20
> To fix this, replace strscpy with memcpy, which is appropriate for raw =
data
> copying, and explicitly use the size of the source field =
(sizeof(hdr->build_date) =3D 16)
> to limit the read, followed by manual null termination.
>=20
> Fixes: f804a5895eba ("wifi: mt76: Strip whitespace from build ddate")
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Ran into this kernel panic while booting into 6.19-rc1 on my handheld, =
this patch fixed it.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>

> ---
> drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c =
b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index ea99167765b0..d2c4c65ec464 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -3125,8 +3125,11 @@ int mt76_connac2_load_patch(struct mt76_dev =
*dev, const char *fw_name)
> }
>=20
> hdr =3D (const void *)fw->data;
> - strscpy(build_date, hdr->build_date, sizeof(build_date));
> - build_date[16] =3D '\0';
> + /* hdr->build_date is 16 bytes. Copy exactly 16 bytes to the 17-byte =
buffer,
> + * and then add the null terminator at index 16.
> + */
> + memcpy(build_date, hdr->build_date, sizeof(hdr->build_date));
> + build_date[sizeof(hdr->build_date)] =3D '\0';
> strim(build_date);
> dev_info(dev->dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
> be32_to_cpu(hdr->hw_sw_ver), build_date);
> --=20
> 2.52.0
>=20
>=20


