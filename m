Return-Path: <linux-wireless+bounces-28645-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A03C38BE1
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 02:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A25C734FC56
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 01:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733A22144CF;
	Thu,  6 Nov 2025 01:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="PJjP3HNq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9CB191
	for <linux-wireless@vger.kernel.org>; Thu,  6 Nov 2025 01:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762393864; cv=none; b=T/sQrVha0Q2BWGY3B6hrv6HfC/+ZFql+Lp03Qm37xESz03X7/G2sx7DP5by8L2p7P//R4Q7nAwWMsjTCuKCVXFBOdjO8tjp7mhsMIxVPPNmn2pIucnEzX5r62ZRYK5QkVP3eK4HeWrzSCIqsW3dY4dUUs/2LgLC0E8XjmxL5KbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762393864; c=relaxed/simple;
	bh=qfmvX+lFub9aFvDogyapA9eARnqCQv29tVp71Wuc8RQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PCSNIMRwvDNb6Ak/c/LdX7evsPtY07ntohVTi3/tW5iKX2tBkyjYJgoxPFbY+BsA7wmj1/NeFx56TKFXfRj8qQHlx0O5KCh0/OY133Xr8vuQh7LyORgSpju/2W+8DKfjPAyJc4l9YfFWhYa7k/fVXc2DwNq5P3b81DTOV07LA+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=PJjP3HNq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A61orPwB2168297, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762393853; bh=qfmvX+lFub9aFvDogyapA9eARnqCQv29tVp71Wuc8RQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=PJjP3HNqPEUtHvK1rcSf2/cCVs5l/2FoIPDyFgjgpOcPy8yPG+MlXZ5NneNmxlBiJ
	 LzD/xniIsslvXk7Hv1P8M44X3yg52/Up2MFj86Dy7LhhcC2SUln/y0LEfgjE7fzenr
	 K4EF1CoXLxDTHF1/kiGF4tSC0mQl8AshL+rIpPl2Cgvp/F4Ir2X2r/dtV6ZHPKIIZ0
	 c9h4qTTunIF5Wi9Yq69TeWeM3JWtIj5YQSI+gHk8iHrzMDAupgnNhU8eUO73ce8OZH
	 3p+QgIlq1TVP2UhF732nHqgUrE4WK6ScS5DpluZdAN+lxSNONwFPITf/KBoRiBNi5H
	 R17m46AL4s3cw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A61orPwB2168297
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Nov 2025 09:50:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 6 Nov 2025 09:50:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 6 Nov 2025 09:50:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Thu, 6 Nov 2025 09:50:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Timlee
	<timlee@realtek.com>, Zong-Zhe Yang <kevin_yang@realtek.com>
Subject: RE: pull-request: update rtw firmware rtw-fw-2025-11-04
Thread-Topic: pull-request: update rtw firmware rtw-fw-2025-11-04
Thread-Index: AQHcTVWDwVYHJS/OqECSpY3xKh7z3rTk5IRg
Date: Thu, 6 Nov 2025 01:50:52 +0000
Message-ID: <9b7e38119bc348df9aee5d6078da8f0e@realtek.com>
References: <6896693c-d69a-441f-90d3-0c9ee850eb78@RTKEXHMBS04.realtek.com.tw>
In-Reply-To: <6896693c-d69a-441f-90d3-0c9ee850eb78@RTKEXHMBS04.realtek.com.tw>
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

Ping-Ke Shih <pkshih@realtek.com> wrote:
> Hi,
>=20
> The RTL8852BT v0.29.127.0 and RTL8852B v0.29.128.0 need new BT-coexsitenc=
e
> flow to support them, or BT will get degraded performance. So, revert the=
m
> and re-add them with increasing format suffix. When driver updates
> BT-coexistence flow, it will declare to support these new format.
>=20
> Others are to fix XTAL issue for PS resume, including RTL8852BT, RTL8852B
> and RTL8851B.

Please drop this patchset. I will re-spin a new one. Sorry for the inconven=
ience.=20


