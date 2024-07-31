Return-Path: <linux-wireless+bounces-10743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C98942E23
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 14:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676611F25C50
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 12:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D2E1AE87A;
	Wed, 31 Jul 2024 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVRS/So0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8921AE874
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428427; cv=none; b=ZgP41qXAvdfHWW2kKQj1kZu2Hxw7Bw5hkNM4TqgV5U/bdoUKbtjgvEliqD5k8p6Vp6DzCMjItNrovgBR2dlfOWL+cNcb1GbxvpzYS0vc4ZkIdNUHnDR3WwcjbC3IAfCZlkjtim0XzqzCy4rb1fMEXK0nHFsv0gQwDwKTzqRf7kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428427; c=relaxed/simple;
	bh=jZh7CkIE/ArcUNOBYJOYTf1TxHBegY6l8HmEie2EMik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBvX2wYWxQ5JnsZLVFNPg5LJ9hHV2AIFNBJA502z8Mm+v62UgSrJlXijwmhBdgdXIlRGvU7AHqfXWqrB0kpPY2eGFfvNLWp+97hig9cDmj4Iix5WC+g29Tey48BRNhkqeCq1qx10LVvhhTXikcULicMZFNehZJTYVzcPJrpuicA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVRS/So0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so7692233a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 05:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722428424; x=1723033224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dHw6LBAHcGV1sBfOEMgDpkD8PiYqEOP5cobGTOzgOgU=;
        b=dVRS/So0rx7I8W8b9e2/SuLTFiXa9Voy+ABThpwOGByBqc2/priQcE8+rGkCvQIuiI
         AtHl/4pKWUXoQCBIH+84htMAx7SJ0FgoLt68FE+MS4dEsDCg5+ntSj1aHbB+FK13ZbW7
         ovulOUrdJ50Err8Zuye1QHOL6xFiY35/XwwtBb8qVhEX2Q9ChtP14RrPlzA75Q5a/Hds
         IZgMeC9aDOh0Upb+MNbgNADjnpY1xZMu9DsEUt4vcpHvCWqt/KY6xgchO0LHim5CAFOS
         Ih3p1q4Nkf1Ey36TkM4jDSs4Q0rLDQi+AzGJDntKTxhAMj/W3zoHsiPwyoCw9wG+Bc2k
         zpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722428424; x=1723033224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHw6LBAHcGV1sBfOEMgDpkD8PiYqEOP5cobGTOzgOgU=;
        b=vFD3OxSglEK28MOPOafF/ScQngDos8q6GwLAw1qKIZGe3hMWgP/xsPUwnkyD3cm2cc
         hxaVsaJTL1ZEtZnuNnD0vRNul2QVtBCgs4AByS2H6KQkoIYZQeQm005TpyZuGwUAMfKD
         RS/hJgcp0vwDJ6CYP1cED+TUH3AEK43vxgGNXmfS5u6vfO6C/kfRysFA3obKyvBtnHS8
         iywfURDmnV4lwTg8NKlI+dw9eF6+Nl2DcDySN6+ABh5Q91MwLQx+Yahg2yPGcxyUnMfb
         dniVlHvEurzrw83Tn4Yez8sXC/ExYcCt+nxgxJiIhX4iyi6EWENXSWfG3Nc2HDo+s/Pa
         Kh3A==
X-Forwarded-Encrypted: i=1; AJvYcCWln2cfW0xzvH2YZHUOQdoVAJ2pYo5pOXqOikerCgf4CWiFubL3fFtWDcjlz/25aeMy0KMrU5etbKLpi6PYHbpTHARbsuywZN3QeO7RGKo=
X-Gm-Message-State: AOJu0Ywmpm+n6UzWZMatrwbfaqE7WUkfwSzTv/+LhFDdw9OT1iAjx/iw
	u5xAue76MsGLRkMRYZPSOvB2D9Qhwrf9vsqLW+YLCE2UiBihy+qu
X-Google-Smtp-Source: AGHT+IGZUjY62RYQ5bLEA/aOqVLYzbV9g+KW0fy9tP6cHCLlWtkg+hvOWkfDAlz8XXL5wLDDBn1kUA==
X-Received: by 2002:a05:6402:1ece:b0:57c:d237:4fd with SMTP id 4fb4d7f45d1cf-5b0205d61c5mr11369180a12.4.1722428424013;
        Wed, 31 Jul 2024 05:20:24 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5afc05c7a44sm6977054a12.6.2024.07.31.05.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 05:20:23 -0700 (PDT)
Message-ID: <91d03fa7-5af0-4ec5-a52c-c2c060e11d4d@gmail.com>
Date: Wed, 31 Jul 2024 15:20:20 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: rtw88: Avoid using macid 0 in AP mode
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Sascha Hauer <sha@pengutronix.de>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <9174a776-4771-4351-85fa-476e240d8ace@gmail.com>
 <e4be0a75-43b2-4ae5-9aab-5c4a88e78097@gmail.com>
 <9356af89520243ccacc0be72b8b03252@realtek.com>
 <4f052989-5fb9-4c5c-950e-a3d34e6499ab@gmail.com>
 <d21bc7a0fac8413b9cc443288924ec7b@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <d21bc7a0fac8413b9cc443288924ec7b@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/07/2024 03:47, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 30/07/2024 09:33, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>>
>>>> In AP mode, the firmware stops transmitting beacons if it receives
>>>> H2C_CMD_RA_INFO for macid 0.
>>>>
>>>> Leave macid 0 unused in AP mode. Macid 1 is already reserved for
>>>> broadcast/multicast. Assign macid 2 to the first connected client.
>>>
>>> Seemingly we missed to set mac_id in TX desc for a long time.
>>>
>>> +#define RTW_TX_DESC_W1_MACID GENMASK(7, 0)
>>>  #define RTW_TX_DESC_W1_QSEL GENMASK(12, 8)
>>>  #define RTW_TX_DESC_W1_RATE_ID GENMASK(20, 16)
>>>
>>> The mac_id should be from rtwvif->mac_id or si->mac_id according to
>>> operating mode and role.
>>>
>>> And I suppose mac_id assignment for AP is mac_id 0 for broadcast/multicast, and
>>> other mac_id can be used by connected stations regularly.
>>>
>>
>> What about the concurrent AP + station scenario? Will the
>> station vif use the next available macid, whatever that is?
>> Just wondering, I don't use concurrent mode.
> 
> My basic idea is to assign mac_id to each vif when adding vif. For station mode,
> sta->mac_id will reuse vif->mac_id. For AP mode, I will dynamically allocate an
> sta->mac_id to a station, and vif->mac_id is to send broadcast/multicast packets
> that are not belong to a sta. For example,
> 
>                   vif->mac_id      sta->mac_id
> vif0 (STA mode)        0               0
> vif1 (AP mode)         1               2...
> 
> 
>>
>> Also, do you mean that you will do all this? It's not clear to me.
> 
> I can do it. Or are you interested in this?
> 

No, no, it's all yours. :)

