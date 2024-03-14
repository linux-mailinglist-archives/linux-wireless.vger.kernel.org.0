Return-Path: <linux-wireless+bounces-4743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E35787BB80
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 11:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400AB1C20B01
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 10:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BFD57330;
	Thu, 14 Mar 2024 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyFCb2ll"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D891A38FC
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412920; cv=none; b=N8NwQecNIlT9zl+kgVAt84oNIyCk6qR1Lpr5GRBXhnehFlyvnOPJ/s6AGorQZlAWuGTEoePmnnRIqPCUpT/F+wyAmTF9oO+onT+i/XdC2ofQqghU8PrzYoXqyE2HnR6nl5Yq0m50w5mAf0VKbmO5bHGNVztUdlEPGQNsrt4Bpwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412920; c=relaxed/simple;
	bh=cuVVUs2G3LAlRqmAnXkQQqdNI05KbA7IjoUM/eOSIuY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=m4EViwVOzkeLATwEaVoFx5QXI8AeahzBnrg+JoQKjvTfp1FevlvBdqqEMN1iezFpdSSiRb4YKzf6VynSVG7yIYuYHmUbJuibm/fe8nXiN583gc/VcTKd/nSZlMHoJPDtEq69uLA2DvJhfpguQ6nHcJ6xC28TmwFPRFCnO9ENZ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyFCb2ll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A04FC433C7;
	Thu, 14 Mar 2024 10:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710412919;
	bh=cuVVUs2G3LAlRqmAnXkQQqdNI05KbA7IjoUM/eOSIuY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=cyFCb2lls/JGqJNJ1bk5Dcr1EIj2rK0l4F83KdkDx+8B6uytHW3Xp90P2wXXqqon3
	 440QO4icr4YCCwEXEJm8IH3q4/q/45CPZnAYpycOI+UyFpr+QibThBf14EH7ErkYwB
	 rRy1OFNCF6WmzG279Wj4rcRyKiHxU8WWDy163h3mNEeJeGSgXFvVj5MopkeI0pmHG5
	 096sYvSO5mArVLFDG8QJzTX5aqFM0+Y+J2w74KLDtnznhGaeCfKSrkwQBcfJgwIhxQ
	 u8iWJHYZ+shi+9HecjpjYI4bDL0KIP1Nk834qK9RKanmdR/OYJgKZ+j/k43rXANt77
	 mVMN7KRwWarVA==
From: Kalle Valo <kvalo@kernel.org>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4] wifi: ath12k: report tx bitrate for iw dev xxx
 station dump
References: <20240219095802.1147-1-quic_lingbok@quicinc.com>
	<87y1b7jkxu.fsf@kernel.org>
	<6f39eb1c-97f7-4029-a5f2-5ab36ff0f0a6@quicinc.com>
	<877ciq9h3e.fsf@kernel.org>
	<4e67118d-80e4-422e-aa39-73b891ee6042@quicinc.com>
	<87a5nkkfs1.fsf@kernel.org>
	<fd8384dc-b35f-477e-aac3-b7a5f49ce712@quicinc.com>
Date: Thu, 14 Mar 2024 12:41:57 +0200
In-Reply-To: <fd8384dc-b35f-477e-aac3-b7a5f49ce712@quicinc.com> (Lingbo Kong's
	message of "Thu, 14 Mar 2024 17:27:22 +0800")
Message-ID: <87ttl9drii.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lingbo Kong <quic_lingbok@quicinc.com> writes:

> On 2024/2/28 19:08, Kalle Valo wrote:
>> Lingbo Kong <quic_lingbok@quicinc.com> writes:
>> 
>>> On 2024/2/27 21:23, Kalle Valo wrote:
>>>> Lingbo Kong <quic_lingbok@quicinc.com> writes:
>>>>
>>>>> On 2024/2/26 23:37, Kalle Valo wrote:
>>>>>> Please use full englist words like transmit instead of tx. Also the
>>>>>> title could be simplified to:
>>>>>> wifi: ath12k: report station mode transmit rate to user space
>>>>>> Here I assumed this only works in station mode. Or does this also
>>>>>> support AP and P2P mode? The commit message should explain that.
>>>>>>
>>>>>
>>>>> Ok, i will apply it in next version. Thanks for pointing out.
>>>> After rereading my comments maybe keep the title simple like:
>>>>     wifi: ath12k: report station mode transmit rate
>>>> But it would be good to clarify in the commit message what modes
>>>> this is
>>>> supported. And what hardware families support this.
>>>
>>> Hi kalle, Could you please offer your opinion on this commit message?
>>>
>>> wifi: ath12k: report station mode transmit rate
>>>
>>> Currently, the transmit rate of "iw dev xxx station dump" command
>>> always show an invalid value.
>>>
>>> To address this issue, ath12k parse the info of transmit complete
>>> report from firmware and indicate the transmit rate to mac80211.
>>>
>>> This patch only applies to the WCN7850's station mode.
>>>
>>> After that, "iw dev xxx station dump" show the correct transmit rate.
>>> Such as:
>>> tx bitrate: 104.0 MBit/s MCS 13
>>> tx bitrate: 144.4 MBit/s MCS 15 short GI tx bitrate: 626.9 MBit/s
>>> 80MHz HE-MCS 6 HE-NSS 2 HE-GI 0 HE-DCM 0 tx bitrate: 1921.5 MBit/s
>>> 160MHz HE-MCS 9 HE-NSS 2 HE-GI 0 HE-DCM 0
>> Looks good, except for readability I would add an empty line after
>> "Such
>> as:".
>> I noticed that the signal patch depends on this patchset:
>> https://patchwork.kernel.org/project/linux-wireless/patch/20240219111417.1185-1-quic_lingbok@quicinc.com/
>> In that you should submit both patchses in same patchset. But please
>> wait until I have reviewed the signal strength patch.
>
> Hi, kalle,
>
> Would you mind if I kindly inquire whether you might have forgotten to
> review "wifi: ath12k: report signal for iw dev xxx station dump"
> patch?

I don't rely on my memory and instead use patchwork for that:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#checking_state_of_patches_from_patchwork

And the patch you are referring is in state 'New':

https://patchwork.kernel.org/project/linux-wireless/patch/20240219111417.1185-1-quic_lingbok@quicinc.com/

So it is in the queue, please just wait patiently.

And as general comment to all Qualcomm engineers (not just Lingbo): if
you want patches reviewed and applied faster then help Jeff and me!
Review other patches, test our drivers and stack, investigate bug
reports, make sure all firmware releases are uploaded etc. There is so
much to do. Don't just throw patches over the wall and disappear.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

