Return-Path: <linux-wireless+bounces-8189-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2682D8D18EE
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 12:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEAD11F25128
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 10:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A192516415;
	Tue, 28 May 2024 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyWUTut1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489C04D59B
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893537; cv=none; b=BGyuZWiGlektAed/b/LyFrz3GvihgpOOaDA5p09NojZ1pHNPq0jBdaAylPgEdmyOVpp5MV3dNHJHs1lhXeOe9KBW1ynVsV330XNNjh59hefdZJhyir8L/o9SUlPtf0XWAj0TEVApDuqKS1y8oWxXAEGA1MM0lYXzWWi/ruF75Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893537; c=relaxed/simple;
	bh=lbYa4qy7ws7sXAO1SMqtZQ63jVCyJk/gfa3VOX2EL0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6nAMS33gVLC108jeOuIP6L4AoW7TPRiXNQFy3DjmkdvSj31qac9/MrqqPZTmIVgDZz91UzXWyNl/4kBPe0D+urWmhHdwCcD5HCxecanAtbXgPO4PO3HXv9hv7NJH9XyS/Hm/iSFCopAraY6JYns9SkGnTMZ/SroJ7DoE4D2y1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyWUTut1; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-681adefa33fso625928a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 03:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716893535; x=1717498335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbYa4qy7ws7sXAO1SMqtZQ63jVCyJk/gfa3VOX2EL0o=;
        b=iyWUTut1T3M4lH7aAdQjThDu5N+5uWx2PJB9qRhEifnmzhIJVvJcxavhDCiKqxu/V6
         qJy/3Rx7m7c5oIujDeV2P2jyBfGU9a06UHGpF5woxup+i90rYTvw6WBBVwTJXzTfm3KV
         jmAy6Sn7eyFAxAXDu2K0tDkInBrrjTzluZ6doitlWsm/upPQZcX6iCfp8o++kmiGWhkO
         OLCS+LeqXnXg+7y7xw/LNZPwkSZXEtN247IcAqLweQcxuQI2vZ0g0rCNTwVpekOn9e3y
         tAsU66ygXHDb9XlYbMQMgOycAR6JlYJ5o/R6YjLJxWErPiywaHJUhET84XvsU6t0hOMU
         laaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716893535; x=1717498335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbYa4qy7ws7sXAO1SMqtZQ63jVCyJk/gfa3VOX2EL0o=;
        b=dHhGCtdN79JQFTHpE/bRP0nbsJOb09bv38vi6eqLN2f2ubNzN+5YAmjBl7fZSNihNV
         XmnPMusjythMXIywOiqshpJuiSVQQRw7CPM3jzl3T9UhuKe8bRWJ6HkvkfeTneG9mego
         UyJVWdG3hdAsIqfcpV2U2uhii0IP9tIXdWS5hhkdqOwnGGLG7w9o5VtLWYo6f1Lf1zur
         1JJYoP3P8d/R/AOeHQpXu5Q2u1kBJ3QfT6wqzBrgaueVkT7AFH9ThO3BoA1VuxpTJENC
         aSa7wfnEbvVmthKlbIQ1pWlu33y/CyYi3CXciQzt0AeJ3FTXE3C3+2hkHdo++pMQRosL
         aUZw==
X-Gm-Message-State: AOJu0YwY3z5SOTFX1iFK7ll+n9cetLpuJ3IxxuNpdKy16tVE6V3F6uPh
	RjqsJCNL5MparNN9Uao5blfaEyolxKFSGV+9f5opsv0NgaMOuxqvTu6wdRTaYCyzbPXxI+eZSOt
	5VfWWqifZU5RCh4LynfCwGuSTeSY=
X-Google-Smtp-Source: AGHT+IGL0ANlEBfDLGQ+iCdXos3ErBclQcbpLotllLyBOeFNW5VMp8nGklJZZtYQd5EjSuHCbqgs96oXuVeNo6TYy3M=
X-Received: by 2002:a17:90b:358d:b0:2b5:6e92:1096 with SMTP id
 98e67ed59e1d1-2bf5ef1c8d0mr11555811a91.28.1716893535522; Tue, 28 May 2024
 03:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527173454.459264-1-marcin.slusarz@gmail.com> <9bfc8f01e99b43e485b2afc6ae4fd661@realtek.com>
In-Reply-To: <9bfc8f01e99b43e485b2afc6ae4fd661@realtek.com>
From: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date: Tue, 28 May 2024 12:52:04 +0200
Message-ID: <CA+GA0_sQ_Bnp8CUq1Pmxf7zut1Kocaxbw4iXT4hYC5_ceXb7WQ@mail.gmail.com>
Subject: Re: wifi: rtw88: 8821CU hangs after some number of power-off/on cycles
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, =?UTF-8?Q?Marcin_=C5=9Alusarz?= <mslusarz@renau.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wt., 28 maj 2024 o 05:52 Ping-Ke Shih <pkshih@realtek.com> napisa=C5=82(a):
>
> Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> wrote:
> >
> > I found out that the reason for those hangs is a power-off+on sequence =
that's
> > triggered by the above steps.
>
> To avoid power-off/on sequence once device becomes idle, I would like to =
add
> a ips_disabled helper. Please revert your changes and apply my attached p=
atch.

My first attempt was very similar, and it fixed some cases but not all of t=
hem.

This is due to the existence of a second source of power-offs - rtw_ops_sto=
p,
which is called, e.g., on downing the interface (ifconfig wlan0 down).

