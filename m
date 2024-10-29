Return-Path: <linux-wireless+bounces-14626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCD69B4123
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 04:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF9E1F21B8D
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 03:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29831FCC4F;
	Tue, 29 Oct 2024 03:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PydfTJQ2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254E51E0DA7
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 03:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730173315; cv=none; b=Sfzzt3hwwHALB9rl5XibIk58MLHm7flKCyHlNwrOuPtkoKj7U5luN0Uy0NP4OCfX94KBbU3Tq+dx/tZR7+xyzEWeOWHxZ9w76YktG7AXiSmSPXF6bCOs79wc+0eDIID7wey+o/RtP4WD1FcXrGiWikIqp+MxtP0Iq76c23clM8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730173315; c=relaxed/simple;
	bh=XWYFqVmfRJ7k1fM74a4/jxz7m7YWBYJr1TpizLb/uJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsYKw0PCEs1DhSeX7D58MOom050CR4XdmsojeRpe9iNZOBb+6DtkVUqPyGyAZ/ZES82KSYAp4/FVi3jfDDxJqn9ouQ5/SPBXMKjnjya1ePNEfCNncglgzuArfoMLMj1bm+ML9v+EqlfFwkCv1vA11aIXhb4LphVy2xyJsQruVuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PydfTJQ2; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbf340fccaso40895606d6.1
        for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 20:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730173312; x=1730778112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBfFGJMsVjfPvoFpdWSsuaLfc0Q9vD4A1u3MqdAmId8=;
        b=PydfTJQ2rcwWOAvMHsHp5p4zov76YSSOFrncce6EzPG5MgEXqWp+XiaK8hNuPNT3cb
         AO0vfnttK61538vBvX7uENOdHbYkOu50XW325Fl2XOqJUw/aQ16wSoS6DspuQoVB3OSa
         o+Kpe89zFRdyPOmD8ERsTNixPnhAh5EvoZq3lJZty/RwhpCMIlibWn/H0LsHXsOUF/VS
         fnOAhMWLHvXrkAhyKLJzRdj8n6jJt0U0ozMaBFQPj9WCmo4Qq03pVMnIzhdPlxys1fZi
         5quVri0nuE3hMtFP6aVhYzyrWGFkHBu35b1cxI3qOM4eZGLI2niPmEknXDx92RjquT7C
         JUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730173312; x=1730778112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBfFGJMsVjfPvoFpdWSsuaLfc0Q9vD4A1u3MqdAmId8=;
        b=YUzRSbY/JgPhKZRJlK0OV4XQbrbsUjhnS53UhQFsIoGCYYKcBGhQjKSXGcucflj26U
         Bz/9UAtUMVy3bTIq+JVZAV799sq77/2bEavQae6rE0TVNqq6fyoq5oVACuZw4DEzq1t7
         yMuggpYGZNEI4zq9JIfxxAJRs86UwQj0+R5ojVIBkJHRCpqH8MfPtpMJABPemKMKfGUs
         HT2iUo0CRNrLHNrUWCk3r5uzQTIt4AjFYYbQ12PrsGeK1lq/VdvEkG8weZ9/wEXkLSGx
         pFudNQ/CUHgErrGT6EabG/b5XUKF1AUR+RSL3FVqriFOuXnIoIJDA+lieK7qlOxOCaoy
         3lbg==
X-Forwarded-Encrypted: i=1; AJvYcCUyEhbn/QqIBzCnWQX9GkEzNAGDJE3yaCW3+EuNNFWq97LXZRBUSJSOtOOoRtZYGMS7U8/iqqO6ekmOmOWDgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLWfuSHH6D0uhvnpccwWPeZmkijuMdrpwra2b+GZWdTfom8u/k
	wLR2bahffJx+K/pomDp01i/KbTsA+4dJLWiaAT7bZp1FpXf/XQ7k+FmyGjycc/fvhT4JGGM6TQt
	l9bkTKnodWh0iw3rVw+VPdJxiEZJb0+Ux
X-Google-Smtp-Source: AGHT+IHlI6ic5+01DV2onimsBwZ66nvHEC6/lv3DtvmwpAC/1xXkqiCP2cH9Y4lhWd/7b7QShnSJMIyoGj7Aw6U0ZuM=
X-Received: by 2002:a05:6214:4508:b0:6cb:f077:f2f7 with SMTP id
 6a1803df08f44-6d2f63df3d5mr8946856d6.25.1730173311971; Mon, 28 Oct 2024
 20:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025064235.382-1-thunder.leizhen@huawei.com>
 <87v7xcgwb0.fsf@kernel.org> <ff8c3443-3651-480e-956e-81c7d592099d@quicinc.com>
In-Reply-To: <ff8c3443-3651-480e-956e-81c7d592099d@quicinc.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 29 Oct 2024 14:41:40 +1100
Message-ID: <CAGRGNgUmdKfWxOSPyj9Ofk8ULyPX0j61Qnrd_ckLAy-a0RhdKg@mail.gmail.com>
Subject: Re: [PATCH v2] ath11k: remove error checking for debugfs_create_file()
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, Zhen Lei <thunder.leizhen@huawei.com>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Tue, Oct 29, 2024 at 1:37=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
>
> On 10/28/2024 7:02 AM, Kalle Valo wrote:
> > Zhen Lei <thunder.leizhen@huawei.com> writes:
> >
> >> Driver ath11k can work fine even if the debugfs files fail to be creat=
ed.
> >> Therefore, the return value check of debugfs_create_file() should be
> >> ignored, as it says.
> >>
> >> Suggested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >
> > Are you just guessing or did you confirm on a real device that ath11k
> > spectral really works without debugfs?
>
> The debugfs_create_file() documentation tells us:
>  * NOTE: it's expected that most callers should _ignore_ the errors retur=
ned
>  * by this function. Other debugfs functions handle the fact that the "de=
ntry"
>  * passed to them could be an error and they don't crash in that case.
>  * Drivers should generally work fine even if debugfs fails to init anywa=
y.
>
> The caveat is that any driver functionality that relies upon debugfs obvi=
ously
> won't work if the underlying file isn't created. Hence the language that =
the
> driver "should generally work fine" since all functionality that isn't ti=
ed to
> debugfs will still be available.

The big question for me is this:

> Since the relayfs functionality that spectral scan uses is dependent upon
> debugfs

Why?

This seems to go against the general guidance that debugfs should
essentially be "fire and forget" and return values shouldn't be
checked.

IMHO it comes down to one of two outcomes here:

1. Spectral scan isn't necessary for normal operation so we shouldn't
initialise that functionality if we can't use debugfs, which violates
the "don't check return values" guidance
2. We should break that dependency

I can envisage a lot of people making the sensible assumption that a
non-debug kernel doesn't need debugfs and therefore disabling it on
their thing, but also it seems to be enabled everywhere I have access
to: Debian Stable, WSL and Bazzite. So I could be completely missing
the point here.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

