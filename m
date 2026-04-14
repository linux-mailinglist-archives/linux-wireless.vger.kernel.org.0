Return-Path: <linux-wireless+bounces-34718-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG9NHZWQ3WkLfwkAu9opvQ
	(envelope-from <linux-wireless+bounces-34718-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 02:55:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EE63F4AAF
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 02:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C13AE3023DB1
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 00:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BBB23EA9B;
	Tue, 14 Apr 2026 00:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GomZ4vnt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9A2224AFA
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 00:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776128145; cv=none; b=eVIy4uaTTUbIKQj/DYCPPC5FtO9cZ+0pAY1i8fdFlkwgRtC65dUTDUj1pFLpl4DlxXN570wLnWxtpjWAguj2ckDDqLRqj2T5+sBEBjg7GnSIpLWTxLZgXH6PocD1XolEOjaSLIywiGuBIFjGz8UZwcYiVLWPdNIKq87yQebnwbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776128145; c=relaxed/simple;
	bh=I7AhpsRjcXSDEj+ZSjHYnCjfFvXtDbszMCC+VRx3wtY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bxsefhBbq7ceyxyF1sweoFhzYFNka/XISJZUxHDjB48SpDVihCdaCUzJ01Nr2repvjCHctz4WZvfidHNrCkQwf90IzHHAaEBfduHWUXUHNtmVABBY9Lo0f8qR5j8GrOrqpNnWOfHlg8Xc62VBtvMbl7TwA4PQWQ67oXTPeKSng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GomZ4vnt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63E0tRYc91020124, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776128127; bh=lKbn22FWgghQXU/2YdJxBPJ4HcVjc53ZOwvS+HD4RtQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GomZ4vnt6YHeJM1CaRrtAVF0mQhey5v6Lo7566Y58NgWIwcSfwwgCQLUbZSKjtk88
	 0dIctO3h5KWYkuxedekqzWt8VqZepAnK9Z7ShRbg4v8dUmZxYzk5WR+kh0NUqtRusi
	 dSKuR0vhQEHgVGzGwyYqycemiLMVrsYKSYf+VK4zMxsExSWxw6YjNEBI3RUrCOhVu2
	 Xf+Fic+nhTdq4vj2y6S/sfxWav7ltfQbpGBDCJbg7zlBXjRXXUyuMvcU9y789dcqTu
	 x3c9JgvUGRrF0I+bYM+2bUMd4X3pXlbU7vcxuOq4ua1Plt996HsiaIa2LezgJh7uNA
	 tVvZl4Y67HGGw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63E0tRYc91020124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 08:55:27 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 14 Apr 2026 08:55:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Apr 2026 08:55:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Tue, 14 Apr 2026 08:55:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH wireless-next] wifi: mac80211: add __packed to union
 members of struct ieee80211_rx_status
Thread-Topic: [PATCH wireless-next] wifi: mac80211: add __packed to union
 members of struct ieee80211_rx_status
Thread-Index: AQHcyYS8LcuPkmNJGEK2JVXt8Skgn7XdvWiQ
Date: Tue, 14 Apr 2026 00:55:27 +0000
Message-ID: <280094f50a534fc998037b21c36ebe11@realtek.com>
References: <20260411072509.1556635-1-pkshih@realtek.com>
In-Reply-To: <20260411072509.1556635-1-pkshih@realtek.com>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-34718-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D8EE63F4AAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:
> The arm-linux-gnueabi-gcc compiler, align the field followed by union
> members, causing size of struct ieee80211_rx_status over skb->cb
> (48 bytes). By investigation, the union member starts at offset 32,
> and the offset of next field rate_idx is 36 instead of expected 33, and
> the total size is (unexpected) 52.
>=20
> When compiling rtw88 driver, it throws:
>=20
> In file included from /work/linux-src/linux-stable/include/linux/string.h=
:386,
>                  from /work/linux-src/linux-stable/include/linux/bitmap.h=
:13,
>                  from /work/linux-src/linux-stable/include/linux/cpumask.=
h:11,
>                  from /work/linux-src/linux-stable/include/linux/smp.h:13=
,
>                  from /work/linux-src/linux-stable/include/linux/lockdep.=
h:14,
>                  from /work/linux-src/linux-stable/include/linux/mutex.h:=
17,
>                  from /work/linux-src/linux-stable/include/linux/kernfs.h=
:11,
>                  from /work/linux-src/linux-stable/include/linux/sysfs.h:=
16,
>                  from /work/linux-src/linux-stable/include/linux/kobject.=
h:20,
>                  from /work/linux-src/linux-stable/include/linux/dmi.h:6,
>                  from pci.c:5:
> In function 'fortify_memcpy_chk',
>     inlined from 'rtw_pci_rx_napi.constprop' at pci.c:1095:4:
> /work/linux-src/linux-stable/include/linux/fortify-string.h:569:25: warni=
ng: call to
> '__write_overflow_field' declared with attribute warning: detected write =
beyond size of field (1st
> parameter); maybe use struct_group()? [-Wattribute-warning]
>   569 |                         __write_overflow_field(p_size_field, size=
);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
>=20
> After this patch, the size of struct ieee80211_rx_status is 48.
>=20
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> Because of size assertion of rtw88's efuse map [1], I found
> arm-linux-gnueabi-gcc compiler throws this warning, but x86 gcc is absolu=
tely
> silent and expected without this patch.
>=20
> [1]
> https://lore.kernel.org/linux-wireless/7c65e315-5a2e-455e-87ee-8fc6d60ed8=
07@gmail.com/T/#m43fdf8a1
> c2b8cff92c1ef50faab7993522647162

I'd note that discussion thread [2] of original kernel test robot.
Arnd pointed out the cause is CONFIG_AEABI is not set, and he said
nobody should be using ARM OABI any more.=20

Maybe, we can ignore the CPU and skip this patch.

[2] https://lore.kernel.org/lkml/6b6310b8-2b0d-4390-992e-5ccd81cef2e0@app.f=
astmail.com/



