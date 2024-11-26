Return-Path: <linux-wireless+bounces-15713-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E329D97D1
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 13:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE423286170
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 12:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B541D45EA;
	Tue, 26 Nov 2024 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+2KvSVg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45151D514C;
	Tue, 26 Nov 2024 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625981; cv=none; b=kYAdtboxSWFnzcAvaRcXRYvNHZR4FGt6J+R76J8oa5y5gccrtMjGbMpNTBRKQvBo1COzzBZkc0oE0nUkZ3ym52IbbEjy5yD1ux+seXKJi57V/ooeXnGeNblKK08axbeV4qo771WkqnBTamRwNvioXt0eGbM4MXVYdkgV+LplY04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625981; c=relaxed/simple;
	bh=gxiuB8hExTw7LLDjIePZKOvEBBraCRY4tr26I2kdQpw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=vA8OH7gzcjCOnZO+A4AOvycKgwGZcGSUQoInWa4oISljsFavU5KcgyyN4T1lwWWhu6yXx2vdr6nBojB5WvOsteDzOb8Rg8MsGnnjHFTXqHA+nHsJviN6Bl6v60ZMdOwDnzsr5JoLXGnzbnlECimPXcf35UmCVeBc2kGyW28+hBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+2KvSVg; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d41176505fso51420166d6.2;
        Tue, 26 Nov 2024 04:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732625979; x=1733230779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tmuzQHP8M/5vwjzhJEB1na265cXygkcCdDHq3RqQfr4=;
        b=P+2KvSVglFFB87n7YmkH7ekKQuC83oiojX3RNwen/YLS+I05f+JgmOgYOjWgCAYC9J
         cKVQmjzlVMKc/M3VJCArKMOFuo2SNIbgtTsAra0x2RVEqoZxE446jrcLdflbT+4b/nBJ
         nkJ2kcVMRoIgqPj0EEAvgze75+UHhSJE6hR0MoWoRL69mjtKDyv4rNRFa4pHdGsW4t2D
         4xJUStySTwWYvenmr4f7x4AzBcK2VWxf3HfHwTyMFAZre+4XpBmxabQ4AbeGtSvMCqZQ
         S7UNZ5y07G+L1/FOvBOCcm+EBh2pcEmVUPr1o82TVUhRGqPLJQGmsVoSl7jmpWVHFSX5
         S+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732625979; x=1733230779;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmuzQHP8M/5vwjzhJEB1na265cXygkcCdDHq3RqQfr4=;
        b=tvEJF7taMsAsthxSfaWiZzW/ZkcX20OKGx5T24Td1otNGAV9tJFVH/0wLD1TBuWrM9
         7UDaPLFp82KwYq8sztebKaXIQ1/KojD4AIjvbBSIRmyVYmsZwqKlwreqZLYo8ZaK/wvm
         wMZ2MOBGrztbgzZNQTSe9eftd6b/UEFBMtUv6RSRwMHf+kRYdNm7l4UR3FOKBkdviiV7
         a7fg6TEtdQIsozzkFvXlUuhRiY6DDrpBFvFPpuwSXTR2eVJ/sL53Lj2QZa9gQKOrwTa2
         VpfdpA2pk6Uwrr9YSg2v/AcwZ6nu0Zbz9dvvFg8gH5eNOwgzQ3pTRk45V6eRq0M/OqxV
         0yGw==
X-Forwarded-Encrypted: i=1; AJvYcCU5Pzaz1LStraaDkapMPGhajjWo5tT2mgA36WNxm7b6YhMDdRX7q33bdpD2WY1ihuPPxSsA+l/VCxDkeJoNbPs=@vger.kernel.org, AJvYcCWiOiSU5Y9hb4PBBkjnuO0NlHI72S+eq8QG49+ZN/BdfS2AtyQ7LW1LuGf0N/sMesaQykMKYsiHpnLi9U8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt1qBRAGHx51FLQepLlNgcmbwrE4Ed2MCT69D7vK10RT/M/5aH
	WX8DAVjk0LuQhhMe+zoCCukuoW+3bwWMaX7UrjmeSn+HnyB4XItl
X-Gm-Gg: ASbGncs+cCYyAIonmxOw3Q5ch3KB1lpLfMt8WcSgLSobW8hhYvvstau06UUn34I8EA0
	Zbfg7loSw6VTyUWWWutkn8wYYmO8kAMkf/qI1LiXS/s24n7kibu6Lsh+21nMo0KMxKMlgfXT3Wb
	Gw8WpxZSikRcAzDyE3oxFTJvIC3qgaB2HAYDT/rsSmMpiPU2eIcsQsIdMqXBfsWwibti7xIsUsB
	Y2XHqp9/v1FbG2L1OgrKbZ7Pz6yvTbuhu3UCSAMT6nfgxGsr7veIQ==
X-Google-Smtp-Source: AGHT+IFyie6MMV1m5Z0np/9hEs9i8B3quTAjMwTDJzLJDJ2GdA7uHhlYgt7uUdvINSCAXbnRqtmhow==
X-Received: by 2002:a05:6214:2a4c:b0:6d4:1a99:427f with SMTP id 6a1803df08f44-6d45136853cmr296619076d6.49.1732625978632;
        Tue, 26 Nov 2024 04:59:38 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451b6670dsm54649206d6.124.2024.11.26.04.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 04:59:38 -0800 (PST)
Message-ID: <8c2f274b-cf05-4fad-b9d6-fa9de1363d42@gmail.com>
Date: Tue, 26 Nov 2024 04:59:35 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3 0/2] Improve ath10k flush queue mechanism
From: James Prestwood <prestwoj@gmail.com>
To: Remi Pommarel <repk@triplefau.lt>, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Cedric Veilleux <veilleux.cedric@gmail.com>,
 Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
References: <cover.1732293922.git.repk@triplefau.lt>
 <20215f63-e2e6-4f9a-bbbe-d7535c5ce9d2@gmail.com>
Content-Language: en-US
In-Reply-To: <20215f63-e2e6-4f9a-bbbe-d7535c5ce9d2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/26/24 4:57 AM, James Prestwood wrote:
> Hi Remi,
>
> On 11/22/24 8:48 AM, Remi Pommarel wrote:
>> It has been reported [0] that a 3-4 seconds (actually up to 5 sec) of
>> radio silence could be observed followed by the error below on ath10k
>> devices:
>>
>>   ath10k_pci 0000:04:00.0: failed to flush transmit queue (skip 0 
>> ar-state 1): 0
>>
>> This is due to how the TX queues are flushed in ath10k. When a STA is
>> removed, mac80211 need to flush queues [1], but because ath10k does not
>> have a lightweight .flush_sta operation, ieee80211_flush_queues() is
>> called instead effectively blocking the whole queue during the drain
>> causing this radio silence. Also because ath10k_flush() waits for all
>> queued to be emptied, not only the flushed ones it could more easily
>> take up to 5 seconds to finish making the whole situation worst.
>>
>> The first patch of this series adds a .flush_sta operation to flush only
>> specific STA traffic avoiding the need to stop whole queues and should
>> be enough in itself to fix the reported issue.
>>
>> The second patch of this series is a proposal to improve ath10k_flush so
>> that it will be less likely to timeout waiting for non related queues to
>> drain.
>>
>> The abose kernel warning could still be observed (e.g. flushing a dead
>> STA) but should be now harmless.
>>
>> [0]: 
>> https://lore.kernel.org/all/CA+Xfe4FjUmzM5mvPxGbpJsF3SvSdE5_wgxvgFJ0bsdrKODVXCQ@mail.gmail.com/
>> [1]: commit 0b75a1b1e42e ("wifi: mac80211: flush queues on STA removal")
>
> I saw in the original report that it indicated it was only for AP mode 
> but after seeing this and checking some of our clients I saw that this 
> is also happening in station mode too. I only have clients on 6.2 and 
> 6.8. I can confirm its not occurring on 6.2, but is on 6.8. I also 
> tried your set of patches but did not notice any behavior difference 
> with or without them. When it happens, its always just after a roam 
> scan, ~4 seconds go by and we get the failure followed by a 
> "Connection to AP <mac> lost". Oddly the MAC address is all zeros.
>
> Nov 25 09:09:50 iwd[16256]: src/station.c:station_start_roam() Using 
> cached neighbor report for roam
> Nov 25 09:09:54 kernel: ath10k_pci 0000:02:00.0: failed to flush 
> transmit queue (skip 0 ar-state 1): 0
> Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_mlme_notify() MLME 
> notification Del Station(20)
> Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_link_notify() event 16 
> on ifindex 7
> Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_mlme_notify() MLME 
> notification Deauthenticate(39)
> Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_deauthenticate_event()
> Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_mlme_notify() MLME 
> notification Disconnect(48)
> Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_disconnect_event()
> Nov 25 09:09:54 iwd[16256]: Received Deauthentication event, reason: 
> 4, from_ap: false
> Nov 25 09:09:54 kernel: wlan0: Connection to AP 00:00:00:00:00:00 lost
>
> Other times, the above logs are preceded by this:
>
> Nov 26 00:25:25 kernel: ath10k_pci 0000:02:00.0: failed to flush sta 
> txq (sta ca:55:b8:7a:91:4b skip 0 ar-state 1): 0
>
> Note, the above logs are with your patches applied. Maybe this is a 
> separate issue? Or do you think its related?

Forgot to mention, this is on the QCA6174 hw 3.2

firmware ver WLAN.RM.4.4.1-00288- api 6 features wowlan,ignore-otp,mfp 
crc32 bf907c7c

>
> Thanks,
>
> James
>
>>
>> V3:
>>    - Initialize empty to true to fix smatch error
>>
>> V2:
>>    - Add Closes tag
>>    - Use atomic instead of spinlock for per sta pending frame counter
>>    - Call ath10k_htt_tx_sta_dec_pending within rcu
>>    - Rename pending_per_queue[] to num_pending_per_queue[]
>>
>> Remi Pommarel (2):
>>    wifi: ath10k: Implement ieee80211 flush_sta callback
>>    wifi: ath10k: Flush only requested txq in ath10k_flush()
>>
>>   drivers/net/wireless/ath/ath10k/core.h   |  2 +
>>   drivers/net/wireless/ath/ath10k/htt.h    | 11 +++-
>>   drivers/net/wireless/ath/ath10k/htt_tx.c | 49 +++++++++++++++-
>>   drivers/net/wireless/ath/ath10k/mac.c    | 75 ++++++++++++++++++++----
>>   drivers/net/wireless/ath/ath10k/txrx.c   | 11 ++--
>>   5 files changed, 127 insertions(+), 21 deletions(-)
>>

