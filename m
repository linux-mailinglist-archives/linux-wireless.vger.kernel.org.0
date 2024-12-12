Return-Path: <linux-wireless+bounces-16323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC169EF9C6
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 18:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10821899F92
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 17:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BB2222D67;
	Thu, 12 Dec 2024 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sp5TKyes"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36445216E2D
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025691; cv=none; b=aCx289LhUQK6ethUZemE6UK6/DGyDK9KdIpntFJqTG9RlMGedCe1i1vCa9AN+PIuLQFCJGz4xU+HO47w4rCOe0phQ7ilR6Z6eeo15/kdWxGcxImn1g21aHaTQdDkKbhRnDvLoJ+G5Mgq23ZT6TCX5/zav0UEA4RMOdZ8Uamv3ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025691; c=relaxed/simple;
	bh=YWsIcsn7D0LmVlhosIM/YCCbxE8z4Uc44udR+XmJ1/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c5vpMcPh+fXAV8gf8A7xWBSq9/3KBEFsNhoRxsp0bj0rmCVgSNqzVTWkBZNYycSmryDo65xa1xhkLa/cZskFKKlLWEH8KjNB3hory4LTpOhR/t+5Lddx8tJ/gCGi4iiTh5Q2Y/L0ji0gTMMdb1I7Kw7XwYirGc2nDIQdkwzCBYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sp5TKyes; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so682263a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 09:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734025689; x=1734630489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xeIwPfToIzpIYSbFrK2Q53g+lNWf7z02d8ag0h1kav0=;
        b=Sp5TKyesegV/NZ3Ubk9w64jDjX7doD93CB1QLC0decMbGltd/WM80EHQHANtn/MbRk
         EtSkiM2y+LNoGiZILZ3iC098pVno1OhMX13HiyGuvSpJwLbuS3IhWWlvwo/vO/zN/RiR
         2qB+0TKIcVsozvRFIhDfou3VyUdHihPVxqmWUuHYeqbl3WtPTKAxkZ3nuQnN8CrdFsYq
         x58aVMUc4ImUCN9jT7UIaFXFphqWBfaqNrr1Ma2Cq5vwibfUUA6+DtSt8AYX5q4vI2Bk
         8TGuy+Mva3q4TffuNBkgfsLkuhfDHEnCghjt6OlsL3xBgOyf/pA71QTJjTZfI/1qQ5uh
         eReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734025689; x=1734630489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xeIwPfToIzpIYSbFrK2Q53g+lNWf7z02d8ag0h1kav0=;
        b=Pvoy0Zs6fvOoVOdqXTzzca9MkCLYdDOoJkQpCstAi4vf/fCgBJH7w+6+CmZbxsvnhI
         ZVr9kS5EgNe4+FmMkfsLQOm/c93z/Hf7W1mk3Gpt9ooD6vtNjHcr0u/rQXPMb2qPksWY
         2at6r+4KnRlgdVOk9EKc3P2eSx8kUTX9FjVP1jSC4c+mHnE14o+XrTYuPIWYE7QKBNZ1
         LjuKMDcSM4l4dwbS9ca5p25j1dsU7oAC83A1rlDq95nPLpBavSGpRkJLe3Q4u9iM23bV
         0S/61NCGmKmQx05VeTF0Bc+9VyovRAgjxePxw00U/aUuBGy9/nlM3aCPo0fgQU3Hsf9W
         UkGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYFWY0UfmykxCd5APHuAlU+6FUGuhWzdCovskR1iZK9kWI3pcukBZcyRQOCKo4rAZVOGDPWMP1Rc7bq4hDYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+HqvJzbbGufFjcnDxqJHXIQcfkH3CP8pG2bRhtj9rhsrudTk2
	2EvJh1ZkJi6oNRhmh+p/6hAaD39x7tVJJqMOPH/2c5LQyUonNifH
X-Gm-Gg: ASbGnct1lqiaX8Y+ZVxJpZ3WX/r/xPAh7Sq8I8Iwnws3Pcif3NZoqgB4a4C8vK+2xDy
	6ioIrSlZxhTdb4YvPvCOQYZadPyGCWgKy0OmxS82F20UccmyuoIzRa7XTDGPTpya7oIbgs/wmHl
	Ra2rQYip0mhQO0Euu0XF3CmRYqi/PQq2izOhLE2dXOSYZdaFpKQDmexZnLYtl2tACKICKX5avRs
	2ann6OjzRqGU/EEpw6L0mQeXHXK2o83ddFtCph8rJO4/TrJx01NbwCAk48i
X-Google-Smtp-Source: AGHT+IF8GrvUMxDv3zhXsNlEkygyTPRmnU5q/9PGL7b0k5f1pLorPpMd/M9pYJhjqgBbvgiVCyE2eg==
X-Received: by 2002:a17:90b:278f:b0:2ee:cd83:8fe6 with SMTP id 98e67ed59e1d1-2f13932900amr7466787a91.35.1734025689464;
        Thu, 12 Dec 2024 09:48:09 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d90bb0sm1558314a91.9.2024.12.12.09.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 09:48:08 -0800 (PST)
Message-ID: <356e451a-0702-44a3-8537-3c9a30854f4d@gmail.com>
Date: Thu, 12 Dec 2024 09:48:05 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac SAE/WPA3 negotiation
To: KeithG <ys3al35l@gmail.com>, brcm80211@lists.linux.dev,
 linux-wireless@vger.kernel.org,
 Arend Van Spriel <arend.vanspriel@broadcom.com>,
 Denis Kenzior <denkenz@gmail.com>
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <CAG17S_M9wxMsSNyqAQv2oxaCQZ9CAe=GHNjZCbw__2bsAg1hdg@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_M9wxMsSNyqAQv2oxaCQZ9CAe=GHNjZCbw__2bsAg1hdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/12/24 6:24 AM, KeithG wrote:
> Based on a hunch that brcmfmac dbug might reveal something, I turned
> it on to see what turned up. I attempted the same as before: using iwd
> to connect to the WPA3 AP.
>
> [iwd]# station wlan0 connect deskSAE
> Type the network passphrase for deskSAE psk.
> Passphrase: *********
> [iwd]# station wlan0 show
>                                   Station: wlan0
> --------------------------------------------------------------------------------
>    Settable  Property              Value
> --------------------------------------------------------------------------------
>              Scanning              no
>              State                 connecting
>              Connected network     deskSAE
>              IPv4 address          169.254.203.147
>
> the attached log shows brcmfmac debug
>
> it always shows 'State connecting' never connected.
>
> Is one of these what is causing it to error out:
> Dec 09 18:11:06 jackrune kernel: brcmfmac: brcmf_fil_cmd_data Firmware
> error: BCME_UNSUPPORTED (-23)
> Dec 09 18:11:06 jackrune kernel: brcmfmac: brcmf_fil_iovar_data_get
> ifidx=0, name=tdls_sta_info, len=296, err=-52
> ...
> Dec 09 18:11:06 jackrune kernel: brcmfmac: brcmf_fil_cmd_data Firmware
> error: BCME_BADADDR (-21)
> Dec 09 18:11:06 jackrune kernel: brcmfmac: brcmf_fil_iovar_data_get
> ifidx=0, name=sta_info, len=296, err=-52
> ...
> Dec 09 18:33:32 jackrune kernel: ieee80211 phy0:
> brcmf_cfg80211_get_station: GET STA INFO failed, -52
>
> I do not know what BCME is.
>
>
> On Mon, Dec 9, 2024 at 8:30 AM KeithG <ys3al35l@gmail.com> wrote:
>> I poked at this a while back and decided to try it again over the weekend.
>>
>> Infineon has released a new firmware:
>> Firmware: BCM4345/6 wl0: Oct 28 2024 23:27:00 version 7.45.286
>> (be70ab3 CY) FWID 01-95efe7fa
>> it is not in the RPiOS release, yet, but I installed it on a Pi3B+ and
>> decided to give it a try. I have an AP running WPA3 personal on a
>> desktop in the home and can connect to it with my phone as proof that
>> it 'works'.
>>
>> I tried to connect to it once again from the Pi while running this new
>> firmware. It gets closer than last time I checked, but it does not
>> actually negotiate a functional connection.
>> I tried with connman/iwd, NetworkManager/iwd and it gets close, but
>> still errors out. I get a number of these in the iwmon log:
>>
>>> Response: Get Station (0x11) len 4                                  38.439787
>>      Status: Invalid exchange (52)
>>
>> Can I probe this further to assist in diagnosing the cause and
>> potentially help with a solution?
>> The log is attached.

Keith, you may want to also include the iwmon logs to show the actual 
netlink packets going across.

I looked at those privately and the full SAE exchange is completing 
successfully via ext auth. When IWD receives the SAE confirm message it 
then sends a NL80211_CMD_EXTERNAL_AUTH with a success code which then 
results in the error -52 Invalid Exchange. I'm unsure exactly how 
external auth is supposed to work, but if IWD needs to change something 
we can do that, we just need to be told what the kernel/driver expects.

Thanks,

James

>>
>> Regards,
>>
>> Keith

