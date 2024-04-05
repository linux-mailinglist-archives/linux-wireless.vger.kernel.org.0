Return-Path: <linux-wireless+bounces-5901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA91899CE6
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 14:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56E28B212E1
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 12:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40F216C861;
	Fri,  5 Apr 2024 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neksvo/R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08E316C862;
	Fri,  5 Apr 2024 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320208; cv=none; b=cbAjvKtE3HR/+KXNpmrIXlhLW7bEXxuKpQgbN1kDJAH7IQEg+0flQuI+8VgXD3QvQoDQ+ktQ5C/YsrftXOYr9V+AZtl47IRjjeIOv4iPh+LI6ITztU1KVLh/p2yP/y1jq3mlakWizmz17Bam6BXqCeSAhZxdKgRLKQouRpRTXKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320208; c=relaxed/simple;
	bh=JR8+Vwz3pz5roRhU/fTETXN5L9wi9qDehmzIoJCYsWY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=hha2Oae1NiDH+why3jmc6RXXKnGW17P6VW51uALTT9+tbMedQm//aZJ/RVM1qt/q4NSk4nKpDsGd1xX9s4hPCbzEcRkJecNSxQLwd3nlkzymN+ShlFgQeQg01tNNpigyKbCNESLDogWWb/sBkTsQ/rZk5JH5pKAJWnEVQkKq7vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neksvo/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0D6C433C7;
	Fri,  5 Apr 2024 12:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712320208;
	bh=JR8+Vwz3pz5roRhU/fTETXN5L9wi9qDehmzIoJCYsWY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=neksvo/RefNVGv94kOSJeWzddtr2dwvzlWDzqeZrWWz8+WB8jbKpwpCH9a/67DZBo
	 8ULRAuSKEi+8uStofOQEGjttycmW6+ChNAIbrJJDNQkl6Xc/9AtG5IZnb9GhV5Xedp
	 rQ1j4moHJ//fvAAUq4K6FuQFqXHt/l8R/F4fIX3YwT3xlG7rR1eJbfztfPaY/lwBun
	 vxZYGlLG2jfo9NwFtlo5oqXz9pz6GIxtJDvQv8R495F00cxg039mTKbLX6YIky3Mei
	 3Z6WOhwbDanDuSfdFp3ts+80lH30SLHf4Pzw661+EyiE+953kAMaypkhvalYw+VVs9
	 IJOg5/94oXSlQ==
From: Kalle Valo <kvalo@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,  ath11k@lists.infradead.org,
  linux-wireless@vger.kernel.org,  linux-arm-msm@vger.kernel.org,
  mhi@lists.linux.dev,  davem@davemloft.net,  edumazet@google.com,
  kuba@kernel.org,  pabeni@redhat.com,  netdev@vger.kernel.org
Subject: Re: [PATCH v7 1/3] bus: mhi: host: add mhi_power_down_keep_dev()
References: <20240305021320.3367-1-quic_bqiang@quicinc.com>
	<20240305021320.3367-2-quic_bqiang@quicinc.com>
	<20240401104908.GA234427@thinkpad>
Date: Fri, 05 Apr 2024 15:30:03 +0300
In-Reply-To: <20240401104908.GA234427@thinkpad> (Manivannan Sadhasivam's
	message of "Mon, 1 Apr 2024 16:19:08 +0530")
Message-ID: <87wmpc2dro.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:

> On Tue, Mar 05, 2024 at 10:13:18AM +0800, Baochen Qiang wrote:
>
>> ath11k fails to resume:
>> 
>> ath11k_pci 0000:06:00.0: timeout while waiting for restart complete
>> 
>> This happens because when calling mhi_sync_power_up() the MHI subsystem
>> eventually calls device_add() from mhi_create_devices() but the device
>> creation is deferred:
>> 
>> mhi mhi0_IPCR: Driver qcom_mhi_qrtr force probe deferral
>> 
>> The reason for deferring device creation is explained in dpm_prepare():
>> 
>>         /*
>>          * It is unsafe if probing of devices will happen during suspend or
>>          * hibernation and system behavior will be unpredictable in this case.
>>          * So, let's prohibit device's probing here and defer their probes
>>          * instead. The normal behavior will be restored in dpm_complete().
>>          */
>> 
>> Because the device probe is deferred, the qcom_mhi_qrtr_probe() is not
>> called and thus MHI channels are not prepared:
>> 
>> So what this means that QRTR is not delivering messages and the QMI connection
>> is not working between ath11k and the firmware, resulting a failure in firmware
>> initialization.
>> 
>> To fix this add new function mhi_power_down_keep_dev() which doesn't destroy
>> the devices for channels during power down. This way we avoid probe defer issue
>> and finally can get ath11k hibernation working with the following patches.
>> 
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>> 
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>
> Applied to mhi-next! Note that this patch is also available in mhi-immutable
> branch for ath11k maintainers to pull into their tree.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/log/?h=mhi-immutable

Thanks, I pulled this branch to ath-next:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=ath-next&id=231a4c893c9bb2984a8c6b7450199f59eb816ed9

This is just preparation for patches 2 and 3, those patches are not
commited yet.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

