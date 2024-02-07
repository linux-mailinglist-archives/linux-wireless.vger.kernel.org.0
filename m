Return-Path: <linux-wireless+bounces-3266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD0984C432
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 05:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7273C281E06
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 04:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B391CD2B;
	Wed,  7 Feb 2024 04:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b="hry8gfQq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC331CD2C
	for <linux-wireless@vger.kernel.org>; Wed,  7 Feb 2024 04:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281567; cv=none; b=EQ2xXnQNhG7U4M4GVBGW2mNRe8ZN05hAgteqlSMopMRT52QHCyCfanq/EZ4CEoUn6o9Bh6hBY7YTtHR43myXRE1WUQFfSYSIwCJmv7FDBakjGtpJbQtdEj3gRW3GPoSJXmeGl0WUic/2UZafIUwQtIqSpyKQXSiyRywuYGOCkPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281567; c=relaxed/simple;
	bh=dPVcO29uYZKD/zur9DiMOfgfvVbNaW/1uwhqNEf0QNA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CxcTgEM5D9Y2oCNba4Y6OFRYI5mSEh+gilkXSOAWWDX0WOm4lNCnkA602oWw3pDJq+54wzFDIw6TTHaGTYYqmg4OFCWQLNNBvA7thOw78RGT1rTAQt5b9O/4EKl91oV8N7c7uTVz7EkW/ysybmL6pL504wcAlJ0Lr4f+Jswj+Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net; spf=pass smtp.mailfrom=egauge.net; dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b=hry8gfQq; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=egauge.net
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bffface817so8451839f.3
        for <linux-wireless@vger.kernel.org>; Tue, 06 Feb 2024 20:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google; t=1707281565; x=1707886365; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/JetO1HFHnrLv72KbwhYU2aX+lCBNNJLOsgakWCN0RA=;
        b=hry8gfQq9pmpXDaYo7U/mg+ZEi5SItcrq33gJ16/2CWgndhjlashhkER8lc2DJXeM+
         H3FWXzXA63JL5qfT0TiqMy/E3nA7KZ2uVolWofXH4Vy4px5KxmGN/1OiAXtrlDj+yiVo
         zvbr+WRnT13DWr8MjYaLG1yzMX21AJSC9Dz55w8VVKxywglNfpPr0Ppk3tyUQiVX70TN
         8hzObiYzK50yAxzf70Wjwiv9HOQYDuLUpbMleVFjwTDdzl60CFM/ok5vY/7Y1buIbDwb
         GhvoQbapFYoy1T0EDdJKAirecxFYrAKx+clslBIqzpezsL3I4z7xhqB3MqP/frt9ssxD
         3OXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707281565; x=1707886365;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/JetO1HFHnrLv72KbwhYU2aX+lCBNNJLOsgakWCN0RA=;
        b=u8DxyDRtJj1brlWWij5ii36OYxVJKSsxjVDb+c9/3P2JyTRIf6oQCZU7PKU3lrBCNw
         x40zYjUdCwaXWP5TQckVBHDMDUOPBepAogFs2imQIhwFOTdNb8lCKE98TAW/YyaWgw7j
         rYKvvBlNh3iMljqB8vUP9PR7hAPRvNSN7BrKp3gmbTY+Jdv5hwFFHCZLpP7rjoQKG0Fu
         nAoV9K91ZiYEKIEDMugsyh+sAApL4YMe8Sh1PTKIU/QZrr6hXDYgfR/IA+tl5htgajwq
         2vTNU5JLvUWyDXbT50RtALfWJtcUu4O3K9aN8+Q+S9n5lcwnAZp7KThCRoTAokxtbu2P
         /vcA==
X-Gm-Message-State: AOJu0YzYaQvt5EGDHMD6Rfaro8aBaTXSqU1P6kgiT+HSgsDijNQ23iLn
	24C6GkdZjn85teix2Xj2UBWiYUSThUCU8hVQ90P3x+2VDnZTF85J1shFuw30Og==
X-Google-Smtp-Source: AGHT+IH8R2i9HTXKFR3MT+BYrhMX4y2/CnOcb+7LboR+cN/dOXveWdlDK0cgZAZBaB5D3LvU24t1NQ==
X-Received: by 2002:a5d:9b82:0:b0:7c3:e993:d6e3 with SMTP id r2-20020a5d9b82000000b007c3e993d6e3mr5327188iom.6.1707281565127;
        Tue, 06 Feb 2024 20:52:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCURALL8d8CBEfmTOVcKjxZuM+5/YnCCYJyajcgoPacNPK9JZ5hbONbVguI6gKbDID+XxLlwlINDQNJxizaVpicLYH9kgywD/CNBYmNpLYiUHjiTSAdAPj1KL6mFdN7rx24=
Received: from ?IPv6:2601:281:8300:a1:5d8a:622a:58d5:54e0? ([2601:281:8300:a1:5d8a:622a:58d5:54e0])
        by smtp.gmail.com with ESMTPSA id z3-20020a5e9243000000b007c3fbe781f2sm100361iop.5.2024.02.06.20.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 20:52:44 -0800 (PST)
Message-ID: <706d5fde96f90078f80c7fb4fc88503d1791426f.camel@egauge.net>
Subject: Re: [PATCH] [v4] wifi: wilc1000: validate chip id during bus probe
From: David Mosberger-Tang <davidm@egauge.net>
To: Alexis =?ISO-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>, 
	linux-wireless@vger.kernel.org
Cc: Ajay.Kathat@microchip.com, kvalo@kernel.org
Date: Tue, 06 Feb 2024 21:52:42 -0700
In-Reply-To: <415a0e6e-5824-44a2-af2a-a75115d5a62e@bootlin.com>
References: <20240127004331.1334804-1-davidm@egauge.net>
	 <415a0e6e-5824-44a2-af2a-a75115d5a62e@bootlin.com>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-30 at 10:06 +0100, Alexis Lothor=C3=A9 wrote:
> On 1/27/24 01:43, David Mosberger-Tang wrote:
>=20
>=20
> > @@ -1142,7 +1170,7 @@ static int wilc_spi_init(struct wilc *wilc, bool =
resume)
> >  	}
> >  	if (ret) {
> >  		dev_err(&spi->dev, "Failed with CRC7 on and off.\n");
> > -		return ret;
> > +		return -ENODEV;
>=20
> You are still rewriting error codes here. At a lower level, sure, but sti=
ll...
> When I suggested setting -ENODEV at lower level, I was thinking about pla=
ces
> where no explicit error code was already in use, but
> spi_internal_read/spi_internal_write already generate proper error codes.=
 Or am
> I missing a constraint, like the probe chain really needing -ENODEV ?

Lower-level errors are often not meaningful at the higher level.  For
example, attempting to read a register over SPI may cause a CRC error
if the device doesn't exist.  That would result in -EINVAL, even though
there was nothing invalid about the read, it's just that the device
wasn't there.

But I don't feel strongly about it.  v5 of the patch does what you
want.

  --david



