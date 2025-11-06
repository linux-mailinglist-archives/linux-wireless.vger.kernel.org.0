Return-Path: <linux-wireless+bounces-28642-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3DAC3883B
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 01:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2B174E9E65
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 00:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF451145FE0;
	Thu,  6 Nov 2025 00:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZrE8zUUy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6150FCA52;
	Thu,  6 Nov 2025 00:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390086; cv=none; b=jIWKZpx+vLf04RlRe8tQiO9q7ipXz4G9kWPvD123R+04RkRpXUJMeL3F2jWcLDsdmTjUo6z1rTD/A4RSV5wZQj9OsQIOyro9YyFAWZ+yVvtUvW6xrGvOpqrxjgZ6W0vRICs7xSDbuZ/qj52UQfrBAz4rpaNIi8sKDTXhBZoEWDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390086; c=relaxed/simple;
	bh=uaKL6lhEQeACMML1EXw6l59dK4hnNOMSzI0H3qUqppM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AMC8Iv1ZO4iDRNUvVGABax6L/FZZ+SvBY+5D1XMZ0QRF0UpWpzhmrYfK6EDm1jscvdzrv9fIlXdfkZhOcHYrlm4csa0kPKQkA5OWxKcd2KUBfLHK26Y19PXrdXUcs7FvX5MHf2egO/2tc0QO7WflilCYEe/mLi7C+iu/o855K6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZrE8zUUy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A60lwM832079079, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762390078; bh=/10ERdKAjHAnTJ9B3wlMyTnBTsS/68fs0Nb7m0Vmyo0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ZrE8zUUyemgUfAZaQ76HEEQqZYHeZQWUTvlRM0cZmWDpZ6xCN+9T8GrC7obROfvYC
	 eLn2z+CIy/fuB7WohLCN5OJuAeLGnSit7jiHZ97wwL7Y9sWNGw2QYBIU2pPC8ds8I3
	 UzVeu0ZjQ6PEifyjUjPkTVCDFiEW2JFul9EJEkQ4FUMRHxjFhZfA2elgDG4tY0IHuy
	 8PLtAyHXjFoogqWH/mpTGGlqjv2Yn+cCRoGJ40H+krUMZQDFWv/sjlpJB7G+u3JF7H
	 IwHpQkZXffUAKlMd8kptUI2TbqB/2nHDYtvfq8U3Y6jS/iRnDNLNZeM66Eim7y61LM
	 N2Ei/H4lnVufQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A60lwM832079079
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Nov 2025 08:47:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 6 Nov 2025 08:47:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 6 Nov 2025 08:47:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Thu, 6 Nov 2025 08:47:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Harshit Mogalapalli <harshit.m.mogalapalli@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] rtlwifi: rtl8188ee: remove an accidental '-' character
Thread-Topic: [PATCH] rtlwifi: rtl8188ee: remove an accidental '-' character
Thread-Index: AQHcSmbpgJ0klacK4UCTMB6Tyko8vbTgKWCwgAOD1wCAASvT4A==
Date: Thu, 6 Nov 2025 00:47:58 +0000
Message-ID: <6ebf3019105c4d5b9a3170ce9bcf2ed8@realtek.com>
References: <aQSz3KnK4wFIJoe3@stanley.mountain>
 <8d6962531a9545fd8279fbc7cd04340c@realtek.com>
 <5c992936-4e7b-4c0a-abfc-0ec0fb9ef9fd@suswa.mountain>
In-Reply-To: <5c992936-4e7b-4c0a-abfc-0ec0fb9ef9fd@suswa.mountain>
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

Dan Carpenter <dan.carpenter@linaro.org> wrote:
> On Mon, Nov 03, 2025 at 01:17:07AM +0000, Ping-Ke Shih wrote:
> > Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > > Sent: Friday, October 31, 2025 9:04 PM
> > > The "->allstasleep" variable is a 1 bit bitfield.  It can only be
> > > 0 or 1.  This "=3D -1" assignement was supposed to be "=3D 1".  This
> > > doesn't change how the code works, it's just a cleanup.
> >
> > Yes, this patch doesn't change logic at all. However, it looks like exi=
sting
> > code is wrong, since other places in the same pattern in this driver se=
t to 0.
> > More, I check vendor driver which also sets this value to 0.
> >
>=20
> Ah.  Good.  Thanks.
>=20
> Could you send that patch and give me a Reported-by tag?
>=20

Sent by [1].

[1] https://lore.kernel.org/linux-wireless/1762390172-21091-1-git-send-emai=
l-pkshih@realtek.com/T/#u


