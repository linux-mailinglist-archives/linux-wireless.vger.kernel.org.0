Return-Path: <linux-wireless+bounces-17060-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE999A00E51
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 20:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2DD1644B6
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 19:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3D21CF28B;
	Fri,  3 Jan 2025 19:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tl0Q6LrF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449DD1B87FA;
	Fri,  3 Jan 2025 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735931581; cv=none; b=S9byZMEGcwiXDwfJ4aCzyIOkUHHwXhlONpxt1NjKh/Ch8+VZWr7couRB/CTfyyRT8We/vwE62ixmQTiF8aDhWvxhXSmziU8cAnv0C1ChyFm/hiob1LGBnXVws8kiNo1ftK9Y/YxST/tkwQB6Tz9RwQ2kCLX5WrZXCTfB2Eg3Sqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735931581; c=relaxed/simple;
	bh=EXJ4Bkwj6Jvmuh3+xno3FAuy6nnL7x0YekASiSSZdmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDAlu1pZrWp0E48k9YZhhrUFQxTMz6I9n8w3Qub7cnwnw/ldTI/40QkAvJObRvtt0Aq/TszurdPSqSrAid1l6vwXhosxFcJUifEYVRGM7Ti4gI+9FfcjwNOejrlkG2VgllIGCIj7NkvF2QP6/2Js4+ACQ0E3GMQzZdrz0DOOB8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tl0Q6LrF; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5f2e31139d9so5640004eaf.0;
        Fri, 03 Jan 2025 11:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735931578; x=1736536378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXJ4Bkwj6Jvmuh3+xno3FAuy6nnL7x0YekASiSSZdmM=;
        b=Tl0Q6LrFDKQIFoUi6hiOkK+MxgY+JYAFs11c0LP39Fpv75TKZqaVz7gWBAiroY+Ce+
         FfwNKsK/fQRsyoGyg8itXpB9Xmy53FfSYWU5Vs4KzHFm1e0Brras2kckYxae8stIF67K
         W66Iv2THHebcP6dKOJXxn08R1j3VaaBYLcYb+xzAwB0T9jRGBs0vctBcR+38zbRNSFj9
         qcPAdPgOEubRxboXQUmhinXqh34scyaX/PUblWBwaPSYnvgtZ4ujdNwTHqfzWjS5sTSc
         PGWhRBrStF7SbfDDvpgBDX6XMpeB3OmnS13yP1ezcP9Cjvjw3pkwS5ABlDU9eJ7PjZj2
         NIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735931578; x=1736536378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXJ4Bkwj6Jvmuh3+xno3FAuy6nnL7x0YekASiSSZdmM=;
        b=H2BzqeYBjtzEAKq2Ix2eRqzu25I9V7B2yeaFiqkmsVT/OgYZWkNYE7/XsMLgEcyZ5Q
         L0Nh9/tZvF7Fh03A5opHH6IuH61b3ymleWpVoGllHRVYeXQ3aEcoPHwpIH7UaOb8NTo4
         scgl254LolgGRhDO/kzFuQM8ADaxV6RAzZADcFNoopKB6ShSK/DFI4FmCOiAkD6/f83n
         jws3p/MoEi008xqJ+Fc/Gkgwl0EKJ9WQHscVwNRq6yU2H4+FRAoqUXrXuqTolQivcBfI
         oCCeUZzeRJ4jRdeoUQZNIgJddHTMuK4QOgHGRuQfNOZ1HTSel+095/Gnu+PcNIqI9a/J
         SbrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4q7TkY0epfzz8hGttZ8KiDBkMy8XUFcOuGS5RgCALOWUsT20A3chvzx/X+u3ZhnC9BDkbrENa@vger.kernel.org, AJvYcCWTLoPfA6i4yKi5J/70v6/nidiQvovd72+17vBaFhm9FkwTgkHNEMhbJGYUbHLupE6jVypBQ4acrxlzar4ckbw=@vger.kernel.org, AJvYcCX7jkIbEAd6JbEubZGjZfbIy+M1pV7zyvr/bOA7Gcv1z859RCO0bGcxvDv2Jl4fK9tCFJlp+EDCywTmQ3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB/TA24vqJ+Lv+d+yrHrY8SqQ/0Zzfma/mTSqaCbO94UQvqXNQ
	QYRCBBwx4Og4LNbO9BfMdblkJR88fj7rbKfHa/ZenNRWqDxhUCYTM1kQI/9h5rrwaFfbfjqrscD
	UIo1ksrCF2RwXsnyDbtQkEg1UWfE=
X-Gm-Gg: ASbGncvu7FacbNyJoHYqlplZxUsHImmpk+fpuzBiP1j5SlcCmqGHwgDNXX+Q1vgweAo
	25hV2h+LDMFBm79KvkGdGwDyO/nBZy9mIZ4ALcg3IiKZP9U5u7FtWzi1MNptdAaTZO9yqSeC+
X-Google-Smtp-Source: AGHT+IFpgceLo4hCgRuWzeEVrvIoDuOGMg2IBDKODb7IECvRIYmo4pR8XCEJv9mMI3/SSgH2nRw3XLTRuMNI0opnQ7E=
X-Received: by 2002:a05:6870:a706:b0:29e:563c:2dbf with SMTP id
 586e51a60fabf-2a7fb34582amr29303649fac.26.1735931578268; Fri, 03 Jan 2025
 11:12:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103075107.1337533-1-anarsoul@gmail.com> <f69874f3c11f4c7b8b0e3026796bb452@realtek.com>
 <d6f4d483-6f05-4221-8412-5c245e5974b4@gmx.de>
In-Reply-To: <d6f4d483-6f05-4221-8412-5c245e5974b4@gmx.de>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Fri, 3 Jan 2025 11:12:31 -0800
Message-ID: <CA+E=qVc=u_O-=WSJHHxchA4MjQ999vbbA+7UDVnLMAH6mtZkZg@mail.gmail.com>
Subject: Re: [PATCH] wifi: rtw88: 8703b: Fix RX/TX issues
To: Fiona Klute <fiona.klute@gmx.de>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>, 
	Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 3:55=E2=80=AFAM Fiona Klute <fiona.klute@gmx.de> wro=
te:

> > Is this urgent? If not, I will take this via rtw-next tree.
> It's a huge performance improvement, 10x more RX throughput in Iperf
> tests, not just in the reported bit rate (residential, moderately noisy
> environment). TX improved too, but not as massively.
>
> Tested-by: Fiona Klute <fiona.klute@gmx.de>

Thanks for testing! Can you please share your iperf numbers?

> Thank you very much Vasily for digging into this!

Thanks for implementing 8723cs support in the first place! :)

> Best regards,
> Fiona
>

