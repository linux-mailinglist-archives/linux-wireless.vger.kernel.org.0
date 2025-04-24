Return-Path: <linux-wireless+bounces-21975-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DD9A9ACE0
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 14:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CC1444950
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4666F2147EA;
	Thu, 24 Apr 2025 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b="fqWNKHlv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AD8214226
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496559; cv=none; b=iFPg5My8EyeSyQp81Ztqk7kofcX7vGXPiGkUgkY8FL8JF3IuVpPESZLTqH8fod2QYs+lZhsGSU3LD08pZvXCDLZDBMMmePTCJVJCKZbnobTWO0YZXbxk+ir8GxGq3IZBYlCDIy939P9bsnqXHpFzvPjAyTAF+UotlFTpTFsARLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496559; c=relaxed/simple;
	bh=kmro36Ab3gY28OhMm061P4TSKfA2oLpaOhz3oaWa1TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkCV4fqx7NsS/GBb0NFuIRxF/7+R9beDao0rfkQbXKpIesnqDyL9FgLqACgP1QYMfNfffItEgRQ1TOWdILowfJhKivWw/PKzTf7Zkzo2gzAutoKOiucdfSOcCYPYviwduT6K/WtZVjit0IqzqccFEl9HMRYqqsc8PC1LavQhbrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech; spf=pass smtp.mailfrom=moment.tech; dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b=fqWNKHlv; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moment.tech
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-523ee30e0d4so453974e0c.2
        for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 05:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=moment-tech.20230601.gappssmtp.com; s=20230601; t=1745496554; x=1746101354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Swkd1V9YcZF9JY4hyQxqrJMc9ulfvfPLwOf+MCgiHPQ=;
        b=fqWNKHlv6EKyjlk+80iDkwTiexzygEJp8RDPFXKqkIZO07Yoign/fwl06qLtsmZNoF
         cgZsZxZ+a7BA3WiC7YpejFXmWAWfMizHR+bm2YqTACN3w6Bb35YI88WCDiXyL0bpCQvu
         5wXvB9w2QIQCJ+umREcV1dmQES1hOd5Fm/vZeHV+C1HeGFmMov2Y9Mbq7B/9j+GI0BiZ
         1TF+8S1VU4BLur6Pv1PdT23o8FxkixEyunHuXymMMiVbb/MldYy/Sopr7ZgZYgtMLu32
         o8kc8Yt6HS4teyDAAO+/XzTwMHTyFWoXGPNL1fB9xDl6J9eV1MPE6YW7+bsEcT2luIV+
         zcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745496554; x=1746101354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Swkd1V9YcZF9JY4hyQxqrJMc9ulfvfPLwOf+MCgiHPQ=;
        b=C7UcUgysyLLcgCwhUUzVNbdbSQ9F4bec3yjX9bBHs75tAVp3HKcim87XRG+t8SNOcZ
         dG2KIYbYm6q5q9xPMQftW9fKr0QY0TETnw0i4kUclpaNyxFEaBGiufLk/1y8sTMpY2uS
         Oksa8BDIfiQiL8avvRtCJhUMocH+E4pFrnVTvAo6FVtpQ5M31Y8fYKrgX9k7bztZ4G9H
         T/8bRsJqhSX6VZgaIkxXOtgrdmVs4VCRFzz1og4kpBjR+D6bEHZXh8wJ7wXklj7iSHrS
         mhTZ/jfvO1QZQI2usGJEhCu5KLDmhOtzSSjDklZQ2i7JLbNj6f4fS4fdaDWP2HjfeZMd
         XAgA==
X-Forwarded-Encrypted: i=1; AJvYcCUvW9VDNbAfbg/mX5450CurhFTvP2nC8OvIkR8FHlousEYxsSzXQtcdKgeijNPnpjiBxL8FaRAoPxOGvw793w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAeMCjUkpxPt8ky4UAxRAmVDvtDtndV1SAG1rG1DDyCiXKdcZS
	jCkhfBt/NDE91YE0AWsdJlPxRwSlPQEUuneD3SrvTMjLyNOYYfuEOdTMlmOBO7hGedNVy/jwlNI
	MCCUEkoQ/biPOhSGFAEWpTD0p9JxhHzMXlNugXA==
X-Gm-Gg: ASbGncvsGb2TT/k5ZYp6tif2hYCZfIL+p5ELgkfC42KCP9k2Q/ttSV4LxaWl7VNiQPY
	O6pYm3gauEJmZ2WAE36k4sHH49sVNyrG1fg/BaFeR1xUR+mSq1BW2JPJM1976MfgscoICIrb7lB
	LQsKYobXjyH94Ax7KmjtP2Nzfud7rpOwpauJ4=
X-Google-Smtp-Source: AGHT+IHifdylEqptJ6hqGxBPWf2e2v10ROUSH+e06NnxStnIN+d+0cmOUDiU+X6v95z2bz1h59GMiaV+ClbRa4Hn45A=
X-Received: by 2002:a05:6122:8c05:b0:529:2644:8c with SMTP id
 71dfb90a1353d-52a783ad5afmr1150131e0c.8.1745496554647; Thu, 24 Apr 2025
 05:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416100939.282481-1-balsam.chihi@moment.tech>
 <0e129e2a-67fc-48cc-9773-efbea3f7391d@quicinc.com> <fa16bad6-305f-77c1-3f56-703564e2dfee@quicinc.com>
 <CAONkfw6m9O_6FZHBrPYdpv+=AxSgsbh1T7+GaS+U+bnjyVVJvQ@mail.gmail.com>
 <3da5d47b-993c-405e-841f-1d16d8715610@quicinc.com> <1d0682c0-ee5d-f2d4-199d-4ebc4e71f9ef@quicinc.com>
 <3660fcfb-be29-422b-a352-3996ad3fc41f@quicinc.com>
In-Reply-To: <3660fcfb-be29-422b-a352-3996ad3fc41f@quicinc.com>
From: Balsam Chihi <balsam.chihi@moment.tech>
Date: Thu, 24 Apr 2025 14:08:39 +0200
X-Gm-Features: ATxdqUFy55GafIlTO6kRVpUbia3dHpuYOp-VHwdtaMZ5mzTJnRSp5Lo9WUSUEok
Message-ID: <CAONkfw5-bfYRwHZ9iHhgJP2f8Zqyz5SZVbdL4n9EPhKU+=ONPg@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath11k: pci: Fix msi_irq crash on driver unload
 with QCN9074 PCIe WiFi 6 modules
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>, jjohnson@kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes I of course I can help, i'm trying to reproduce the bug, by
rebuilding a clean distro without the patch.
and i will enable the debug_mask=3D0x1020 at boot via u-boot to kernel argu=
ments.
please let me know if is there anything else you would like to test.
just FYI, i'm using the official openwrt-v24.10.1 (with kernel 6.6.86
and mac80211 backported from kernel 6.12.6) on a Layerscape LS1088A.


On Thu, Apr 24, 2025 at 12:45=E2=80=AFPM Baochen Qiang <quic_bqiang@quicinc=
.com> wrote:
>
>
>
> On 4/24/2025 6:36 PM, Vasanthakumar Thiagarajan wrote:
> >
> >
> > On 4/24/2025 3:19 PM, Baochen Qiang wrote:
> >>
> >>
> >> On 4/24/2025 5:25 PM, Balsam Chihi wrote:
> >>> Hello,
> >>>
> >>> @Baochen Qiang,
> >>> Thank you for your feedback.
> >>> I tested unloading and reloading the driver and it is enumerated,
> >>> detected and operating correctly.
> >>
> >> Different hardware platforms may have different behaviors ...
> >>
> >>> And I understand your concern about other chips, and certainly it is
> >>> not the best way to implement such a fix.
> >>> I will continue debugging to determine the root cause of the
> >>> synchronous external abort.
> >>> So this patch is now just a workaround to fix the kernel crash when
> >>> rmmod the driver and reboot the system,
> >>> that i wanted to share with you to attract your attention to the
> >>> problem, and seek for help.
> >>>
> >>> @Vasanthakumar Thiagarajan,
> >>> Thank you too for your feedback.
> >>> Yes, I understand.
> >>> I will enable the debug_mask and check the logs, like you said.
> >>>
> >>> I'm wondering if anyone else has the same problem with ath11k_pci.a
> >>
> >> There is another issue report with the soc_global_reset register, alth=
ough it is reported
> >> on another hardware.
> >>
> >> Vasanth, could you check if the register address is correctly defined =
for QCN9074?
> >>
> >> #define PCIE_SOC_GLOBAL_RESET            0x3008
> >
> > That offset for global_reset is correct.
>
> Okay, then it should not be global_reset causing this.
>
> Balsam, could you help debug further to check which specific register acc=
ess is causing
> this issue? We can then check if the register is defined correctly or not=
.
>


--=20


Balsam CHIHI

Embedded Systems Engineer

06 42 90 57 24
3 Boulevard Richard Lenoir - 75011 Paris
Maximize profits with our latest guide to ancillary revenue strategies =F0=
=9F=93=8A

