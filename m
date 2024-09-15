Return-Path: <linux-wireless+bounces-12868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D84E979543
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Sep 2024 10:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97301F23100
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Sep 2024 08:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF69B1758B;
	Sun, 15 Sep 2024 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="lR3yqTLI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A51A9463
	for <linux-wireless@vger.kernel.org>; Sun, 15 Sep 2024 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726387675; cv=pass; b=okZ+yeIzSlSSJAJcRGo6TgkNHNDNqsaBH+aEzXvMBaV3FaViZac0FC66X2Ji0+pst6fw5HMT/vwFk8wqjbwhNYsHjDVm5XXNV8uE1vdRO2CIvWbOGpJA8KbmmY2RTXwQiktXWEz7i4zc9SvoKPZEme2e8f4yIyFhza/IsD1vG/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726387675; c=relaxed/simple;
	bh=TkNgOy9bCZPrGimahlcsk6L7452H3HUCusGI8yEwh00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDa0AEVDp6a9FMG0v6Y5c1FyYV2UsMMGPMpvQ6gO+b2CH/Z4q6zxkVi/OS3j0ue4ZLEOzJifNIciOaIXUjpgs2iH16z6iKWCXgvrUqwLbcap6+E/Hs8o8u992YgfppWQ5KS0qP32VgRKWwx3il3EykshXX8eSxh+whY/6q8p8rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=lR3yqTLI; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: martin-eric.racine)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4X60ym2Cjxz49Q5X
	for <linux-wireless@vger.kernel.org>; Sun, 15 Sep 2024 11:07:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1726387664; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0mybldXID1M5smDXhj8IoG2O8M4cEp1OB06KjlTCmM=;
	b=lR3yqTLIo5QMoV/LY6mlH7Na3E7zRx3G10A9iLpzAyw/ju7B7P96Tb6/+9b18I1syMeFqv
	pvw2nF69bS+3ZcBJ4Up7YkdeZe5RJt8AEWG7RZchbLC7OL0heAbccSJFGbpQ/bQUURnYN+
	yu2VGuG6z6VN57rD1TgcixvSPLEN+49jSzoOjyZYRndjZxF6etOXpjf/vapAUDkDf95Hem
	4pssi2lAaam1kJTYLNPBPhDpVvvOfoiHGJ54m1HEwj03HgNiuLN6zguKnPh+CoxVnA9/po
	WCTSVvQDbkaE17veEXBK6eDR0KcZvAOGwojvpiv8X5tzQ/B2Yk1xsJGjgZmHDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1726387664;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0mybldXID1M5smDXhj8IoG2O8M4cEp1OB06KjlTCmM=;
	b=aW5bAcWlKA7diiHy8+p3CGez7KyzhzU6vWKtf+v6xCvgdhjUr/g8OlZlPceONzZW/DWp/B
	5N6L2I/at67WJoLD26QGKRvVx4CWMicDxPPTtuksg7r83YaSwBmmrhBmPTwEI7+4EO4Hbb
	X+v+SViedcDlsK2mUXc2x0MvOhgpE7Qpih/hoBG39tzgBkBR8fBCPRmo5Afirs3WSun+Ci
	5N93yBzgQBqU2PhHfVlePpzruswIQcvYNpsqsSt8dheSJtqvOuBZBqnOQ0moOikEZVBbhy
	MZdeHsAZH2cqK6l03KQdllV9LreGSJ8fnD2FMfCixB/H6Dk46r2q5rk/EC5zLQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=martin-eric.racine smtp.mailfrom=martin-eric.racine@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1726387664; a=rsa-sha256;
	cv=none;
	b=BayXMeAXp6d/cBH9VExvIS7EjGEhYduMdZl0agXaDq4uNwDlXwJJT6lAMp6hfbB/We8XdO
	qd2ggtK6o/R4R0fQiiy2nB2fDk01GHfbguKGlxXXqRiRLXaOfbKeq1WjOa1SIH/SZmMg8Z
	Eo6zgylKjGqtD9FohIXB7l/xV8EdteMsalLjZk1aAuz1cXEEfPnN5gCy1fXKvgi3lfOGTc
	y2WN8L5M5bqoiYAxM/UKKudP4RpuYwHFRuIsy69GrqoEDBFoPl9/0bHZLmUd91TxASj6pg
	dk9wdhjpEl6Us245yOuuCR4yMGNXEv9p43vg/Rrkr8NlvdLEBBIr0kkfj9TGwQ==
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374bb08d011so2048849f8f.3
        for <linux-wireless@vger.kernel.org>; Sun, 15 Sep 2024 01:07:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZDTBIznXDXHZZwXh4jJLunoiokCnMYaFqn46LLTs0YebCcjIwnuy9WF3atEHAVRNkTnpoFnWrEtvR/An2PA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYeW2ngFLS0Q5BK4WeQMK9i6I3JHwF4ta1IbrwayXoyCkKl+RQ
	+rhKkk195NZABtsKx/n6V+ssG/2cZrAvHPp1PppoDpEnUOB1s6ndGxuXEvnmUqZyKUeRrldHtrz
	TgJiV4nKdXlaMryCf3gSN5UX7+tM=
X-Google-Smtp-Source: AGHT+IGAZAWWfcdgZFWqWa8FJr2l1EusnxO7jt9ZfGYsxtlHoeBahn5S57/vATF1XUAXI06Q4uLTX2eojMTVbEW1b7k=
X-Received: by 2002:a05:6000:4581:b0:374:c4c2:fc23 with SMTP id
 ffacd0b85a97d-378c2d5b40amr5737556f8f.56.1726387663539; Sun, 15 Sep 2024
 01:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZuIhQRi/791vlUhE@decadent.org.uk> <20240912083959.GA132706@wp.pl>
In-Reply-To: <20240912083959.GA132706@wp.pl>
Reply-To: martin-eric.racine@iki.fi
From: =?UTF-8?Q?Martin=2D=C3=89ric_Racine?= <martin-eric.racine@iki.fi>
Date: Sun, 15 Sep 2024 11:07:31 +0300
X-Gmail-Original-Message-ID: <CAPZXPQfqtKcxb+TFBE1xxeWWDABrXTG-sRzZyVP72PVKejmi8g@mail.gmail.com>
Message-ID: <CAPZXPQfqtKcxb+TFBE1xxeWWDABrXTG-sRzZyVP72PVKejmi8g@mail.gmail.com>
Subject: Re: [PATCH] wifi: iwlegacy: Fix "field-spanning write" warning in il_enqueue_hcmd()
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Ben Hutchings <ben@decadent.org.uk>, linux-wireless@vger.kernel.org, 
	Brandon Nielsen <nielsenb@jetfuse.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

to 12. syysk. 2024 klo 11.40 Stanislaw Gruszka (stf_xl@wp.pl) kirjoitti:
>
> On Thu, Sep 12, 2024 at 01:01:21AM +0200, Ben Hutchings wrote:
> > iwlegacy uses command buffers with a payload size of 320
> > bytes (default) or 4092 bytes (huge).  The struct il_device_cmd type
> > describes the default buffers and there is no separate type describing
> > the huge buffers.
> >
> > The il_enqueue_hcmd() function works with both default and huge
> > buffers, and has a memcpy() to the buffer payload.  The size of
> > this copy may exceed 320 bytes when using a huge buffer, which
> > now results in a run-time warning:
> >
> >     memcpy: detected field-spanning write (size 1014) of single field "=
&out_cmd->cmd.payload" at drivers/net/wireless/intel/iwlegacy/common.c:3170=
 (size 320)
> >
> > To fix this:
> >
> > - Define a new struct type for huge buffers, with a correctly sized
> >   payload field
> > - When using a huge buffer in il_enqueue_hcmd(), cast the command
> >   buffer pointer to that type when looking up the payload field
> >
> > Reported-by: Martin-=C3=89ric Racine <martin-eric.racine@iki.fi>
> > References: https://bugs.debian.org/1062421
> > References: https://bugzilla.kernel.org/show_bug.cgi?id=3D219124
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > Fixes: 54d9469bc515 ("fortify: Add run-time WARN for cross-field memcpy=
()")
> > Tested-by: Martin-=C3=89ric Racine <martin-eric.racine@iki.fi>
> > Tested-by: Brandon Nielsen <nielsenb@jetfuse.net>
>
> I proposed diffrent fix for this here:
> https://lore.kernel.org/linux-wireless/20240520073210.GA693073@wp.pl/
> but never get feedback if it works on real HW.

I submitted bug reports about this at Debian and on kernel.org's
Bugzilla, but never saw this patch, so obviously could not provide
feedback.

> So I prefer this one, sice it was tested.
>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Thanks.

> Martin-=C3=89ric and Brandon, could you plase also test patch from
> https://lore.kernel.org/linux-wireless/Zr2gxERA3RL3EwRe@elsanto/
> if it does not break the driver?

I am not currently in a position to test this. I will trust Brandon's
results on this one.

Meanwhile, an entirely unrelated bug crept into the kernel. See
attachments on the above bugzilla report.

Martin-=C3=89ric

