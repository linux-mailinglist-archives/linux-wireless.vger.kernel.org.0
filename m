Return-Path: <linux-wireless+bounces-7866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D808CA84A
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 09:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24A01F223B1
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 07:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E693E3FB8B;
	Tue, 21 May 2024 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLrxZN6W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C087F;
	Tue, 21 May 2024 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716274873; cv=none; b=plSiT53Ly4fNZECSMVfzceRvmbr6Y9ewVXpjZOJCIt7XSQxlyhOAW1qneA+gEr1OD6utyZ99UO+19LJpHxxvMH3GXOCsJ8yh2F0c5jsocN48/bTzXj/4VKr2NoJDtuBVNst8xWsn2J0HrddG6BhQAGGYjZgSH1kkWJn/EOzocuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716274873; c=relaxed/simple;
	bh=HkA7G+WZziI0+WY66bqy3c/uUl0leQntthhE7ntsiok=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=qwmTxdWGXDSK/nY4uu1zjJwMHoDEDCGdvWErzUlVLINEAxCFxYLeZ3R3Yts5oUgYzWGXhjOg+NUHe/542tjOiixUY6pmKZQPCUbsJrcplX1GcjpCpEZaI1MbS4K1wZK6jOQsV4CQ0Tkbe0Adt4vWknltJhGbpycesoSstR44vgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLrxZN6W; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e271acb015so64928481fa.1;
        Tue, 21 May 2024 00:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716274870; x=1716879670; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkWR+t4coTvUfqKps9eZBaaz7b4Ay7sWZdC6HnQxB+Y=;
        b=XLrxZN6WHCjRXtbKf6ynCl5u5U0kGOwmPWG7zrO8Z7rkGdGkurKHBVBt0MmIU4Ekxu
         kW1MQyZupWyIDHVEvSxoWtZkWDFtxFP8q6okW7ruhv6Ie7eWAn1bACtNRgZQWIJybH8+
         zQSAfPvaQMnUfKko3slutqgEUrufJWt7k2VJVIr51pjYAtiyEkgfcA8Kdfc0w3VP67v9
         /SzDI1oDEUfYXn1aGBkj6tGaiA17zRMgKI4W0cD5N7WOlQtERLtRfVX2sZ7wuNI43VSt
         xmL0JkDpwoF/d+sxDVGaUvbNWfm6xd5hb+71KRRKxEDZ8A3ki2cyEeapmaGw7vpsM4Ku
         upZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716274870; x=1716879670;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UkWR+t4coTvUfqKps9eZBaaz7b4Ay7sWZdC6HnQxB+Y=;
        b=CT5T1PGZWnqT04T+6v/LKl8SR188AtT0i3ZdxyvGPopd7iQrwpJEzTzP3xngmrVEt4
         KVqzXCIlFkzLoZxYbv9P6dfB6XVBkQ9Sdq6YtfAhcefAXIZihnXB0DOirKBkghbqT/ia
         hR5RrzWJPlL6389M0vlSb9TBT1p6agHeYGn0yqkPVpf6ys7Q/Q11BUkfyHiUFeX0WrzW
         jaJER31Rmo0dcLWPpKZJ4vqtRh0eifYyjDhtu3nDbYuan/9nWuw+NDi6CSTypEBErTM2
         KNv9yHIFEyVDcRsFZNKMTu+muFWKZZnyJrnlLd2jukwEHij5ouyHYKWPBA2gTEza7QVX
         QMNg==
X-Forwarded-Encrypted: i=1; AJvYcCWnSBN6rdabwvQW43eMXefNpbaiC3hknYc6c81QGAtnlb56A/5TrL0KmiiOluyDdy+mS6XPc8J/kFwUpo8g0OjvGGbAloXbu+mdQwY+UQCymxwFWuJvQSCw27HNGt/gzEZTLoDEu8suh4ls3D4=
X-Gm-Message-State: AOJu0YzRdDdijShNIYrSMOwAutluwu0w8/yeYgjxrxqbhHqITpNE7FTt
	mQYBGBLBCAmNeORARx4kVNnZelnW+/b7/jg9r4kYtW9WoiCdinG50uhqWg==
X-Google-Smtp-Source: AGHT+IGMUIWoeq0jhoFs/GRtfBhQ/rk6jS/l8R79/kT9O7NdrOKMHEpwVp27euETugMllwP1USmcSA==
X-Received: by 2002:a2e:730b:0:b0:2dd:409:3b25 with SMTP id 38308e7fff4ca-2e51fd42038mr215262941fa.4.1716274869853;
        Tue, 21 May 2024 00:01:09 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42012a025dbsm351827435e9.23.2024.05.21.00.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 00:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 09:01:08 +0200
Message-Id: <D1F4NY5F73YD.1T55A9QAAA1N@gmail.com>
Subject: Re: [PATCH] wifi: cfg80211: Lock wiphy in cfg80211_get_station
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Remi Pommarel" <repk@triplefau.lt>, "Johannes Berg"
 <johannes@sipsolutions.net>
Cc: "Antonio Quartulli" <antonio@open-mesh.com>,
 <linux-wireless@vger.kernel.org>, <b.a.t.m.a.n@lists.open-mesh.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <983b24a6a176e0800c01aedcd74480d9b551cb13.1716046653.git.repk@triplefau.lt>
In-Reply-To: <983b24a6a176e0800c01aedcd74480d9b551cb13.1716046653.git.repk@triplefau.lt>

On Sat May 18, 2024 at 5:50 PM CEST, Remi Pommarel wrote:
> Wiphy should be locked before calling rdev_get_station() (see lockdep
> assert in ieee80211_get_station()).
>
> This fixes the following kernel NULL dereference:
>
>  Unable to handle kernel NULL pointer dereference at virtual address 0000=
000000000050
>  Mem abort info:
>    ESR =3D 0x0000000096000006
>    EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>    SET =3D 0, FnV =3D 0
>    EA =3D 0, S1PTW =3D 0
>    FSC =3D 0x06: level 2 translation fault
>  Data abort info:
>    ISV =3D 0, ISS =3D 0x00000006
>    CM =3D 0, WnR =3D 0
>  user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000003001000
>  [0000000000000050] pgd=3D0800000002dca003, p4d=3D0800000002dca003, pud=
=3D08000000028e9003, pmd=3D0000000000000000
>  Internal error: Oops: 0000000096000006 [#1] SMP
>  Modules linked in: netconsole dwc3_meson_g12a dwc3_of_simple dwc3 ip_gre=
 gre ath10k_pci ath10k_core ath9k ath9k_common ath9k_hw ath
>  CPU: 0 PID: 1091 Comm: kworker/u8:0 Not tainted 6.4.0-02144-g565f9a3a791=
1-dirty #705
>  Hardware name: RPT (r1) (DT)
>  Workqueue: bat_events batadv_v_elp_throughput_metric_update
>  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>  pc : ath10k_sta_statistics+0x10/0x2dc [ath10k_core]
>  lr : sta_set_sinfo+0xcc/0xbd4
>  sp : ffff000007b43ad0
>  x29: ffff000007b43ad0 x28: ffff0000071fa900 x27: ffff00000294ca98
>  x26: ffff000006830880 x25: ffff000006830880 x24: ffff00000294c000
>  x23: 0000000000000001 x22: ffff000007b43c90 x21: ffff800008898acc
>  x20: ffff00000294c6e8 x19: ffff000007b43c90 x18: 0000000000000000
>  x17: 445946354d552d78 x16: 62661f7200000000 x15: 57464f445946354d
>  x14: 0000000000000000 x13: 00000000000000e3 x12: d5f0acbcebea978e
>  x11: 00000000000000e3 x10: 000000010048fe41 x9 : 0000000000000000
>  x8 : ffff000007b43d90 x7 : 000000007a1e2125 x6 : 0000000000000000
>  x5 : ffff0000024e0900 x4 : ffff800000a0250c x3 : ffff000007b43c90
>  x2 : ffff00000294ca98 x1 : ffff000006831920 x0 : 0000000000000000
>  Call trace:
>   ath10k_sta_statistics+0x10/0x2dc [ath10k_core]
>   sta_set_sinfo+0xcc/0xbd4
>   ieee80211_get_station+0x2c/0x44
>   cfg80211_get_station+0x80/0x154
>   batadv_v_elp_get_throughput+0x138/0x1fc
>   batadv_v_elp_throughput_metric_update+0x1c/0xa4
>   process_one_work+0x1ec/0x414
>   worker_thread+0x70/0x46c
>   kthread+0xdc/0xe0
>   ret_from_fork+0x10/0x20
>  Code: a9bb7bfd 910003fd a90153f3 f9411c40 (f9402814)
>
> Fixes: 7406353d43c8 ("cfg80211: implement cfg80211_get_station cfg80211 A=
PI")
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

Reviewed-by: Nicolas Escande <nico.escande@gmail.com>

