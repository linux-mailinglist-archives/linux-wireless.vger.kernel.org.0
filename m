Return-Path: <linux-wireless+bounces-26060-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2EDB16A38
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 03:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE841AA26DD
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 01:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D0815442A;
	Thu, 31 Jul 2025 01:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="el3XsFnS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183082D023;
	Thu, 31 Jul 2025 01:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753926301; cv=none; b=QpuQsyG9249Nm+1xoR9wadmAPWmwXUaRLi+h47KWnBIbRTK6PTiz8ruBnQcWWy5mDLuiVTSo2FaZvbEvyRgu3MUbnsWcBLHd+COl6Vb3nhiQFyzAXWH9NBheB2OBBioRnNhlTIXHCaS0GnXFh6ohc4GWiXoSMb7rsJL9ykMy92k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753926301; c=relaxed/simple;
	bh=8ycMzanKfn/v4u/ZyldJ7ds/EqsMVt4f1HAFoiLHzpA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bq4Q9xbb02pe0ftGObaLgQGywzE0lEnMy6W3u9q9kMCMQF0WjzYSs5V8jQ1F3MJ7aRj+J2jxjYtFdNxEkltAy/NkEQgm8wf6weVcUBZdAstwwtXNVaZpfqK33g2ZT5rrD2R1DIetYJ2XHIjSStpM0QYdPST4nKDUxmR1JiBxUKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=el3XsFnS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56V1idgS7305146, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1753926279; bh=8g+895L8WsXPGFnFkTfb3gD9nWQbADrUMkgjo2Bh2+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=el3XsFnSLp9zdA7iZT8JrB9MKGF57b6MpIqCStKqbQ2yP2HB/hRELqLyG6jm7WSOo
	 uT4LJOc7AYfyVY+z2VOsgwwNs8ZYvZjwZo1iTjI8na3jJzAgdoyqUZJI6kv30neP2x
	 2aVgv/O5cEMuvvilH0fZHSJwsyKoZumiQoKdIsGWy2IpX43lVvoSCFKhloXPn9Ejgl
	 H3BS4LQ9WwD/Jp+RRnjY2ch+wkF50/n6CYPwr6CQV1fNrVYMpIusfpQLquA9P7GMSQ
	 KnEqqpd5pBbW67AMgmA60aB/+dZXpG/YB4C5JTUs6cUEYZ3oQ4TE1OBasOC9/QndXh
	 y1YgnoQ3jPprg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56V1idgS7305146
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 09:44:39 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 31 Jul 2025 09:44:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 31 Jul 2025 09:44:37 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Thu, 31 Jul 2025 09:44:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Mande Imran Ahmed <immu.ahmed1905@gmail.com>,
        "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net/mac80211: replace scnprintf() with sysfs_emit() for sysfs output
Thread-Topic: [PATCH] net/mac80211: replace scnprintf() with sysfs_emit() for
 sysfs output
Thread-Index: AQHcATh5GvqFiHspD06BS3uK8zvoH7RLdJIA
Date: Thu, 31 Jul 2025 01:44:37 +0000
Message-ID: <5b63288d487547f1a4e6df426432ea0b@realtek.com>
References: <20250730095634.3754-1-immu.ahmed1905@gmail.com>
In-Reply-To: <20250730095634.3754-1-immu.ahmed1905@gmail.com>
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

> --- a/net/mac80211/debugfs.c
> +++ b/net/mac80211/debugfs.c

[...]

> @@ -152,16 +152,15 @@ static ssize_t airtime_flags_read(struct file *file=
,
>                                   size_t count, loff_t *ppos)
>  {
>         struct ieee80211_local *local =3D file->private_data;
> -       char buf[128] =3D {}, *pos, *end;
> +       char buf[128] =3D {}, *pos;

The assumption of buffer size in sysfs_emit() is PAGE_SIZE, but obviously
here is 128. Also, this is not sysfs.

Maybe, I'd ignore this patch since I have commented this in your patch that
changes similar stuff in rtw89 driver. Just share some information for
other reviewers.

>=20
>         pos =3D buf;
> -       end =3D pos + sizeof(buf) - 1;
>=20
>         if (local->airtime_flags & AIRTIME_USE_TX)
> -               pos +=3D scnprintf(pos, end - pos, "AIRTIME_TX\t(%lx)\n",
> +               pos +=3D sysfs_emit(pos, "AIRTIME_TX\t(%lx)\n",
>                                  AIRTIME_USE_TX);
>         if (local->airtime_flags & AIRTIME_USE_RX)
> -               pos +=3D scnprintf(pos, end - pos, "AIRTIME_RX\t(%lx)\n",
> +               pos +=3D sysfs_emit(pos, "AIRTIME_RX\t(%lx)\n",
>                                  AIRTIME_USE_RX);
>=20
>         return simple_read_from_buffer(user_buf, count, ppos, buf,


[...]


