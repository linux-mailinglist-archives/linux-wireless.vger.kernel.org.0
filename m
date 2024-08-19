Return-Path: <linux-wireless+bounces-11614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B319568BF
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 12:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3947C1C21A2C
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 10:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A32415DBC6;
	Mon, 19 Aug 2024 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0Pf+vdd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E92161911;
	Mon, 19 Aug 2024 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724064596; cv=none; b=LrN+vUCTk3krCoaT6ydS7btT6LsqlBa2UDyHR2ns1CIY9ndNe088Fnyx7+PDMGZ++b2Tb1W6JJ7akbJUmLd7H4RjJ9lyyqi2x+KbYnoHO5CjDaE9OZzeWh4aeiXLMuSIGTaAcxdcJ7ONEd5V4M2c4xixr0mKDU0Gbb8vuzmVUco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724064596; c=relaxed/simple;
	bh=ejSnJSpZeJIHl/Wxrcnk77OEbJf52ZUES1NcfmT3oCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXg4aWaTOAmgvaErJbesdoiVMpb4OgfVlEfc+mePCUBsOO8jgPDOrOlus/z9elF2b/ZAX96Vimq3WVmtL7uoh+7p15S/XVWWwqClY6Rpri2qhmXJS0Q3qLws9lD9JLYesd6TmnGuIWvNaxsWBt3Uxw6ymR9BIynWEAy0n8Ig/ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0Pf+vdd; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8251e23eaebso6802139f.3;
        Mon, 19 Aug 2024 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724064594; x=1724669394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6r5TjXljmBlpCGH6gaZQoVB7sULh0ZU8/sd0GXa27M=;
        b=J0Pf+vdd1cylNYIDOWKu2E8f3B3TTamfSk6iDLTvmT27b/Ia25MY1u1iXyE5z9UKR4
         iTmKgVEdwV6IRCMXwLoDYya7vF0vEg2ANLVJnI+ePzHElZSvilBELk577cU+pl55neAF
         VDinHmnjpPAues2QJfTK32bbp2QWgZtlI/Hq3Ul+gGMq2OFQPSdA8c4KMka46bE00XMc
         ZmuaaZDR9kt1j4QC1t4d5viSIzUqEhijPIk3Qxvd81NFU26srU8+1FAT5nRPDT3N7Gr1
         We1JkCDWLlIGGFdsjfpxwZmtlKota/P6ThSdbxRSJ4QcwPpnOlRa/0eGB7wAxJeP+Z8K
         bO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724064594; x=1724669394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6r5TjXljmBlpCGH6gaZQoVB7sULh0ZU8/sd0GXa27M=;
        b=LmYR29Uevc4uQ66AmwKxikbEIMixhCXoQ8LVAJBwUOskqx/HRW3xKt024J9XByVIOC
         y4TXsJqi2SmmrRmf/R3yBii5rqqbtaKCxBYV8Ai1VUIRrVrew2tOWUmXm/Nl6x0q7zE5
         1wDP/VtrmqZkkB33mr58ZUX+WkXRw26xhfq+aqM/ebZN8cJPtLfp2pBfhQbkrZ+IKGvt
         Jm+FQNrkzqdkTsnDOWJQ/XlN4r7w8kKL64CBWYIDqGt0e7qM9BXBFdmQft3EalcXrFYZ
         AkwJcyT8OzUZT0e/Wi0S27F/HZ0+dqzTwPsiC7k/Vt0t+9pxXHbUxKsX+RtoFSfhABsL
         qoDg==
X-Forwarded-Encrypted: i=1; AJvYcCXmTfdCYyw/y4Hp8D4lc166297yVS4AsTNWoiXxr/sqoYM8TAuAPa0vLA45ICWqFeJbzmJyF0aVC3W3STLZRNPL6XzrPskzE5EdqYquGv1MzZ/bkmCEK6W81H5nMcCoXE9W7RX5xdacGxfsKvYQnVzmPFask3Cz1W+Sp6v/rglO+zbci/nhpFw=
X-Gm-Message-State: AOJu0Yz0he3ptuxnXFIUSLoUfied5fMkH2423aMn8E7kWzFFjVIb+uok
	DR1lGDuRTtJ5nVScfbCi124DdxBbM3eAJjS4VF0tjR+2itePX4pq4RIUXTgP5cd4b+Pxw4Rg4jr
	qyqsEQIrqi4GnadyKFXPzjt5a+w==
X-Google-Smtp-Source: AGHT+IFTNzLwiLc8D+K9WXfFP3/4W5slIKwubxgBS37z967zTlcM5145Xmkb3hQMUyxDqeZl5gsiW/pD6c5S0TfSWgg=
X-Received: by 2002:a05:6602:2d94:b0:824:d6ed:e479 with SMTP id
 ca18e2360f4ac-824f266b92emr1021026539f.7.1724064593843; Mon, 19 Aug 2024
 03:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024080359-getaway-concave-623e@gregkh> <20240814055816.2786467-1-wirelessdonghack@gmail.com>
 <91e19cf3-216b-48ac-a93d-f920dd2a7668@rowland.harvard.edu>
In-Reply-To: <91e19cf3-216b-48ac-a93d-f920dd2a7668@rowland.harvard.edu>
From: color Ice <wirelessdonghack@gmail.com>
Date: Mon, 19 Aug 2024 18:49:42 +0800
Message-ID: <CAOV16XEsgkLWz3rOQsAdve-qKsPEDw-QxJNoo4hJfXdLnowHfw@mail.gmail.com>
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer
 Dereference&Use-After-Free Vulnerability
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, 
	mark.esler@canonical.com, stf_xl@wp.pl, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

How is the patch development progressing? We would like to conduct a
full verification test. It=E2=80=99s possible that many drivers have this
issue, so you could try a simple fix, and we=E2=80=99ll see how it works.
Recently, we tested some embedded devices where the operating systems,
due to automated operations involving WiFi drivers, had UDEV rules
built-in or granted significant permissions to USB. This allows the
PoC to cause a kernel crash without needing root or sudo.

Alan Stern <stern@rowland.harvard.edu> =E4=BA=8E2024=E5=B9=B48=E6=9C=8814=
=E6=97=A5=E5=91=A8=E4=B8=89 22:55=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Aug 14, 2024 at 01:58:16PM +0800, LidongLI wrote:
> >
> > Dear
> >
> >
> >
> > When will the patch be released? We are waiting to test it.
>
> Sorry it's taking so long.  I have been extremely busy with other things
> during the last few weeks and have not had any time to work on this.
>
> Alan Stern

