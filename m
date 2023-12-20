Return-Path: <linux-wireless+bounces-1103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBE281A425
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 17:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0553E1F21405
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 16:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E334BA96;
	Wed, 20 Dec 2023 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bnj7gtbZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F41749F7F
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1f055438492so4201089fac.3
        for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 08:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703088709; x=1703693509; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hdqHK3WS3HA02q2kdpUCbq6TQNt+Fw1P3vW/26UvhZ0=;
        b=Bnj7gtbZeupu1opdrc/ymN5lZNROrdO9atEsd7CXYRc6VgI4e5vP1vJb0hf8yOWRfM
         yxsrQjcPLSg7cvNGmXjCgTGyOia45t0NqnywdcBJY31ecpH7C0oyRGmlnsMjveFeIibI
         T38zE7Z2YLvikyKi6g+rtZR+MKCQpDngjneOJjaEv9wWmUtHqKh7pO3JtZx3aClk4VFO
         yyoRbziecRdu5Ht1jvqXZauigWYT4fjPHQjTTDVq40EEO15IzJP/CU557+08qhD6Ct2A
         lnOXZLXZVuTtbOgvOk/UJ0wKvwwQPzZ3aP5+TBGlll74l5UGhrTkDWE84OSHgT4tbF0t
         Wl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088709; x=1703693509;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hdqHK3WS3HA02q2kdpUCbq6TQNt+Fw1P3vW/26UvhZ0=;
        b=VnfFI2Co76UIxES4OYFvxaUs7HWIB3rIkE17/1S/cUDHeteGD8Hhf6Sf3uDp0xdht2
         XrP6Mtn20e+ZLZymYl06CuB+x9+WVAa0BtsEByxN/bReqUKSI3rQYFXu6b5fysBlOVMd
         awoaQP5zOm4S9X5JQxghF8+2vrgwQDXbuvP8+IINvCVYUp+a0Chj0+drzfPpRddZSCiT
         NIfcuHh77pE7h3wUzTws+2hBySpYovdwRdazgswzKPAzav7fJhwJg3tAFL4fkxOPqjwO
         FQbMal5gQAJ3Vt3mN2rJzYcnmW2Qtj6pLhtdF4EvTHh24V6IfY9zonZVKasB6RHykJQG
         2+MQ==
X-Gm-Message-State: AOJu0YxwsSKc95sqjeY0+F6ik+eBeLV82P9jA/H+ynJKibHLuvOGNTPB
	+6WPT9pPnR7PH3IfC2d8Qxksnr4XCdYCf4uFhhX6jgVvLH0=
X-Google-Smtp-Source: AGHT+IEqDsTD6ILErhzM+7LkZawNhqj0kVfSYwzlktRxGxGLWcX875ru95DvUU+xDXzUGx4g8Ff3tXhFakaw1b7T3oc=
X-Received: by 2002:a05:6870:55cb:b0:204:1d93:f83d with SMTP id
 qk11-20020a05687055cb00b002041d93f83dmr388021oac.111.1703088709113; Wed, 20
 Dec 2023 08:11:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sreekanth <chvsreekanth@gmail.com>
Date: Wed, 20 Dec 2023 21:41:37 +0530
Message-ID: <CALpXwdLv_wqZKCwtoLGiUadLpf1xcD2x_bZ1OnQzXoeasiTANw@mail.gmail.com>
Subject: Subscribe linux-wireless
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Team,

I am working in Analog Devices as a senior engineer. I have working
experience in Linux Kernel and Drivers. As I am new to Wireless driver
development, initially would like to start contributing to Tetsing and
then will start contributing to Coding and Reviews. At first glimpse
of the patch seems difficult to connect the dots, but as I go through
the driver code flow and functionality, I'll be in a position to
contribute better.

Thanks and Regards,
Sreekanth

