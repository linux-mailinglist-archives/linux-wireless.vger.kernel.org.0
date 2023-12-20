Return-Path: <linux-wireless+bounces-1114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C666381A6A3
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 19:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02AE31C2376C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 18:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15159482C0;
	Wed, 20 Dec 2023 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAuIRe/S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E54C482C2
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cc7087c6c4so46596471fa.2
        for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 10:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703095412; x=1703700212; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+VFVpKA5l5WRhi6iFr6WgzjQ1BJaMwNlfF8FJIbQtqE=;
        b=FAuIRe/SqgnlXvWwB4lS5ldqVnfi4Q/2mgjis6hCjgAgwXLVPEYeABc9Eh3WVmzjGU
         5Ib1XK1emU0r2SjLx33hSzuY4p7nzqOHGJSOpEk3izBij8rvOvsOd07UlOn/0bY8LjkF
         NRopflKStlwBceTcoiMmVVlwvQ9SY5pKll5aPjxKtEeUNbWVGS6d8ppu1TsThxFxDpQu
         GgGBesfeZ8/VZHwEScpKVrBBX4ExuAXAA3IbEN156i+fsIJo97PDqrOp8GXTKLqahXT4
         NVaoLeXPS5G1jP85JT7SDoNR3wMOKL2d2cdiJxTG1hz1JTdczO1Fu+ebd2NsJX/C6Vef
         T2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703095412; x=1703700212;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+VFVpKA5l5WRhi6iFr6WgzjQ1BJaMwNlfF8FJIbQtqE=;
        b=MDO4ty5JaclFWEnERcDsWjPNpoMtDyzfFDL6ao02ZSNZL/+eufSAXBAYhgutj6C0mm
         e/Xoes8VdP6kSGy+8iPIuDaDK522iKoz4x3lHDvAOi9rrXtxquEP3XxpKDFZygEhLG6j
         OSZEnJmfUIDFqjsaSylqwHfSOt/rc14K8gTDTQ3PR1kV/baejNAZ1EDFAwAbEIPACbgD
         gWOPdyeVO4+6PCUuTuAEQ1kItxlydb1kBYD6qxlbd7873gZ65Ln9iI1t10Ra4ew4TJFa
         6kU4OHCDcYt62bmfx8vT3Q13oE9YBs8jE2g8kMtYR3L9sc7TgTVVLQbSIKZBrF4lRu3t
         m9ig==
X-Gm-Message-State: AOJu0YyTa/5GwL/BJ8jNrBF2GJ3fH877GfXHQHc8ltIFINgHnPkBtsPL
	bKeFofR/mrtnfSRZUYKtyBN2vpBX2R1G9ImsmhPxtCYcKuA=
X-Google-Smtp-Source: AGHT+IGf2KVyYXYYhDiimbCAsZhksPmpSYd14gbx1h9ho8gM2tc9K24ygaaMyY+DjcZ9TCIaZnhvhyGKcJDBgGSTqPs=
X-Received: by 2002:a05:651c:514:b0:2cc:1def:18aa with SMTP id
 o20-20020a05651c051400b002cc1def18aamr9537934ljp.96.1703095412225; Wed, 20
 Dec 2023 10:03:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFwS=wUORO=qs=RvVEEyMLspxcHxUDy+1aVXKPnwtHaggZ7D=A@mail.gmail.com>
In-Reply-To: <CAFwS=wUORO=qs=RvVEEyMLspxcHxUDy+1aVXKPnwtHaggZ7D=A@mail.gmail.com>
From: Fernando Piacente <nandopiacente@gmail.com>
Date: Wed, 20 Dec 2023 15:03:21 -0300
Message-ID: <CAFwS=wUiJXgh6uG-5h+Je5Ks83+khB_p9Zi3GrqpcJqPLjQu0A@mail.gmail.com>
Subject: Cypress Wifi collaboration request
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Based on Eric Curtin post on linkedin, I want to manifest my interest
in collaborating with Cypress Wifi.

I'm an embedded software developer and aspiring kernel developer, so
I'm looking for open source projects to collaborate with.

It would be a big pleasure to help with any kind of code-related
tasks, being a maintainer or just a developer.

Right now I'm working full time but I choose my schedules, so I can
invest a good amount of time and energy in this.

My experience with Linux is vast, but I have two years focusing on
kernel development (courses, experiments and some minor job tasks).

Let me know if and how I can help.

Ps.: I'm open to another project's recommendation as well.

Cheers,
Fernando P. Nazario

