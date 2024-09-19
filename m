Return-Path: <linux-wireless+bounces-12999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 944FD97C490
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 08:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E4F1B21109
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 06:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305D918F2E3;
	Thu, 19 Sep 2024 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linuxmail.org header.i=cemunal@linuxmail.org header.b="CtKgCHma"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.com (mout.gmx.com [74.208.4.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D07A18E36C
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726729143; cv=none; b=ujcHgiboF4enppQWV015aG6JKpSuYIbhJI6JDm9ra7od5WP7RitpvM6COzqEi2bPDnUCNKcSDwAOQgDmSKeUmfr+/mf3UnbZW4nemcdnOOGonbVkQwxMv3qsPz+MNDmWnPMs218Dl+yzt+kBhkFn+rw6DSoee5oH1GZunhwqWdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726729143; c=relaxed/simple;
	bh=Jt4Plcy7z07BneLjiXcpnyCX27teLevcIZmFG+r0ebk=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=V3te4VTRlro4gnF4WxQFUzsQ8UGTv6rO7Db9OLzBoGqV2Kp0bCJrpTAke+ehdSYGnRLRpdgG+xZBRObRs3hzrVZwhb+WjjSzEIiJ8DtQAFaY/a/lrAAmB7qHtMoM3jcIXQtix3Lxwl8WcjALsfQx8Mppuvmtk+kxq9NHgcmiXM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxmail.org; spf=pass smtp.mailfrom=linuxmail.org; dkim=pass (2048-bit key) header.d=linuxmail.org header.i=cemunal@linuxmail.org header.b=CtKgCHma; arc=none smtp.client-ip=74.208.4.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxmail.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxmail.org;
	s=s1089575; t=1726729137; x=1727333937; i=cemunal@linuxmail.org;
	bh=Jt4Plcy7z07BneLjiXcpnyCX27teLevcIZmFG+r0ebk=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CtKgCHmaEH0ewQpW1lv+xwfwejQBeYUIannVoxut/BGr5pEhozh2Djz44no2O8cE
	 yPpVX/pWbDP7Wr3kU1yYX9rIZvPzWWNFv7HaQvodx7t4Kp5MNwVn4L1pyBy2/rRz2
	 T3AJz6T1CVNRkA4bBE4LgidXjn93+sFus4jKh61CYbuLk9UsXM7FXd7EYiz1qUGtF
	 gaLgvFJMoq9TJcNJftii6I1/CcPKHPZKr3OXH9/N5rk5cvkajglDQ8tjvSE+0GeAd
	 WUXBZQeTNux0ra2E85UM/yoZo0H80F2DjvvhjZIN72cyRryfPXcZ5ZJ2MvWCoC338
	 uZYASWFAI0AZFNK7Aw==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [188.3.12.169] ([188.3.12.169]) by web-mail.mail.com
 (3c-app-mailcom-lxa06.server.lan [10.76.45.7]) (via HTTP); Thu, 19 Sep 2024
 08:58:56 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-f8267b6f-c5ce-46cd-8fd3-3e2fb10613b2-1726729136948@3c-app-mailcom-lxa06>
From: =?UTF-8?Q?Cem_=C3=9CNAL?= <cemunal@linuxmail.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: RE: RE: RE: PCIe Bus Error from rtw_8821ce
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Sep 2024 08:58:56 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <ee1680e0f3e1460d8228ebecfd8e95b9@realtek.com>
References: <trinity-7a84c76b-e8b0-4da8-8f8c-07ad3485a23d-1726560422197@3c-app-mailcom-lxa11>
 <6d0fc72b21794f73a6017b467a102500@realtek.com>
 <trinity-154f2ef3-0df7-4802-88fc-d2ddcfb70a52-1726643761105@3c-app-mailcom-lxa04>
 <71107862cf8e451ca19c1dac72a51b4a@realtek.com>
 <trinity-dd463594-7071-49e4-8e07-e6c885c189e3-1726660668932@3c-app-mailcom-lxa11>
 <ee1680e0f3e1460d8228ebecfd8e95b9@realtek.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:WE4a5yZdBS0EWcqRs0c3QUQLt4JDutg6velBt3F1E9ZyVB07a+C5d+PhQ8OuG8HdEtCb8
 Ij00KMqfPLphO576I/I7UGnpJzyNHrSI2eiiGfTjUOgNxjoSNptuIUAgRhyzGCf62d+LFpiOLTws
 owuN/aLEGGrxf7uwp50HkAn36MSGJnzJlhMImHLrRi9NxGw3V6KOpV5KLuuQWRf4x6TaeTk7mSHj
 1HE8J7vYkgNNbNxLWFQZfMtwuKvhwORtDQq8nQGYxws2Nj8KaVO662UrXDC5bn/HU3Lkhax4Evu9
 FM=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:t/9SQarkqF0=;ghD+osKe0Qw4AmH2NmJn+XKSmJT
 rFMNKwCYUZqn3V5KNAgldxPM5jBT6lumvShjP53w8QwWkvljtMjMxO8reqXeUDXKt16lkqk/d
 mJEY7XVgGYz549WKs7OA/GFyonZLezwO7/5MdSU5r1W2KXuDQP0jUVa6gmwsf3hdkBNdDfmC+
 yB9RhfVTafFgqdBy1lAIBRylgmx/d/bc6g7Rva+35MpUm1MSzDNEs3iyvAno5VndvKN+T9zw6
 r+8r+BjtTqCqpClP7shFWOuaKCj0DBhpZ3GTmNuKKq4pdUfX3OPblse+88RUnRCH3vCh2AbbG
 +4HH7nNxYSye2Cij04Vg0176wiRAR1FrOJLpOShzmnVpRBdGE2yb289xuMtFfqjz5DLTUr9Jv
 STRiRZqYKXJUWgeqxpDYgjgzQuzh7oYl769/u+ifaBdNq+wOIE3hOi6k1ptXVSgoBFSQscg4r
 9jFLSVeA+REBzQMf/3wM1DAD+OgVOKKVstlOuV6WOLioxtyfwPy7eKZ4HPdtYdgJ8Cx+kDkMv
 VCu1V1giT56WTVe+EYLJ3PFn0g4AOi5YeweYrdKrVhZOTOaszXqKE++A2lXT56pJuPVVK9+AZ
 181QvgUg3jxECK5Y0gWV9hRtR/1NRyd6sFLLRgECL4Qy4MyBs1H8SpQXkIPZQDofQn4/uFdhR
 WRl2MBa8PHjMOHHu1f9L10Tmp/XE8K6gqcmvWapFSQ==

Thanks Ping-Ke but I am getting same error logs=2E I think the problem is n=
ot related about "power save"=2E

> Sent: Thursday, September 19, 2024 at 3:19 AM
> From: "Ping-Ke Shih" <pkshih@realtek=2Ecom>
> To: "Cem =C3=9CNAL" <cemunal@linuxmail=2Eorg>
> Cc: "linux-wireless@vger=2Ekernel=2Eorg" <linux-wireless@vger=2Ekernel=
=2Eorg>
> Subject: RE: RE: RE: PCIe Bus Error from rtw_8821ce
>
> Cem =C3=9CNAL <cemunal@linuxmail=2Eorg> wrote:
> >=20
> > Yes, checked and their values are set as "Y" and there is no options a=
bout PCI power save in the BIOS=2E
> >=20
>=20
> Additionally try to turn off WiFi power save by 'iw wlan0 set power_save=
 off'=2E
>=20
> This is the last try I have=2E=20
>=20
>=20
>

