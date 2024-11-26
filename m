Return-Path: <linux-wireless+bounces-15712-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9BE9D97CE
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 13:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B1FCB277E2
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 12:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E2C1D416B;
	Tue, 26 Nov 2024 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUyhUpSR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FE41D4169;
	Tue, 26 Nov 2024 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625863; cv=none; b=bxUg1TcS2Ye/BPtX22bk2JK99METwWUtpMUpteDvsdLqkJSTt4bn4urgxcAX8NJUshNf4SX8uMYdoPdqo7B223qkidAcz3oHsz+MOlQ214EgG+VYkdMr0CrVQeQTlzUKYYBPaW1HeHtnwI5p2KZ8boGWcQqF1sFNDNCjh7TfONA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625863; c=relaxed/simple;
	bh=pAXvbAY21IjprYSWZVB5ThcCCa74QSWQQFIKi5caw4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oupy9aytY1Z9EQwHAMl32DVmOZ+sKDiYk8b7fN4bvWXxvlGtloPyEVYzl7F5CSS7mtn/jgWe5NS534oBFThyL6QLbGp0NPpuHC+YEejGs8XDyD9ntsTJCgyXwbufn05Cyd8fGqZ/eniLDSOmbO6DpThgu5UkDuiUJhqZhNaBbLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUyhUpSR; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d40ae72d35so38100346d6.1;
        Tue, 26 Nov 2024 04:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732625860; x=1733230660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kPMLzMmK0KKzaO0NVovKhOpAnvw6uWElGaIczBWn2T0=;
        b=fUyhUpSRWCJbEmpk/f5hx/0MSSZWuCc3adItJWi+Qnd/TC4R88RavSfDQYASEXQcCX
         Mf5kSs1F1cYMKxjHoq5ZfclGnf8rydyA7mohTmvcUj2Im8uAKhKdpEUOxKMPPvqyF9nb
         ILRXIlBSX52h8edM4zg4Bh0EIhzd0MvgLWXv5Od+9q0xlrezDgkSmxH49N91IC5/sO71
         u+IxoPluYMsyyfGVD/FzkjHSQJx7jLoqTaBWDMl6g5OzpcFKA2t47PicVO3ixuGXcB4n
         fsJnBZWzgAkv+BO0npBhJ/fsxlH8k9Ky2MqT7ESf2Zfb6k31D+s/GoyVEMHelA283SoG
         EKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732625860; x=1733230660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kPMLzMmK0KKzaO0NVovKhOpAnvw6uWElGaIczBWn2T0=;
        b=TCiU+isjf8o6ph2DfKDFWTIZyfNZ/utHu/9cmqD37aIvw9Gz0ovz25U33wR0wdjDPp
         p4o+vJ5gBTGuVDVavzbilU/xSQlTHm8fbDpglfbX79NarXSLW2AR6bgPlwEv0pE6umGS
         NgLWIcf4Jx3GecWWYWKFZrVNGWDUSGKlAKKP5QTFilOTTBnPhiihWf8GriqTjFUtgHWd
         XNABDIUuKczWVoF6E78+3OWgyxl9wArklyjPOzxxlfKujLvELwxELU6GPjI/2W+WpV7L
         F/c5ChTuacgh2aHh7S1HZxl9LDiW0vNc2AVfYYgtIpAk2LTmMYHD7qy0Ea02SXz1D8Qj
         9tlg==
X-Forwarded-Encrypted: i=1; AJvYcCUEuYR2nSZwzIbgoZl/ktkhjtJzWkvYqNmPsKg6IqodDPV5L+UeHivpDZ7J21CqZUHZhBz+r4+qt3lcXrQ=@vger.kernel.org, AJvYcCVzLZmfu4Nx1ejvYFalpbHif05e1NTe7pcSkB8byd4ui2fjzW/fbAoF/x+1QLx0hB00LbctIHWnjf7dUOWxXkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUpsgBNWxo4ptRV/mn6waoP8egXvEclOp5nS80XpLU4VF52CTr
	RN95qNJGlPI8Ld+OcHZnY+VMK01KCMX7EOCOedlKlt0fgIi3V/Ku
X-Gm-Gg: ASbGnctQZ3pCjIwXhBZuwyUDOnXAZUkGYpl8K5ojink6u6uiDMlnJjcEOD3au1StBBS
	sgbFIKzoAcgucf1eqnU2L0lbiJIdrbMtw0trPBh/H/hnOBv8LItKPyOoBtW7fnGCOz+YLmLaKSi
	As0CgOWnms/7v5P7DmeEtxsRC6lc5hqJCOGJeWf7ITfqxEDLyowwDlYv6wpFX3ZwD8ogdnAVvot
	LRzXN+km8CZ13DQcFHS/exkvnMnmQIs5MGAJDmuSTY0o+2WTNBlCQ==
X-Google-Smtp-Source: AGHT+IFnP2Gi8gvg7R66MTjJ+gzk2OF2AsbQsoaxzJZu2XBdwQXekD9jcmse+lTjI945O7/0K3D1Mw==
X-Received: by 2002:ad4:5fca:0:b0:6d4:12af:be77 with SMTP id 6a1803df08f44-6d451345773mr282199186d6.38.1732625860511;
        Tue, 26 Nov 2024 04:57:40 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451b23e25sm54289396d6.89.2024.11.26.04.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 04:57:40 -0800 (PST)
Message-ID: <20215f63-e2e6-4f9a-bbbe-d7535c5ce9d2@gmail.com>
Date: Tue, 26 Nov 2024 04:57:36 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3 0/2] Improve ath10k flush queue mechanism
To: Remi Pommarel <repk@triplefau.lt>, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Cedric Veilleux <veilleux.cedric@gmail.com>,
 Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
References: <cover.1732293922.git.repk@triplefau.lt>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <cover.1732293922.git.repk@triplefau.lt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Remi,

On 11/22/24 8:48 AM, Remi Pommarel wrote:
> It has been reported [0] that a 3-4 seconds (actually up to 5 sec) of
> radio silence could be observed followed by the error below on ath10k
> devices:
>
>   ath10k_pci 0000:04:00.0: failed to flush transmit queue (skip 0 ar-state 1): 0
>
> This is due to how the TX queues are flushed in ath10k. When a STA is
> removed, mac80211 need to flush queues [1], but because ath10k does not
> have a lightweight .flush_sta operation, ieee80211_flush_queues() is
> called instead effectively blocking the whole queue during the drain
> causing this radio silence. Also because ath10k_flush() waits for all
> queued to be emptied, not only the flushed ones it could more easily
> take up to 5 seconds to finish making the whole situation worst.
>
> The first patch of this series adds a .flush_sta operation to flush only
> specific STA traffic avoiding the need to stop whole queues and should
> be enough in itself to fix the reported issue.
>
> The second patch of this series is a proposal to improve ath10k_flush so
> that it will be less likely to timeout waiting for non related queues to
> drain.
>
> The abose kernel warning could still be observed (e.g. flushing a dead
> STA) but should be now harmless.
>
> [0]: https://lore.kernel.org/all/CA+Xfe4FjUmzM5mvPxGbpJsF3SvSdE5_wgxvgFJ0bsdrKODVXCQ@mail.gmail.com/
> [1]: commit 0b75a1b1e42e ("wifi: mac80211: flush queues on STA removal")

I saw in the original report that it indicated it was only for AP mode 
but after seeing this and checking some of our clients I saw that this 
is also happening in station mode too. I only have clients on 6.2 and 
6.8. I can confirm its not occurring on 6.2, but is on 6.8. I also tried 
your set of patches but did not notice any behavior difference with or 
without them. When it happens, its always just after a roam scan, ~4 
seconds go by and we get the failure followed by a "Connection to AP 
<mac> lost". Oddly the MAC address is all zeros.

Nov 25 09:09:50 iwd[16256]: src/station.c:station_start_roam() Using 
cached neighbor report for roam
Nov 25 09:09:54 kernel: ath10k_pci 0000:02:00.0: failed to flush 
transmit queue (skip 0 ar-state 1): 0
Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_mlme_notify() MLME 
notification Del Station(20)
Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_link_notify() event 16 
on ifindex 7
Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_mlme_notify() MLME 
notification Deauthenticate(39)
Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_deauthenticate_event()
Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_mlme_notify() MLME 
notification Disconnect(48)
Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_disconnect_event()
Nov 25 09:09:54 iwd[16256]: Received Deauthentication event, reason: 4, 
from_ap: false
Nov 25 09:09:54 kernel: wlan0: Connection to AP 00:00:00:00:00:00 lost

Other times, the above logs are preceded by this:

Nov 26 00:25:25 kernel: ath10k_pci 0000:02:00.0: failed to flush sta txq 
(sta ca:55:b8:7a:91:4b skip 0 ar-state 1): 0

Note, the above logs are with your patches applied. Maybe this is a 
separate issue? Or do you think its related?

Thanks,

James

>
> V3:
>    - Initialize empty to true to fix smatch error
>
> V2:
>    - Add Closes tag
>    - Use atomic instead of spinlock for per sta pending frame counter
>    - Call ath10k_htt_tx_sta_dec_pending within rcu
>    - Rename pending_per_queue[] to num_pending_per_queue[]
>
> Remi Pommarel (2):
>    wifi: ath10k: Implement ieee80211 flush_sta callback
>    wifi: ath10k: Flush only requested txq in ath10k_flush()
>
>   drivers/net/wireless/ath/ath10k/core.h   |  2 +
>   drivers/net/wireless/ath/ath10k/htt.h    | 11 +++-
>   drivers/net/wireless/ath/ath10k/htt_tx.c | 49 +++++++++++++++-
>   drivers/net/wireless/ath/ath10k/mac.c    | 75 ++++++++++++++++++++----
>   drivers/net/wireless/ath/ath10k/txrx.c   | 11 ++--
>   5 files changed, 127 insertions(+), 21 deletions(-)
>

