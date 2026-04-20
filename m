Return-Path: <linux-wireless+bounces-35021-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIlzK1jp5WndpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35021-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 10:52:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDF3428806
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 10:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84C82304EB9F
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 08:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BC11A2392;
	Mon, 20 Apr 2026 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="klmvbdVn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BC63750D5
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674721; cv=none; b=Hlng1DuBrmeABrg42n4zfYXxknNncPOQPKp+oOE9MWcv+tHfJ9f5TXWHjDR7gl1SKijmL+cosRmbXwyeAwm/uY8ZXgF4XYYhT2SfM3BChIRarviGfLdWiT+SuvfYpiQLg20x1DZa9jegC5+SX7v6UaSynUYLY7oUNwDF48SmEn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674721; c=relaxed/simple;
	bh=3k8ql+hDQP6GAkrUgrjZuqSsr1PnRl+l08h5kTp1DWE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FLphy5DJ4qdaplLqvWC0Kup4OJakI0q3TKxPzkj4Bq2UQm0jXrKTJTaR9HT9jIST+56jCN8K7ylG6AGJYVZPwy0ni1Kf6Ax7QgGpmwSkJ6NHA8OQ6d5IIAhTO2YpIHa2NZcsn8op3QZ3WTPbDWWvFufZpn31ggrYXTKBKkRu3K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=klmvbdVn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K8jC6y9843160, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776674712; bh=qF4glTA3tE2OPg2dFZwGCOBg4g2v/Zit1QTKFnO/q88=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=klmvbdVnDKiRZxpRhDRL+/Bqd51Y+X0/M6A317VnAvlppLPlKhzcz27Xj4k+Xrapq
	 2P6uEtQ5agGMk8iha8u4qU+mC6KHznW10wmEWHQv2vUFkVjsPeQTfkTKMZGcTR1Zs7
	 TsVx0sECn2VLckKusg+GFFd34hFHx1ty0KUYyKHaSKc7NTyxj93Cr2rp9TFaSwVgar
	 d9nyMDkbnWjApHYF5Epcoh0lfQ6kZV4iIBNf+DfNT2DQU6ao19GZKvrZgu9QUz04nH
	 zDOSbtMr+/UkInUoJ0nc9ZlUjEzu4lAmQ9lUy0ensoyeMt/UF1mXhPveXdtSA6xPEw
	 8I9BIoQlUHUHA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K8jC6y9843160
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 16:45:12 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 16:45:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 16:45:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Mon, 20 Apr 2026 16:45:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "lkp@intel.com" <lkp@intel.com>
Subject: RE: [PATCH rtw-next] wifi: rtw88: 8814a: add __packed to ensure efuse
 map size
Thread-Topic: [PATCH rtw-next] wifi: rtw88: 8814a: add __packed to ensure
 efuse map size
Thread-Index: AQHcyOy6g5W5Hl8CYkShQRvxGKKftrXX6gIAgAGNEiSADjqCwA==
Date: Mon, 20 Apr 2026 08:45:11 +0000
Message-ID: <4bea1c66c6f949c9bdda4d2e0e104843@realtek.com>
References: <20260410131353.1550803-1-pkshih@realtek.com>,<7c65e315-5a2e-455e-87ee-8fc6d60ed807@gmail.com>
 <c97d9fcb628a4a5a94d041c63da1c711@realtek.com>
In-Reply-To: <c97d9fcb628a4a5a94d041c63da1c711@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35021-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:dkim,realtek.com:mid,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1FDF3428806
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:
>=20
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>=20
> > On 10/04/2026 16:13, Ping-Ke Shih wrote:
> > > All nested sture/union used by efuse map should be packed. Otherwise,=
 a
> > > arm-linux-gnueabi-gcc compiler might throw errors due to size asserti=
on.
> > >
> > >=A0=A0=A0 In file included from include/linux/bitfield.h:10,
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from incl=
ude/linux/fortify-string.h:5,
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from incl=
ude/linux/string.h:389,
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from incl=
ude/linux/uuid.h:11,
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from incl=
ude/linux/mod_devicetable.h:14,
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from incl=
ude/linux/usb.h:5,
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from driv=
ers/net/wireless/realtek/rtw88/rtw8814a.c:5:
> > >>> include/linux/build_bug.h:78:41: error: static assertion failed: "s=
izeof(struct rtw8814a_efuse)
> =3D=3D 512"
> > >=A0=A0=A0=A0 #define __static_assert(expr, msg, ...) _Static_assert(ex=
pr, msg)
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ^~~~~~~~~~~=
~~~
> > >
> > > Fixes: 1a7545784642 ("wifi: rtw88: Add rtw8814a.{c,h}")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes:  https://lore.kernel.org/oe-kbuild-all/202604101721.fsv5XmCX-=
lkp@intel.com/
> > > Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> > > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> > > ---
> > >=A0 drivers/net/wireless/realtek/rtw88/main.h=A0=A0=A0=A0 | 2 +-
> > >=A0 drivers/net/wireless/realtek/rtw88/rtw8814a.h | 2 +-
> > >=A0 2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> >
> > Thank you for taking care of this. Actually, every chip's efuse struct
> > has a union like this missing __packed, not just RTL8814A. Most of them
> > don't have a static_assert.
> >
>=20
> Indeed. I added size assetion of efuse map entirely to rtw88 and rtw89 [1=
],
> hoping we can find and address this kind of problem earlier.
>=20
> [1] https://lore.kernel.org/linux-wireless/20260411072413.1556575-1-pkshi=
h@realtek.com/T/#t
>=20

As discussion in original link [2], the ARM OABI should not be used anymore=
.
I'd drop this patch, and also drop patches to assert efuse size of rtw88 an=
d rtw89 [1].

[2] https://lore.kernel.org/oe-kbuild-all/202604101721.fsv5XmCX-lkp@intel.c=
om/



