Return-Path: <linux-wireless+bounces-15321-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662259CD9CA
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 08:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8FB8B21A75
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 07:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC5C174EE4;
	Fri, 15 Nov 2024 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="KpbJEhfi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389A8523A
	for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2024 07:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655194; cv=none; b=VZrEbtY281awhSkwkPhQduboNQeh0gWwsctuinshsu6Yge21FqaR/BYXL2DinZuO4p82xHGiuDSVfe6yxPyogc4Hv8NnRBjKYw1Sj7uUK6K3eNVRSbCGHwD9HQbMONj7uPBM/SqGwZ3O2x08EOshVSCrvoNI6Ed4x2eunz1ZZSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655194; c=relaxed/simple;
	bh=1ekfyA2urzfnuQZsJGxgci+jDT59XLSGc6DXjz3tnK4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MXZ/Ej9x5yKi9v6Yvtta/07HqDIqTQH24UHyjRtZbLpNXXTlzFeNj2RA+xytE7GIu/DoM9k6/rUtlgVaxZuCirWuUh7g093WLHXuVzw4IKXomkIJuL+mOQEc5JEl1vsuu0s+sLIuXpzrEpfcjy6KoPAvKgpba+9umE2N6BJzxpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=KpbJEhfi; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AF7Jkn36098412, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731655186; bh=1ekfyA2urzfnuQZsJGxgci+jDT59XLSGc6DXjz3tnK4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=KpbJEhfi/CrVlY5sStB1JCTUif+10clbcD/2SYyfBw0WVtcMOdNhpG1JdMbIQiSB8
	 78h6qud/Uow/Dp+jHB70Ej2oR498oaB3SFuGC+h8Fmpekn1li76mfspCbNP4qn3LDp
	 Obe9Kbqed3ACPy2PXKUAOPpgIuWPng79zsbPS+H1Ji54TkLa+nYIufMbOATotyhOF3
	 gzsB4kDDW64fmGwlihedtjCLH2X7MGc6oU4F8d8203OgJ1G//S1SWQLKgi3/LJ5uIj
	 0UbIX/OtOJDzPQEaJTrN1da7Fj7R8arU9/dfU1uTkMHux/XKuWXNkBOKxg90FL/6Sr
	 VNWZeeq25Q8BA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AF7Jkn36098412
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 15:19:46 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 15:19:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Nov 2024 15:19:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 15 Nov 2024 15:19:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Shadi <shadisalman11@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: Update regulatory rules for Syria (SY).
Thread-Topic: Update regulatory rules for Syria (SY).
Thread-Index: AQHbNpumlQ5/XbMpckmWH4NhUW2BDrK36H4g
Date: Fri, 15 Nov 2024 07:19:46 +0000
Message-ID: <19377941c0f6489b91e77431378cb074@realtek.com>
References: <UH0YMS.VC3MBEUCWKPP2@gmail.com>
In-Reply-To: <UH0YMS.VC3MBEUCWKPP2@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

<shadisalman11@gmail.com> wrote:
> I'm a Linux user in Syria. We don't have any rules dictating which
> frequencies we use indoors. However, the regulatory rules in db.txt
> specify only 2.4GHz networks to be used. This default behavior is
> currently not allowing us to connect to most of the wireless networks
> in Syria. Which are mostly 5GHz networks.
>=20
> Can you please update the regulatory rules so that the default behavior
> does not ban those networks ?
>=20

I can update the regulatory rules for Syria.=20

By page [1], the Short Range Devices Regulations [3] defines 2 GHz, 5 GHz a=
nd
60 GHz rules, no problem to this part.=20

The Regulations for local wireless networks [2] looks like to define
Wireless Local Area Networks (RLAN/WLAN) for 5 GHz, 4.2 GHz and 6 GHz.
I suppose we can also add 6 GHz rules (the range between 5925 - 7125)
for WiFi 6E, but the table in page 6 shows weird frequency ranges.

By Google translation to English:=20
 * 7171 - 7171
 * 7171 - 7371
 * 7151 - 7517
 * 7517 - 7271
 * 1123.7-1111
 * 75111 - 66111

Could you help to translate the table?=20

[1] https://sytpra.gov.sy/pages/%D9%84%D9%88%D8%A7%D8%A6%D8%AD-%D8%AA%D9%86=
%D8%B8%D9%8A%D9%85%D9%8A%D8%A9/%D9%84%D9%88%D8%A7%D8%A6%D8%AD-%D8%A7%D9%84%=
D8%B7%D9%8A%D9%81-%D8%A7%D9%84%D8%AA%D8%B1%D8%AF%D8%AF%D9%8A-%D8%A7%D9%84%D=
8%B1%D8%A7%D8%AF%D9%8A%D9%88%D9%8A

[2] http://sytpra.gov.sy/public/uploads/files/%D8%A7%D9%84%D8%A7%D8%B7%D8%A=
7%D8%B1%20%D8%A7%D9%84%D9%82%D8%A7%D9%86%D9%88%D9%86%D9%8A/%D9%84%D9%88%D8%=
A7%D8%A6%D8%AD%20%D8%AA%D9%86%D8%B8%D9%8A%D9%85%D9%8A%D8%A9/%D9%84%D9%88%D8=
%A7%D8%A6%D8%AD%20%D8%A7%D9%84%D8%B7%D9%8A%D9%81%20%D8%A7%D9%84%D8%AA%D8%B1=
%D8%AF%D8%AF%D9%8A%20%D8%A7%D9%84%D8%B1%D8%A7%D8%AF%D9%8A%D9%88%D9%8A/5.pdf

[3] http://sytpra.gov.sy/public/uploads/files/%D8%A7%D9%84%D8%A7%D8%B7%D8%A=
7%D8%B1%20%D8%A7%D9%84%D9%82%D8%A7%D9%86%D9%88%D9%86%D9%8A/%D9%84%D9%88%D8%=
A7%D8%A6%D8%AD%20%D8%AA%D9%86%D8%B8%D9%8A%D9%85%D9%8A%D8%A9/%D9%84%D9%88%D8=
%A7%D8%A6%D8%AD%20%D8%A7%D9%84%D8%B7%D9%8A%D9%81%20%D8%A7%D9%84%D8%AA%D8%B1=
%D8%AF%D8%AF%D9%8A%20%D8%A7%D9%84%D8%B1%D8%A7%D8%AF%D9%8A%D9%88%D9%8A/L1.pd=
f



