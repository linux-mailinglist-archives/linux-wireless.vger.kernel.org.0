Return-Path: <linux-wireless+bounces-23037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B5EAB8F85
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 20:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A02D9E31BF
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 18:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303E728642D;
	Thu, 15 May 2025 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkmaIkFl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704B025A2B2
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 18:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747335483; cv=none; b=J86jHtJW0IWi5opFFE1DE0o4HL82d00ppSi7pUTUJZGhHBYKkJ2JrUcEgPDM7g0u9Us8BYYIc3neQD/QFngO7Pcq/Z8oe+jjUGapXdAz/PrhlrgAW9VFrEDjWKx4UGCFlHnuaohqEdMeqjI9nOTfMEQTAitY/YCXrigWTnxbhI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747335483; c=relaxed/simple;
	bh=JRe9pBALwoloKQMDtYYRo83F8zooiP4QduuUTQf5Hik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=epJid4wWwFDDqmAskZQOHq0f3ulIR9BJ9Q63qPev6x/TTDKYkxXh7aZT20eTnHvKb3xA/ouAbYyMb2vHkGBTI3sUioSfLTxO8qw5UxpYSqyASMH8EYI0kSaKZQP9oef42QWp2wxQqluv47fvdlDPfTwRPaG882XbAnMQaUagSRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkmaIkFl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-442ea341570so8808075e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 11:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747335479; x=1747940279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRe9pBALwoloKQMDtYYRo83F8zooiP4QduuUTQf5Hik=;
        b=fkmaIkFlszAihfnRGiWn5Xv0V9d/NiX4VwVIMkXGhBNRcc77iJtZ6WxiYg/mN0QLNI
         6QtP+gRLsiIjCQ7EJQcYH6Cl2fGXj4VgLdP/j2kS0ekO9OGfO3pn66QaA3SltMEHWS24
         4fMuNHP2Q+XkCxzoqDcyDib9N5bCSCCMiRjTRPSq81HnXdc2pr2c+cqQmXxgY80zAvoJ
         D9eJbqbNeq8vfFST95j7qtX63TkYZwxh4hjwYqKajY4xC+Mw/NYkVTNKUGBU1SQMd6HW
         lLJDTBDrxW+c9ddPfs2uooSOFDoeaxS6wjykaotWc5GLWiPwojCyB1xJyTwoClLNq+n4
         FDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747335479; x=1747940279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRe9pBALwoloKQMDtYYRo83F8zooiP4QduuUTQf5Hik=;
        b=TF/kN74gHePvj7yo7Km1oXSP8+WOLvPxz0P3/uhIuti8lxpU9xxR0JOaioWsA56M2W
         DefdHxpwqUipKgowzN1WQAXJr2JlVvxfjFbHbvACSYVgIGTjRDNvVVQOIiybJU8evDB9
         R9zyG09+s/7LZbsPFuswCEnektsgCvbnz2iWngAS4Kt6HX5I2cvqk3D9vh/xRBYlP2Z2
         mh7Sftkq7JqunChIXpOZZ4M6YN21tJ/oaL5PMF6ap+XheCeoeOmd8BCgMBRyJ1uqGGK8
         WZ1xD/MU5eC0JRt2FjD7XxbtNyH4HOlU6ifzov0TuRuop0nYVGfEPBnjITblTISeNi0q
         Lc7A==
X-Forwarded-Encrypted: i=1; AJvYcCV7akvwReZ8eVykW+FHfrSK2UXvtjME3Qijq/LODe/Lv4lx2pGO0aW6PTM6xIn5yJ5iTfC3ZIWyKFh77NM+6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw30pKS58Y+EgjYd399heBK9+KBx4G0KqFdGsw+4pknOCW0fS3c
	3G91itXwLOH+fzVYKc0RzvSUNIDIS875lm7I2e8C1mMNNP0cAfF26jrgu/JxAFrsGJLQO0849nA
	QcQ1swvm8cMYmSeEZoqv4jylqqjJAzQ8=
X-Gm-Gg: ASbGncu0yAqIPYgARazcrf8pqUqls9+FL/GYnd4Xp0QLubKU8efN8xY4CfQF0g0ACrg
	6utOtLhX+NtVQgPEx6PFkMNV2kFhWH8KJdYCxcYKAhlLzrtZ3UAkDFWW7beT/x2LUsfsENrGFAj
	ia/ILaiWt0zTbHjDQdF6CrwFZn49XiLvU=
X-Google-Smtp-Source: AGHT+IFnPI/D3I42zhtn6Eo3/ju9VXJPwh+5PhBxi/YCt9kniIybmcM8jss+YyH3ttHJ1tW7Z0n55/xRWJSwSVD/LBA=
X-Received: by 2002:a05:600c:1553:b0:43c:eeee:b706 with SMTP id
 5b1f17b1804b1-442fd66ecb4mr6491095e9.24.1747335479257; Thu, 15 May 2025
 11:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMb39_ngQs8=FUML5QXMh2RmEZBZ2NwUHefhGoTkGtHat+KWJA@mail.gmail.com>
 <ef81db9e-99cb-4802-b17f-94eb623a8b32@quicinc.com> <CAMb39_m+4dNBDbkZmn-rDA7T+u84y-dx1jSfmPNWnse=R1=gCw@mail.gmail.com>
 <18788f02-e374-4aa6-ac4a-fd53bc93754c@quicinc.com> <CAMb39_=G_TEL1pbeF_PAZLQh-JOFcncSfqZChPmEj63NjsEOLA@mail.gmail.com>
 <16ccbe02-b315-40d1-8600-232b592d4dd6@quicinc.com> <CAMb39_n4tyrzS=-j0L+ekJVer=KiZyDYFhMqrrcpr9py_itU9w@mail.gmail.com>
 <0933d8d6-5b72-40df-95f8-69f6fbbdfde7@oss.qualcomm.com> <CAMb39_nHO_TbHPQawdLVY8nt3yt4wDuEHyEuzMa-p5Ab1n94sA@mail.gmail.com>
 <CAMb39_nQ-uyKAqCz1HEUDt5qjszbhzf3oikVcvzHcVwt4_qt=A@mail.gmail.com>
 <CAMb39_n89hBL_GvfXb7Jw9h5-h-+Qg-3GyqvpahL7MT5ewpvJw@mail.gmail.com>
 <CAMb39_=YPYg0q7Lf0sMgTx5QwKOqcyJrZR7kTspyXEDa6qz9Bw@mail.gmail.com>
 <e9da4ad5-52cb-416d-991a-259140469e2c@oss.qualcomm.com> <87774003-d0a5-4408-b710-20bd3c194cec@quicinc.com>
 <CAMb39_ntK9Zv3pOuMSza5hRfs_KZBhya=GAPnpBWjN2wZDst9w@mail.gmail.com> <ad255f5e-d1be-42e0-83ca-40fdc4eb25a4@oss.qualcomm.com>
In-Reply-To: <ad255f5e-d1be-42e0-83ca-40fdc4eb25a4@oss.qualcomm.com>
From: Walt Holman <waltholman09@gmail.com>
Date: Thu, 15 May 2025 13:57:48 -0500
X-Gm-Features: AX0GCFvyrGDMPQ28FWQyG1gXLH5c7Sl3DeSrafBnKdNPWNupvxTTFNCdATEY3z8
Message-ID: <CAMb39_muO=E_zqBJtdDs3+XBGNXjN2yTQUaWsKgTd8gMp6DQSQ@mail.gmail.com>
Subject: Re: ath12k: No 6GHz Wireless found
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Kang Yang <quic_kangyang@quicinc.com>, linux-wireless@vger.kernel.org, 
	"ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 1:20=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 5/15/2025 10:47 AM, Walt Holman wrote:
> > I adedd another network with 2.4 / 5 / 6Ghz settings and still only
> > connect to the 5Ghz network portion. This is verified through wavemon
> > and the AP. I saw some patches recently to address 6 Ghz operatoins in
> > various modes (https://lore.kernel.org/linux-wireless/1692f2f8-c77e-87c=
e-db70-00b4d9fc7c95@oss.qualcomm.com/),
> > but the patch doesn't apply cleanly to current or ath-pending. Don't
> > know that it would help, but it seemed interesting.
>
> That series is already part of the pending branch, hence why it doesn't a=
pply
> cleanly. So ideally you could test with that branch, but there are some o=
ther
> issues in that branch that are still being resolved, see:
> https://msgid.link/7db2e4b5-377c-4d3b-b51f-290accc9ddd9@oss.qualcomm.com
>
> /jeff

Thanks for the info. I've found something odd out just now. If I turn
on WPS it will find the 6Ghz Network. It times out before the
connection can be made and WPS turns back off. Just another data point
to consider I guess.

-Walt

