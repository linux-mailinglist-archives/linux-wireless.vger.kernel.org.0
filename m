Return-Path: <linux-wireless+bounces-8193-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564658D19E5
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 13:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B9C28E159
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 11:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B490016C69D;
	Tue, 28 May 2024 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCY/qlw7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCB113CABD;
	Tue, 28 May 2024 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896553; cv=none; b=VZVXreWjLi54f6s+NO8rwwT5ZOvLWjC04ePGQzc/H3qjadlWM1v6WRTmhLecIxTNk+lsidZD0UwSOK9ELnq8tHNz7/eTu5EZJzbWs2N2xDkSW6ORCOvcGUdkF2AGTBUoZoi1WbCN+u+puE/vge3XCIKfI9+rxWFeJOdRxa5+PKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896553; c=relaxed/simple;
	bh=sGJmrEh9auOiE3A4aIx6z98vnSFWMxMsIKzLamdhd6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGZfe3S+lgUlbFIIKVZ7qLZIiwEcUjPBFrI3UpWTyMtGyacMgWy7c1oxKHKCAJ4uk5fQBRnardtqWsbk4/WMdaLW2bM8itPE92PD8I5HIcW69x/VZv7tGTEkk+R4LnzFUI6zETTjs6YanRWnZAK/nV7ykCCtRrTTrecOHDuSyIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCY/qlw7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f48b825d8cso4990315ad.2;
        Tue, 28 May 2024 04:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716896551; x=1717501351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JnEXNXS7Fuo888+4R+iNANBlrnAQM4YxC3FEnPxAUGg=;
        b=LCY/qlw7ensCFFUOIfl6tF9w5Mguqoj8jcF3apHbHyWyCovwVa9Gjacb2cXlnUuxsA
         f8PDTKGIDFQwWRs8hmMFdvrvy7ifnvd90rXvu7gcTtlmNmA65qAXtVzsKNTjtpLyxW01
         yq0n6bH+561R1MR5y9n/033XxzIOhyrfLRmqkzZXtEF5iljqKbl7mqju7W+X3zk1nxas
         ilg7ORFVcUCXjzJvxixLLVcV58UeBtFo7c8s7KjBUmWSze8fPT8YegmEM0KHnJ3ZPnoC
         UG3InbYWYZRdAfXiNCkCXcr7dhKdNLGTucDaSAFcKCyRUwgLnX0Yxkis4sHdIiIZzXf/
         /pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716896551; x=1717501351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnEXNXS7Fuo888+4R+iNANBlrnAQM4YxC3FEnPxAUGg=;
        b=YLyCLIvbwPudllK+K2Np7N5B9+gUQnLb8JiDAtani/V5AHu0ad58qxx7zB9BX2nn3x
         y8oz0+ShMqPBpSu9e1Q2QGZuCHLetCRkqWwI8EiXRy00HJFFzFfxjpHcatxDXZIvA9RC
         5AWJWk2pnRXEY5bUmAhZzFhMn5UEXgXIKNUkWd7F+FBLDjDQ5sLXMBbEbpnXQAKvpNiv
         xp+EVR+B0CMBT2YGf8PClQmaGp0oZsuJT70u2uk+bmjokra63KwgIxWdUPSQYZ/DaSkF
         oLjKm7IwlZ0rqAGBDAt1I4ySi0jZcrvSUkv3wsG8fFUle08TWJyvth8ra8h03a6Ag+BG
         xZPg==
X-Forwarded-Encrypted: i=1; AJvYcCX1dMmma/2/Efqhm+m4GwLwYDKVVZt+SfgaCw5dCvezwdykfdCZFY/Z9uy6of1uYyiks2C5jMGJQwc4kGb2Akkq1Fgk7UhV9OiYI4/F
X-Gm-Message-State: AOJu0Ywa7z04NgsSZagk+E8RYrcF7ml62GzdKAvwC6msa72VqPF8C6Cz
	/Ld9y2KeJsBBJRkCWr5bb+M+sJP5II/OvVBOxjmCjyakjMBW9f3L
X-Google-Smtp-Source: AGHT+IGO5L3Fa32QU5l+BrSfABCdODP/2O1IBTw/BZxrL/qzg2y4CjJobhzCA/43uv5Ek01jZL0Qzw==
X-Received: by 2002:a17:903:1d0:b0:1f4:962f:633e with SMTP id d9443c01a7336-1f4962f6542mr71297945ad.12.1716896550607;
        Tue, 28 May 2024 04:42:30 -0700 (PDT)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c75debfsm78387435ad.14.2024.05.28.04.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 04:42:30 -0700 (PDT)
Message-ID: <ffd7a57f-8cb9-4f9a-b830-d4659a4de520@gmail.com>
Date: Tue, 28 May 2024 04:42:29 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath10k_pci 0000:3a:00.0: Could not init core: -110
To: Paul Menzel <pmenzel@molgen.mpg.de>, Kalle Valo <kvalo@kernel.org>,
 Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
References: <0c544b16-5c0d-4687-9f96-8ff1f3269f79@molgen.mpg.de>
 <e1bc0bb8-a66e-4e03-bc22-3dc506b6fb59@quicinc.com>
 <87sey38vte.fsf@kernel.org>
 <96828117-2cf8-4a34-a8e6-78ace96b32d3@molgen.mpg.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <96828117-2cf8-4a34-a8e6-78ace96b32d3@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Paul,

> Thank you. I haven’t found out yet, how to reproduce this. I’ll keep 
> an eye on it.
>
This seems like the original bug I reported here:

https://lore.kernel.org/linux-wireless/304ce305-fbe6-420e-ac2a-d61ae5e6ca1a@gmail.com/

Note its not specific to power save which I originally thought, but you 
can reproduce it somewhat easily (at least I could) by simply 
adding/removing the wlan interface in a loop. IIRC even just ifup/ifdown 
would eventually trigger it.

But so far the patch Baochen submitted completely resolved the problem.

Thanks,

James


