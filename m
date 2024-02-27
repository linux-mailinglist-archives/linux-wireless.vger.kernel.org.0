Return-Path: <linux-wireless+bounces-4058-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 323238689BC
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 08:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99195B21029
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 07:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F13754BCB;
	Tue, 27 Feb 2024 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SN8pe4f9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B903C5477C
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709018365; cv=none; b=fSzntCCGsh/9Ngim7p6Qegx1POK+OUjGV/PiGEQa+/1uzP7gFe2EkLuHgQeEWK4yXs4/6QmTgL/vw2uCcMCWMGWas6abnKZw3mLzubRjwU389dY2KQQHFRjR9n4Uq/i/zpMNepsUNcTg8GtIi7E6gWZPA6+0WtPAUI5WMLNv7Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709018365; c=relaxed/simple;
	bh=lVyTXCleZImck8BrH8tMbX31xUSHJ2/S9SscG0nZ/HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUqwTBoyG8ncuZKx6s3T0w9DbYlaPId+NGtaM9Jg7SxxSWPLa+kzyse7JViZxGlE8bCT+yGaHIbeAmpcXE+zwvxhkvjVp1NoDetwAQ/wqp0bfr2qhpm0a9OnoCZjzHLgs3+XzqP8KByzmQdQ/KD7Z+wMUEkWeJgJ+X0+yTeo1mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SN8pe4f9; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cedfc32250so3699820a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 23:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709018362; x=1709623162; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QxFTuOsrpMcuyCu0Hy+lb4Bd4RUL02qdG86Qt+qw8gE=;
        b=SN8pe4f9gF6DAhXL3H5nVuy9/w+r3VioQsssbYjj34y2xhuyYlxxfqFuvOmfHkdM09
         v6dwv2JXQKwf2bvCcniKQo+TmVpY3wC/vvXBCdEym2SsgIQ28bqbtHQeifFAb0PK7E+h
         WtDa6biEK1of15P0u1Pub+0bTnBY4DcoLz1Z8sLgf4C2X9LQbDTWrDQ3dqRX8fE22cUS
         j6KmnXsKIer9e0MQSyYxqLpjJVE27E3FalLmBtO2vxeSI90OPSNoMay3DeqnZRYef6ay
         1GcAL1pbTDPDE354jNrtcP3sxhY6bpr1aKMMDpfaOPmdGMg/abx125hq8nDrOmZRLTel
         qQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709018362; x=1709623162;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QxFTuOsrpMcuyCu0Hy+lb4Bd4RUL02qdG86Qt+qw8gE=;
        b=cQh/SvQMTFnHJ+CkzrXo8FxqrKdhs64bYWe1pHPCp3/sgv/8IwvlWnTaXKOwavheov
         ttGZV90E/D8Jyo0OPoVjAu5qHCohQQKzVEeii5uH4+hLWI4gPizgYUDBkyx+TknMXTTK
         BekCVxHhgLDxKzwqZaRefanI72et8/WS77YcCUb3eJ8AjOoFqivQ8+CN8C5ZXrxtyDF1
         WQ7zqOjueKgK+81ZnEvtxcyWFhvquxaMQYGlCQIP0n8tISsOw0S0/7r/FmrMTFnPwV4T
         mGfymyXKw4yB8pxjKl7go3jBl6qaEaNsEqPosfz15ym6omDD9kZE6bwpK92mWWbBmPYk
         /qkg==
X-Forwarded-Encrypted: i=1; AJvYcCWrht9eUy0sBl6zkdDlCNqOe1/u3oG011yCK22g5TmssonhWO4IrxJHuJKyQ0zFvErh9dlqF6gCYg+2m8mfEtUFk7+YlyYzfMSA2xtM38A=
X-Gm-Message-State: AOJu0YwrM78ZaJhhzK3iKHjfEoSysgZPUj7Aoke9+93AuD0k/cqJNJhs
	T2pwDxwLNZZSQCF8Et0cFfuwLZXWNPbzxJymeDsU7KEow68LYRnZKOy/F5UyGgId9Uf02KqfCS8
	=
X-Google-Smtp-Source: AGHT+IF1LF7zhEOVHEOb+Wy1qkWAaN21CKUVcJcNJZUjgL5YGc8K+RirkDo2jbJKuMOoL83r7N2YfA==
X-Received: by 2002:a05:6a20:e605:b0:1a1:e83:8eb4 with SMTP id my5-20020a056a20e60500b001a10e838eb4mr801517pzb.9.1709018361960;
        Mon, 26 Feb 2024 23:19:21 -0800 (PST)
Received: from thinkpad ([117.213.97.177])
        by smtp.gmail.com with ESMTPSA id kr12-20020a170903080c00b001dca813b07csm839619plb.62.2024.02.26.23.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:19:21 -0800 (PST)
Date: Tue, 27 Feb 2024 12:49:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Takashi Iwai <tiwai@suse.de>, Jiri Slaby <jirislaby@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Linux Wireless <linux-wireless@vger.kernel.org>,
	ath11k@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org
Subject: Re: ath11k allocation failure on resume breaking wifi until power
 cycle
Message-ID: <20240227071915.GE2587@thinkpad>
References: <96481a45-3547-4d23-ad34-3a8f1d90c1cd@suse.cz>
 <0994ae16-8174-4a04-b454-1974b16bc106@quicinc.com>
 <20240222054739.GG3374@thinkpad>
 <38c36d16-9cc1-4f03-b758-4a3ba90f8aa4@suse.cz>
 <abc0c24f-2137-41eb-bb99-80aea8dacdb2@quicinc.com>
 <a36b35a9-fb37-4afe-a718-a47dfe658cb5@suse.cz>
 <34123ee0-26c9-4240-8d58-aba02f7c66b9@quicinc.com>
 <20240226114307.GA8422@thinkpad>
 <c4b7ec62-7d2d-438b-904d-d935e09e517c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4b7ec62-7d2d-438b-904d-d935e09e517c@quicinc.com>

On Tue, Feb 27, 2024 at 10:43:22AM +0800, Baochen Qiang wrote:
> 
> 
> On 2/26/2024 7:43 PM, Manivannan Sadhasivam wrote:
> > On Mon, Feb 26, 2024 at 05:11:17PM +0800, Baochen Qiang wrote:
> > > 
> > > 
> > > On 2/26/2024 4:45 PM, Vlastimil Babka wrote:
> > > > On 2/26/24 03:09, Baochen Qiang wrote:
> > > > > 
> > > > > 
> > > > > On 2/23/2024 11:28 PM, Vlastimil Babka wrote:
> > > > > > On 2/22/24 06:47, Manivannan Sadhasivam wrote:
> > > > > > > On Wed, Feb 21, 2024 at 08:34:23AM -0800, Jeff Johnson wrote:
> > > > > > > > On 2/21/2024 6:39 AM, Vlastimil Babka wrote:
> > > > > > > > > Hi,
> > > > > > > > > 
> > > > > > > > > starting with 6.8 rc series, I'm experiencing problems on resume from s2idle
> > > > > > > > > on my laptop, which is Lenovo T14s Gen3:
> > > > > > > > > 
> > > > > > > > > LENOVO 21CRS0K63K/21CRS0K63K, BIOS R22ET65W (1.35 )
> > > > > > > > > ath11k_pci 0000:01:00.0: wcn6855 hw2.1
> > > > > > > > > ath11k_pci 0000:01:00.0: chip_id 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
> > > > > > > > > ath11k_pci 0000:01:00.0: fw_version 0x1106196e fw_build_timestamp 2024-01-12 11:30 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
> > > > > > > > > 
> > > > > > > > > The problem is an allocation failure happening on resume from s2idle. After
> > > > > > > > > that the wifi stops working and even a reboot won't fix it, only a
> > > > > > > > > poweroff/poweron cycle of the laptop.
> > > > > > > > > 
> > > > > > > 
> > > > > > > Looks like WLAN is powered down during s2idle, which doesn't make sense. I hope
> > > > > > > Jeff will figure out what's going on.
> > > > > > 
> > > > > > You mean the firmware is supposed to power it down/up transparently without
> > > > > > kernel involvement? Because it should be powered down to save the power, no?
> > > > > Let me clarify: from backtrace info, seems you are using a kernel with
> > > > > the hibernation-support patches [1] applied, which are not accepted yet
> > > > > to mainline kernel or even
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git.
> > > > 
> > > > Oh, you're right. Sorry for confusing you all. The rc kernel builds we have
> > > > for openSUSE have nearly no non-upstream patches so it didn't really occur
> > > > to me to double check if there might be in the area.
> > > > 
> > > > Seems Takashi (Cc'd) added them indeed to make hibernation work:
> > > > https://bugzilla.suse.com/show_bug.cgi?id=1207948#c51
> > > > 
> > > > But then, why do they affect also s2idle, is it intentional? And why I only
> > > Yes, it's intentional. When suspend/resume, ath11k does the same for either
> > > a s2idle suspend or a deep one.
> > > 
> > 
> > That's a terrible idea for usecases like Android IMO. s2idle happens very often
> > on Android platforms (screen lock) and do you want to powerdown the WLAN device
> > all the time?
> I am not familiar with Android case. Is WoWLAN enabled in that case? I am
> asking this because if WoWLAN is enabled ath11k goes another path and only
> calls mhi_pm_suspend()/resume() instead of mhi_power_down()/up().
> 

I don't work on Android platform, no idea about WoWLAN. But I just raised a
possible issue. Please check with the Qcom internal Android teams about this. If
it is not going to be an issue (different code path as you said above), then
feel free to ignore my comment.

- Mani

> > 
> > Even though it offers power saving, I'm worried about the latency and possible
> > teardown of the chipset. Later is only valid if the chipset undergoes complete
> > power cycle though.
> > 
> > - Mani
> > 
> > > > started seeing the problems in 6.8, the patches are there since August.
> > > > 
> > > > > So this is why you see WLAN firmware is powered down during suspend.
> > > > > 
> > > > > [1]
> > > > > https://patchwork.kernel.org/project/linux-wireless/cover/20231127162022.518834-1-kvalo@kernel.org/
> > > > > 
> > > > > > 
> > > > > > But I just found out that when I build my own kernel using the distro config
> > > > > > as base but reduced by make localmodconfig, the "mhi mhi0: Requested to
> > > > > > power ON" and related messages don't occur anymore, so there's something
> > > > > > weird going on.
> > > > > Here your own kernel doesn't include the hibernation-support patches, right?
> > > > 
> > > > Right.
> > > > 
> > > > 
> > > > 
> > 

-- 
மணிவண்ணன் சதாசிவம்

