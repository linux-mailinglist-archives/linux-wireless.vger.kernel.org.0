Return-Path: <linux-wireless+bounces-23204-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5C0ABECFE
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 09:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 360757A693A
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 07:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C4E2343C9;
	Wed, 21 May 2025 07:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avpLffxl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B866199EAF;
	Wed, 21 May 2025 07:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747812266; cv=none; b=HyE6imU/CiyTr9oxGLLva+qalxauhQUIfzIr4nnNfDJyenfAJzgXbiacfs84SbwBWXYVzNZDBfowxCxDPEEC2siLxXirmmKsJfy+0li0iW4Fjy2hAuvxqU0k2qpOttThagadw1Avpp/YULV/YSrgHP1d0GVd3M5xdeeddq68EWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747812266; c=relaxed/simple;
	bh=bsRKvz0IeflenEfvIJXltQBXIEynMd8vYvMNQDAeBNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7yjPyYeuGO/p0yLido0kEqcPm5SEqDvuNXvCXjmrRoBIpAb6yJj0qHdJEwiJX0s1r0m75KcH03m9sTD1F5xrpPK10pm255pUm2gvIbO95JHEgLX7VD2AWOI83IYRIuL3cF477AUJJi6jmKIXxaE+Bp0jqUaUeKh5FzpXBYF3Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avpLffxl; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-861d7a09c88so154212839f.2;
        Wed, 21 May 2025 00:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747812264; x=1748417064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsRKvz0IeflenEfvIJXltQBXIEynMd8vYvMNQDAeBNo=;
        b=avpLffxlLvZPCPH7ewdoPbFaR2a7Snr70IFgMAUf6h5tGeH9/vKhahlqrzvbiVzczP
         ZsqQloFKWYc1Qu5HjD0IbfuaTHMPW2RjfRbdMK/z/jbWptdKM1yfght7LUSEA4BZLWEu
         n3m6crFKtsWFjfNnBRWuPreRMUqzJZCrGarkHy4moclgLec2qaCLgVs6Nht2MBnB9osx
         cvnVz8SJUtMy/e4IX1jKqYocQQuW6OJ3bIe9ydqDqyv1NAc0aOBz2daQOgTMQEjzYqDU
         Y1vaDRP7WKHE1xJCGAHjdgWcmcxNhdQ5YI3uPTsevd+mRaKBh0htTpANTF1t+rLtL5a6
         wHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747812264; x=1748417064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsRKvz0IeflenEfvIJXltQBXIEynMd8vYvMNQDAeBNo=;
        b=hr18D+5mxpUuM8nmcIHaTR8QaSQ4dDmz+u+BwE3huKLIPiUKQMwmyaJnamLDnYVbYb
         hUhWjQF88aeMGNfa29f2TgmTAedw+QIH48n/tsmdibjnONvLdoH32tsuqtXim+ENYIFx
         0eOwiZIa0io/ORKLYPplEsSLYEcrcwhUraFpW9XfjeeRPAPbvcFoZ3L873J9TDe9DcKZ
         0Lslcvf5BeJrYgfBUsP3l3lbXwq21IGaHAXuth2IOwwe2MYNfhoeOYZKNGTHICHD46SV
         9wR2FFV+zpoGvnRS+2CRhvd2IRktDF1CMbPGGxzX9tUksR0eHjQw0SzNqUtSNwuxBMoR
         5PuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkidpvfVsjSX2aV/oh02XRj8KMYUtfk9Fdq0oubRalPu/2Zx9y69xNdu6sbukV4StbsIu9NII1z6VXHMs=@vger.kernel.org, AJvYcCVArbWAdKULrxxdNHGvxSGJe0na1hoZFJ3gcSFivIKD5HoLDO1dVnFgB/XQMIkK/Q+qSr4WSz0CMPKvXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDHAwPqixGolaWQQqNwdIsTo7GimlGEhHsM7Vx6g7IkQ2bubyy
	mQFdKxM2T0wdf/nYFMyd0p9N5KaCuXwFc4eOrPpoHJTDuCbmSOK6wuF1z8FX+Ptpinluqh4uRfI
	S74gInZkFYantHDuKUoMWfYNYq2sPZcE=
X-Gm-Gg: ASbGncuoqGxSFyCn7tkPQWtdpcPPKO0SfIKOvW1fY5/TXhnOEU2inWmN/q5DQRaa4S0
	6r5v4Er0KpIhVL6rr5v+VcAVVTSO3HETinNhKx1yHnV6JgSD2p3qEqfj9NHSVCLnzG6IBkWdBQz
	cOsyKGnAgXCmNWCCq49SrcR55IL1bg8616
X-Google-Smtp-Source: AGHT+IGFDYBRiQXD5xgvrn5c6GrFeLVxKsut4Q0h05F8cCwAOAEYT3ecSVh9wv9zXcr7frmDxZ0UC4M6jQeMmcdwzfo=
X-Received: by 2002:a5e:da43:0:b0:86a:2523:a9fc with SMTP id
 ca18e2360f4ac-86a2523ab62mr1661574539f.0.1747812264166; Wed, 21 May 2025
 00:24:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520223430.6875-1-spasswolf@web.de>
In-Reply-To: <20250520223430.6875-1-spasswolf@web.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 21 May 2025 15:23:47 +0800
X-Gm-Features: AX0GCFttNynCNWUpGDwxv5Ee1zvFjTDsRbF65Fu6DSl_bVrh9rFic3i78TZ0q48
Message-ID: <CAL+tcoDtk2vNqiNWdG1hvo3jMNt0_fPffi5ts8LZWZzMDvsLXg@mail.gmail.com>
Subject: Re: [PATCH] wifi: add sk_requests_wifi_status()
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 6:34=E2=80=AFAM Bert Karwatzki <spasswolf@web.de> w=
rote:
>
> Checking the SOCK_WIFI_STATUS flag bit in sk_flags, may give a wrong resu=
lt
> since sk_flags are part of a union and the union is used otherwise. Add
> a sk_requests_wifi_status() which checks if sk is non-NULL, sk is a full =
socket
> and checks the flag bit.
>
> Fixes: 76a853f86c97 ("wifi: free SKBTX_WIFI_STATUS skb tx_flags flag")
> Idea-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>

Since Johannes will modify it manually, so...
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

