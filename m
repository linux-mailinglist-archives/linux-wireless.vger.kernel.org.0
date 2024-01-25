Return-Path: <linux-wireless+bounces-2496-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A15D83C871
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 17:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC671F244D2
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 16:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0945813172A;
	Thu, 25 Jan 2024 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwB2xaio"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88A1137C4F
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201004; cv=none; b=SDKxS+SS+f5Ucyt2RqEYBCVzk/ieUAzi4vhq3U/ODZ2Tv4fWfTU2RJ3LoDU/eOCFIiB2XxCAqgFneAWc4l8WSKLFuvgDFuOpUw8mpjgr6raHSug3VBShtZqtblXzXoV13ConPI1m+be3neAJeihoK9uMrsiNtBGkuk5qi2QEbIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201004; c=relaxed/simple;
	bh=q2idK8n/E6MaATBa7r34B0Wjj8fT6oqpM5c7h4sKBUM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=lIhk9d2hcpBBPIWpQ4OMWbbRQn9nI5mmMyfPriZbVo5Rd3URnu9GzHNLFMXWTvwWuSh2v+LhBJmFj4MOn5qfM1Rj6M03PtDgHSrt/Xs0Pk2yCfaCAk/iD/jPA9i3UWBQqo7skPWUQoUttLEMxmtBnQ/Wu3PTExSrE+cbvEcitIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwB2xaio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E96C43390;
	Thu, 25 Jan 2024 16:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706201004;
	bh=q2idK8n/E6MaATBa7r34B0Wjj8fT6oqpM5c7h4sKBUM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ZwB2xaio3PdSa/qTT/NuJ1TAWYgSKAwVyK8dhP1WB0vtuQHsN/9Ki7qQjGSWQ03K7
	 AxpNRDzh6QhlPBxzYWbT/Z55oP7GCX7YTSSj+Dqsab0WrFX26l7sHvFrC/DdOO3BtM
	 xhxe8BTraXG3PZNJy1eISHDRFqwDR7l7DMz7wzxCC35taV/JpXq3CQDVz76TPVeQMo
	 oXXeGpC9j3bZ2nDh0gX6DAO/XBLSNatVZDSXh6vsM01Qdt7RQxngW/DAA7uFtsnj9h
	 3p73PRy42KTd6kLvd/7Y1gZEqwHtvcipGo/ANEcaFtc2cOuX9td/7YqAWg75so0oQy
	 T+p26i8S94t4Q==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,  <ath11k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/4] wifi: ath11k: remove invalid peer create logic
References: <20240123025700.2929-1-quic_bqiang@quicinc.com>
	<20240123025700.2929-2-quic_bqiang@quicinc.com>
	<bb75794e-e475-4736-9dcd-a4c9e9633e8c@quicinc.com>
Date: Thu, 25 Jan 2024 18:43:21 +0200
In-Reply-To: <bb75794e-e475-4736-9dcd-a4c9e9633e8c@quicinc.com> (Jeff
	Johnson's message of "Tue, 23 Jan 2024 18:05:23 -0800")
Message-ID: <874jf11hzq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 1/22/2024 6:56 PM, Baochen Qiang wrote:
>> In ath11k_mac_op_assign_vif_chanctx(), there is a logic to
>> create peer using ar->mac_addr for a STA vdev. This is invalid
>> because a STA vdev should have a peer created using AP's
>> MAC address. Besides, if we run into that logic, it means a peer
>> has already been created earlier, we should not create it again.
>> So remove it.
>> 
>> This is found during code review.
>> 
>> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>> Tested-on: WCN6855 hw2.1 PCI
>> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>> 
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ath11k/mac.c | 16 ----------------
>
> My Qualcomm Innovation Center copyright checker reports:
> drivers/net/wireless/ath/ath11k/mac.c copyright missing 2024
>
> Kalle can fix this in the pending branch

Thanks, I added 2024.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

