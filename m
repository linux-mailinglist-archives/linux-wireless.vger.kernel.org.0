Return-Path: <linux-wireless+bounces-38621-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QYcCCGdjSWpV1AAAu9opvQ
	(envelope-from <linux-wireless+bounces-38621-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 21:47:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 854A57084A8
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 21:47:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=J27VjZC9;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38621-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38621-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E009A3015A55
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jul 2026 19:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD6830C14B;
	Sat,  4 Jul 2026 19:47:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8FC2264CA
	for <linux-wireless@vger.kernel.org>; Sat,  4 Jul 2026 19:47:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783194468; cv=none; b=dI2pE9FxAdeczNTnkOV5eqseS+xsPb0yyN9S8vgb+Q0Jl5LyleRPBbM/mvIi1bJX5U4Cw6jSTWLc/JnxHLUsP3zmxASgrKy8mwbVmonlahE/dlOFiBIxn2xDHNAwez88QFUALLu8j3ARKlTJqjPo2JQZ61JCvuVtXiSk9FyWU0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783194468; c=relaxed/simple;
	bh=Snl8VegfNU3b+pp7xcK18+nJNfh+AsT7lENoZyT5PN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OYxummjjiyYWEq2f82gT4ygmW4nmA2HJd1tFRE7HvsKCyW/jpthVtOuGF0B+pHOZiCfPoZy4vhwpIEYRzi2mX0c+XnixuLmQSXpsBzunuV788mI/FKp5qt4lZrT+CjSW1C5BfmMhl+cGyaMNs1R5mL7utxS6+6rAvy9RPvsr9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J27VjZC9; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493bab44440so8799375e9.0
        for <linux-wireless@vger.kernel.org>; Sat, 04 Jul 2026 12:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783194464; x=1783799264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3VAekp+c4ejiOh3PjpFobvfEAsfcvbc3HnHbTxtxZXg=;
        b=J27VjZC9+/1poANI8rslb+RtbKxlTAh6wefvMARNOLfM7Y+mKj+SfAPJ4nL7zFNGO3
         x1m7WTqrk3j9LG4uC7OJ02qrUl5PELQQVS05UusQLOKfKIzM5VRV9K24UNaXTM8qg7WC
         6iv50Vrds/U92gFjTHWfUwbMb0mPuSf/5uOEwTzoXpRQEMb0pqqwlip+0z7xgaSZCHPL
         pPKrORp+veSJgBKQtig6Ww/ooHaMk7pwzBAPsyD4vFlLd0JaDYBLP5BDB8lJdMPmGbq3
         BM3Thj6v0Y1DQwTvgTAV8VCShvJeGcVof8+6Go1Vrpj+WAypf8aj8PLhrC27W8tiqzR1
         2bWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783194464; x=1783799264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VAekp+c4ejiOh3PjpFobvfEAsfcvbc3HnHbTxtxZXg=;
        b=ZG3m/AiMryYC+eCxtf6flfeQ4DfBaAYrH8zHBdmOsjdaj/mZ3l2xQvhdosd5mHWCHB
         WHrHMqS+zmUhrW3q5f2G5/OhyqYxYqlUoiKuAWX78+hcFbpodOuyuc/3zDw5kYUwS/jo
         jBhbT5NdWZuwPXvxKi01cnX4fd1F9sfadfp7z3BMnsNsl2VDPA/6ENByoCD3Lt0HrtbQ
         OfPPZWh3pw6H51sTWFC54MOkxHW+WUHt9r/P0aNeqhccAnefXmvI32SSv7YpTwrmAQpu
         NjrqEP3BHsNNSp/DHmSRdj5o2PGf9RQsg1bvQygtyxDBSj7Bo/YIAzp+6ogCEL5WK0xK
         v8Rg==
X-Forwarded-Encrypted: i=1; AFNElJ+yVNp6mymdXQxKdSiiiuc0aD6fVNeSoKRzm82LbCoFBmCzFAND/rW7pFHYJSRZ2auB5ojS11EXeFRFeDuO+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjthQWniLetbpIV+hv/PR+4qNEE6kc5rTtIvPsmI9Q3Wi2rtcs
	kYf8oArOCo11WSHC+ItEeGTpc8nchPqbV4x/hsJ3f2jnEwry8YCnNHaV
X-Gm-Gg: AfdE7clY2BEvZ57d7pPhja+k92PO2MOM7MehDQ9p0FSQJAW70ROthn9bh7Oq2t16yhA
	MJUHzhlyo/LJgxOhQfyPHXktnxByBm+dhufgcjVLNpPDOH6qWmKvkvITfw9FVoBQhD80oFt+giq
	6yvaiVfs7sUJjsR5DXAWR9APQJbaiLgHRqZ1mA2il/rLTnJaFo0xv66qkM1am0rf0aOK/MCF6BH
	apXgHM84lYRHbpj87M/X89606+omk0qpBFNz9s5cHQXWsgv1Mlq3Thz1N0Cdd8S26p4rxJ03tG1
	m4e+8QGO8m2yY+G5Tu2cbUXj6vJykoUe+yEV462bLq20vD75y4w3COaXbPMay24DhzFfEFsnrjP
	u9aYtsE5riiit0+fBe0i+oZQHJenBoQDraqzqthxh0z4AgEP0ioXD9CS3Zp4+NFZPwFfRfN98Ph
	2b5DtHemv799dKOFcm4dQrRFS7KgUg4tURJjk6Fdh5mqMrjqpP7dEsSTjunETbYD9lk2CU9UTXE
	axaRMNh+Js=
X-Received: by 2002:a05:600c:1d0d:b0:490:5000:917 with SMTP id 5b1f17b1804b1-493d127f020mr38066405e9.1.1783194463567;
        Sat, 04 Jul 2026 12:47:43 -0700 (PDT)
Received: from shift (p200300d5ff229f0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff22:9f00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637568dsm253713735e9.4.2026.07.04.12.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 12:47:43 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift with esmtp (Exim 4.99.4)
	(envelope-from <chunkeey@gmail.com>)
	id 1wg6Ky-00000000Jmx-2UA6;
	Sat, 04 Jul 2026 21:47:40 +0200
Message-ID: <7b4d5221-ed48-489a-9b24-f29758f25e4e@gmail.com>
Date: Sat, 4 Jul 2026 21:47:40 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] wifi: carl9170: firmware trust boundary hardening
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Tristan Madani <tristmd@gmail.com>,
 Christian Lamparter <chunkeey@googlemail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
References: <20260421134929.325662-1-tristmd@gmail.com>
 <b31525d8-e3b7-4ff9-bee6-4974fa9f9a6a@oss.qualcomm.com>
Content-Language: de-DE, en-US
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <b31525d8-e3b7-4ff9-bee6-4974fa9f9a6a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38621-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,googlemail.com];
	FORGED_SENDER(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:tristmd@gmail.com,m:chunkeey@googlemail.com,m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tristan@talencesecurity.com,m:chunkeey@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[spinics.net:url,syzkaller.appspot.com:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 854A57084A8

On 7/1/26 7:47 PM, Jeff Johnson wrote:
> On 4/21/2026 6:49 AM, Tristan Madani wrote:
>> From: Tristan Madani <tristan@talencesecurity.com>
>>
>> This series adds missing bounds checks for firmware-controlled fields
>> in the carl9170 USB driver.
>>
>> Patch 1 bounds the cmd callback memcpy to prevent heap overflow from
>> an oversized firmware response. Patch 2 fixes an off-by-two in the TX
>> status handler. Patch 3 caps the failover copy to rx_failover_missing
>> bytes, using min_t per Christian Lamparter.
>>
>> Changes in v3:
>>    - Regenerated from wireless-next with proper git format-patch.
>>
>> Changes in v2:
>>    - Use min_t() instead of separate if-check in patch 3, per
>>      Christian Lamparter.
>>
>> Tristan Madani (3):
>>    wifi: carl9170: bound memcpy length in cmd callback to prevent OOB
>>      read
>>    wifi: carl9170: fix OOB read from off-by-two in TX status handler
>>    wifi: carl9170: fix buffer overflow in rx_stream failover path
>>
>>   drivers/net/wireless/ath/carl9170/rx.c | 7 +++++--
>>   drivers/net/wireless/ath/carl9170/tx.c | 2 +-
>>   2 files changed, 6 insertions(+), 3 deletions(-)
>>
> 
> Christian, will you be able to review this series?
> I'll take it once I get reviewed-by or acked-by tags.
> And then we can ignore the dups from others.

 From what I can tell, the "others" made the effort to also check skzkaller.
i.e: https://www.spinics.net/lists/stable/msg965098.html
Closes: https://syzkaller.appspot.com/bug?extid=5c1ca6ccaa1215781cac

Wouldn't it be possible to merge this information with the patch? I guess not.
Oh well.

As for the series I do have a headache with patch 2, I wonder why none of the
other AI-fueled mails proposed the same.

