Return-Path: <linux-wireless+bounces-29576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A84EDCABD09
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 03:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6DE93004F49
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 02:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C1C2F547C;
	Mon,  8 Dec 2025 02:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pJuGW456"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3502DC77A
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 02:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765159889; cv=none; b=g8ttjQn9iOmdqwhDE6bIQehSjpO500Fx0SrrTPXtxNOFmfngFwUwMyoUSzOe+E6mh6iO4fcgQgwHg3wgvMludKB/SCpoK2tSF9bp4TyrCaxp9c8zRhQZXP4Y1cf3Tx2hk/SKtvMh/UrLF2qA+Kf7uHv+iQWmLw3VRxd+EtGxEMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765159889; c=relaxed/simple;
	bh=P91gzKjNx/qscbzhdgcXMWFWaJ5RgHgJMRYiz0PEMPI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KZTj3irCLI990kHhtPDlX8BcWnwqa+OurnVzoN33fmpOAOfnE+v/lEPX9NLyDM2ttDAoyTzSVSmfiaLDgHZPgqQVdi/FjMppmkTfGoGnOG0CvFrB+rUKjDpZqamW9xhr/7Ykst+uKYc9VrL2B9g0mxeTlKvWRHKHksU/hxqKjiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pJuGW456; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5B82BIgE43107765, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765159878; bh=HySL71KNUlMtePGvxwL12dcF5klNYuPKp29w0QsYODE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=pJuGW456yjiYVOfsSV49NJnFyU9Hkfeq7asQMlWwrYkwlv7ZTjRWrGrg0wI06r7nJ
	 tJtl+P5fAtUoJPiGZuWSkSuvn67afe6F/un2wUxpkQQUEkFjuSW9uiydqoWQFnlUK/
	 xcWCZqfbXsZbwpWHS1blM+3dNP4JHHlh+LGtxCVSLOj1e+JW3UuK/4TZGhSYeVQ+xZ
	 AQIbplmykeQ75UkSUo18MRiGn6HSFnVV8gSujf9OkdgX7lr8Ljcn1LXGTV/oQoxWfk
	 ge4QCmfvJyu/dG7lLA2gfOz7r/kIbDf/hoMy8/T0mltZHfS6fcMeOCyeFnDGtbD6q+
	 lGCaOcnJB9j/w==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5B82BIgE43107765
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 10:11:18 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 8 Dec 2025 10:11:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 8 Dec 2025 10:11:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::2fa5:eccb:34ee:7bb%10]) with mapi id
 15.02.1544.027; Mon, 8 Dec 2025 10:11:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "marco.crivellari@suse.com" <marco.crivellari@suse.com>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH rtw-next] Revert "wifi: rtw88: add WQ_UNBOUND to
 alloc_workqueue users"
Thread-Topic: [PATCH rtw-next] Revert "wifi: rtw88: add WQ_UNBOUND to
 alloc_workqueue users"
Thread-Index: AQHcZt66JkU/0qBLKkWq0rXfVDO7QLUW53QQ//+MloCAAI1Y8A==
Date: Mon, 8 Dec 2025 02:11:17 +0000
Message-ID: <c5ea34777592402caeb7fb83af7d6f07@realtek.com>
References: <dcf31afec1614ce0b5e6c6d7f8cd2cb9@realtek.com>
 <20251208014243.3512-1-zenmchen@gmail.com>
In-Reply-To: <20251208014243.3512-1-zenmchen@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Zenm,

Zenm Chen <zenmchen@gmail.com>
> Hi,
>=20
> Last weekend I tried applying the v1 [1] to the kernel 6.17.9, but that o=
ne didn't work, either.
>=20
> [1]
> https://patchwork.kernel.org/project/linux-wireless/patch/20251113160605.=
381777-3-marco.crivellari@sus
> e.com/
>=20
> [  306.035759] usb 3-2: new high-speed USB device number 5 using ehci-pci
> [  306.162258] usb 3-2: New USB device found, idVendor=3D0bda, idProduct=
=3Db82c, bcdDevice=3D 2.10
> [  306.162272] usb 3-2: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D3
> [  306.162278] usb 3-2: Product: 802.11ac NIC
> [  306.162282] usb 3-2: Manufacturer: Realtek
> [  306.162286] usb 3-2: SerialNumber: 123456
> [  306.239143] ------------[ cut here ]------------
> [  306.239148] WARNING: CPU: 3 PID: 2886 at kernel/workqueue.c:5667 alloc=
_workqueue_noprof+0x676/0x770

I think this is because kernel 6.17.9 defines:

__WQ_BH_ALLOWS          =3D WQ_BH | WQ_HIGHPRI,

and the latest is:

__WQ_BH_ALLOWS          =3D WQ_BH | WQ_HIGHPRI | WQ_PERCPU,



