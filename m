Return-Path: <linux-wireless+bounces-11729-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D73095975B
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 11:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6471F21012
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 09:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A37015C139;
	Wed, 21 Aug 2024 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rs8Pmv5Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F6E1CDFB3;
	Wed, 21 Aug 2024 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228750; cv=none; b=LwozO8TyVj1vvb4fTfK2ZETEojKfE57L3+MFgdDyn7Fwh7Rddrzho8eHBLvVu9ivoDXZfnJSHQQ76gIRHeGekDXoSy1WE07pxRuSkYLYLQSgtgKVh0q3UDUIW2QBqOMx5FlUu/0iQrVBq3U9XzL1944vZD8xlZx4CPBmAO8ey6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228750; c=relaxed/simple;
	bh=EdzeupSGGvl1TZEs83iqfDc4cvZFxHBoh8FJ0Eh1G8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7CdjZ7YUEOt+qVSS9tPuaje8mS3lg2mQCXmqejM0MRFBdMF+FG19BFWIDyB3WqyXKbAnHHHhULMZ53lUo8mUn8lvcO1y1nbQGX+5RMZaw7B2gWW8RQC/31w5J/k2rrIsR+k3rQkwNsN68i/eug8hVZVmBc5qpQjtpONMTJWFRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rs8Pmv5Z; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-81f96eaa02aso347970939f.2;
        Wed, 21 Aug 2024 01:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724228748; x=1724833548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtDQjm8iV4cdUO+HD94R4GQWnETA3Pr7CL8RG8TNuww=;
        b=Rs8Pmv5ZBd/m3E9MjSiZ0w+iix2i1fFTIsNAJ0nPBbPJIjAGDqBM7yJnIzsk3StPsy
         5H7D5laxFNDP9sZFq998T7/ewMc2bOjWzMUywH12/kJhbXUPm48yCo1bBupWdDTI1Gvc
         4M3ZijYaFdi1wbpmdxqUSiJiGukcs//J4Uk8SuPrOdZjA+yVJdhMG8I4mAJSfW327i9m
         EPD5Npee3OzkRmuHvtB4dBa3FuqCdpu3IJ+V+74mvYjwkqo1t0vrfm2XAEpI5BhFIGS6
         0whZz6rBKWs7By8VHCZkaMDAl5WqjQwkRP87/BUSSoRqkI+EuM3TpaZaZeyNtFBqtMDe
         lU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228748; x=1724833548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtDQjm8iV4cdUO+HD94R4GQWnETA3Pr7CL8RG8TNuww=;
        b=k0S4OUevo1ABLFVbckLUl+Kzu5oE/TScTdo3R9KJz2nWzpKMVYVxygWoZDse+/GTC2
         BxiJusVCCgwIjX2oXUF6yDetXBy/zXNN313Ef1I+95a1xN7DUgSHAmFj7sDLrf4LATaj
         DmCZtzalWbvBD9T7xAAlMwaa3WeyTVISvr5KNdm/3IRX4orh5WgcYssXPgymWHGeEqtH
         mCy2hFG0smoJF0q2azbD+M8fRHEBGqU4OjzzK231XpP63XNP/SrMhyiTyguiJybc9chw
         XYHWUoxldvqgeQba8Co1xFLqKH/Y6HcTxHhWbgxw1v5OEr5aTpOFgyeX1ZDaVT2NkOf0
         rLXw==
X-Forwarded-Encrypted: i=1; AJvYcCUPnJi4mPQtdIitTnCuc//7WKmn+SWdxyZaOFLwIxbiNno8uxHK/ZZvwyY9fHc4RToT165/6XLUgfbFXTI=@vger.kernel.org, AJvYcCW3YASVtJh4BnNMgYxOxZPxgtgg7p+1leZl8D+ujxlgZ0ImlfiCAgZ5WewxTEMNSMadpoEQR3jrJlqfk2CM/zA=@vger.kernel.org, AJvYcCXgDqk9kt4xJOhWW4vJ0unuep91Fd8zJynibqWT75ZfYWp0jLUTU535DCWCMZKHIdB6p6SNnbxDkhzt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzge4nBl01Ar8nYLjHJ3ll+7TUgVwImUF58sofeLQY59qJQwEBy
	5HQDOLr9HKXXXyXs/pevkcH8R2PwVeC92oOtKeG6Iga9RANqEowcXhhorkaTSGeAv4Byx7ou2/Y
	72I+/MN7663wBUpKpIga1gbMUoA==
X-Google-Smtp-Source: AGHT+IFZ7B3clZToa0llT69FQPt3YfkKJq6le9aPzsukagic2r195jKWwzuhWEAszXEMwA2BFpru2eSaWeSwWE/qbaA=
X-Received: by 2002:a05:6602:14d5:b0:81f:9df7:40d with SMTP id
 ca18e2360f4ac-82531a2bb22mr166091439f.17.1724228747366; Wed, 21 Aug 2024
 01:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024080359-getaway-concave-623e@gregkh> <20240814055816.2786467-1-wirelessdonghack@gmail.com>
 <91e19cf3-216b-48ac-a93d-f920dd2a7668@rowland.harvard.edu>
 <CAOV16XEsgkLWz3rOQsAdve-qKsPEDw-QxJNoo4hJfXdLnowHfw@mail.gmail.com>
 <2024081946-designate-dioxide-c59d@gregkh> <CAOV16XFYeWdT4tSpLWoE+pCVsNERXKJQCJvJovrfsgMn1PMzbA@mail.gmail.com>
 <2024081904-encircle-crayon-8d16@gregkh>
In-Reply-To: <2024081904-encircle-crayon-8d16@gregkh>
From: color Ice <wirelessdonghack@gmail.com>
Date: Wed, 21 Aug 2024 16:25:36 +0800
Message-ID: <CAOV16XEjJT6Oe7PX7HjqEaT5tpX0MqTOZy6=akEKFhtk0emOzg@mail.gmail.com>
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer
 Dereference&Use-After-Free Vulnerability
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, kvalo@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, mark.esler@canonical.com, stf_xl@wp.pl, 
	tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Ubuntu Team,

We have analyzed the issue, but due to our limited time and ability to
create a fix, we are unable to submit a patch directly. However, we
can provide some ideas to assist you in generating a fix that we can
then test.

I have encountered a race condition issue in the RT2X00 driver,
specifically related to the function rt2x00usb_work_rxdone. The issue
manifests as a kernel NULL pointer dereference, which causes the
system to crash. Below is the detailed analysis and my suggestions for
addressing the issue.

Problem Analysis

The kernel panic log indicates that the crash occurs due to a NULL
pointer dereference at the following location:

[ 371.258315] BUG: kernel NULL pointer dereference, address: 00000000000000=
38
[ 371.258339] CPU: 8 PID: 144 Comm: kworker/u40:2 Not tainted
6.8.0-40-generic #40~22.04.2-Ubuntu
[ 371.258346] Workqueue: phy23 rt2x00usb_work_rxdone [rt2x00usb]

The root cause appears to be a race condition where multiple threads
may simultaneously access and modify shared resources without proper
synchronization. Specifically, it seems that the pointer being
accessed in rt2x00usb_work_rxdone is not consistently initialized
before being used, leading to the NULL pointer dereference.

Suggestions for Fix

Introduce Locking Mechanisms: To prevent concurrent access to shared
resources, I recommend introducing locking mechanisms such as spinlock
or mutex. This would ensure that only one thread can access the
critical section at a time, thereby avoiding race conditions.

Pointer Validity Check: Before dereferencing any pointer, it's
essential to check whether the pointer is valid (i.e., not NULL). If
the pointer is invalid, the function should safely return without
proceeding further.

Retry and Delay Mechanism: If a critical resource is not yet
initialized or is in an unexpected state, implementing a retry
mechanism with delays could help avoid crashes. Additionally, more
debug information should be logged in case of failure to assist in
diagnosing the issue.

Code Review: A comprehensive code review focusing on areas where
hardware resources and multithreading operations intersect could
reveal other potential race conditions. Identifying and addressing
these issues proactively would enhance the driver=E2=80=99s robustness.

Example Code Snippet

While I cannot provide a complete patch, here is an example of how the
suggested changes could be implemented:


void rt2x00usb_work_rxdone(struct work_struct *work)
{
    struct rt2x00_dev *rt2x00dev =3D container_of(work, struct
rt2x00_dev, rxdone_work);
    unsigned long flags;
    void *data;

    // Lock to protect shared resources
    spin_lock_irqsave(&rt2x00dev->irq_lock, flags);

    data =3D rt2x00usb_get_rx_data(rt2x00dev);
    if (!data) {
        // Unlock and return if data is not valid
        spin_unlock_irqrestore(&rt2x00dev->irq_lock, flags);
        return;
    }

    // Process the data
    ...

    // Unlock after processing
    spin_unlock_irqrestore(&rt2x00dev->irq_lock, flags);
}


This snippet shows how to introduce a spinlock to protect shared
resources and ensure that the pointer is valid before dereferencing
it.

Conclusion

In conclusion, the race condition in the RT2X00 driver is likely
caused by insufficient synchronization between threads. By adding
proper locking mechanisms, pointer validity checks, and retry
mechanisms, this issue can be mitigated. I hope these suggestions will
assist in resolving the problem. If you require further assistance or
additional information

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2024=E5=B9=B48=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=BA=8C 01:43=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Aug 19, 2024 at 11:11:10PM +0800, color Ice wrote:
> > On some TP-Link routers or routers running OpenWrt, as well as Raspberr=
y Pi
> > devices with a headless setup and BeagleBone boards, certain USB
> > configurations are required by default. These devices typically grant
> > higher permissions to USB by default. Therefore, on certain devices, I =
can
> > run a PoC without using sudo. This explains why there are some inherent
> > risk scenarios when declaring this vulnerability, as there are many Lin=
ux
> > distributions applied to different embedded devices.
>
> I suggest filing bugs with those distros/system images so that they
> properly remove the ability for users to reset any random USB device
> this way.  If any user can disconnect any driver from any device, that's
> not a good system...
>
> Also, why not dig into the code and try to come up with a fix while
> waiting?  The code is all there for everyone to read and resolve, that
> way you get the proper credit for fixing the issue as well.
>
> thanks,
>
> greg k-h

