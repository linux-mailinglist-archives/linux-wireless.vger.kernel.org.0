Return-Path: <linux-wireless+bounces-9797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E52F91EAC2
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 00:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4671E1F21868
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 22:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3B417BBB;
	Mon,  1 Jul 2024 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1NFBgeI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EE185947
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719872223; cv=none; b=llTx05c012o6f/t2vStgNYM8OP22T00YrjqyQd/oFomNBNMtQqLa4K5+M71/ItHwEgrDEOLjl4xPg87P2o7yMrbGsfXXmB33tFdG8KpbHkcX6gB1buk6GPIzpx2DtMxnKcfr17GZu0UtecmbvTGAO5ftzmm7neHoOgqGDlgxrmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719872223; c=relaxed/simple;
	bh=45eiQpHuie4RD6Cei7yJ9HOjoZJBtr41BIgwlnvTuBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPAk+96GQCLLzen0YQsrBAEjQbBJjpDAz2WyyTtFJ/HcJJNQ36SkApDimDWKVEM3Aj+fN0BmDmTij+Wn8cGlIEPZlwJnAEMK/QGVKoIiJWE0YJ90zjSqQJDWUfdtxuc2qLfL3gGZxPHYQUsneZpOF8cjNP0aNakVa7ME+RIiw2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1NFBgeI; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso3166556276.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jul 2024 15:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719872221; x=1720477021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atLSQBZx29bltErpDjyHxvCi5PEdnKPYZS7A3XODE7w=;
        b=g1NFBgeIi/6OCyheO6WGDBeE/NSFwng3riPq2GyBBw4VOoxUQ+Bl5xbJpWKtnH3/ic
         mrCBh0mFSPIeVSotb2g8kGKuMlm5kBAUPqgZVAZZ79V1sk7t2JrgFpuYGRFf4sYkagZW
         KuDyOd0FjZWi8FpnTJyg0oUqjqj6mMd7wlevnBRzryA5TUBOfh0e2RpQ9y3gJzqjWiZ9
         zK20dnAeC5XWdwfFkZMW1mFwAkv4JxZWYjlCZUThGNXPIRLfMWl2hZkviC81kUnQjuDt
         TG5444TZqHvIdAGpUCck3hYGUHh906TGFAZJ4oBl1WgIZiZXjqfq5DJuKqhxSuy0Up74
         WQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719872221; x=1720477021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atLSQBZx29bltErpDjyHxvCi5PEdnKPYZS7A3XODE7w=;
        b=euo6KQxYKITlnzkdr4IsGNX4OsKWNIuDIQzqfLuIG9PbFN49apj2pg1w4zRS12P9to
         AjZkaFIRK2d6YPr/s5o+C3N755wPkUc39whh5suE+5IeucrCoq0MILRd1M6KrDvHlzfN
         lqgbXgC8IdOFaA5Xwr7el1qYYyRGl8L6DNfcPg0caJDpY2hPM2DolbrROBqnx09loPMT
         cuc1bxyWZ+bNDCfwxMjKeZ54IcwVLZ1VAIoCv1opUI5vAwLY6/5F5avNi5IH+Hrx78/9
         /00I+wqkSM+An2sdgwMDCwPH6zbGoD3Brvgn+cwwKuQ/nXk9SIunqq/y6QaD6tffg1Lf
         zRKA==
X-Gm-Message-State: AOJu0YzL3euyoq/X/9bhRio+4zSFsZr9Hg0D43G1x56ejTLqCiLCaSss
	HQ/kAziwIFrqNcvEn6TFupmzV+HCqmw3KpavJKR2W8Dy8BfBMshfvB7UpFrgZVZnlT5RovTTKSE
	dcMMDlr5AnH3zkiyR+aE861M8prf6QKbx
X-Google-Smtp-Source: AGHT+IEeEffJjZePfhqEW54EEsOcyk6G7FNZ6uhXev9PqV2QcV76tHSaGl/qxQYi1x2PiuCS/kKU0aNclH+lQRwx80s=
X-Received: by 2002:a81:fe04:0:b0:615:1cbb:7b81 with SMTP id
 00721157ae682-64c739eeae8mr55963557b3.46.1719872221192; Mon, 01 Jul 2024
 15:17:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628223237.16222-1-rosenp@gmail.com> <8f826bf3e6c2a676c4db37fdfd5b10e364abbb51.camel@sipsolutions.net>
 <CAKxU2N-L+B_DSTA9nsseDgnzCtgOvtSgd6pShEF-MmA=DQCR7A@mail.gmail.com>
 <a95d943d72123ddf4079262003516f29f52b06ad.camel@sipsolutions.net>
 <CAKxU2N91jXA9hjdbPkfdQnHa1iehdBE+_K4QdsRGGfKu9V_sJw@mail.gmail.com> <1dd82a549053f7c2d841a966704664ca785b14c9.camel@sipsolutions.net>
In-Reply-To: <1dd82a549053f7c2d841a966704664ca785b14c9.camel@sipsolutions.net>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 1 Jul 2024 15:16:50 -0700
Message-ID: <CAKxU2N-SH2pKTq4tQX+cJEceQ3EHN2nxQK+krr8q3VQ7a-3nrg@mail.gmail.com>
Subject: Re: [PATCH] iw: fix formats under MIPS64/PPC
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 3:10=E2=80=AFPM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> On Mon, 2024-07-01 at 15:07 -0700, Rosen Penev wrote:
> >
> > They go away because if the define is found before any header
> > inclusion, __u64 gets defined to unsigned long long.
>
> It *isn't* found before any header inclusion though.
>
> For pretty much all of the C files, "iw.h" comes _last_ in the list of
> included headers.
Oh I see what you mean. No real idea. However without this patch, I get

event.c: In function 'parse_nan_match':
event.c:668:41: error: format '%llx' expects argument of type 'long
long unsigned int', but argument 2 has type '__u64' {aka 'long
unsigned int'} [-Werror=3Dformat=3D]
  668 |                        "NAN(cookie=3D0x%llx): DiscoveryResult,
peer_id=3D%d, local_id=3D%d, peer_mac=3D%s",
      |                                      ~~~^
      |                                         |
      |                                         long long unsigned int
      |                                      %lx
  669 |                        cookie,
      |                        ~~~~~~
      |                        |
      |                        __u64 {aka long unsigned int}
event.c:680:41: error: format '%llx' expects argument of type 'long
long unsigned int', but argument 2 has type '__u64' {aka 'long
unsigned int'} [-Werror=3Dformat=3D]
  680 |                        "NAN(cookie=3D0x%llx): Replied,
peer_id=3D%d, local_id=3D%d, peer_mac=3D%s",
      |                                      ~~~^
      |                                         |
      |                                         long long unsigned int
      |                                      %lx
  681 |                        cookie,
      |                        ~~~~~~
      |                        |
      |                        __u64 {aka long unsigned int}
event.c:688:41: error: format '%llx' expects argument of type 'long
long unsigned int', but argument 2 has type '__u64' {aka 'long
unsigned int'} [-Werror=3Dformat=3D]
  688 |                        "NAN(cookie=3D0x%llx): FollowUpReceive,
peer_id=3D%d, local_id=3D%d, peer_mac=3D%s",
      |                                      ~~~^
      |                                         |
      |                                         long long unsigned int
      |                                      %lx
  689 |                        cookie,
      |                        ~~~~~~
      |                        |
      |                        __u64 {aka long unsigned int}


And many others.

I submitted a similar patch to fio and was advised to move the define
into the Makefiles. Not too sure how to do that here.
>
> johannes

