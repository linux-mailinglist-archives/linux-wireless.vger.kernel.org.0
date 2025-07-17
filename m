Return-Path: <linux-wireless+bounces-25623-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 150FDB09717
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 01:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F77188BDF5
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 23:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7CC23ED6A;
	Thu, 17 Jul 2025 23:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwEdpv4f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5102C1A2541;
	Thu, 17 Jul 2025 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794076; cv=none; b=dLWWXduzBVzv0K4eefq+4T6eXzOQa8diATT6SKJIU9W3o9NXZfyAz/F3Xu3AlhBq+8PANVYDuSZyE1AkNKUK8LL8ndvxJsrQeucDskBMwpK2D0IyBkBt4iu7kUDOXfIjrB62xo3qWyBMCFlv6x1q3PG2+jHTWJzwFE9CJgS/ckU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794076; c=relaxed/simple;
	bh=Boz1NnANL68jZFSj5utovY8CrOn3qt7bAPUypNpOzTM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=XgW5CT1FXNbZjhEVxkqOMKgl4lLZo2bwt2OtRn2XJP6mCHldirTScMFKHTmyvJVO89G7XlklSssWZh7XkN7Z1HpGejXhQCXZRNXtPrfslrh4A4mZ0agydVgT01jVsDs8uSt8YEPF3FZJQ6voebYT+ft8DJ+DTsccs8fg3sROWOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwEdpv4f; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so1702054b3a.1;
        Thu, 17 Jul 2025 16:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752794074; x=1753398874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Boz1NnANL68jZFSj5utovY8CrOn3qt7bAPUypNpOzTM=;
        b=jwEdpv4fSp/9RTt7mTPsy0pb1hOLwHI1khg8fn4VvrX/pGe2LmaR6zZrXVwMVQfFqd
         ZiN1vPn1OSm2PtOm75fAY5X7jVBTpTKYh7BKnpP2JPx3WR6B9OTxB6OjosFRoHkdhUGt
         6Iyj8y2OWTN0BQoOE/BD0jhl7DFyQ7g58BvFgnqDOGBv0rvavVe/H3Yi2NhjnwRdZFVH
         Yo/xqxHztYn3oYekVCTjiXE+stO4ahz5YmLuOTEwGOxh4z407yXR3yY8viRHLJBSBnlD
         M55do4ga/MGKT7wbZZwzbhbquMeyTQYUr1czmBBoYfpApt7hdvOuIiCNipNDVop8Cndk
         cMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752794074; x=1753398874;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Boz1NnANL68jZFSj5utovY8CrOn3qt7bAPUypNpOzTM=;
        b=ZWVrOrWFdff/ewEj3FMJ1+YXz7LmmGY5KUVf7z7aWxAMUOUinK9QlAECDFli+92wvq
         /Q7vY2ai6DJQsM57QcfBfnsgWwKMbaSnf+gG3fFXve8BfK9VBZEUS4OSGI0xc509mENz
         2tZorZjMNNRwk+eQ/qfwiaOseeW17cA0uW/5F09oTlZD24te0gk2G1xpXItwkwftdREq
         yYDW2vd5aysVzJf6KxIUGL72cBIrg/UtAZOob+M6Ng9BJfo4yJURihwlcmNn0B8R1Fw7
         NNAIwpnt7ppXpnW5pUl0mTPYCQSzu1uZqe7ebhf5liwoFnyESG9y4SAjqKaGzy2LTyT3
         XgNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC0uDrlBMVH2fUQ8D9J1BiPZN+7dqPhuqezIdOoEpl9VacVXxNljpB8rjMYh+3lq2ob0Ab6RHMLW7SlU7xGw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn4M5O3jEGeKu3aAQRMZlYHcofJ+Jvg0SOUhJvBDLiGJJVK4AQ
	GPef2dkhseOsTs3CQsU0ffxlvdVKVfJz3UwLD0QGfIh364QG4hOIRJKP
X-Gm-Gg: ASbGncuLM0K9vpyMAMDenZ4l/ZIlg2LbKDRckhRVL9QIz/AahaM04DCqJkI7QHRVJ+q
	3iGdDCbbBJFYxBNA12pJymkL+eD7mCUWlEi1H+ssCAwfDTlPkXCuz6oJRieJvhblFkTS/oQY/+U
	/6UUZuF2oo2EIWE0lmuXiQLKxZCXAnncKEKa+N/YeeBzzLntLjAVxClOAxEmShuoraH3tXpNipc
	ypdQiVu4CfV5dT8WIfzzIV2yV4vo5yQxeZmWkrtLkIMjCHA3GYu7aY5zLmZhlLF5Lm3MGIlNsSa
	3L1cqNEYvyz6xPC3UH46z5s4NzZfb3GXiAmv2owE2GZyk5l56vB7h2fa74GGi1FqziNb1z8uvA4
	jSJW4N1Hz4IenwQbEALGTItdn1+r2ffTy5lsBOaw=
X-Google-Smtp-Source: AGHT+IGqxUgt2M7kl0/VxWjAcj+d9qWEHTt2Cy17UaLhAJdy0zmaf5a76BKuMYJ7ItuMr/jiUnopIw==
X-Received: by 2002:a05:6a21:998b:b0:238:351a:f960 with SMTP id adf61e73a8af0-2390c84dd57mr8247735637.23.1752794074432;
        Thu, 17 Jul 2025 16:14:34 -0700 (PDT)
Received: from [127.0.0.1] ([116.206.223.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbc6c16esm81623b3a.149.2025.07.17.16.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 16:14:33 -0700 (PDT)
Date: Fri, 18 Jul 2025 04:44:23 +0530
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
To: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
CC: stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Bath10k=5D=5BQCA9377=5D_Firmware_crashes_on_Dell_I?=
 =?US-ASCII?Q?nspiron_5567_=28IRQ_=2316=2C_all_modern_distro_kernels=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <690B1DB2-C9DC-4FAD-8063-4CED659B1701@gmail.com>
References: <CAEmM+Qh=8tm55Ypa2w3ZtOFFrGXTpKqxue59mVAo_5TVy0RJ6g@mail.gmail.com> <CD81F065-CDDD-41F6-AECD-167B509F57C6@gmail.com> <2DC25FD4-0EA4-41CE-BA17-BFF84C1C5F7E@gmail.com> <690B1DB2-C9DC-4FAD-8063-4CED659B1701@gmail.com>
Message-ID: <D048183F-E342-4505-9891-8F35D09812FA@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Sending this on the initial email thread to the ath10k mailing list=2E

I have built the kernel using Bjorn's patch=2E The kernel is still tainted=
 but certain issues could be pinpointed (for example, ath10k_pci mishandlin=
g write32)=2E

Here it is:
https://gist=2Egithubusercontent=2Ecom/BandhanPramanik/ddb0cb23eca03ca2ea4=
3a1d832a16180/raw/07b34aa3fa19da5afa4bb161454e3cb2081b9880/journalctl%2520v=
6=2E16-rc4-PATCH1

It would be highly beneficial if the matter is looked into=2E

Bandhan

