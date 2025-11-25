Return-Path: <linux-wireless+bounces-29299-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3664FC83097
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 02:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B6F3AE21C
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 01:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0AA1EB195;
	Tue, 25 Nov 2025 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="qjvZ0t0P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F6B1A254E
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764034864; cv=none; b=Z1MQHmXk1wqfpS9TmZdHyK5z3h9slSCJEkJaOCj5jXSbgDkF2swDn9uuntky55rYp17PKvtOIAMxyKojpVJYDsFyibF1nlpp3shErmrT+pYPLL4SHjIfPKgUbcjlpeUrBOexlBCphn42Up0jhf47Ne96R5voA2C9tIA4UUjR/1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764034864; c=relaxed/simple;
	bh=YmVDVTC/rB8xxMAZ/2+bimmSAzsWEzFSRO9EagC71U0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ccn5aa/UIkaRzFhcjuXRhWbee00S1WftObInI+KK2VMq5u1JJTktkEjX+CriSgk3MZ5rNqwTrU9pwxq+nZ6X3cp9vUkjct5H/B1cZ5kag7v3n/MWUUFYiyKel1E0cJwf2WGn20/uC+a4nn/X55xlIZFeZMKi+0Z7unpNq/yr19U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=qjvZ0t0P; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AP1euRvB2032969, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1764034856; bh=uLCLahdVSr4e8b1rz3GC7FMMBK8MiJiseenL6rWz4F4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qjvZ0t0Pw1Qe7K2zZjfoOccyfF4mVuy2WfDj+ZyR9T5HLoSbSCZmHDdaA9oDHaOHR
	 peqTKI4q7Ik3JNMHW2/PTk4jPqVFQiDFepw25AZSqcjl1YxAq5tSq/ztIwzUK2EF+u
	 63BDNqt0vS1SMTRFC+d19tOf1OUEzOdXNblRQQO2TmSr97dmx+X9zW3N/0vbICa7GN
	 XK57z8Anq9/Cgtl0+DBNlS57/P51/9wv8+n43SOeqcc0YjTF07DL46lltJLJySkKq2
	 XZo+LlILWbgaD5l4Y7BK2Buc3tvke15+s74yhGxUJNQMgxBQATl9XeW2Gqx/Mfrvbr
	 nkKJl6c6Z9O+Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AP1euRvB2032969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 09:40:56 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 25 Nov 2025 09:40:57 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 25 Nov 2025 09:40:56 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Tue, 25 Nov 2025 09:40:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "andrej.skvortzov@gmail.com" <andrej.skvortzov@gmail.com>
Subject: RE: [PATCH rtw] wifi: rtw88: limit indirect IO under powered off for
 RTL8822CS
Thread-Topic: [PATCH rtw] wifi: rtw88: limit indirect IO under powered off for
 RTL8822CS
Thread-Index: AQHcXau9OvPGih9a+EGdHV2cJ+wjGrUCnItw
Date: Tue, 25 Nov 2025 01:40:56 +0000
Message-ID: <799749958ece4b8e9a6f460c1b5aacac@realtek.com>
References: <1764034729-1251-1-git-send-email-pkshih@realtek.com>
In-Reply-To: <1764034729-1251-1-git-send-email-pkshih@realtek.com>
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

Hi Andrey,

Ping-Ke Shih <pkshih@realtek.com> wrote:

(for record for patchwork)
The subject missed to point out "sdio: " which I will add during getting me=
rged.

>=20
> The indirect IO is necessary for RTL8822CS, but not necessary for other
> chips. Otherwiese, it throws errors and becomes unusable.
>=20
>  rtw88_8723cs mmc1:0001:1: WOW Firmware version 11.0.0, H2C version 0
>  rtw88_8723cs mmc1:0001:1: Firmware version 11.0.0, H2C version 0
>  rtw88_8723cs mmc1:0001:1: sdio read32 failed (0xf0): -110
>  rtw88_8723cs mmc1:0001:1: sdio write8 failed (0x1c): -110
>  rtw88_8723cs mmc1:0001:1: sdio read32 failed (0xf0): -110
>=20
> By vendor driver, only RTL8822CS and RTL8822ES need indirect IO, but
> RTL8822ES isn't supported yet. Therefore, limit it to RTL8822CS only.
>=20
> Reported-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> Closes:
> https://lore.kernel.org/linux-wireless/07a32e2d6c764eb1bd9415b5a921a652@r=
ealtek.com/T/#m997b4522f7209b
> a629561c776bfd1d13ab24c1d4
> Fixes: 58de1f91e033 ("wifi: rtw88: sdio: use indirect IO for device regis=
ters before power-on")
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Could you please test this patch and give a Tested-by tag if it can fix iss=
ue
you encountered?



