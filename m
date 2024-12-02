Return-Path: <linux-wireless+bounces-15832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D84D9E0708
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 16:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A02281492
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 15:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53F6204F8F;
	Mon,  2 Dec 2024 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e++C3R6a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319F02040A7;
	Mon,  2 Dec 2024 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153136; cv=none; b=lfCLdLya1rqvArsXog/ubnQK1qUR4RV7TBSB/FnzRFUpwzml5/JqtN8QpJ7ILEQMAXilBB4waHVnlsaafPB7DvdiwVdR8+TPwOiXf2M5XIRAX/RwB0s3W4CyjNrgeaTR80gr/+otTyUlIaU5VsdE4CyZJ97P10i9HremVbOjn70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153136; c=relaxed/simple;
	bh=e6LH6POy9VHR/M1Zp/UBEHqB2KxmevLmG6yooKh2mJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Be7dRl03HxciSysJH0noMpv7uqFnU17N452gnvQ5sBgAvPHZe5Q9Qpb2Hp4FoUL/4+NRuzwHpjVCHBU9Rb3PCVwqeoMkjMaQuEYeMQluXf+76JbYe5nM1EJFFRNj9MWJXMTppY1B28eiTJTsKC9yd2Eur0avKCWeDx3RknzKeXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e++C3R6a; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-215b4681c94so469505ad.0;
        Mon, 02 Dec 2024 07:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733153133; x=1733757933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rpHtEoVQT/+1mheZMHNstVnKoPavKC8kFC2zHFzplvs=;
        b=e++C3R6acdRRbe9Z9WUAko7HPvMhX/Q1YV3shd5NytpNm9hwZoHPK1dCFv5MsTkMKI
         QTW6NLe5HdZ0veJoBzUXxlKMFnDtjjUv+RNzGiyabrs7DyVinBkfc8pdo00Ltxf1Vux4
         3mHuxgzXS+2opIxBkT4CzLxm5rIgYzeGKWI8m+VJVo35u3ndC3cuvUp4tRL9Iad3ypHW
         zQ69FXQgGVixRtGclKNoTSdFQFaoJ+hKGcprdgmCPG4F3P95fsMFQMTN628EFrq7UeR6
         aXDr40QvuMAPTa6fbpLGucaMuK4P8Bx1ixDqrdJQ3GJnCpKxngsNBP7AcQJEy3lviFac
         3s4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153133; x=1733757933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpHtEoVQT/+1mheZMHNstVnKoPavKC8kFC2zHFzplvs=;
        b=XSPK2h2z1Mz3HDdEvBe761gV899kSXUvIeVUk8WXDA6uFPYQntlhlYlfh6ubj5MAO4
         U+ucm/zyK0yXH8ImU29F+WZWWvBDMecwIuk+wHw02bXrSbalnkAxwUzsV1RAEWG+OqIN
         GwT2NPbEwZqs5Yf7C/n3DJgplyuQNPNDjaSaEAVSBLGbLwRCklq4DPh8Og9NDTPTqN6N
         LnE+7j2JVmMVzHCfLy/R9hZhtaWKyHk7LyP0Cq+Qq4fmi/WgTn9FhlG/vrP8bs5aZNC3
         0KWEnvVeYT3e7v83R91q/xHCZtDTsSrAfUeOMLV5FxLVmzA3rT1V45p+JkXgMstJA+Xx
         GikQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEpqdJfz1P5OrKYlACdev50r/K4XQ486Ysuhda5IaDq+Z9Nyrd7/FBxwroHmNNrykPbngwew3KDxqT/AU2K1I=@vger.kernel.org, AJvYcCWMeFKe95uzWzKleLKpb7yesUHzw8SpLVN8e4OuhdFCQwg2ZXFLEXdV3TBvr/ZnbiP6j1y9ZOn8jwInHAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9V9p/V8e4njNtRdI1RhZ69ktTgPk2JC+m5zHGjXcMd7FL9pYE
	TnK1PpIqw/IWvS/cFu5USpKRkOKzbpmPFezPR0AMnz0RVCcjuCiI
X-Gm-Gg: ASbGnctmogn2k+VeW62KC7Qb2LDlnAqUx0LkbCaXcVvzShhopKolSBWXU4jjn1ZGhhU
	FU+aU1BD/6VF0mm0x7uQUp4LrEx9A+FqaaDFn8qaL5nEQRDF/j6/VPUehOF8qmud8vDm+EHQJR7
	Fi1pQy6FWuDtxP+skk1v4/8tdYj6u3uU7A8xVn+NffWRuqIzLvdjN9dsjOIu4vsmSGbMSkpozHf
	U+9OkcTUDPH6vNRtmTCnGq7YD8CjQW7IJXbzQjsjy/Zm3aVO5mynw==
X-Google-Smtp-Source: AGHT+IHs6Zg/q+Mom3d2oxd1f1h8lVQiA/g/pyUTMYgRVSJh39AGgZPkleLdZOm9nAaSqgBUuRv/Ng==
X-Received: by 2002:a17:902:cf4a:b0:215:4a31:47d4 with SMTP id d9443c01a7336-2154a314b2cmr198391635ad.56.1733153133101;
        Mon, 02 Dec 2024 07:25:33 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f25easm78183965ad.27.2024.12.02.07.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 07:25:32 -0800 (PST)
Message-ID: <670b209b-dd5d-4b77-9b21-7cb1e3fc036e@gmail.com>
Date: Mon, 2 Dec 2024 07:25:28 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3 0/2] Improve ath10k flush queue mechanism
To: Remi Pommarel <repk@triplefau.lt>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>,
 Cedric Veilleux <veilleux.cedric@gmail.com>,
 Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
References: <cover.1732293922.git.repk@triplefau.lt>
 <20215f63-e2e6-4f9a-bbbe-d7535c5ce9d2@gmail.com> <Z0nsfoiPOHiKIXvH@pilgrim>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <Z0nsfoiPOHiKIXvH@pilgrim>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Remi,

On 11/29/24 8:31 AM, Remi Pommarel wrote:
> Hi James,
>
> On Tue, Nov 26, 2024 at 04:57:36AM -0800, James Prestwood wrote:
>> Hi Remi,
>>
>> On 11/22/24 8:48 AM, Remi Pommarel wrote:
>>> It has been reported [0] that a 3-4 seconds (actually up to 5 sec) of
>>> radio silence could be observed followed by the error below on ath10k
>>> devices:
>>>
>>>    ath10k_pci 0000:04:00.0: failed to flush transmit queue (skip 0 ar-state 1): 0
>>>
>>> This is due to how the TX queues are flushed in ath10k. When a STA is
>>> removed, mac80211 need to flush queues [1], but because ath10k does not
>>> have a lightweight .flush_sta operation, ieee80211_flush_queues() is
>>> called instead effectively blocking the whole queue during the drain
>>> causing this radio silence. Also because ath10k_flush() waits for all
>>> queued to be emptied, not only the flushed ones it could more easily
>>> take up to 5 seconds to finish making the whole situation worst.
>>>
>>> The first patch of this series adds a .flush_sta operation to flush only
>>> specific STA traffic avoiding the need to stop whole queues and should
>>> be enough in itself to fix the reported issue.
>>>
>>> The second patch of this series is a proposal to improve ath10k_flush so
>>> that it will be less likely to timeout waiting for non related queues to
>>> drain.
>>>
>>> The abose kernel warning could still be observed (e.g. flushing a dead
>>> STA) but should be now harmless.
>>>
>>> [0]: https://lore.kernel.org/all/CA+Xfe4FjUmzM5mvPxGbpJsF3SvSdE5_wgxvgFJ0bsdrKODVXCQ@mail.gmail.com/
>>> [1]: commit 0b75a1b1e42e ("wifi: mac80211: flush queues on STA removal")
>> I saw in the original report that it indicated it was only for AP mode but
>> after seeing this and checking some of our clients I saw that this is also
>> happening in station mode too. I only have clients on 6.2 and 6.8. I can
>> confirm its not occurring on 6.2, but is on 6.8. I also tried your set of
>> patches but did not notice any behavior difference with or without them.
>> When it happens, its always just after a roam scan, ~4 seconds go by and we
>> get the failure followed by a "Connection to AP <mac> lost". Oddly the MAC
>> address is all zeros.
>>
>> Nov 25 09:09:50 iwd[16256]: src/station.c:station_start_roam() Using cached
>> neighbor report for roam
>> Nov 25 09:09:54 kernel: ath10k_pci 0000:02:00.0: failed to flush transmit
>> queue (skip 0 ar-state 1): 0
>> Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_mlme_notify() MLME
>> notification Del Station(20)
>> Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_link_notify() event 16 on
>> ifindex 7
>> Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_mlme_notify() MLME
>> notification Deauthenticate(39)
>> Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_deauthenticate_event()
>> Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_mlme_notify() MLME
>> notification Disconnect(48)
>> Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_disconnect_event()
>> Nov 25 09:09:54 iwd[16256]: Received Deauthentication event, reason: 4,
>> from_ap: false
>> Nov 25 09:09:54 kernel: wlan0: Connection to AP 00:00:00:00:00:00 lost
>>
>> Other times, the above logs are preceded by this:
>>
>> Nov 26 00:25:25 kernel: ath10k_pci 0000:02:00.0: failed to flush sta txq
>> (sta ca:55:b8:7a:91:4b skip 0 ar-state 1): 0
>>
>> Note, the above logs are with your patches applied. Maybe this is a separate
>> issue? Or do you think its related?
> Thanks fot the test. Yes this patchset is here only to fix the issue for
> AP (this caused AP to stall all traffic for every STA connected to it).
> So while this issue is interesting it is not addressed by this patchset.
Thanks for the clarification.
>
> Out of curiosity I tried to reproduce it currently trying to roam an
> ath10k sta back and forth two APs (same SSID/psk, different channels)
> and wasn't able to reproduce with wpa_supplicant, didn't try with iwd
> though. Or maybe the AP the sta is roaming away from has stopped
> responding, in that case I don't know what can be done here as it does
> not seem we want to drop pending frames (as we would prefer to deauth
> cleanly from AP in main case).
We have quite a lot of clients on ath10k and the issue is rare(ish). But 
you may be right and its spurred from the AP not responding. I need to 
dig in more to see if there is anything to be done on the client side, I 
just figured implementing the flush queue op would apply to both station 
and AP mode.
>
> In any case still I think this is a separate issue and it is also way
> less critical than the AP one (one STA can create ~4sec DOS to the
> entire BSS vs a STA took more time to roam away if AP crashed).

So for my companies use case a 4 second DOS to an individual BSS can be 
potentially bad. This doesn't really differ from an outright disconnect 
but I'm still trying to limit any lapse in connectivity if at all 
possible. If I can gather more info I'll report back.

Thanks,

James

>
> Thanks,
>

