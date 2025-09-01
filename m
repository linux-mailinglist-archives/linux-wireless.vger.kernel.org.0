Return-Path: <linux-wireless+bounces-26897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A21AB3EE11
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 20:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50DBF7A9F3B
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 18:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3BA1CD15;
	Mon,  1 Sep 2025 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7jWrMCF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82357469D;
	Mon,  1 Sep 2025 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756752388; cv=none; b=hsaaEe3/ShIyeLJFF0fWH08YIWv4RJJFhzEmE/DSwWbBnIOfqfAWJ+FB4R7FWKIiRIKY+lV0zQjGX7HG1+hK93LDfoNGtYpXEtdsvVefqYqCBPW2ao46EcMLDg/yhUO00HPRbLnmIcO1ttr4BhD2MkEUdXzaHWv98cmc7BLC/no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756752388; c=relaxed/simple;
	bh=1YMRX08gpT2vD1LpJiZlR81GiPJhvKxpMkERYn4ffFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ty5tDO6sz8vCUv3h3miw96tMgi39g4FcPtS36xe2zkray04PHgeZKYZfVfx50Th66Lazc8PSSX+iAPCk+gIIu795oi6cJUh0CV6s6dv1arVqHlSayQ75gBPuG6OH1VniLe7qr6c57n29YAvtJo1Cvqg6qzST+Wd12J7Rwoi9bAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7jWrMCF; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3d4dcf3863dso1086775f8f.1;
        Mon, 01 Sep 2025 11:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756752385; x=1757357185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fnOBh1AqRx4Gf9M7qjq5GsPWwcJ3xJdlCn3P5Hrt2SA=;
        b=X7jWrMCFLsOg3OGUUd12l9csIzB3e/yhmJMazASUAEC+cnoXe5GNc1jAK80KRuzWpo
         i0iUpodHDbG429/VToGrADvREmJts1Xl/lhrms66Lk5J6maKcm8W0RqdRJpybFgbSvGy
         wbk554HoImzmko5S6KBrueMTfFq+SqTVwWIIhmy2Dai9YLGHA58VnCKC6mPqWV3CdlNp
         nvMY1TGdO3inBdVLw/d68Fj1nwlysZlTItSa7JeixHA7NtVjtp9LvmJ0QxpmXxGdCgPL
         /BOxXEtoFF/SDk4BnnXlgKLnMiWBHlaLDeTaBY3VTUe32KSydrMuAJiq8CrAog/q1+TP
         DVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756752385; x=1757357185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fnOBh1AqRx4Gf9M7qjq5GsPWwcJ3xJdlCn3P5Hrt2SA=;
        b=sO8pQWI9A39m59h4q8aul3u4wb0FJd73Q24gbMd15gJMNSQAG2P3GHojLEx69sp7B+
         f0RAu+1VPlO0P/dZW7Euvb+Qe2yngJ+hiqXIeNt/vhGvewfFoKW+mcxQfxx0yf0hjBwz
         mYLTXop3vkxs961A5B8A2f4zOlVQr5se3LSkIqUT8ZZFV6x16m5rH5wD9p+qh727iDc6
         WZ/0SlXQ3hdPd60md5t68gbD0ssWSsjdwCqwgNtd+Vidk/azwYKox79IOoWsuKtgbwWq
         UGkVXREOkp4l6qsyOfmyHqYFU6SY9rfGe+B1Wq7d2O3H2g53h8JeBo1sHUZDQWoNVM9h
         IPJg==
X-Forwarded-Encrypted: i=1; AJvYcCUXiqtPANFDrGyS130PdZrjNGJlT/Pby04S1vEyGhd/L8wEW+sJc/sVCHmZH43kAtHD9e4atPsd4bzmRJc=@vger.kernel.org, AJvYcCXVo3VhwSKS6dC6mbsgJ7pVdKZyLJXV7+j9+j1WBDLVTCbh7w/1Kyp6RlNZvGKGpa4NvfiLpJinlBcddrZB43s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcTct+lkENjYzwRN5Pln80rAZqLAggbV/2HMUGTWihGn8R2slj
	oUFGlGb8+7d6caZcmfbrn+IuFSgeCBuc3R1MfWUcfpTX7XcApNn5IKj1UiTJLg==
X-Gm-Gg: ASbGncsFKLqlw5hqPzIQgqmpmsnwkP0PNeuiEdO55EG7XCRJbQAO70y0mQb4lbzQRAU
	SqDpN4IwDZ+37398aT8WVDxEFpHMvHROwFBtmhjlZYfCZ2WLz9DGwTSF33SqDf3ZL7eY/TstKq5
	iPIxIxgqYIfw/xplBHKgL9pohzN3mzFF2k/vHxAESf0EDpcacTBtL0GNfcMUEB91KW8mJPuspPz
	bO4s72H08e+961JlBL33ebf7leuVmynV4PoGW/bklTvGkmCsSDKoditdnjDWZlsOKu5cYKuUJ0+
	h1i0WWzlOjFKhbNgcCDZ2vMK6sJJwxk4dD193AU62CpiMSuSHAAbmB5wy6/YKDmCPyRzfnoqnh4
	cw1OQMfEOq8c/bDJl53OErPg0/Lx4RXs9F5CMrYH2LrEanhL6fg==
X-Google-Smtp-Source: AGHT+IG0u3LzWEjaj0Pbrj+EeGCJTlPlXJUlwglP6eL8K9knX4TpjdNvVzTn9oRV/ksr5lNnsMAIvA==
X-Received: by 2002:a05:6000:1a8c:b0:3cd:96bb:b948 with SMTP id ffacd0b85a97d-3d1df15a131mr6710148f8f.47.1756752384638;
        Mon, 01 Sep 2025 11:46:24 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d6cf485eb7sm5496813f8f.3.2025.09.01.11.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 11:46:24 -0700 (PDT)
Message-ID: <0cb4d19b-94c7-450e-ac56-8b0d4a1d889f@gmail.com>
Date: Mon, 1 Sep 2025 21:46:21 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw v3 3/5] wifi: rtw89: perform tx_wait completions for
 USB part
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Zong-Zhe Yang
 <kevin_yang@realtek.com>, Po-Hao Huang <phhuang@realtek.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20250828211245.178843-1-pchelkin@ispras.ru>
 <20250828211245.178843-4-pchelkin@ispras.ru>
 <bc1857a0-86d9-40aa-a1ab-f4bc83adf6fa@gmail.com>
 <20250901194743-62fc282f96aeeb9804c34e2f-pchelkin@ispras>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20250901194743-62fc282f96aeeb9804c34e2f-pchelkin@ispras>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/09/2025 20:45, Fedor Pchelkin wrote:
> On Fri, 29. Aug 22:57, Bitterblue Smith wrote:
>> On 29/08/2025 00:11, Fedor Pchelkin wrote:
>>> There is no completion signaling for tx_wait skbs on USB part. This means
>>> rtw89_core_tx_kick_off_and_wait() always returns with a timeout.
>>>
>>> Moreover, recent rework of tx_wait objects lifecycle handling made the
>>> driver be responsible for freeing the associated skbs, not the core
>>> ieee80211 stack. Lack of completion signaling would cause those objects
>>> being kept in driver internal tx_waits queue until rtw89_hci_reset()
>>> occurs, and then a double free would happen.
>>>
>>> Extract TX status handling into a separate function, like its
>>> rtw89_pci_tx_status() counterpart. Signal completion from there.
>>>
>>> Found by Linux Verification Center (linuxtesting.org).
>>>
>>> Fixes: 2135c28be6a8 ("wifi: rtw89: Add usb.{c,h}")
>>> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
>>> ---
>>>
>>> New series iteration -> new nuances found.
>>>
>>> It seems the two previous patches from the series would not be too great
>>> in USB case because there is no completion signaling for tx_wait skbs
>>> there.
>>>
>>> I don't have this hardware so *the patch is compile tested only*. It'd
>>> be nice if someone gave it a run on top of two previous patches of the
>>> series, thanks!
>>>
>>
>> I tested your first three patches with RTL8851BU for a few hours. It's
>> looking good, no explosion yet.
> 
> Hello Bitterblue,
> 
> thank you!  Just in case, rtw89_core_send_nullfunc() has to be called in
> order to trigger all the tx_wait activity touched with the patches, please
> make sure it's called during the tests - it should be done after scan
> complete, 47a498b84f01 ("wifi: rtw89: TX nulldata 0 after scan complete").
> 
> There is one more issue we'd also need to solve: perform tx_wait
> completion signaling inside rtw89_usb_ops_reset() (driver shutdown stage
> should probably also be handled with the case).  This'd require having an
> ability to track TX URBs and kill them.  I'm just throwing these thoughts
> now, maybe you have some ideas.  I'm still exploring the USB-part source
> code and hopefully will have a chance to get hands on the USB chip soon.
> 
>>
>> The USB side doesn't have real TX ACK status reporting yet. I only
>> learned recently how to do that. It looks like it will work about the
>> same as in rtw88.
> 
> Do you mean similar pattern already exists in rtw88?  Could you give a
> hint on how USB side TX ACK status reporting works there?  At a quick
> glance, I don't see how those TX URB complete callbacks differ from what
> rtw89 has.

Well, I assume we are talking about ACK status reporting. For example,
when mac80211 detects beacon loss it sends a null frame, or a probe
request (I'm not sure which is used when). It flags the frame with
IEEE80211_TX_CTL_REQ_TX_STATUS, which means the driver has to report
whether the AP sent ACK for the null frame/probe request or not. If
the AP doesn't reply for a while, the connection is considered lost.

A URB status of 0 only means that the URB was submitted successfully.
It doesn't mean the chip actually transmitted anything, and it doesn't
mean the chip received ACK from the AP.

In order to receive these ACK status reports rtw89 will have to set
a bit in the TX descriptor and place the skb in a queue to wait for
a message from the firmware. ieee80211_tx_status_irqsafe() can be
called when the firmware sends the message. 

This is for USB. It seems to work differently for PCIE in rtw89
(rtw89_pci_release_rpp()). In rtw88 it's one mechanism for PCIE, USB,
and SDIO.

These are some functions to look at in rtw88:

rtw_tx_report_enable()
rtw_usb_write_port_tx_complete()
rtw_tx_report_enqueue()

rtw_usb_rx_handler()
rtw_fw_c2h_cmd_rx_irqsafe()
rtw_fw_c2h_cmd_handle() / rtw_fw_c2h_cmd_handle_ext()
rtw_tx_report_handle()

