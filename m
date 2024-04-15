Return-Path: <linux-wireless+bounces-6334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81598A57B8
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 18:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E661F22A9A
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 16:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944A32E40F;
	Mon, 15 Apr 2024 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plbaAq1k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D9080055
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198461; cv=none; b=uFuDAOzQbfnzgEmfP/yP5pQ/y4+vA38ny2pJIqkVfuoAvExcqbJq0t7eqlrLtfXePV6zfvHtgpWMM+vsxCLVuOqwtrJQWl3rYW8A58zhY01a9SiQ68qvbHBt4aFqOJDWOg1qph5p+Skf/lGBPFNX9AYNc1QbvUKNLNVdHTdd2ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198461; c=relaxed/simple;
	bh=JmE3OhAUrf+9FlekMukywTyl1WYIiSH0C2eGbw3iFIE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Tkw9mgUezFJ9g1YRgdWC4mNZCv7qntVmkZUrqvmvg4dp7owSnjGc/KCmMbrkIGmIdNLhEceA1gGYCc6AYmd0Pm9W5hBdvsZzvZ/PknYl5vU/HCSXQimFENNYMQIWORysUL1Bwa5rjWKs2hyoIn63mZC2uD/bYlPEZZkOXYFKuNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plbaAq1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388F3C113CC;
	Mon, 15 Apr 2024 16:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713198461;
	bh=JmE3OhAUrf+9FlekMukywTyl1WYIiSH0C2eGbw3iFIE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=plbaAq1kP4Muwf3ilWhWunxX0x4lpWyMvzSBtvzWWUpDJai9UkqBESHSPaC5UAlDa
	 kLWi7TMi2dEKbDsydmQKeRU7PcIGmsiXWQBKhySXYB3tzJxN5ZztzsVlZbnGtT9Kb6
	 PudkQWbxlwCh1ONU7AeFXJV0ObVhhxuZJ1zHuKKwz+QDvzwhLNcNB+yht4BYfhudWD
	 ObktfKubZIVbfKorEzVbawe8erFMF4hsfAtiqKfjf8LGIwJB/ag4mH/QHff11nTgzT
	 YZp0Wy753CpyrzMiHGkf6krD3ll840gt7eyJW6LrEqqS10vhi470gMf0KEGb6ho+O8
	 vy57Lnrx1ozew==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: enable WIPHY_FLAG_DISABLE_WEXT
References: <20240411165645.4071238-1-kvalo@kernel.org>
	<e8618364-e547-41e1-b18f-4cddeafd3371@quicinc.com>
Date: Mon, 15 Apr 2024 19:27:38 +0300
In-Reply-To: <e8618364-e547-41e1-b18f-4cddeafd3371@quicinc.com> (Jeff
	Johnson's message of "Thu, 11 Apr 2024 12:41:48 -0700")
Message-ID: <87h6g2y4jp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 4/11/2024 9:56 AM, Kalle Valo wrote:
>
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>> 
>> ath12k will support Multi-Link Operation (MLO) in the future but not yet. A
>> major change with MLO is that cfg80211 will disable Wireless Extension (WEXT)
>> user space interface. To avoid having inconsistent user experience, first
>> supporting WEXT and later not, disable WEXT already now.
>> 
>> Now ath12k claims that WEXT is not supported:
>> 
>> $ iwconfig wlan0
>> wlan0     no wireless extensions.
>> 
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>> 
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

[...]

> Currently on my version of Ubuntu when I switch to Hotspot mode I'm seeing:
> [   55.189623] warning: `iwconfig' uses wireless extensions which will stop
> working for Wi-Fi 7 hardware; use nl80211

Do you know what entity is running iwconfig? Or was it you running
iwconfig manually?

Please note that this warning is shown only once, all following WEXT
usage (of any process) is not warned. Linus proposed doing a per process
type of warning but we never implemented that, I think we should do
that.

> So are userspace folks aware of the need to move away from iwconfig?

I hope they are but difficult to say. We have been trying for years to
get rid of WEXT but the progress has been really slow. This warning is
another attempt to make everyone aware as with MLO WEXT will not work.

> Is there a Ubuntu / Network Manager fix fir this?

I would hope that Network Manager doesn't use WEXT or especially run the
iwconfig tool. This is why I suspect that you run iwconfig manually.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

