Return-Path: <linux-wireless+bounces-16117-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E549EA0D5
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 22:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFAB2188671F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 21:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B61F1991CA;
	Mon,  9 Dec 2024 21:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSk7xM+0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BE017BA5;
	Mon,  9 Dec 2024 21:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733778512; cv=none; b=N8h6sE89PUaC1nKEqjgsZFR+kWRAM5IiDcvR08WEIJWfVLo406as08yjDtaA1oDD+Pab1fkRnPA0gQUtN5cUyg3FhetlADfK8jHkEuSo0Z9Ze+iXLIOxdQk4iuD0Sd64ii481IEUn/hm+cXOjApIXYOZI4YmgzZiNOp5S6z2nak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733778512; c=relaxed/simple;
	bh=INrlLq8aQWxUFnTxFCwCdW0I/rDBC/T3SLuLP6j/PLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFohzJdyesWHShNSZpEDkL9tF87iRrl+y5oG1G7IhKlXK/7y3nLtCBtLGaKvPsVkYOl6TIUbGQ+u1CB7qM7RNNn9O8FiNXcnFB9UbLDGX+qzmxhHUeb8BARRAoNzobyZ9yAhz+URpv/I1YRY00Dh+9bS5RztMR6H3RowNAQu8H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSk7xM+0; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71de7b9d572so997420a34.2;
        Mon, 09 Dec 2024 13:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733778510; x=1734383310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INrlLq8aQWxUFnTxFCwCdW0I/rDBC/T3SLuLP6j/PLg=;
        b=dSk7xM+0AHQx5/fvocTtXtsK/oQZpXpgMkP/pNgNIdTQGp3CLyxVWu2r1+bzdfR07M
         e7LVYSw9n0PHW4ob1gwDimOWJYjBlvsKmHSmjOI6Qn7rLSZYq75ljL06PAvRSk8qDscQ
         wkcgfa+3Hor9shUo2ahgms6wXKXaA95qeLObnj8wrVj5LAJUEFl0nmR99IGXwDsjTs46
         G/SKAYVmoA18sK/wBthdZsVoc0t2vbLE/KrgcRNmJb4wJ4SvuOatwWUEdaM84xDbnOkN
         ZFFMPg95q3xLQhVvM47gtWaztdHmTYaHPePWS7wG+OnLVfi4Zd9LvDzqApEM+pOasUZl
         6ZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733778510; x=1734383310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INrlLq8aQWxUFnTxFCwCdW0I/rDBC/T3SLuLP6j/PLg=;
        b=NURYvCsgc0swzohXtXweKjKlIcPKIcEZvhF5+cQipa0Y4j3WXTXw1D7rmb4uBYQMmA
         If0z1pcOhpL0mG86xxgQB81zOTyC9BhgCqdItRQ1ZlyKlHvEV9BFpEtbobAmDviYtfzM
         laIhiMReSS2XO7QmaeOVOsmX9Ye8aw6WB0R/kr+iffUcvuruoJodnVYohT3bfPgvkoN7
         pmyvuiUNoUs+LpbzWsWjxshPTl4mp3WZUrHo19oytMRF5t2PsglSe0mRyqjAykgbbzEr
         yutApdud07IsabPkyj7GJnAAKBeDc8LzmPY0xZ5K7orvAV0ju5zLzEb+YGDQiUi38MUZ
         4+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVq6gXYKaDHobUE5qPT9d6ImEEK+em9sjecLBAl2gyTNdJk6VhjvGFB9z3ZHJeHeC59zFY1eV1LdeWNMjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzajTtpyjWeIN1pcA+pumNO4azJcIgiPZPbY0o7HvIr/ivWHrbR
	ZtL3zTenyiSIfqOSlqaQHNdS+araqATLebpyPKRYx29FUPQ4QwKh/0w9sthILMJBqqOnEscJTVO
	GMaVzOO0GuKafXDgCn8XU9jsP9Ik=
X-Gm-Gg: ASbGnctrgqLIUyzts1IIHYVX0ulVjLddSz3YaeCelqI02vMx6pw2eT+k2OMxpYnTbCt
	y8VESgp/2uHfd2X65YKUKnbSqRUtSLj+4oA==
X-Google-Smtp-Source: AGHT+IEJicYcFoJbXg/NqQFRKqB25/wqRz8C91cCA0J8LdvL5RJJBcGvh2aBRKQwxJC6xjwQPl344SOvQ9bb+4cBRIs=
X-Received: by 2002:a05:6870:fb93:b0:29e:1325:760a with SMTP id
 586e51a60fabf-29fee5519c3mr1218737fac.8.1733778509948; Mon, 09 Dec 2024
 13:08:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122210346.2848578-1-alexthreed@gmail.com> <980c5cee-2dc3-4d26-b749-6ba00b9c2091@broadcom.com>
In-Reply-To: <980c5cee-2dc3-4d26-b749-6ba00b9c2091@broadcom.com>
From: Alex Shumsky <alexthreed@gmail.com>
Date: Tue, 10 Dec 2024 00:08:19 +0300
Message-ID: <CAF4oh-Np5HZzdCxjycrvr_-RS0ZdC4Y3AyCi89=Lo1gQnSSowg@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: fix RSSI report in AP mode
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, Alexey Berezhok <a@bayrepo.ru>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Kalle Valo <kvalo@kernel.org>, 
	Kees Cook <kees@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, brcm80211-dev-list.pdl@broadcom.com, 
	brcm80211@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 2:13=E2=80=AFPM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 11/22/2024 10:03 PM, Alex Shumsky wrote:
> > After commit 9a1590934d9a ("brcmfmac: correctly report average RSSI in
> > station info") it is required from firmware to provide rx_lastpkt_rssi.
> > If this field is not provided brcmfmac doesn't report any RSSI at all.
> > Unfortunately some firmwares doesn't provide it. One example is firmwar=
e
> > for BCM43455 found in Raspbberry Pi.
> > See https://github.com/raspberrypi/linux/issues/4574
> >
> > Fix it by falling back to rssi field if rx_lastpkt_rssi is not provided
> > (like it was before 9a1590934d9a).
>
> Sounds like a reasonable approach. However, I would like to learn more
> about the issue. Maybe it is a per-vendor issue so I am interested what
> the sta_info version is that we get from firmware. It is printed in
> brcmf_cfg80211_get_station() with brcmf_dbg(). You can make it a
> bphy_err() call instead or enable TRACE level debug messages in the drive=
r.
>
> Also would be good to know the firmware version and kernel version of
> the BCM43455.
>
> Regards,
> Arend

I've just checked sta version in trace logs:
brcmf_cfg80211_get_station version 4

Firmware I currently use:
BCM4345/6 wl0: Aug 29 2023 01:47:08 version 7.45.265 (28bca26 CY) FWID
01-b677b91b
https://github.com/murata-wireless/cyw-fmac-fw/blob/e024d0c0a3ab241f547cb44=
303de7e1b49f0ca78/cyfmac43455-sdio.bin

I'm not sure what firmware version is used in the raspberry pi distro.
From raspberry forums it looks, like:
Firmware: BCM4345/6 wl0: Nov 1 2021 00:37:25 version 7.45.241 (1a2f2fa
CY) FWID 01-703fd60

