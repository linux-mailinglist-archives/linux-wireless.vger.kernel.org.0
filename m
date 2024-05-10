Return-Path: <linux-wireless+bounces-7476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 063E28C267E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 16:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E3B1F21E5D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 14:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F3512DD93;
	Fri, 10 May 2024 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9UuUBzi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D80E12D1FD;
	Fri, 10 May 2024 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350493; cv=none; b=lW+kUbswCuSYC+qLoQ33715rhSHqm0DyR8GferMkqokmKGljTu7reW/wfDSTsTLf2Ph9jSlpXbiE8Y1y0wQLeZ8WF/f7zKZzHROCw5vWAppdN1sOuxK3PKuozcmTN0e/yXf364UpkaUn59c9Xex0A3aunkD8oyJoQvPAK5YjF/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350493; c=relaxed/simple;
	bh=ew71z39jrBini8fb1Cf3Li5Ir++/AIdlxhlLwmWoIUQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYhZAo2iko/mfb7JmQuNOJ88gJoaaY/K2Zoz//w0ABikRVqfXkslJvxY34SwIeiGwRaRV2iBjkqnf/WX+P2K1jKx+MHpqv4c+xlM2uGZFXM8TUtkBs7eibpm/jed3LhoT7hK1EpbrdVb5bwSFOELom/piYlz5V0bDwSNwWi1O/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9UuUBzi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41bca450fa3so13366075e9.2;
        Fri, 10 May 2024 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715350490; x=1715955290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V4Chi7FQsImO6C08GNf9uEOdcEOp5eUHyPr9M94jyZk=;
        b=B9UuUBzikxypY3OIPvs5YxN20P25rDckxdoAdIBtRpUTewDrdNeWsE8jVS5zcCHhAX
         drGCM7l8by2WiTASrzRNu6HFJR2gqz929g/fMpLZnDrzbNKJEtsz3ep1//tm/NNx0kfs
         W+lD7unAgDyd24B0IG24ncWiXTSr6gQWuTGjFNAwssSXpcr+/bY1lj2tHjDdZ9kU9gRH
         q5NULX+WosSEBVRjQSS71K5HPTx0PzZ0ax2go+nC2SrJpJWq1SLJgszBQ3eWIvq+tEEU
         t82wVhDKhYiIEvgos+FLikfavg/44MvJ+rLfS9trGIO5ktz9KusXUBUK75ZngqQ1Gd4E
         TMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715350490; x=1715955290;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4Chi7FQsImO6C08GNf9uEOdcEOp5eUHyPr9M94jyZk=;
        b=hzQaB9yekUSiiEvixfagxE/RyFuJyI4C2Qp9G/h7WBDqbCv4c9oAhqO5Wu2Hzz3ym/
         RDN2cAk4iLbv/V7rElirCbD7+iNoMoo13K1uQcyzDDpjCrydhYlaSjyqR7GMGsDTFM+E
         4qF2Fw8AQHCS7g/LGPGPNdPCVyoDE9Rc5jofpZMw7nRO0FV/LdB1nvnFVjKMtOpc7igq
         R3P6Eb9ay/OzTMIFekN22WMz/M4aeqAt2rXmTdnFZoT2CMfZC8aHN7ZtpfTz77w2xqqa
         Hd5tEQqN9TJRTnq4Suy1aKtG8T2KZc+fAzfiODxSzMAwxhPK0EnSt+RlN0lYlcZVjoqm
         K1ow==
X-Forwarded-Encrypted: i=1; AJvYcCX1JD99Gg5ztKNeeAO5hTdp9q48eiuavVaVDe8sqKnV6A+MpMrllkhyePM3GWMCHSCN49frvIfuno4QM+CG8gu0jvlplLcfrNXvhPhXuZf8zhxtkWk2teHv5u16qaYO38r19SzVwOeg4G56AOdpmJVaHbKufYbTmYpl3ZYDb0v45E2yZ8g=
X-Gm-Message-State: AOJu0YxDrtKpuE9IWp5EMPKgy9D1Oy90KewpXawC2QFmL5ioCZglEQhr
	DTHzbMKxow2FePiviQpkAAoJ/UcLxZVR+ISci1tiHYteI5Orkgcu
X-Google-Smtp-Source: AGHT+IGOLYUOycFRbQJ2nHehCiWT7J3HpYvUMXtGyYTQmtsn+zy5jklYhoqjlwyylQUwP3VCoztrQg==
X-Received: by 2002:a05:600c:5685:b0:418:f991:713f with SMTP id 5b1f17b1804b1-41feab42b13mr20922365e9.23.1715350489598;
        Fri, 10 May 2024 07:14:49 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbbf9esm4675703f8f.91.2024.05.10.07.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 07:14:49 -0700 (PDT)
Message-ID: <663e2bd9.5d0a0220.d970d.cbf8@mx.google.com>
X-Google-Original-Message-ID: <Zj4r1RDdVleh9Y92@Ansuel-XPS.>
Date: Fri, 10 May 2024 16:14:45 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	Sebastian Gottschall <s.gottschall@dd-wrt.com>,
	Steve deRosier <derosier@cal-sierra.com>,
	Stefan Lippers-Hollmann <s.l-h@gmx.de>
Subject: Re: [PATCH v14] ath10k: add LED and GPIO controlling support for
 various chipsets
References: <20230611080505.17393-1-ansuelsmth@gmail.com>
 <878rcjbaqs.fsf@kernel.org>
 <648cdebb.5d0a0220.be7f8.a096@mx.google.com>
 <648ded2a.df0a0220.b78de.4603@mx.google.com>
 <CA+_ehUzzVq_sVTgVCM+r=oLp=GNn-6nJRBG=bndJjrRDhCodaw@mail.gmail.com>
 <87v83nlhb3.fsf@kernel.org>
 <7585e7c3-8be6-45a6-96b3-ecb4b98b12d8@quicinc.com>
 <cce2700c-e54f-4a50-b3f0-0b8a82b961a4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cce2700c-e54f-4a50-b3f0-0b8a82b961a4@quicinc.com>

On Thu, May 09, 2024 at 09:48:08AM -0700, Jeff Johnson wrote:
> On 5/9/2024 9:37 AM, Jeff Johnson wrote:
> > On 5/8/2024 9:50 PM, Kalle Valo wrote:
> >> Sorry for the delay but finally I looked at this again. I decided to
> >> just remove the fixme and otherwise it looks good for me. Please check
> >> my changes:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=688130a66ed49f20ca0ce02c3987f6a474f7c93a
> >>
> > 
> > I have a question about the copyrights in the two new files:
> > + * Copyright (c) 2018-2023, The Linux Foundation. All rights reserved.
> > 
> > My understanding is that Qualcomm's affiliation with Linux Foundation via Code
> > Aurora ended in December 2021, and hence any contributions in 2022-2023 should
> > be the copyright of Qualcomm Innovation Center, Inc.
> > 
> > 
> 
> ok it seems like Kalle's v13 had:
>  + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> 
> and Ansuel's v14 has:
>  + * Copyright (c) 2018-2023, The Linux Foundation. All rights reserved.
> 
> So Ansuel, is your work on behalf of The Linux Foundation?
>

When I resubmitted this at times, I just updated the copyright to the
current year so I guess it was wrong doing that?

As you can see from the copyright header this patch went all around and
I think at the end (around 2018) the Linux copyright was added as it was
submitted upstream. (can't remember if maintainers were asking that)

So me watching the old year and resubmitting it, just updated the date.

Soo I think we should revert to 2018?

-- 
	Ansuel

