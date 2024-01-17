Return-Path: <linux-wireless+bounces-2100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 739CB8307FD
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 15:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04731B24AEA
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 14:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52D1200DE;
	Wed, 17 Jan 2024 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loM8IwVK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771B51C2AE
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705501543; cv=none; b=Q4N3ZnyKDIuZXtQRDxOk7Wsh88EMse5mt31P5TF5QTO6axhsA7GqvZOWakzXYCScFodBgjfeIWe9OpJ8N4Hhx/Qtg73Zg6kzuaFOH3Jvtrtc44wo52VtKS0uoSIJwUbVVRgoi+cKw+wVrtn+PsfXVVSU8weHH9kVDprNGEGdUTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705501543; c=relaxed/simple;
	bh=v/mqPQeLMLiS8UZGJWedmUXPOI+IfXdlUfL4jZ795A8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=myYnYnW6ep1oe+C6/8jxsslFOeo+nHtiOb5VchV2lis0NjDjIsTX7TjR/vD2Em/SK0H15w2rOoETjWk4co8LKO1ZkPHRerPWK4/7FPNvrGmeLuoZTtYv2X2c3b+X55kIMfGZSg6qwO9RRPbejpKf9ybvf9CErq6C6paBzp/t7WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loM8IwVK; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-68163149b78so16133606d6.2
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 06:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705501541; x=1706106341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iyL6nwgFST/GdpkNqZbwJv1exFvxTHY2yvfVF6D4mpI=;
        b=loM8IwVKpi6uddCKoZbN0fk24hP3yUvXj0dLALE8hjKxgmsc1MJOEKTUhJ0vFS23LZ
         sGDVdGwOCsebUx1ldYo5OnUU9Q4RnSCIGhwiYt6I8OZoJYWhckHypmO9TQmPKhQ3+mHM
         XKIqEKQ9/kJVBJFZHuKm1XFbAzZiOOo4r3YFplHv0EO8YKUG05zkNlriiYgTtAqdPuKk
         EwiZxaFLe6sPpX2UfEXxn9ai4Va7WOGuO1XpENtr9raM9EBKAxEUWSauEHviD47HkdAC
         nQZs5YlBJAaAfo3etSksFDxCKXrrWhBqpaqbCaliwOtGc+Mi9O6lgb8j5gybCD0VHD5K
         f0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705501541; x=1706106341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iyL6nwgFST/GdpkNqZbwJv1exFvxTHY2yvfVF6D4mpI=;
        b=DYZHDYMlCA+3miPUTQXoC41qjl/rgggWOXUAM4Sh0z9+6Wr+DmYeqVa+g3PNTleTJ2
         m+OXKK7ZDQUcR7Cdh9HnuSkPCpwAFODiw6CQKWlo6E2RxAnleGiW5tsjpzzSjWbVKtnA
         yG0l+oEBGoA9LIL2MLwViisi1brqpeaA/ygvKpEvwJBKOJWzobuSEeXjasn53k03EXsX
         mpGuXj0tDFC37OcJT4iWNCLnmnj5NBWJmavVtAJwz9ZfKoLv/w/Xu7ElYPMS5e5x28vh
         A8+Xlmb18UJWOWm+G7rLs8u0yLUkhWSWOMlgwx7cYSwmA0IVDxzVBm7xVhJWI4dfDhIN
         lWxg==
X-Gm-Message-State: AOJu0YwJziRDNEtDaCc1wfa4lJMIXJAK1vUZHiYbJ5HlKxnyM/sJjTvQ
	dUElrGiJv+GYup71UZszA9o=
X-Google-Smtp-Source: AGHT+IGqJFcigCL28SyONVViKR9Iw5RQiobdzsuoxQtEf+OBYzsWxzlGiHBh7mk2o83QzDaEQtwwWw==
X-Received: by 2002:a05:6214:d88:b0:681:6457:400c with SMTP id e8-20020a0562140d8800b006816457400cmr4807046qve.59.1705501541309;
        Wed, 17 Jan 2024 06:25:41 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id e13-20020a0cd64d000000b00680b1090832sm4963533qvj.146.2024.01.17.06.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 06:25:40 -0800 (PST)
Message-ID: <6fc593ee-0b4f-4116-a30a-94ba375bba4f@gmail.com>
Date: Wed, 17 Jan 2024 06:25:38 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k and vfio-pci support
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <8734v5zhol.fsf@kernel.org> <87fa5220-6fd9-433d-879b-c55ac67a0748@gmail.com>
 <87r0ipcn7j.fsf@kernel.org> <356e0b05-f396-4ad7-9b29-c492b54af834@gmail.com>
 <26119c3f-9012-47bb-948e-7e976d4773a7@quicinc.com>
 <87mstccmk6.fsf@kernel.org> <df9fd970-5af3-468c-b1f1-18f91215cf44@gmail.com>
 <8734v4auc4.fsf@kernel.org> <e8878979-1f3f-4635-a716-9ac381c617d9@gmail.com>
 <285b84d0-229c-4c83-a7d6-4c3c23139597@quicinc.com>
 <4607fb37-8227-49a3-9e8c-10c9b117ec7b@gmail.com>
 <3d22a730-aee5-4f2a-9ddc-b4b5bd4d62fe@quicinc.com>
 <ee0280fd-032c-4f45-a3f9-50d96d8bed6d@gmail.com>
 <16cfd010-b62d-4385-92d1-002820a8db38@quicinc.com>
 <cdec259a-b779-4856-8585-f285179e3671@gmail.com> <87cyu05b4j.fsf@kernel.org>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <87cyu05b4j.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kalle,

On 1/17/24 5:43 AM, Kalle Valo wrote:
> James Prestwood <prestwoj@gmail.com> writes:
>
>>>> I don't see anything in the dmesg logs, or in lspci etc.
>>>>
>>> fee00578 is the physical MSI vector so I got it using lspci in host, see
>>> ...
>>>          Capabilities: [50] MSI: Enable+ Count=1/32 Maskable+ 64bit-
>>>                  Address: fee00578  Data: 0000
>>>                  Masking: fffffffe  Pending: 00000000
>>> ...
>> Mine looks like this:
>>
>> ...
>>
>>      Capabilities: [50] MSI: Enable- Count=1/32 Maskable+ 64bit-
>>          Address: 00000000  Data: 0000
>>          Masking: 00000000  Pending: 00000000
> And that lspci output is from the host (not the guest)?

Yes, that is on the host. On the guest I have:

Capabilities: [50] MSI: Enable+ Count=1/32 Maskable+ 64bit-
         Address: fee01004  Data: 0028
         Masking: fffffffe  Pending: 00000000

And I just tried those values, i.e:

-       ath11k_dbg(ab, ATH11K_DBG_PCI, "msi base data is %d\n", 
ab->pci.msi.ep_base_data);
+        ab->pci.msi.addr_hi = 0;
+        ab->pci.msi.addr_lo = 0xfee01004;
+        ath11k_dbg(ab, ATH11K_DBG_PCI, "msi addr hi 0x%x lo 0x%x base 
data is %d\n",
+                   ab->pci.msi.addr_hi,
+                   ab->pci.msi.addr_lo,
+                   ab->pci.msi.ep_base_data);

Though wasn't sure for "Data"/ep_base_data since the kernel uses a u32 
but lspci appears to show a 16 bit value. I tried:

+       ab_pci->ab->pci.msi.ep_base_data = 0;
+       ab_pci->ab->pci.msi.ep_base_data = 0x0028;
+       ab_pci->ab->pci.msi.ep_base_data = 0x0028000;

(maybe thats entirely the wrong change)

>

