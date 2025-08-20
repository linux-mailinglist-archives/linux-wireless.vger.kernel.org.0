Return-Path: <linux-wireless+bounces-26471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D163B2D5E3
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 10:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F028A00585
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 08:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7292D8362;
	Wed, 20 Aug 2025 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b="ULcMvtqf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DB52D837E
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677693; cv=none; b=FPgj9V5TcN9XM76ZcFn6hGkk3B6DFevx7vwox3fC6pc2KE7k1w5k+F4zslQw51ynuvU/ysI06N9CHV6eg/o3HcAQ7IycByDmw9ezqLTfPqV+5wGNd1rqkGSeYHqhj+kzHIDL808mfZIkiNGEMLfDgSsyKOICrDRjqHVcZfhkwrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677693; c=relaxed/simple;
	bh=qoD6Jvb7fcPgvT4QiYpQRvBShAYWcwKCtyWZSasJpbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+cvDT0wgyPVMRnASDLh0CwvmnsJjnWqpzErxE55HsNKTPmhP+5lJFtYAq0BAk+yLsAuK11fv+BCGbCiEi3DD66I5s3don8GSjMJLrNLBxzA7AWFRrJuho0trpFCGGJpebkwE9Kx3twYqvIt7YbMDXj0TVnUxwCt9Jtkq2goxGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech; spf=pass smtp.mailfrom=moment.tech; dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b=ULcMvtqf; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moment.tech
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-50f8ba51c85so2120267137.3
        for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 01:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=moment-tech.20230601.gappssmtp.com; s=20230601; t=1755677688; x=1756282488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoD6Jvb7fcPgvT4QiYpQRvBShAYWcwKCtyWZSasJpbY=;
        b=ULcMvtqfNG+21LTxqg+qoevWqqg6cDp1DdOPXKz4fUqwdDPI6CcMokTT7z/M8/IlE3
         YHSuXPgRmr0oeCnQlBOUtXqplGl09HdSwRgBo5DOeUsqSGgx5IL8seO/oXEX9VEXMWuK
         WpUG46vYmPGB00XO2wev+ONVLYR13rryr2et2a0p5ULwBTEwQbVEyTye83zFsrFtKT0k
         hMV9xlnjER1Eck533CYro9l/5D+0A4pqAYQyjg9KfOejowh+BgbAXwAvLQNOWqs7b5AB
         M7MQ2p9Y8NjiGzLUtE7YlSaLmjy/J4yS9Oa/elecII9IGeFQSgyjwCUT+w4Q+VYs3Nqr
         /3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755677688; x=1756282488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoD6Jvb7fcPgvT4QiYpQRvBShAYWcwKCtyWZSasJpbY=;
        b=ZGY7ldOhY+ifkhSgNroxZylTeaQBFVaBxYdtWr7ukUCizPCqU/weyGzY1ZzEpJs9H2
         vQrCdbi4802rpyHmJneqpv18tzyy3gneQiniuGSp7HC9Y4zHKPS81eCrhXSwrG0dDfqA
         N66YTPP/gAznDPvxQh0GNSrmW+niG3/D+opcJv2W5k8ifQYovNG1e5uZabLHcT/3vzgj
         szMzVYo7HhtTEpA/zy7gueSU+1tppVQq1qpZPIUvNicOzgmDbTnFy++W6kZeqpEBU7hM
         CHq/341j+RmM8sQL2t8jRZeKC7qeBBF+6t+4F+sgIbdzbF1Vf9Skwh3o/mbDhtZLgzzc
         sRLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIcEXtL+8lAY1R+G2BE1raYoGhceKPRRLaV2OmR/48+xp24zak4qIwwpH2Lof6cRY+FoY15vlxeiZSRGEZpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxppKYErGjEhFQlutlBaLr/XEUHLzuzMAO6ek2fo+q4406VxLxb
	LgyQ9Kxyf2nUC3Z0vGhi9S+MbRhLo6uaCyUgp91dFiHvMyX++REjwh2ekhNXejvcLCh/qnlAngK
	WKIQlvnvq/VPdJeX4rD7CiEEASF1exmYFjUdCX4vXYw==
X-Gm-Gg: ASbGncsYb5EB2mBf1qQPdG7qWO/0RA9TJAhAQuUOcSXRTYoNQheXUDgfSHoLz9Uj/OC
	Wz/+yaThmvJ7OI54K9eO/0b9uMuxwUMDWA2+luc4Eqcibl3RvGgPAQXoMR3s1qhNiIWXbaFzTgL
	BwqhFLbTUZindPPOVdp0h/RwkRfSwuNZlZLOM7qAUfLNvtx8iExnHjeJN9VgAb8vpjK+72pcOUm
	xe2tfu+yA==
X-Google-Smtp-Source: AGHT+IH8ZPC5VW9vk5vRYJtfgjilWt/wkkgDPxES6TzVbPR9ibWB/LhfOZW2INutNpaHV4M5k/wRJxPg2Uyy3LvOuX0=
X-Received: by 2002:a05:6102:50a6:b0:4fa:d2c:4fe with SMTP id
 ada2fe7eead31-51a513b32d5mr550729137.26.1755677688226; Wed, 20 Aug 2025
 01:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611164004.38580-1-balsam.chihi@moment.tech>
 <91fa8b1d-7bd0-4beb-80ef-eb65d2562f17@oss.qualcomm.com> <CAONkfw5Xyk8CGmVDpWZfkWnuCcFq6400jUkqyeMDtS0UNSh9vg@mail.gmail.com>
 <ecab2156-b234-4fba-a2ad-13a2d9b4693f@oss.qualcomm.com> <CAONkfw4hkDQtJyOj4RVsR3V=FJDJYKnjtmqzD=jBMy1ax=tC_A@mail.gmail.com>
 <0dfe48fc-085f-4dce-933d-e0f132d2ff9c@oss.qualcomm.com> <CAONkfw4p1AuE-MhGiZNMmi-PXR+CjoY63K2Yx_dmv2vnjo-Eyg@mail.gmail.com>
 <CAONkfw58jcGRxotm2zJasQd56oDR-h0b3Z0Yi+pE8hdrmN=Ucg@mail.gmail.com> <1321153053.0.1755624998195@boobie.home>
In-Reply-To: <1321153053.0.1755624998195@boobie.home>
From: Balsam Chihi <balsam.chihi@moment.tech>
Date: Wed, 20 Aug 2025 10:14:11 +0200
X-Gm-Features: Ac12FXxhBB3Z1Fz5eOxICU2Y5Cr0csO4dqd3bF0XHzDGnb9CHwpO-aDrYx8e05Y
Message-ID: <CAONkfw452N+cOrLo4p7KXOE_W6p=CFHanBReDdnenXrgEY6Cww@mail.gmail.com>
Subject: Re: [PATCH] ath11k: pci: avoid unsafe register access during shutdown
To: Ameer Antar <ameerantar@comcast.net>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, jjohnson@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 7:36=E2=80=AFPM Ameer Antar <ameerantar@comcast.net=
> wrote:
>
> Balsam, do you have a patch for this? I also have cards that require diff=
erent
> bin files for each band. I haven't been able to figure out how to do this=
 via
> configuration rather than rebuilding drivers.
>

Hello Ameer,

Yes, indeed we have to rebuild ath11k but once with the patched
core.c, not each time we add a card.
Then you can add text files named with the pci device address and the
path to your board-2.bin inside,
for each instance of the driver.
That way we avoid building the driver or the kernel each time we add a
wifi card.
I'm cleaning up the patch and I will send it to the mailing list if
you are interested.

Best regards,
Balsam

> Thanks.
> -Ameer
>
> ----- Original Message -----
> From: Balsam Chihi <balsam.chihi@moment.tech>
> To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
> jjohnson@kernel.org
> Subject: Re: [PATCH] ath11k: pci: avoid unsafe register access during shu=
tdown
> Date: 8/19/25 4:50:47 AM
>
> >Hello,
> >I Have a question on the same subject but not related to the bug.
> >I have many identical PCIe WiFi cards on the system and I need to load
> >a different board-2.bin on each one (1 adapter per frequency band).
> >Is there any kernel built-in solution for that?
> >I could not find any, so I had to create a patch that loads a
> >different board-2.bin for each card based on the pci device address.
> >I patched ath11k's core.c file so that it reads a string from a text
> >file in the rootfs (board-2.bin path per wifi card).
> >If the text file is not found, the driver loads the default file
> >provided by linux-firmware for all cards, the original behaviour.
> >Please let me know if there is a better solution for that.
> >Best regards.
> >Balsam

