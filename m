Return-Path: <linux-wireless+bounces-17054-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E60A00B46
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 16:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE9F1639B7
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 15:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B2D1FA84F;
	Fri,  3 Jan 2025 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AZVJgi4L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAA011CA0
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jan 2025 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735917545; cv=none; b=ovlj+mqOn4AdHGeGkmQE88Xw/i/MZZjElIvJgJSU1XShbwKUuIpc4Nt+RkNDgMOyhfrr6SzeaoRsNHSNMvUPSxbwku6IHtJI9NGV7Vt0Y4yH0X4efm7Bwqa26bn7cfLs7BDGE6Rfz1v8ayveJw4agbR/NvZVdlg5h/HJc+2106o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735917545; c=relaxed/simple;
	bh=CGB8nJCzb5yHLiu2JB0xT5s1DN9ayx5bmIexjSS5sZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBNkpuu9VstfV7ft3dKOoycD9sJHbD6zYJnM4zMh51AJo8Z4rWp71SiBbu7Ys+K4COYN4ZuUsK9jqMzqgW4CEXgovas+fhF5EY9E6YZ35tSxkIlxKsVsy4GXOs8Byq2yxopuiN91RKGuEN9alzWv5ZjxwPO3EZC+jCLS/DIG3W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AZVJgi4L; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6f1b54dc3so1824811785a.1
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jan 2025 07:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1735917543; x=1736522343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CGB8nJCzb5yHLiu2JB0xT5s1DN9ayx5bmIexjSS5sZE=;
        b=AZVJgi4LFgjJiTQIAexsmTdplUM0cWXGuBu6YqQg7Iz980c0iZh9jKFmhCdv69yx7R
         OSA1IF7JVTdhaLuhamsR1j6cgm5HcPpMbML1A4zOT4LPaJoQdoMxb0cJQR0Rk/HYLgxx
         kkYwhV5gYv9uOx0gGUWOYjjZHGD9tW7vw6WMmvnPo8CvY4XAD47cBbanFAplj0NMY0hz
         fK1IY25OEu5xjZKUd7JDzTqWktBCqew5ZY7H+OR2VvSy74obzVUaEiD2QLXoSDZ/SVn2
         WuYSkTKRqjIw7dGeJC/ZIqfYOlDRhie3CcxG8ppgErfuvX2XqADNQg/4+Hg8UXXh1qNQ
         iicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735917543; x=1736522343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGB8nJCzb5yHLiu2JB0xT5s1DN9ayx5bmIexjSS5sZE=;
        b=RUwTegJOLgb6rtL7ESMK4TbTsGUbXSDUPtCR7KO4pOzKQQ6AoOsdy/ZvaJxu/CYxao
         iP2N33La/IrEMgs7Z3ZqzisMPgux/C53O4q3n4+yt5L+EFYQcPWpTwbpUUJHWuKz15j7
         mRvcZBcvAeXpzKrFvciCqyNDYqVD6ceDmLOLUd6HMCfoeHrELPi6dm90k19bsggeFM5N
         wv7xQWmOgoB8vI6KQGbSAXS1tn3nnQKD+4RHG0lcJg3Efw4mLk5LbYWKNoMb3p+Wa7GR
         cMi4Od4ynblsKtMZx/dGKKIRFYwod3SKGX02BN/oandjDgZzvqPZ+kRms79WyH23IpJU
         vAEg==
X-Forwarded-Encrypted: i=1; AJvYcCUdxrSlKNf6MuRkFqaG/9J1UuT1Lh3YvOGgiJN/pNdFvWmbDuUv4+HvuIkHePkDOkBu8NrZBQmVWw3kIaqdxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTpKbS+7kGK0saQHGXWTNcbzbF5O0jfLQ4MeaJB0tAMerow0Rq
	i52vdlgFnnZQpfHu2Wzs6GBstZ0VIYyY3qnqV6iuXrpL4fbEzAs1rGkLOrmYijQ=
X-Gm-Gg: ASbGncsSA24X0uoBoihuG/xvIstE/1oxvwzvGvqbYWqB1aTO7AnTcdZCfBaiz0Cq8pu
	F9YIquju1AsuCRsFz9QGkuB1Vbxrmts5zssZJKe+/A2TkSLgxnp15NfHv9gWyQQmvKj2yHLvCPd
	KVKqrMWk+s9K2vY0Ne/uqc7JS/j+ufoSyiTOGhKGKsylFvHyUQVh+OzJZFudmU0BkiqPI8qgEaa
	Zh33i4AJCvG6/l1v2XyPaFk5bwvrfZRTtMoEGZGNjuoVyluXd4SZWHN+LPd/XA1JUD9GFIgO7SD
	9UH4b46RexKPvqKIUGceVD5lj6TMvQ==
X-Google-Smtp-Source: AGHT+IHTG+Bq32SHg17tHpm9vXIkHAkuaGHUCVV1avASRsb7eSYGQtc9W1/GwgW3NuW7igfw1fFU3w==
X-Received: by 2002:a05:620a:488a:b0:7b6:d5cb:43a9 with SMTP id af79cd13be357-7b9ba773db8mr7230744485a.23.1735917542951;
        Fri, 03 Jan 2025 07:19:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac478f0fsm1277723385a.71.2025.01.03.07.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 07:19:01 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tTjS0-00000000iwx-2edn;
	Fri, 03 Jan 2025 11:19:00 -0400
Date: Fri, 3 Jan 2025 11:19:00 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
	quic_bqiang@quicinc.com, kvalo@kernel.org, prestwoj@gmail.com,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	iommu@lists.linux.dev, kernel@quicinc.com,
	johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci: Create feature to disable MSI
 virtualization
Message-ID: <20250103151900.GE26854@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170014.1583783-1-alex.williamson@redhat.com>
 <20240813163053.GK1985367@ziepe.ca>
 <87r0aspby6.ffs@tglx>
 <03fdfde8dc05ecce1f1edececf0800d8cb919ac1.camel@infradead.org>
 <20250103143138.GC26854@ziepe.ca>
 <432d4304b579c5bd6973628c3c4aaad476627f7b.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432d4304b579c5bd6973628c3c4aaad476627f7b.camel@infradead.org>

On Fri, Jan 03, 2025 at 02:47:11PM +0000, David Woodhouse wrote:

> Probably best for the hypervisor to have some way to *advertise* that
> it's handling this though, as guests also might want to run on
> hypervisors which don't.

If the hypervisor doesn't properly virtualize the device it shouldn't
assign it to a VM to start with :\

Intel looked at the question of advertising clean interrupt remapping
when trying to virtualize IMS and it didn't seem so great.

Bare metal machines need to work, so any test they could think of
adding would either fail on bare metal or fail on existing VMs.

VMM's have taken the approach of not telling the guest they are in VMs
and then also not implementing the bare metal HW behaviors with full
fidelity. So we have no way to discover that the VMM is, in fact,
emulating broken "hw".

Thus we get this push that all kernels need to accomodate the worst
VMM behaviors :(

Jason

