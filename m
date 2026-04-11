Return-Path: <linux-wireless+bounces-34649-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJAsEGb42WncxQgAu9opvQ
	(envelope-from <linux-wireless+bounces-34649-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Apr 2026 09:29:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 663893DEAF3
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Apr 2026 09:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D970230115BD
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Apr 2026 07:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183D632F764;
	Sat, 11 Apr 2026 07:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="rYHJu+pp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04A32D2381
	for <linux-wireless@vger.kernel.org>; Sat, 11 Apr 2026 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775892578; cv=none; b=LNIxscnmFyMKVRO8SyfnrStpeh+BiQ+rs6MheVOOfjrMPeeeFykNWSt6vu1i2j6crSXIpVMrjZZ9ZYOk6d4b1+gxEGbKaERKYhV3FZZwGLXBdmffcUfjx8JG+dP5EU643CxSlLr0hGs32/QaJb8O1g59nfcakIVoP6SwQvBXPeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775892578; c=relaxed/simple;
	bh=xXQV26n3pJtSB9gxfUKFJ3lZsT9VDoFdU4gDVbn6K+g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XZ6VFOQNNYcBawRaS9Fe4lXmYJghAQGZjc9vlQStwVlK030kbXjvOSQWe0169OU6d4tofipVjpP0fNl0jHjJLKd3y/wW/Mu1CUKNtM9r1i145JvFDkuB8bfHnh7Ul6FktyGKqy1eZr0Vz4PIQLG2g+2162Zb+GTMMz5Sh9iDVzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rYHJu+pp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63B7TRwrC169401, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775892567; bh=gGd2TLj1K3ibbEUkvifNG8T1HeZUI3mw75wQ2pDOJdw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=rYHJu+ppcV/hHEaUXygc4q9rMf63ukExG2MtF7+V6CZFxdV2vYigEawmuXANkfOdI
	 2+XWp8S9fVvfjFXRaDlSBjdF25vhEiHu3H9gwgOKIP6q70t6AgDvnMJkt6pQgFfuz5
	 JnT7zz1o0CFXn8auVYbkS0aXNzG+FUZJiWE5pxK4wAQScXKaYkQJnaA9fg4MWncgSB
	 Fd+mkjnmmYdMum+ETBmiIEsHceTz3jGUYUNl/k6lcqhBKp+uyVtCy60RiE/s8EsgDp
	 Xy0V7+0cgl73Ayp64EpoBLocmk2zZPcPRu8C6lDkt8zzbUTWfHkDTB6z75t8AHpNP3
	 XkN5X9RcIPsnA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63B7TRwrC169401
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Apr 2026 15:29:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 11 Apr 2026 15:29:23 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Sat, 11 Apr 2026 15:29:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "lkp@intel.com" <lkp@intel.com>
Subject: Re: [PATCH rtw-next] wifi: rtw88: 8814a: add __packed to ensure efuse
 map size
Thread-Topic: [PATCH rtw-next] wifi: rtw88: 8814a: add __packed to ensure
 efuse map size
Thread-Index: AQHcyOy6g5W5Hl8CYkShQRvxGKKftrXX6gIAgAGNEiQ=
Date: Sat, 11 Apr 2026 07:29:23 +0000
Message-ID: <c97d9fcb628a4a5a94d041c63da1c711@realtek.com>
References: <20260410131353.1550803-1-pkshih@realtek.com>,<7c65e315-5a2e-455e-87ee-8fc6d60ed807@gmail.com>
In-Reply-To: <7c65e315-5a2e-455e-87ee-8fc6d60ed807@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34649-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 663893DEAF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> On 10/04/2026 16:13, Ping-Ke Shih wrote:
> > All nested sture/union used by efuse map should be packed. Otherwise, a
> > arm-linux-gnueabi-gcc compiler might throw errors due to size assertion=
.
> >
> >=A0=A0=A0 In file included from include/linux/bitfield.h:10,
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from includ=
e/linux/fortify-string.h:5,
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from includ=
e/linux/string.h:389,
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from includ=
e/linux/uuid.h:11,
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from includ=
e/linux/mod_devicetable.h:14,
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from includ=
e/linux/usb.h:5,
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from driver=
s/net/wireless/realtek/rtw88/rtw8814a.c:5:
> >>> include/linux/build_bug.h:78:41: error: static assertion failed: "siz=
eof(struct rtw8814a_efuse) =3D=3D 512"
> >=A0=A0=A0=A0 #define __static_assert(expr, msg, ...) _Static_assert(expr=
, msg)
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ^~~~~~~~~~~~~~
> >
> > Fixes: 1a7545784642 ("wifi: rtw88: Add rtw8814a.{c,h}")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:  https://lore.kernel.org/oe-kbuild-all/202604101721.fsv5XmCX-lk=
p@intel.com/
> > Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> > ---
> >=A0 drivers/net/wireless/realtek/rtw88/main.h=A0=A0=A0=A0 | 2 +-
> >=A0 drivers/net/wireless/realtek/rtw88/rtw8814a.h | 2 +-
> >=A0 2 files changed, 2 insertions(+), 2 deletions(-)
> >
>=20
> Thank you for taking care of this. Actually, every chip's efuse struct
> has a union like this missing __packed, not just RTL8814A. Most of them
> don't have a static_assert.
>=20

Indeed. I added size assetion of efuse map entirely to rtw88 and rtw89 [1],
hoping we can find and address this kind of problem earlier.

[1] https://lore.kernel.org/linux-wireless/20260411072413.1556575-1-pkshih@=
realtek.com/T/#t


