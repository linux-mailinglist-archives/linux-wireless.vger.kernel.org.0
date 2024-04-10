Return-Path: <linux-wireless+bounces-6132-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C75C88A003D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 21:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67CBF1F24E2E
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 19:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681F27460;
	Wed, 10 Apr 2024 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwHKf5Fe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42122180A6F
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775843; cv=none; b=fN8xWnbn95WBssmnNOZdNfy6+PvoiHoFFhc8v680J6li7MT0lsHv9QfGEsExJBkOwJ9x3MuwNTIoaWoQmv16woLRDto7sPhHFgJSOA7fjZ5EEPk33gKiEMlXobGdcxMQIeafBd2F0NmV3c3wklNfyaGTJ/V0rrgVbs6BgP3q2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775843; c=relaxed/simple;
	bh=F4cYN6SunpPWHU1bl/yI2soLXJlqGsgNXZPQZzZDmZc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=FZy7F7My6hDbEQkyhV2Hmr/MwkoHWifctCiZqNJ9/apBnwBe1VJb7NItrhUNz2fz23Wu0kZmJ8/7i698liZ89Ja9T7fKaf7TDdKG1v80PltCCxjlqBflDrDIw8iGALvPIAqCeIW8AMveoHXDTlgdV69XSYCt5VwdqlZ4qrIeKp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwHKf5Fe; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-22ed075a629so2995530fac.3
        for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 12:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712775839; x=1713380639; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2zayn471XtcXJE9t0D4QBo96mbz6EP6coJCrayMusTQ=;
        b=SwHKf5Fe3J+OOyAe2je43Z41xpxL8XEoUfJu3yQSYo+hWsFxKUi4OfFQD8LvdpX8QO
         qrrdcxIAUw7DMleVEn4OdccEdyvwIF4Se5ZfuxK8MWWKimEQF+uz2rD8I789CzKVRtS3
         zlAujH8UdnsKailMm523KAedUoioYbg0/HfjqLh2wC0HxD0SZIw7Jt8Ss8kooAutrwuI
         Vh7gDxjCcNuJNK80bFBXG+xdOG8j+pY+l24HIWNbmMHokz5FIbaN1JqUfldf7uMViI7p
         vu8aj8zWnmL4pAqST2W6BsgaubMGHgDFur5crPNt9BJI96cfh8ArAM/ChJsTtUAcla9W
         7RFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712775839; x=1713380639;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2zayn471XtcXJE9t0D4QBo96mbz6EP6coJCrayMusTQ=;
        b=KqiWrvR13EcOqPOGmziiVbagAqcNanoB0w/ubkYWDKxnIR892FepmLt3F7+WTKGENg
         h0i5Yjl3pUiAwZKDRuMpVl3JYPkuVkBaefYS5gymxQXqMtWogP5zZ2ee2mvwx7sW/g21
         o48wnxcbXMgCkYNddKF3DSKR8Ksf65hcW9njZ6h6Vgq3d2uDItqEAogz0lemEi4s6k10
         JuqRfgUbvxitaF+xJCacn2Yjh2jJxFRb5QVA2LtIzbuh13OeggAUa4iOF9TacyVXlOR3
         VSA4mfJOegDgAiGKWENkz91i2JIhDWJmqqz2zQq5dZj0FJLlHRViKn93zWSvbzvTxTXC
         6ExA==
X-Gm-Message-State: AOJu0YzTmK3hqpunsk0yp6qXV1BVoVeWV8B2mMgv1JLz8Lgtu4VOB+FE
	Wu/E9OxCq/TRoRRP0KNWoe58o0yDPOa43S7kV2VGT/WT9BzzT6kJ1c/wt3oGSXg=
X-Google-Smtp-Source: AGHT+IE8vf8bcMnH6KXgiwrMhFOpwOCdoslnhruhCDBJ7F5RKZ34er8urSy+SAAPXR6jZ3KdlzTriA==
X-Received: by 2002:a05:6870:d627:b0:22e:ddd1:4641 with SMTP id a39-20020a056870d62700b0022eddd14641mr3742047oaq.35.1712775839336;
        Wed, 10 Apr 2024 12:03:59 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id ny15-20020a056871750f00b0022e9af4f5a8sm3212047oac.34.2024.04.10.12.03.58
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 12:03:58 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <8909f667-96e2-484d-a0fd-a20847e42d27@lwfinger.net>
Date: Wed, 10 Apr 2024 14:03:58 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-wireless <linux-wireless@vger.kernel.org>
From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Need Help with SDIO device
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am helping a user of the RTW8821CS device, which fails on startup. The device 
is composed of an SDIO wifi unit, and a UART-based Bluetooth section. Our 
discussion is at https://github.com/lwfinger/rtw88/issues/187.

What an msleep(150) was added just before the SDIO probe routine proceeds, the 
success rate was about 60%. Examination of the dmesg logs of 10 runs showed that 
when the BT section completed its initialization before the SDIO probe routine 
was executed, wifi started without error. If the SDIO routine was entered before 
the BT driver completed initialization, wifi failed with error -110 for SDIO 
read/write operations.

What mechanism is available to ensure that one driver finishes initialization 
before another starts? Is there anything more sophisticated than an mdelay(500) 
at the start of the SDIO probe routine?

Thanks,

Larry

