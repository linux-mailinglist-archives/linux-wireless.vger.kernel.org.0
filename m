Return-Path: <linux-wireless+bounces-10122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BFD92B8C4
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 13:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3B91F23277
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 11:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7D115099C;
	Tue,  9 Jul 2024 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/8QkQCf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157611EA74;
	Tue,  9 Jul 2024 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525804; cv=none; b=BqTFiYcIem+L7AH403Qjvrjc/2EsfMw/q276WhCuBpg5kzWhifw7619tcNJqO8RyMZUbh6ZHe9+MAclvTsp3FD94jT5OjnzqSSLZCXe60PuLjJ7zpcNKMKIau+VYXpExkJ4RVP9xHr6pvuhTeXzzBUKaM6H+GFYXntUy7byYjwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525804; c=relaxed/simple;
	bh=lNlid3H/kN6Odo1mBwFYYrRtvNdI/Uorb7eOHuXh8L4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qHgfqARPyZzlMaC6bfE1qO2enAkYZqKMz+7tru+q5wRvqor90ftmJRPm9PvrJQ148c0OciQJcR372uVXotScEhMmOCUvTPeXmwcvHuDO0SfkI3NuO5mO6uxppoRoKl9lsodBYgRonYtd1dThqp2+PdACAbJ/8REig2g1Fms8i4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/8QkQCf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1faad2f1967so41204315ad.0;
        Tue, 09 Jul 2024 04:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720525802; x=1721130602; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MRGbhkDfzuBSO1BGfrLFHwF8BBPQc55G/CgkIUBsVh4=;
        b=O/8QkQCf/oY9jcrKyH+RhNnlbY1zrWhWacwAWixIjccfGXkRE76ig9DGUMIfjvmQ1e
         R1F4VywuNYYYAOpie89kD9++Oy+YEWWfixFBIIpaMdIn1xvLjS1YWbeMznG2S7dA76Fy
         tGS7gRHLncue3NvXzE/V+jnc/qqXt1U9GZpS1e1hFM+lW+oimX00VppYSAQ4fi1FMKYc
         ixIKfPMeZ79zA426I/vb1xeDOe/jzpZMU6tFHw3rhS6dtmGJSoMDFwvSrMv/kwZSyDWQ
         ml4kcPwHaW8nnjBDFBmaAalPtuvhLxSL6+oUqzF6mGdgDJq5nQpJjIBm6Y7ZH9ZOIlvG
         FrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720525802; x=1721130602;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRGbhkDfzuBSO1BGfrLFHwF8BBPQc55G/CgkIUBsVh4=;
        b=U/TP4uPMYVZtTzcBJE/KBGpIOEzNWldEjRtZY01awaMXOlZMMaQApHuempBGdNABr9
         qFbvP2f2WSKWdJCDNncKauRwCRyXX+G7VxagMNQnjJ83olR00gDChetw5eZnxtHwj1YS
         CygUKDAx8ONmSNOS+5Mr5837YH3mt+uAbh4siPrzApknK9FPIzsfcmVh0pQjqy3UhFoA
         FrCpK/+2JnHLs8czH12+3NH12OZPMYmJqs4U56a5JRFAkzva04fqP3JN1AEp+FPg+1kU
         QQHX1LITC3mBQVtuxw0I21HZxfiraQdh15ZCkn1Pzls3gX0Zsq1JUcSJtRipgOO7f5mA
         IdsA==
X-Forwarded-Encrypted: i=1; AJvYcCUaue4704f+Mg+SpaPo6ifL0S9EOU5IBHE+K1dkjgdqc+V4RPGsMDnj0fQao/U7bR8/WavXzKeQ3/6p1voFD22R6JLoU/xWDxk=
X-Gm-Message-State: AOJu0YxEMxFyqqFfxGGtncOtXbtLpqLYc6vUBFPdBwV7u6bloA4VsbKk
	BYqokKirVE4VoiHwALq5mqQb6aWcEYdToqv5OrxtnKFAfqrYvl5s
X-Google-Smtp-Source: AGHT+IFbcw5Rbnlg5vNsawjDtxjUrTIEdZVU+0P3B3/uXitWW7pGl52jTKe3eD0Jktlg0ppOD+QWKg==
X-Received: by 2002:a17:903:2bcb:b0:1fb:24ea:fe29 with SMTP id d9443c01a7336-1fbb7fea2e0mr26955925ad.15.1720525802132;
        Tue, 09 Jul 2024 04:50:02 -0700 (PDT)
Received: from terra ([122.171.22.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab6d3bsm14372405ad.159.2024.07.09.04.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 04:50:01 -0700 (PDT)
From: Forty Five <mathewegeorge@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Bernie Huang
 <phhuang@realtek.com>, "kvalo@kernel.org" <kvalo@kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: RE: [REGRESSION] Freeze on resume from S3 (bisected)
In-Reply-To: <e9c35b3d72a34c8e8ac607590917681a@realtek.com>
References: <draft-87msmrdgkb.fsf@gmail.com> <87h6czdexm.fsf@gmail.com>
 <6673a2dc01a941f5900da7393d160005@realtek.com> <87o777tdbw.fsf@gmail.com>
 <e9c35b3d72a34c8e8ac607590917681a@realtek.com>
Date: Tue, 09 Jul 2024 17:19:52 +0530
Message-ID: <87o776g4yn.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> The commit date of culprit bcbefbd032d ("wifi: rtw89: add wait/completion for abort scan") is
>      CommitDate: Tue Jan 23 13:38:15 2024 +0200
>
> But, you want to apply to the top of 57f22c8dab6b whose date is 
>      CommitDate: Fri Jan 19 13:49:16 2024 -0800
> and doesn't contain commit bcbefbd032d, so no need to apply [1] at this point.

Ah, I get it. So, from here on, I'll be applying the patch only if this
command returns exit status 0:
git merge-base --is-ancestor bcbefbd032d <commit-to-test>

Bisection log so far:
git bisect start
# status: waiting for both good and bad commits
# bad: [5bbd9b249880dba032bffa002dd9cd12cd5af09c] Merge tag 'v6.10-p4' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect bad 5bbd9b249880dba032bffa002dd9cd12cd5af09c
# status: waiting for good commit(s), bad commit known
# good: [bcbefbd032df6bfe925e6afeca82eb9d2cc0cb23] wifi: rtw89: add wait/completion for abort scan
git bisect good bcbefbd032df6bfe925e6afeca82eb9d2cc0cb23
# bad: [480e035fc4c714fb5536e64ab9db04fedc89e910] Merge tag 'drm-next-2024-03-13' of https://gitlab.freedesktop.org/drm/kernel
git bisect bad 480e035fc4c714fb5536e64ab9db04fedc89e910
# good: [57f22c8dab6b266ae36b89b073a4a33dea71e762] Merge tag 'strlcpy-removal-v6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect good 57f22c8dab6b266ae36b89b073a4a33dea71e762
# good: [43a7548e28a6df12a6170421d9d016c576010baa] Merge tag 'for-6.9-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
git bisect good 43a7548e28a6df12a6170421d9d016c576010baa
# bad: [8c9c2f851b5a58195ed7ebd67d7c59683d1a02bc] Merge tag 'iommu-updates-v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
git bisect bad 8c9c2f851b5a58195ed7ebd67d7c59683d1a02bc

