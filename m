Return-Path: <linux-wireless+bounces-30248-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B78FCEC8E4
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 22:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA5A030088BD
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 21:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7D22E22BA;
	Wed, 31 Dec 2025 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Odh0sm/3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAF9242D72
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 21:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767215314; cv=none; b=W49VeY3lLW/9KSiQqMrTJsn1bdZCguTtZKptiux0wV6mVFW5yUAnpQQgFEa7ZGCgFVOl4GYVLOmOC9teJPXvbeN08ZTiRNyOKrKz8/zSrZCTAx1KGHDQWwgvhCb+2Haq1dGgfB+PoHQwkLyOhPLtmsifMO89ApHHF28lfl7nfMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767215314; c=relaxed/simple;
	bh=/fpSGKCMZ84Yv6KlVUKGe8MIPvLGKfxJMy99z/GEhKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oajIbfhN4PytWU767TaKidj8xJl/YLYYEPsE2Ztugt04izQ36LfdzSpW7Qjr05n72ZhrrTXOdmOk1pPrdtRWOwDBd4ZPt3cJ71X7ER+tTNMRnX9XG21ZnJB6zn4dIICkgcbwbjV6upE5J7XF4RYWJsfeCoUq/e8RYCUIwBp0uKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Odh0sm/3; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-44fe6771b2dso2269566b6e.1
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 13:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767215311; x=1767820111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xtR7PK39BaSx2GpuhvAfss4ZTutnP9LImpMPJNr7WtI=;
        b=Odh0sm/3ewt9g2YwVP7y754mMB6rXILXiYIcxEred0B9OabaFzUy7cldkFiSzkPdHz
         NX04tc7vFy8/ktSoF9GJUZ20uDSXiWZVxKodbUOY1AR6Bw/fk+60aSNBk3ZHGU2uiRAJ
         oddk0iop2JzeyAcUUszgwkIp7I7VB8p3Vpaic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767215311; x=1767820111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtR7PK39BaSx2GpuhvAfss4ZTutnP9LImpMPJNr7WtI=;
        b=hxiXaFeF9cMytDtuRpIaoM/88fBjNIvDX3ltEV3+Pjjc8e/Q9E0JPYbFgqYjvgzJNM
         ghRL73wkq6MWX2adqKCs6o24uC71kLUjudDUW40RReJwT0o8b5UFF9I3sTYWo45vMpun
         7rqyywY7h3o+pzi/iI5QtycMHlAYJ35CE44zGwJCjxgok/KuK1VLc6wjm14Jj760D/ce
         /Hnxp+SVkQfFziRtacJ2z97DvQIku39TGi0MGYLUlbfYug5Oi/oQrlw57JPFDBM6s+6b
         f+i+135viqwj0aqVR7Nmv6S+06hHGSxfy8wkQpj48+Bcz74i7e7vRoZ5HEF2iUS3NbcD
         Hd+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1oBQ+1ANRgXGwjDNF5RzQj2+R3VRyj/RaN3gZI3K00I4w8fl/zdSZda/ywaz30eJF7HBaTilbWnOkbjM4+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJtUIF8XQoTxqjoreKJ8bmdXEzt2me3h7uReENlB4mK2qIiYlb
	bdd8+1eeL40yjw+xSiRcnUhF0ippJNKm/kqijBPagUu4DE4FFyS9QJFuhEEc8KFM8YA=
X-Gm-Gg: AY/fxX5Joq4F5qYU2HARhYiXuqAbCq2rKDwGEPgWV10adrkSv7v6Xcj7zBtYT5CO5iW
	+ll4aKvc6qeM3q7Qe/8MIrv+E802TD4uSThKnvwOfPuJZPC1aT16XPJmD63IeNXBMQXDlZ+nAwY
	3cGhNh5PgNkGpA4IpD3215IdFa9McU7880UJF+lPd5SgWEGM05kPf6XnrOT233p2dXYQkvaxbWv
	yBBGc8zvgnGj9q/92CkqErN6feevvZTgjy+Qwt7L47U97lYCOw53LQV70pqNnuxI8DvuCYNnvyU
	u8/dPSGbrVNnFbZerqsYFfWlzfxW8U4cVThwpa+HvuEv6+PzrrFZIVc+qZOajtVUFUXYZ2b2hK8
	Gh0W3E6y3ZTscqC4fcEpKh5L9XAFAEdgubHeJ4pOtWUVSTN7PsorsDOwGEeQGVdw53Mn5U3ST3T
	veW6iUm5m54ZaqOsgZSOw3PwI=
X-Google-Smtp-Source: AGHT+IHTwHn1nXDjbjmhskjWx+MgiaHwYI6WYS1jGtnZhB7g8+LiP9lF5g92eNpfucMrdW9R4flOrA==
X-Received: by 2002:a05:6808:1526:b0:450:3ff9:f4dd with SMTP id 5614622812f47-457b20b7730mr18285141b6e.24.1767215311322;
        Wed, 31 Dec 2025 13:08:31 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4598c356623sm12481094b6e.2.2025.12.31.13.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 13:08:30 -0800 (PST)
Message-ID: <8b3d207c-76a2-4312-a149-724e55fbd0cb@linuxfoundation.org>
Date: Wed, 31 Dec 2025 14:08:29 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.19-rc1 mediatek mt7921e broke badly
To: Eric Biggers <ebiggers@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Mario Limonciello <superm1@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>, quan.zhou@mediatek.com,
 Felix Fietkau <nbd@nbd.name>, lorenzo@kernel.org, ryder.lee@mediatek.com,
 linux-wireless@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-mediatek@lists.infradead.org, shuah <shuah@kernel.org>
References: <d7f3b00d-beec-41f0-b157-7cfb871f9a46@linuxfoundation.org>
 <756e3f65-b2f2-4da3-985a-17754a7a872d@t-8ch.de>
 <CAHk-=wjO-7uR5HBi-MFnkxAxjhpgfbAQ+HCMKPiXFVwM+AJ7tA@mail.gmail.com>
 <6fc04df5-b753-4b2d-b978-0e59a7f48ff7@linux.dev>
 <c1304430-dd7d-437b-8744-70af9ca85c0d@linuxfoundation.org>
 <CAHk-=wh6WP0Wq=rbC2Md6vsFrV-+nvDjxgfx9NpMzUmVFNkJ9A@mail.gmail.com>
 <20251231015712.GA2299@sol>
 <fdebed60-264d-4f05-9423-618bc3ec6d6d@linuxfoundation.org>
 <30d14c51-3325-49be-9510-43f4661ff6c4@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <30d14c51-3325-49be-9510-43f4661ff6c4@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/30/25 21:07, Shuah Khan wrote:
> On 12/30/25 21:00, Shuah Khan wrote:
>> On 12/30/25 18:57, Eric Biggers wrote:
>>> On Tue, Dec 30, 2025 at 05:27:13PM -0800, Linus Torvalds wrote:
>>>> On Tue, 30 Dec 2025 at 15:57, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>>
>>>>> I would recommend reverting f804a5895eba instead of trying
>>>>> fix it. Then find a better way to eliminate extra newline that
>>>>> shows up in dmesg when firmware build date happens to have
>>>>> a newline.
>>>>
>>>> Yeah. Let's revert it.
>>>>
>>>> And the way to fix the extra newline is trivial: just remove it from
>>>> the "dev_info()" format string.
>>>>
>>>> Our kernel printing logic will add a newline for the next line anyway
>>>> if it is missing (unless somebody explicitly uses PR_CONT).
>>>>
>>>> Can whoever saw the problem confirm that just a revert and a "remove
>>>> \n from that dev_info()" fixes the output for them?
>>>
>>> That works for me.  The revert by itself makes the FORTIFY_SOURCE crash
>>> go away and reintroduces a blank line in the log.  Removing the \n from
>>> the string passed to dev_info as well makes the blank line go away.
>>>
>>
>> I just sent the revert. I will try removing \n from dev_info()
>> later on tomorrow.
>>
>> My quick trial still showed extra line which didn't make sense
>> to me. More trials have to wait for tomorrow.
>>
> 
> Hmm - there are 3 places that print build_date in  mt76_connac2_load_ram()
> 
> 3022         dev_info(dev->dev, "WM Firmware Version: %.10s, Build Time: %.15s\n     ",
> 3023                  hdr->fw_ver, hdr->build_date);
> 
> 
> 3051         dev_info(dev->dev, "WA Firmware Version: %.10s, Build Time: %.15s\n     ",
> 3052                  hdr->fw_ver, hdr->build_date);
> 
> 3127         dev_info(dev->dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
> 3128                  be32_to_cpu(hdr->hw_sw_ver), hdr->build_date);
> 
> The last one prints %.16s and other two do %.15s - is the fix simply
> changing last one on line 3127 to print %.15s - this avoids printing
> the extra \n?
> 

The following change fixed the blank line problem on my system.

Mario, if you want to send this patch after testing on your system,
let me know. Otherwise I will send it.

==============================================

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index fba7025ffd3f..0457712286d5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -3019,7 +3019,7 @@ int mt76_connac2_load_ram(struct mt76_dev *dev, const char *fw_wm,
         }
  
         hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
-       dev_info(dev->dev, "WM Firmware Version: %.10s, Build Time: %.15s\n",
+       dev_info(dev->dev, "WM Firmware Version: %.10s, Build Time: %.15s",
                  hdr->fw_ver, hdr->build_date);
  
         ret = mt76_connac_mcu_send_ram_firmware(dev, hdr, fw->data, false);
@@ -3048,7 +3048,7 @@ int mt76_connac2_load_ram(struct mt76_dev *dev, const char *fw_wm,
         }
  
         hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
-       dev_info(dev->dev, "WA Firmware Version: %.10s, Build Time: %.15s\n",
+       dev_info(dev->dev, "WA Firmware Version: %.10s, Build Time: %.15s",
                  hdr->fw_ver, hdr->build_date);
  
         ret = mt76_connac_mcu_send_ram_firmware(dev, hdr, fw->data, true);
@@ -3124,7 +3124,7 @@ int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name)
         }
  
         hdr = (const void *)fw->data;
-       dev_info(dev->dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
+       dev_info(dev->dev, "HW/SW Version: 0x%x, Build Time: %.16s",
                  be32_to_cpu(hdr->hw_sw_ver), hdr->build_date);
  
         for (i = 0; i < be32_to_cpu(hdr->desc.n_region); i++) {

========================================

thanks,
-- Shuah


