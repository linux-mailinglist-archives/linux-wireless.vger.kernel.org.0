Return-Path: <linux-wireless+bounces-2303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20E5835AEC
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 07:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3316B22D58
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 06:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF977610D;
	Mon, 22 Jan 2024 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CY1ZkjTD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976F063A0;
	Mon, 22 Jan 2024 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705904665; cv=none; b=kTo05GcrwnNRuAX34de6Y6hZhC4aZc6Bru7Y+NzM8k6IsXizdOtmGTmuRyJFWAxAmT87BQWai5TX/nw93L+dBAnlTo2oRnb6kAW4MZe5y05nNfOWr9GEdcU/Vy10DzFq1e/UEMiJ0qMvxHjF+SHTky+MsnjNwWfbBJu2DGuZtE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705904665; c=relaxed/simple;
	bh=ytQ70xzw9VFq0ngIprfNmliPx9LBkAoh27nHd5RHzYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9Bqk1HLbd3SpDC0f0tQObs1fWsDM1lW1owFyNcgFX1sCG1W29mj8IYK19adCRKU5GQt0KppWRiK4sHzODpXALMuFUy9VVm2VUctoZezBSOHI2tSP6tWYyc+n6OxzJuJ53t0cp+H6DdxJQ7ukfcwfkdE1CSB/gehjosLnymhEoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CY1ZkjTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0572C433C7;
	Mon, 22 Jan 2024 06:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705904665;
	bh=ytQ70xzw9VFq0ngIprfNmliPx9LBkAoh27nHd5RHzYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CY1ZkjTDYIl7+UJ1dyUpfirvwdoVAMRbMoqr9lWpPih1UFj+oYhgembV47LZcvka3
	 ExmL9/w3jSOjXOu3sQ0hG9Sf0Wbmh5NvsZan+IxhCKH5c1c/dgYYV7fZ4aUkfWQ/ns
	 lV05TA9OP5gb+AY2XqshCbLZkEEjz+gO1nbmwIEOLc4qHzeBvNjl7CryfR/YPoShfD
	 Rn/yOP6PuRwBdNlvSkNkCno2V3Bs2xmxXq2LoAKI34rAoNH0Vcdsus0/IKMY9qvvGQ
	 GDd37K0EOtunAA/DH5lQE8Lj7IbOa5AbjU0aUEe4DYmUu/2JjkjGFnOp6ba5/zEvhs
	 Zq3Up7LuKcwPA==
Date: Mon, 22 Jan 2024 11:54:11 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
	mhi@lists.linux.dev, ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org, quic_cang@quicinc.com,
	quic_qianyu@quicinc.com
Subject: Re: [PATCH RFC v2 1/8] bus: mhi: host: add
 mhi_power_down_no_destroy()
Message-ID: <20240122062411.GA3176@thinkpad>
References: <20231127162022.518834-1-kvalo@kernel.org>
 <20231127162022.518834-2-kvalo@kernel.org>
 <20231130054250.GC3043@thinkpad>
 <87v89cq1ci.fsf@kernel.org>
 <20231220163209.GJ3544@thinkpad>
 <20231220165113.GK3544@thinkpad>
 <7a31696b-cf2b-48c0-bad3-327e9ce47172@quicinc.com>
 <20240104060904.GB3031@thinkpad>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240104060904.GB3031@thinkpad>

On Thu, Jan 04, 2024 at 11:39:12AM +0530, Manivannan Sadhasivam wrote:

+ Can, Qiang

[...]

> > > To me it all sounds like the probe deferral is not handled properly in mac80211
> > > stack. As you mentioned in the commit message that the dpm_prepare() blocks
> > > probing of devices. It gets unblocked and trigerred in dpm_complete():
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/power/main.c#n1131
> > > 
> > > So if mac80211/ath11k cannot probe the devices at the dpm_complete() stage, then
> > > it is definitely an issue that needs to be fixed properly.
> > To clarify, ath11k CAN probe the devices at dpm_complete() stage. The
> > problem is kernel does not wait for all probes to finish, and in that way we
> > will face the issue that user space applications are likely to fail because
> > they get thawed BEFORE WLAN is ready.
> > 
> 
> Hmm. Please give me some time to reproduce this issue locally. I will get back
> to this thread with my analysis.
> 

We reproduced the issue with the help of PCIe team (thanks Can). What we found
out was, during the resume from hibernation the faliure happens in
ath11k_core_resume(). Precisely here:
https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/tree/drivers/net/wireless/ath/ath11k/core.c?h=ath11k-hibernation-support#n850

This code waits for the QMI messages to arrive and eventually timesout. But the
impression I got from the start was that the mhi_power_up() always fails during
resume. In our investigation, we confirmed that the failure is not happening at
the MHI level.

I'm not pointing fingers here, but trying to understand why can't you fix
ath11k_core_resume() to not timeout? IMO this timeout should be handled as a
deferral case.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

