Return-Path: <linux-wireless+bounces-6986-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4CE8B5774
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 14:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B091F20F1A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 12:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D8853383;
	Mon, 29 Apr 2024 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aD4g/j6n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A825338D
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392519; cv=none; b=S82WW/KtDVJh++nAFOsaZkrexStStRUn95uXsXmuIZo+mYW14Epx/pu60/+mad8ZPyHiZRjY1luxFpVwqHZ38Tyj78YLkY4npGowdRMv0jI/Q7XTqQx912WVd3wYqz4ENVYpA0q8CO95uTOMTJgs4JTsO1v4M4PFyZ8bYO2uAZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392519; c=relaxed/simple;
	bh=hh6xj8ii1wDcrGKus6DtblItp0E3LrAfUVATj9Jdzm8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DJHABUOfP+HrvcNAh6ukjteZp8+FrfNYoZmsu1rJ/OkAuwsEr6OFqpeqsEP5/WKR6RftmIPxENqX5zs+pwOEfY0wMlwtZHHaz3fucPiq0+qs/KnJEPHWw954VsBxgYHspPCk2cySb5fpNPIn/Z7gEPlt03qFDNxumnKG60TNOjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aD4g/j6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A27DC113CD;
	Mon, 29 Apr 2024 12:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714392518;
	bh=hh6xj8ii1wDcrGKus6DtblItp0E3LrAfUVATj9Jdzm8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=aD4g/j6nXYrnakOEglCmYtL+66dpVhLJFzIFPol4DVictXYOxxfzP/YSK9t/6Cj6u
	 y4FWm+ySQx0yow74y1+uF26tfubAEzPYwRFA3mSjvrNrG4vF/bcohEsalCZB4NI9g2
	 UXIVJEGCks4yIrMK8hPPQwmHL9KbSQgaVYyXbfEHNWpp2JAiTGe4ZQOh3muoX9rqS5
	 58QgfmQGY6ekH2Xqd51dRcAQkDjGuaggwHvnrwzScynMam2YvASkiMfpyiHODMv/R9
	 t2qeVR8Zjq5Aw894FaRaCLso/rjukBTwEce/qRaYAxWUkHZULL3ZkegCVDQgCSbVa7
	 yFff6t9SXyy6Q==
From: Kalle Valo <kvalo@kernel.org>
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>,  "Muna Sinada"
 <quic_msinada@quicinc.com>
Subject: Re: [PATCH v3 07/10] wifi: ath12k: add support for setting fixed HE
 rate/GI/LTF
References: <20240424201959.935-1-quic_pradeepc@quicinc.com>
	<20240424201959.935-8-quic_pradeepc@quicinc.com>
	<72bc6772-8bf7-427d-8f03-01e8dbf30d0c@quicinc.com>
	<87y190fulv.fsf@kernel.org>
	<198e317f-a849-4fe2-8080-3d1834d07481@quicinc.com>
Date: Mon, 29 Apr 2024 15:08:35 +0300
In-Reply-To: <198e317f-a849-4fe2-8080-3d1834d07481@quicinc.com> (Pradeep Kumar
	Chitrapu's message of "Fri, 26 Apr 2024 16:42:22 -0700")
Message-ID: <87sez4fk1o.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com> writes:

> On 4/26/2024 12:31 AM, Kalle Valo wrote:
>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>> 
>>> On 4/24/2024 1:19 PM, Pradeep Kumar Chitrapu wrote:
>>>> Add support to set fixed HE rate/GI/LTF values using nl80211.
>>>> Reuse parts of the existing code path already used for HT/VHT
>>>> to implement the new helpers symmetrically, similar to how
>>>> HT/VHT is handled.
>>>>
>>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>>>
>>>> Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
>>>> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
>>>> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
>>>> ---
>>>
>>> [...]
>>>
>>>> @@ -7753,7 +8034,20 @@ ath12k_mac_bitrate_mask_get_single_nss(struct ath12k *ar,
>>>>   			return false;
>>>>   	}
>>>>   -	if (ht_nss_mask != vht_nss_mask)
>>>> +	he_mcs_map = le16_to_cpu(ath12k_mac_get_tx_mcs_map(&sband->iftype_data->he_cap));
>>>
>>> drivers/net/wireless/ath/ath12k/mac.c:8041:22: warning: incorrect type in argument 1 (different address spaces)
>>> drivers/net/wireless/ath/ath12k/mac.c:8041:22:    expected struct ieee80211_sta_he_cap const *he_cap
>>> drivers/net/wireless/ath/ath12k/mac.c:8041:22:    got struct ieee80211_sta_he_cap const [noderef] __iftype_data *
>> ALWAYS run ath12k-check, we wrote the tool for a reason. Skipping
>> these
>> tests is disrespect for maintainers' time and a great way to get your
>> patches to the bottom of the queue.
>> 
> Hi Kalle
>
> I did run ath12k-check but I don't see these errors. Trying to see if
> this is due to version differences. will update further once I have
> more information on this.
>
> This is version I ran:
> qca-swiss-army-knife/tools/scripts/ath12k/ath12k-check --version
> ath12k-check (md5sum cb8a85242f2ec7343f6f94af9fa5ebb2)
>
> python:         3.6.9 (default, Mar 10 2023, 16:46:00)
> [GCC 8.4.0]
> host gcc:       gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
> config cc:      gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
> sparse:         v0.6.4
> checkpatch.pl:  Version: 0.32 (md5sum 12ea394e9bf27280f30a684ff937cc57)
> gtags:          gtags (GNU GLOBAL) 6.6.2

Your sparse is too old, you need to get the latest from git:

https://docs.kernel.org/dev-tools/sparse.html#getting-sparse

Also your GCC is really old, I strongly recommend to use GCC 13.2. You
can get it here:

https://mirrors.edge.kernel.org/pub/tools/crosstool/

Why on earth are you using Ubuntu 18.04? It's end of life was a year
ago.

And please also update ath12k-check. This is what I have:

$ ath12k-check --version
ath12k-check (md5sum c5567fc8aaede613275e8cafea6ed7cd)

python:         3.11.2 (main, Mar 13 2023, 12:18:29) [GCC 12.2.0]
host gcc:       gcc (Debian 12.2.0-14) 12.2.0
config cc:      x86_64-linux-gcc (GCC) 13.2.0
sparse:         v0.6.4-39-gce1a6720f69e
checkpatch.pl:  Version: 0.32 (md5sum 77c655474ed7622c0077caf2f0d7c440)
gtags:          gtags (Global) 6.6.9

> I see some notes like below this in all files:
> drivers/net/wireless/ath/ath12k/mac.c: note: in included file (through
> include/linux/bitops.h, include/linux/kernel.h,
> include/net/mac80211.h):
> drivers/net/wireless/ath/ath12k/mac.c: note: in included file (through
> include/linux/bitops.h, include/linux/kernel.h,
> include/net/mac80211.h):

Jeff and me are extra careful that there are no warnings in ath12k, in
fact in wireless-next the whole wireless subsystem has no sparse
warnings. So if you ever see warnings please report them to maintainers
ASAP.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

