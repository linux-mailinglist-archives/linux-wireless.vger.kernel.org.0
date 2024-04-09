Return-Path: <linux-wireless+bounces-5995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EED789D598
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 11:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D040E1C22E25
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 09:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EDE7F487;
	Tue,  9 Apr 2024 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7Fy2HCg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38DB1EB45;
	Tue,  9 Apr 2024 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654999; cv=none; b=fAaKbCkbxQ8n68J79oz2+fXxm0M5zqwb7YRlR50Akx7ul27v1SqX1YyOUFfHzQGQhNsp4w//TEtJY/6e72YriynX2v45stzCTtSGMqBq9cBx5gt+ntQeWyu2sx64w4ukZdp61IWVKbg5/23719pz13Jp7Gn9iPJ98bvQ2Lao5Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654999; c=relaxed/simple;
	bh=VxGe2y2hTT/OKqj/iuGp7AuAf+llkMhGqGe3IdyOeRU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=hZPb5SPWyMSdPaDMVskFNt579oaRoGLYC+OU4OW25XyvrM9Z8cvzHLXew9Y2TBE813tImzC/o+a7bOwv+MNgez4TEtlI3kPteoLHyFGvZT5ZE57MqQjZI0QM2UPHjwc+Zm2HOAGZAqDUCK6K2hoAN+5LIv1I3Qq4MXM37SBuC5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7Fy2HCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E850DC433F1;
	Tue,  9 Apr 2024 09:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712654999;
	bh=VxGe2y2hTT/OKqj/iuGp7AuAf+llkMhGqGe3IdyOeRU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=S7Fy2HCguTBT9VYHJZclIYbNIIKYyjGS4SJ6JNEwheRqDkW8jfuBojcHs5bYHEfQ1
	 +pJCicyv9U3TRrhFv8uSfPDBhs90GB7CwzWYY8ojXd5Fh79vzTbZUMBAH5VUIr51dP
	 1rr/V69bZgCBGlKNxH7zw1DI/1WZgRsv3/xFWVAqfk5oVqt6qPVd9TnwpRt+9OCIOy
	 5v79PvNGYxcVicC0wpkpRecp3upICbOWfUQZHEQ/RMFzydcBr2RkDeZfOZ4AzrbsuB
	 8zCxyqoVo9bCM2CCZKLvwrq/qpDUkSRNoVkw7Y5oBA1MeaxzNjcPJS5AedbUMKorq2
	 aricVyz3cg8yQ==
From: Kalle Valo <kvalo@kernel.org>
To: <davem@davemloft.net>, <edumazet@google.com>,  <kuba@kernel.org>,
  <pabeni@redhat.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,  <ath11k@lists.infradead.org>,
  <manivannan.sadhasivam@linaro.org>,  <linux-wireless@vger.kernel.org>,
  <linux-arm-msm@vger.kernel.org>,  <mhi@lists.linux.dev>,
  <netdev@vger.kernel.org>
Subject: Re: [PATCH v7 2/3] net: qrtr: support suspend/hibernation
References: <20240305021320.3367-1-quic_bqiang@quicinc.com>
	<20240305021320.3367-3-quic_bqiang@quicinc.com>
	<8734s02b3s.fsf@kernel.org>
Date: Tue, 09 Apr 2024 12:29:54 +0300
In-Reply-To: <8734s02b3s.fsf@kernel.org> (Kalle Valo's message of "Fri, 05 Apr
	2024 16:27:35 +0300")
Message-ID: <87il0q28a5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Hi netdev maintainers,
>
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>
>> MHI devices may not be destroyed during suspend/hibernation, so need
>> to unprepare/prepare MHI channels throughout the transition, this is
>> done by adding suspend/resume callbacks.
>>
>> The suspend callback is called in the late suspend stage, this means
>> MHI channels are still alive at suspend stage, and that makes it
>> possible for an MHI controller driver to communicate with others over
>> those channels at suspend stage. While the resume callback is called
>> in the early resume stage, for a similar reason.
>>
>> Also note that we won't do unprepare/prepare when MHI device is in
>> suspend state because it's pointless if MHI is only meant to go through
>> a suspend/resume transition, instead of a complete power cycle.
>>
>> Tested-on: WCN6855 hw2.0 PCI
>> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>
> Could I take this patch via ath.git tree? Full patch here (same patch
> but links to both patchwork projects):
>
> https://patchwork.kernel.org/project/linux-wireless/patch/20240305021320.3367-3-quic_bqiang@quicinc.com/
>
> https://patchwork.kernel.org/project/netdevbpf/patch/20240305021320.3367-3-quic_bqiang@quicinc.com/
>
> I ask because we need it to get hibernation working on ath11k (and ath12k):
>
> https://patchwork.kernel.org/project/linux-wireless/patch/20240305021320.3367-4-quic_bqiang@quicinc.com/

No reply from netdev maintainers but as the patch is marked as 'Not
Applicable' in netdev patchwork I guess they would not have major
objection to take this to ath.git. It should go to net-next in the next
wireless-next pull request anyway.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

