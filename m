Return-Path: <linux-wireless+bounces-23226-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBB7ABF6BE
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 15:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72043AEB0F
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 13:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F3B158DAC;
	Wed, 21 May 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tt+mZQYf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D81415B115;
	Wed, 21 May 2025 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747835797; cv=none; b=FZT1nxgC0l7T4mbyVuOCvBV5OR+NDccn3Gly1WrGF66Q7Ip24zj/cN43vy/rFIJ3KFrU48GO0dzVm0M789x59GHrdeG8DyjP71n0VjDIwHmlUKLxF7PotZZ8sC5NjC4HzWaMTRxHPtH66fvMsL+Xdg8/ttI5rcq648rWsP49Ub8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747835797; c=relaxed/simple;
	bh=fhSK92qIz8poswhb2TZ+Ynud2jnbG9BvqmBT8U8vJwA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oLNH6/YOWea8LKJ1EP+p5IQKmp3CxeYzyTtVt396XxKa/U9tOZGqdANR2VU0DCOpB9gSWUxVV+DDNverbRxPTDr6WjAZjFDCOJF++oeb8Ywk7E+xXTPa+zOuZfFtfFzIh/UnU/ty3kmS2LsgwOiR4WmzVlCCi4Rln3tSt+IzKfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tt+mZQYf; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-329157c9f79so18151711fa.1;
        Wed, 21 May 2025 06:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747835794; x=1748440594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fhSK92qIz8poswhb2TZ+Ynud2jnbG9BvqmBT8U8vJwA=;
        b=Tt+mZQYfbr7LB81pciwMAq0U6Cg3sv/a9q5VmDN7dRsNno87KXKhiJSb98RWpR9o5B
         C84ke7Ed3bHsmhaeEQ4Bhb3I7iVq5NIIp0amlQAIvuQjIXj0SMRLZn1KTARdBWCLM0sA
         fVXoxQaoWG27K19Zby+uco7xO3Ypf8qnUi9DDK/CBKjMUclzg0v5pMMGsr5Xb4xIkdc4
         GJpuusw9xTEF9v43CIDOYNxjKAUuzu6qMPXNg8HbPVg7OR/Zadx8OUpHLA53LbbO4vmi
         JlEKJ7uiO9/x4Z68ZEHHVK/6qeltwDJkjvOD2N0K4I5YF4tvjIWU2a/CiO8t27rK66Dn
         t2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747835794; x=1748440594;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fhSK92qIz8poswhb2TZ+Ynud2jnbG9BvqmBT8U8vJwA=;
        b=il3b7ly+weTiRGJ9Mqs6kqyYPVjt2Eioj0gGcbCA4u93Sxlca8kizdgaa3b9Drr6HE
         HACKZKyb1KNdsf0wQpW6eW2o+br13qn6SjJ0VZU1yMHEH+snAdEQ7eUkX491mwGM0atJ
         MAVDNryVJABJYGgNQhyvoLgLO4ExcX3ebQw/bVpNhkRnEdkr11hD1HB4QkHraInDZ5vV
         cI+iKvrGWJ/1cqBD+u6R4r19hrNixjjzMdQVrFrjPmP+uAzZj3M88eVvc8Oz9/PwvGzy
         HqkwIIqcFyczn/ASHxivUc8E6L+yFfcPZqLNkGX2xcDjLnGTmuTPp/Tby0zeZ6JONXWz
         xbyA==
X-Forwarded-Encrypted: i=1; AJvYcCVi8B0Qmx/GJ8AxCHjDXkG0mB33lEpJ3NY23FRwwwFMA3v2ojoHGkqeol0iq4JF7RML7xGZQSHfDRumMqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOgeoeHcbVegYnvgtses7M5u06CnhDRK25rQgnHsWlNSm+S6WT
	PDjt7fGWnIVCEWgmWB/Z9CeuNAaVTZDogz9nI0ZnfWjTZ9apn+/ihRlOd3fXVcvAs7jxc2bsG1z
	20v8VhPBJqOfmI+m0fcCr0Fv92l+ltQuavISfqA==
X-Gm-Gg: ASbGnctKm1UBqPFP/dYnanvf8Oa1iLvl5czH/HkrLVQRPzfUGmGdtqgTAQffwQ60l+2
	F4eVrUGFgWd3YnAYtpftU2k0zFCVHwP2ud6K9AfoDuFu82Zfo6mtKrE9dxIKLcA3W/5w8gyFX+6
	zjp7EekDIlhrH3Mbd+ZMrft8xy2a1+94SuUb/+XWQ/j/LdR94me01hEg==
X-Google-Smtp-Source: AGHT+IHNRSlH2urQGoP4VnsmY05jJmYgV4LzyqX/JwSmcoPNv94uQpK/V2swcMjkUH8RXepH2B5eQEQXC4wrT1XUeAE=
X-Received: by 2002:a2e:a551:0:b0:30b:d562:c154 with SMTP id
 38308e7fff4ca-328077321a5mr78487191fa.19.1747835793761; Wed, 21 May 2025
 06:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John <john.cs.hey@gmail.com>
Date: Wed, 21 May 2025 21:56:20 +0800
X-Gm-Features: AX0GCFvtZwNaIYor0agv7Uq26ppQh02gdEar_RB_fD0JW4hJXX3Tl5N1vq9Bz_w
Message-ID: <CAP=Rh=NP-KjKhzfh21GKCCvDwDPfh37z8+b13btXVS5owUS4WQ@mail.gmail.com>
Subject: [Bug] "INFO: trying to register non-static key in cfg80211_dev_free"
 in Linux Kernel v6.14
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.14.

Git Commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557 (tag: v6.14)

Bug Location: 0010:cfg80211_dev_free+0x2ba/0x3b0 net/wireless/core.c:1197

Bug report: https://pastebin.com/1XeQBvgW

Complete log: https://pastebin.com/tcvP4fP4

Entire kernel config: https://pastebin.com/MRWGr3nv

Root Cause Analysis:
A WARN_ON is triggered in cfg80211_dev_free() due to a spinlock being
used before initialization or after free. Lockdep reports a non-static
key warning, indicating that the spinlock inside rdev->devlist_mtx is
either uninitialized or UAF.
The issue escalates to a second warning from __flush_work() when
trying to cancel and synchronize a work item that may still be pending
or undefined. This is reproducible via mac80211_hwsim netlink
interface when rapidly creating and destroying virtual radios.
This bug exposes synchronization issues and unsafe memory usage in
cfg80211's device free path and requires proper spinlock
initialization and work item handling before release.

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
John

