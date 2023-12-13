Return-Path: <linux-wireless+bounces-548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA832808B01
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 15:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71308282E43
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 14:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164494185B;
	Thu,  7 Dec 2023 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2JCN7X/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5F240C07
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 14:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1133C433C7;
	Thu,  7 Dec 2023 14:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701960566;
	bh=IcBWMYQlbFYpDxnAIk+Jk20qDDu9aXKuMpFk3AIunOw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=W2JCN7X/eXCeAegQm6DdAqck67UHemwbx5CjDZq96bBLybUHuSknz5K6rHOKkYdLl
	 zc6lcsgLDJtmhUKLl2pEQrDSJwpGXqe5rEz5FZB2h134EZ2Y06UvklhrtN4XmkfAxk
	 G4kUAd61MDzBjK92XPhdIOOd7wVKjPmySRMo0S09IQDfXxvw4IeTByl68Er78s2kOg
	 T9PvQflC1CwgqIzMgk8M35zZDrRRJcOTLo8tJGNmSCGlonDYaenpnm1ct79ZAoESMx
	 MQhv2TRfZWZncrkdA7TZpQxa9vmoMk3JTd0bppGiJenwgnbxQu9ykRMp5/nC9t8fdO
	 NUqmtRY5AOZzg==
From: Kalle Valo <kvalo@kernel.org>
To: Yongqin Liu <yongqin.liu@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>,  ath10k@lists.infradead.org,
  Abhishek Kumar <kuabhs@chromium.org>,  Youghandhar Chintala
 <quic_youghand@quicinc.com>,  linux-kernel@vger.kernel.org,
  linux-wireless@vger.kernel.org,  Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>,  Sumit Semwal
 <sumit.semwal@linaro.org>,  John Stultz <jstultz@google.com>,  Viktor
 Martensson <vmartensson@google.com>,  Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH] ath10k: Don't touch the CE interrupt registers after
 power up
References: <20230630151842.1.If764ede23c4e09a43a842771c2ddf99608f25f8e@changeid>
	<CAMSo37XcwAn9znSQ8202LUTdBKLDz94QJ9i43aXya5LHs-4GiQ@mail.gmail.com>
Date: Thu, 07 Dec 2023 16:49:21 +0200
In-Reply-To: <CAMSo37XcwAn9znSQ8202LUTdBKLDz94QJ9i43aXya5LHs-4GiQ@mail.gmail.com>
	(Yongqin Liu's message of "Thu, 7 Dec 2023 22:29:03 +0800")
Message-ID: <87wmtqnk3y.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yongqin Liu <yongqin.liu@linaro.org> writes:

> On Sat, 1 Jul 2023 at 06:19, Douglas Anderson <dianders@chromium.org> wrote:
>>
>> As talked about in commit d66d24ac300c ("ath10k: Keep track of which
>> interrupts fired, don't poll them"), if we access the copy engine
>> register at a bad time then ath10k can go boom. However, it's not
>> necessarily easy to know when it's safe to access them.
>>
>> The ChromeOS test labs saw a crash that looked like this at
>> shutdown/reboot time (on a chromeos-5.15 kernel, but likely the
>> problem could also reproduce upstream):
>>
>> Internal error: synchronous external abort: 96000010 [#1] PREEMPT SMP
>> ...
>> CPU: 4 PID: 6168 Comm: reboot Not tainted
>> 5.15.111-lockdep-19350-g1d624fe6758f #1
>> 010b9b233ab055c27c6dc88efb0be2f4e9e86f51
>> Hardware name: Google Kingoftown (DT)
>> ...
>> pc : ath10k_snoc_read32+0x50/0x74 [ath10k_snoc]
>> lr : ath10k_snoc_read32+0x24/0x74 [ath10k_snoc]
>> ...
>> Call trace:
>> ath10k_snoc_read32+0x50/0x74 [ath10k_snoc ...]
>> ath10k_ce_disable_interrupt+0x190/0x65c [ath10k_core ...]
>> ath10k_ce_disable_interrupts+0x8c/0x120 [ath10k_core ...]
>> ath10k_snoc_hif_stop+0x78/0x660 [ath10k_snoc ...]
>> ath10k_core_stop+0x13c/0x1ec [ath10k_core ...]
>> ath10k_halt+0x398/0x5b0 [ath10k_core ...]
>> ath10k_stop+0xfc/0x1a8 [ath10k_core ...]
>> drv_stop+0x148/0x6b4 [mac80211 ...]
>> ieee80211_stop_device+0x70/0x80 [mac80211 ...]
>> ieee80211_do_stop+0x10d8/0x15b0 [mac80211 ...]
>> ieee80211_stop+0x144/0x1a0 [mac80211 ...]
>> __dev_close_many+0x1e8/0x2c0
>> dev_close_many+0x198/0x33c
>> dev_close+0x140/0x210
>> cfg80211_shutdown_all_interfaces+0xc8/0x1e0 [cfg80211 ...]
>> ieee80211_remove_interfaces+0x118/0x5c4 [mac80211 ...]
>> ieee80211_unregister_hw+0x64/0x1f4 [mac80211 ...]
>> ath10k_mac_unregister+0x4c/0xf0 [ath10k_core ...]
>> ath10k_core_unregister+0x80/0xb0 [ath10k_core ...]
>> ath10k_snoc_free_resources+0xb8/0x1ec [ath10k_snoc ...]
>> ath10k_snoc_shutdown+0x98/0xd0 [ath10k_snoc ...]
>> platform_shutdown+0x7c/0xa0
>> device_shutdown+0x3e0/0x58c
>> kernel_restart_prepare+0x68/0xa0
>> kernel_restart+0x28/0x7c
>>
>> Though there's no known way to reproduce the problem, it makes sense
>> that it would be the same issue where we're trying to access copy
>> engine registers when it's not allowed.
>>
>> Let's fix this by changing how we "disable" the interrupts. Instead of
>> tweaking the copy engine registers we'll just use disable_irq() and
>> enable_irq(). Then we'll configure the interrupts once at power up
>> time.
>>
>> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>
> Recently during our Android build test on the Dragonboard 845c board,
> with the Android Common Kernel android11-5.4-lts and android12-5.4-lts branches,
>
> we found there are some ufshcd related changes printed,
> and the serial console gets stuck, no response for input,
> and the Android boot is stuck at the animation window.
>
> The problem is reported here
>     https://issuetracker.google.com/issues/314366682
> You could check there for more log details.
>
> And with some bisection, I found it's related to this commit,
> when I revert this commit, the problem is gone.
>
> So replied here, not sure if you have any idea about it,
> or any suggestions on what we should do next to resolve the problem?

FWIW we don't support Android kernels, only kernel.org releases.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

