Return-Path: <linux-wireless+bounces-4263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5050286D344
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 20:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E601F1F23DA1
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 19:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E81013C9E7;
	Thu, 29 Feb 2024 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQJtxn7+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED5813C9E5;
	Thu, 29 Feb 2024 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235339; cv=none; b=D+GNt0XUIPaeFxjVs2HMEOQuNJ43YKYEi0FN2d+7skLTA0HptyeHkV//Lq/SiOg6DYEvIcvhYv9vXPHflWgA0Zowebra/kQ37oNBIoUzQDqs5pzw4nAJt/TNu8CagpAB7kTP73wwGLlVJEN2jXJMaU19Bc9Polq2jYFtuf5sEhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235339; c=relaxed/simple;
	bh=z+ll6MviZxAO9oJ8WAt1UoEwqN5J4y0yQMH87Dp3Lgg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JcUEp3KM1HppB3rjzefgzG8g60gqFGC0j65HW4Puk8sz1x961d13FvFFzxa5iD9Oy6T3+rXT8Ogvu6ZbXtabXWJ0kzcAcrKN7E+UsUjbvF+4aVRx7BnTFcVY0icr6inAUrkGnxwJQ9uHs1/ZFKSRqp6eE+a1srVYJc753QENJOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQJtxn7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA240C433F1;
	Thu, 29 Feb 2024 19:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709235339;
	bh=z+ll6MviZxAO9oJ8WAt1UoEwqN5J4y0yQMH87Dp3Lgg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=jQJtxn7+AqbnVuE+PBx7GcVjn06hzaXhUwyYdOKDoNFmbPZii46rlwhjAdB24ZI4Q
	 T4kZauY7MEISI8Kzd0vzFUKUC2BUzWeSbTNchV8hsy7+KVjrd8CnICSp3Hw260uLVs
	 f/FtpHhp4apxYVCwfWB0vqs54p965NrDRxkeqHTk9W7tdGzHeJ5xcJROr/EV3Bg/kC
	 y9dEjBdhmv6fjVosVqvXRyE2E4UxEpB1aOeLBGobOLrK098vT5B/+n6zgc/u1ExYoE
	 IcZJLJXgbPx1v+5p4AKF2dgtK905OAM7NpixAjFItscUdjjzxK9Yz+0g1Oy7Vsgjgl
	 vVWK5ir8KoDWw==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,  "Kalle Valo
 (QUIC)" <quic_kvalo@quicinc.com>,  <ath11k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>,  <linux-arm-msm@vger.kernel.org>,
  <mhi@lists.linux.dev>,  <davem@davemloft.net>,  <edumazet@google.com>,
  <kuba@kernel.org>,  <pabeni@redhat.com>,  <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] bus: mhi: host: add mhi_power_down_keep_dev()
References: <20240228022243.17762-1-quic_bqiang@quicinc.com>
	<20240228022243.17762-2-quic_bqiang@quicinc.com>
	<20240229101202.GB2999@thinkpad>
	<531daaa9-cf14-4812-8908-c617bd25bc08@quicinc.com>
Date: Thu, 29 Feb 2024 21:35:34 +0200
In-Reply-To: <531daaa9-cf14-4812-8908-c617bd25bc08@quicinc.com> (Baochen
	Qiang's message of "Thu, 29 Feb 2024 18:33:43 +0800")
Message-ID: <87le7383nd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> On 2/29/2024 6:12 PM, Manivannan Sadhasivam wrote:
>> On Wed, Feb 28, 2024 at 10:22:41AM +0800, Baochen Qiang wrote:
>>> ath11k fails to resume:
>>>
>>> ath11k_pci 0000:06:00.0: timeout while waiting for restart complete
>>>
>>> This happens because when calling mhi_sync_power_up() the MHI subsystem
>>> eventually calls device_add() from mhi_create_devices() but the device
>>> creation is deferred:
>>>
>>> mhi mhi0_IPCR: Driver qcom_mhi_qrtr force probe deferral
>>>
>>> The reason for deferring device creation is explained in dpm_prepare():
>>>
>>>          /*
>>>           * It is unsafe if probing of devices will happen during suspend or
>>>           * hibernation and system behavior will be unpredictable in this case.
>>>           * So, let's prohibit device's probing here and defer their probes
>>>           * instead. The normal behavior will be restored in dpm_complete().
>>>           */
>>>
>>> Because the device probe is deferred, the qcom_mhi_qrtr_probe() is not
>>> called and thus MHI channels are not prepared:
>>>
>>> So what this means that QRTR is not delivering messages and the QMI connection
>>> is not working between ath11k and the firmware, resulting a failure in firmware
>>> initialization.
>>>
>>> To fix this add new function mhi_power_down_keep_dev() which doesn't destroy
>>> the devices for channels during power down. This way we avoid probe defer issue
>>> and finally can get ath11k hibernation working with the following patches.
>>>
>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>>
>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>>
>> Did Kalle co-author this patch? If so, his Co-developed-by tag should
>> be added.
>
> Hmm, I'm not sure...  I would like Kalle's thoughts on this.

IIRC I did only some simple cleanup before submitting the patch so I
don't think Co-developed-by is justified. I'm also fine with removing my
Signed-off-by.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

