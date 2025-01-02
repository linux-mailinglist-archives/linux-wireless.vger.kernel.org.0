Return-Path: <linux-wireless+bounces-16976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 651179FF58B
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 03:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2473A27EC
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 02:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B808F66;
	Thu,  2 Jan 2025 02:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="eU7nBqv5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34DC8F5B
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 02:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735784062; cv=none; b=tPg9ijwbZle0KgKVQ3wDo44xaqWWqOGxRTngiUw5sMAyeKayWp7qrK782D8Ke+Dx/yoxs4HGFmrrGU0D8eNpTxxqCNatzU0pA7ZnaWsgEWz3BznPmvyHGQmy/+NnRrp66Q1S51a7V7DsP8iq0+O2VsRxgt509x45S5YGQ7z8x8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735784062; c=relaxed/simple;
	bh=belqC9vT4lmBDldSbZmajs48Hbxtnt+SKAFHzm9I04Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaXwItzvfRRnvoASc3laSmb/rpOcn6YKmiXw1VhLPdyoGgm2sZy4rjw0aMtNJhGQtJdWhNx7LAIYB9aKZc75GT6dYjuYf74upqhvhQxwacr/mF/dGHDUYlfqjWBNJkmdz1z/a8PFWiCuSjIyw0bzGD2EpDXx9vHGtYxE9tZpA8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=eU7nBqv5; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2AF813F735
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 02:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1735784050;
	bh=byHhbG91T5UG9+5Qg0wGiCDOInz3RlJuX9hGg0L+ObY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=eU7nBqv5n0YMpW5HapQHrcHM4EN8/gX4nEDEaKF0ueDxnzqv8FXVVtoRU1oI6g5QX
	 M3qmxBII3Do8Di09+tHTqc/X4z+tOucVkM2vtI6E3k1WzVHMzn43Vk9aBc9J7CLQ3I
	 wFsepJgJyftIUH/2+6WAy5afE+nT/jG0+zeAvRU0zIzbxOc6lSbdKSE4pqd8vd0QTz
	 r0s88wmJdsh1czeTyxhyfudBQinPRnAoCVRm3+0gK1uNFVlTHCqFBroIPHQl4s6mQf
	 UUEkpMP7wuk869ENLDFQuDuLCwlmBaGHieew5jFDv11J517tZwKmWuCqgEM3Jb/oCF
	 SGb6xXmV4vU+w==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21631cbf87dso131228785ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jan 2025 18:14:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735784047; x=1736388847;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=byHhbG91T5UG9+5Qg0wGiCDOInz3RlJuX9hGg0L+ObY=;
        b=HnB5zPcDmL2A+NsQwO8l5pKgRwaUMMrwTzBttJwE732A4EwiGyyemlE+1UzJx4tSfo
         V1dWx2YvvIMGMJw9eMpfpuxk74Y4R4VUNOabgnZREpkMVNc3b10hRnX71uBwGWdRWnwr
         G6gtnKrChQHYXHctxcO9cSDyBMOEqtz5wZFi+iiRYz3++pZi/8MLhinfq/OViaOMCrwe
         VE5SZlMt3fxWrRJvR7GfbJkE7jC1a/Vfm9l8Z6ySyBjlf7l1oYPtDHM/Vue3IVvIS249
         4MqRsz1pcMo1Z1v/R2Sssdr93B/ocN0aLKoDAUT9Df9ER996opgNCW6BnKSzLsKJiIXO
         Gtvg==
X-Gm-Message-State: AOJu0YxNPvaAvIvAUrCVN8HfWSAr0kmB6Qn8Gs49Y2QRTXRrC25HiX3K
	tjtzRW3OAJNeh/yVPX47ffyw2imn1Lcf5VH0qLEu66emGnqzcq/76Qeheqi6FGM+ta7hJEmgnoS
	eFJn04kbEQDAd7AE1gCV6Hy2TpZPSt205deYcDULbd54UFycEoDWduVy1fD7wXknlX9Mb8vWuHO
	nyfofa2u2r3CNmbUY=
X-Gm-Gg: ASbGncvPFVcWsf3oyc0Fs+Ls3/Vk6M8xdQdegjZ7Oo1i1x0ztvZGbfQaUYI52ZGudAG
	+5vSepMGW/qBquP/7Bkei3hEmvXNu2CoGhqp3YDiIfcfGdU80FQnJy4rK93cdy4FfZrKRpfJs0N
	Hvra9ALJKCzdNysf07JeBl0T0aMPvmMnVDbhx6hLQbyerr3WZuM5JHiM7AApFWUHnq0SFcT93Oi
	9I9gaGL7IELQfBqv/fUlD/fokz+mspNzu8PDG/iSlRB6Dj6tOc6e9PZa5C7235XaH7KyMmCHAMu
	Rjg8rZytrb+hMmQjM8kqV/up/ELkVpgVkXk=
X-Received: by 2002:a05:6a20:12cc:b0:1d9:2705:699e with SMTP id adf61e73a8af0-1e5e044ea31mr68543646637.7.1735784047517;
        Wed, 01 Jan 2025 18:14:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCasflXXvF7DdbfLS1AiJ9zPSN1Nb3vRxEXeGsqgnA75uSp2VkKiRrjbQG4+kzG9N/QUZ7Lg==
X-Received: by 2002:a05:6a20:12cc:b0:1d9:2705:699e with SMTP id adf61e73a8af0-1e5e044ea31mr68543632637.7.1735784047187;
        Wed, 01 Jan 2025 18:14:07 -0800 (PST)
Received: from acelan-precision5470 (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842e4db5fb6sm17712340a12.85.2025.01.01.18.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 18:14:06 -0800 (PST)
Date: Thu, 2 Jan 2025 10:14:03 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Mark Baily <mark16829@gmail.com>
Cc: linux-wireless@vger.kernel.org
Subject: Re: MediaTek MT7922 or similar
Message-ID: <jp4v6tcegezbagnr733wh3c6ljlqddljoncc2vp6rppe527ypw@7d3rm66e44es>
Mail-Followup-To: Mark Baily <mark16829@gmail.com>, 
	linux-wireless@vger.kernel.org
References: <CACZGwE92CovpNv5qGefCKeffk+Y0zgqrhgq-pqOmQ8eDmXzA4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACZGwE92CovpNv5qGefCKeffk+Y0zgqrhgq-pqOmQ8eDmXzA4w@mail.gmail.com>

On Wed, Jan 01, 2025 at 08:47:23AM +1100, Mark Baily wrote:
> Hi,
> I have a Lenovo E14 AMD laptop with Ryzen 5625U processor and Mediatek
> wifi / bluetooth adapter. The kernel module it uses is mt7921e.
> 
> Starting with the 6.11 and including the 6.12  Linux kernel, the
> laptop won't resume from suspend with the bluetooth turned on. If I
> turn bluetooth off, then the laptop resumes OK.
> 
> I have read a handful of other people's online posts with the same problem.
> I am using the Debian Trixie 6.12 kernel but have tested with 6.11 and
> 6.12 on Debian bookworm - same issue.
> I am using a fairly recent linux firmware package downloaded from
> kernel.org (like from Dec 2024).
> 
> Just wondering when or if this is likely to be fixed as testing
> upgrading from Debian bookworm (which works fine with the stock 6.1.0
> kernel) to Debian Trixie results in this issue occurring.
> 
> Here is a snippet from my laptop's journalctl which seems relevant:
> 
> Dec 31 20:45:38 debian kernel: mt7921e 0000:02:00.0: Message 00020007
> (seq 5) timeout
> Dec 31 20:45:38 debian kernel: mt7921e 0000:02:00.0: PM:
> dpm_run_callback(): pci_pm_resume returns -110
> Dec 31 20:45:38 debian kernel: mt7921e 0000:02:00.0: PM: failed to
> resume async: error -110
The issue looks pretty similar to this, and has been fixed by 6.13-rc1
https://bugs.launchpad.net/bugs/2092746

You may try reproduce the issue by the latest mainline kernel.
https://people.canonical.com/~acelan/bugs/mainline/
> 
> Thanks
> Mark
> 

