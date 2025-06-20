Return-Path: <linux-wireless+bounces-24283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C57CAE1930
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 12:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34D01BC5364
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 10:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE1B2550C2;
	Fri, 20 Jun 2025 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="FXuXDwx6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D86B264A63
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750416275; cv=none; b=I/PePi984z6p9eXAvfQpbu8rMWvXRxlJkG2pNyE5eMCuqGGVIx1JoDkP2k4kGv6Svzk/KNuc0AywIhXwGNYQElCx78TK8kPx+u8oFL0s4rIzl+lHj4gJlvCmRQYhFzLgPhK5LKRLihISXCFIvKlMbJ06p++4oA9OLPgEjFsXzzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750416275; c=relaxed/simple;
	bh=CGUyWDvGU7hOknEfA3rhlbxrA4tHuUQfs9tgedJPSfY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dpB52lKdmJVmmKDpX/sjcbYQq6AbaMa95osJCwgOD5Lz0QhyxkeTzwTRvVIHuGuu6QKqISaJgQD/1ch6CcXBDppX89inEBVssxAbXUVhpyiVCqqYcze+FbOBBDI2mNp6fnOsAGsyiE3sWBtrl5MHC66EWt94RTfFIH3Qaepd/Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=FXuXDwx6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450dd065828so12126565e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 03:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1750416270; x=1751021070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t7Ie+bipzU+v4KmePUhTWi2bEZp3fYYlAWtmorew1Do=;
        b=FXuXDwx6tkyocUtEPyd4cUrgVqoHjWqzGDH+Olz6TqIXThvFfEPa40hlb7CeFbyPve
         0u8tz0cQTakFocuR5Q9uJ1/uriaxlE8GfeWy+2c38WRvlP5+986FZ1zoXkGvQBw6HQDT
         eAjeMtoLuEYwVwcs6DwW/7O7q1skd0QHEB7VQTEzendQHvDyFXaboaA5YbKBpIxOsxWn
         F1t0kFQdk5thvHEWAyibI/rL8wIWPb+LNtk6vIoMydZ1vQypD5mQ2PJrxt0lkDyVXh4W
         Gw5ylR/JCQLv04/mXSXraGg8jrvAtzthHQN5AarkjI82Sb8DPVijcpNX955zpS86R1ny
         DW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750416270; x=1751021070;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7Ie+bipzU+v4KmePUhTWi2bEZp3fYYlAWtmorew1Do=;
        b=DC5cPplwuuK1LDGe+io0+XkIKQbdueMmtIv3ezhKXfhmtcDJIuis6hSC25dhMPTZZj
         h/jCDQ/pW1g0Gf5URWyAoXMgqhx7wOM8BU27c2+HbelQjq62+3BQ0f/d+sEYQEReZrjs
         L/2iuDZ1xBtSo4I2UkQ7C7yXHlDrIj+6XgXRIkFraAtQhaq8BOWMpnAgEmRjAhcM7xft
         OuFqJA92CBr8DiG1dUFk4PQRkool/O1MXiQ60asm0lMcRLJ7Ym22ELjrjiDm9rHqCpe5
         zAKoIDpe3QYgGEKtFXGLiqdO+t6lzAohu7p1Icca97nUbqxJcl4lQiTmOKgVSb8nhOxu
         eGtw==
X-Forwarded-Encrypted: i=1; AJvYcCUuQPre2c+E6qAgOiQ6m/7yX+jUm05J/RNt3loTR4z9RFxliXoXmQPN2IAQZH6GySj/Fm4+V6QVtKh2a0umFw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yysufo3f8wx7E9KZiOUB7J43fVvge3p7IKCj+8H2IEJKbFudh0Y
	3IcwtBQD/dQe0iAaLed0/Z74IGTi6TwYcYuge9x70xx4iN1BGGXX/Q9wNsINurhuBd4=
X-Gm-Gg: ASbGncvqzE3TWgDpj4P8Vy39Q6ekxJfPGG6v5io9C6hoLQY8OrgofwlUheafixDvtoH
	H2kkH6t6Dfrusc1m/bQ84zauopfrDgsZUX6nN1rhXl8QKYJI+0FzTAzQMjCdMWq7hu7wYG00YAq
	zZHVz0JtVJXqg6rPmXh0Kw9j1Ghy4kzVG++7t3O1v4u61oqnaurkJcbk+eIgFbzwPfIbw81cnSZ
	soNvDDFiV6LI93DtUWbVJUmi5o90idW/IO8Dxu5uQC6oQbLz6yojv7HjX2nIPrjWdqmW0smVw0W
	TSJKhaAoA4801UmFvoRiD2bKB1v2uMsg64LGKcIYQgwr38AhTFm1t8p6U0DC8VoTbaZCb0t+G7g
	9PwfC7WgFhnOzUlY1BQ==
X-Google-Smtp-Source: AGHT+IHZQWCinVMK5GMqwM7px9AiDgOngAZEsKV7S20UbRTJylRXPBDyf+qxK94FHUVtytrOHM84HQ==
X-Received: by 2002:a05:600c:c48e:b0:453:697:6f30 with SMTP id 5b1f17b1804b1-453659c414dmr16006585e9.32.1750416270085;
        Fri, 20 Jun 2025 03:44:30 -0700 (PDT)
Received: from [192.168.108.121] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d117c6b2sm1689982f8f.46.2025.06.20.03.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 03:44:29 -0700 (PDT)
Message-ID: <fa22feaa-497e-4349-bd20-fd8b75bf4e9f@freebox.fr>
Date: Fri, 20 Jun 2025 12:44:29 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Subject: Re: [PATCH] iw: add support to parse 6 GHz channel
To: quic_surapk@quicinc.com
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
 quic_pradeepc@quicinc.com
References: <20250620073240.2770468-1-quic_surapk@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250620073240.2770468-1-quic_surapk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 20/06/2025 09:33, Suraj P Kizhakkethil wrote:

> [PATCH] iw: add support to parse 6 GHz channel
> From: Pradeep Kumar Chitrapu<quic_pradeepc@quicinc.com>
>
> Currently, 6 GHz band channel parsing is not supported for
> set/switch channel commands. Channel numbers of 6 GHz band
> overlaps with those of 2 GHz or 5 GHz bands and therefore needs
> additional argument to indicate 6 GHz band. Add support to
> parse 6 GHz channels for set/switch channel commands by an
> optional argument "6GHz" in the set/switch channel commands.
>
> Examples:
>
> For 6 GHz band,
> iw dev wlan0 set channel 49 6GHz 80MHz
I'm not sure this is the best course of action to implement the 6GHz 
support (but I admit it is the simplest). iw also supports the S1G and 
60GHz bands and both bands have channel set numbers that overlap the 
ones of the 2.4GHz and 5GHz bands. The most future proof solution would 
be to pass the global operating class alongside the channel.
> For 5 GHz band,
> iw dev wlan0 set channel 36 80MHz

Pablo MG



