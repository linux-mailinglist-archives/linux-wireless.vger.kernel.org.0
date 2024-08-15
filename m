Return-Path: <linux-wireless+bounces-11489-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BA095379C
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 17:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC350282176
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 15:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8988A1AD408;
	Thu, 15 Aug 2024 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahegxlm2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0439C1A4F3B
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736861; cv=none; b=Fv3e2qKsS4yXsIFv8VP+knPPc+UOAWmvQfasVCiTDVQArEA6KRBvY3ZeUalRs51m0kJTWhBvzWxCQO/b+rCuT6GTE6JWchrURNTwvevHKTdty2BFGMDbFZksxUOkxeDuDRbz98kbiEHWeRjleYC+Kp4IiahOkJt34kmV/AXN/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736861; c=relaxed/simple;
	bh=1diq+8ATDEiezN6dqIK5r+3hJz2XRtjXl9WOxRApcO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4zNYfiRAuChb0NUlb7DCmb04pjUiKSVroi3iHUCAi3xMrVy/VjuVrutBUxzGJKef2POkodA3Ee17WB0Snin3/cvOL1W3BZGMWINT9dcBjCuuROT6j3qkrM6+NgBsYfnB9oE9cS97BQHgtMl1Gs6Rfz++BJFCkXMUCXQi+YPLj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahegxlm2; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b7a3773a95so5749676d6.2
        for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 08:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723736859; x=1724341659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4RjQfC9B1fvnRu6RvXMXIpYc8OGb2IYxIWcv0ZiP1jU=;
        b=ahegxlm2eTykSD+rNyOBSdsLmvZQDofCvDQZGehAOWra5Si2nEcb5hzZHh33kXs7uI
         crO7r6Jzy8owy8E2gbACbUH8SbCbjOPVBlIE6gR8GxyY4/pBMIKsmhENjtiUO69juC9K
         oyaJnxwzrFfgUyww5DMl4WzszBNiAQrQXaD3GzkQhZMmM3aycVywhhvtn2nYvLAoNqti
         YTxU0504C1Wyf08mpHdxeaX8sPqIBS87XDhLv2pwqEKQ9iE2shdCqS5v+AzI8G/zhjdg
         vrJNYUOlv4JwFGsol6gFBdnLemDxhmRON97BcK/HGCbIiN85wMPlfrMCQXWtjACuvT6E
         btMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723736859; x=1724341659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4RjQfC9B1fvnRu6RvXMXIpYc8OGb2IYxIWcv0ZiP1jU=;
        b=bVK4y7mneoow6tpa/UmZ0K3pp9QoWzRqAc4mFV4CYud1ysMDx+eRXjfVf6StDTcjR8
         kWEIosVWfRN6TQhG3zCwUXMUEG0Pr2PyYo0WSMgWTkUEr/tpgj47CXk6MXPpF5gvH7HK
         EAsCouAR11/D+JyY8xPkFAXZyKtc4pPZ0nbcl34lSPDZFiH+tYY55ldP7Qa06CmIZ1QU
         WCR3OcQ9hu0aNG1GSGFPcchjWzNPVG/pfHU+19oibKMh7tbQxYexlDoGnPYFQRDDke+n
         wL8C4jY2j00ZdviSLMNhMjZFLCI6jKBznzmPiOE1Mp4ygIYZWaCGZucPyoSmBeNdeLXB
         vciQ==
X-Gm-Message-State: AOJu0Yy8cifGQzazpeeFVa32IYXwOxzmIqNGzemggrqR94Y2kvmALe/X
	ZFgDpif/5nX4fHrTA3yvI9g63pOGHqAu3jDp6GlhJN6LNW6znNf/7/uRaA==
X-Google-Smtp-Source: AGHT+IHsRYOCPAznA6wBSI0oYhBA7QUz6I0fUMWqcxHEROKqf4ooNcNPMAvUZYYZW9Wfcok9Wbt8Xw==
X-Received: by 2002:a05:6214:540e:b0:6bb:841c:ec6f with SMTP id 6a1803df08f44-6bf5d164943mr84594716d6.3.1723736858644;
        Thu, 15 Aug 2024 08:47:38 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fdd9818sm7406806d6.13.2024.08.15.08.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 08:47:38 -0700 (PDT)
Message-ID: <6ba02350-3c8c-4664-9d68-67cb7e90eddb@gmail.com>
Date: Thu, 15 Aug 2024 08:47:35 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath10k "failed to install key for vdev 0 peer <mac>: -110"
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <e780560a-86eb-4189-ab5d-3bed3ee5825e@gmail.com>
 <c407064a-1c2f-46ec-ac57-32bf9cf6f5c6@gmail.com>
 <9eafac85-2262-4f92-a70b-32109f65c05a@gmail.com> <87r0apyjc3.fsf@kernel.org>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <87r0apyjc3.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kalle,

On 8/15/24 7:03 AM, Kalle Valo wrote:
> James Prestwood <prestwoj@gmail.com> writes:
>
>> Hi,
>>
>> So I have no resolution to this (trying to get the AP vendor to chase
>> it down), but I'm toying with the idea of trying to work around
>> whatever issue the AP is having when this occurs. The only thing I can
>> think of is that there is a 3 second delay between the authentication
>> and reassociation, and perhaps this is causing some timeout in the AP
>> and in turn the deauth.
>>
>> I'm wondering how long it should take to add/remove a key from the
>> firmware? 3 seconds seems very long, and I question if this timeout is
>> really necessary or was just chosen arbitrarily? Is this something
>> that could be lowered down to e.g. 1 second without negative impacts?
>> The code in question is in ath10k_install_key:
>>
>> ret = ath10k_send_key(arvif, key, cmd, macaddr, flags);
>> if (ret)
>>      return ret;
>>
>> time_left = wait_for_completion_timeout(&ar->install_key_done, 3 * HZ);
>> if (time_left == 0)
>>      return -ETIMEDOUT;
> I can't remember anymore but I'm guessing the 3s delay was chosen
> arbitrarily just to be on the safe side and not get unnecessary
> timeouts.
>
Thanks, I have reduced this to 1 second and have had it running on a 
client for ~19 hours. Still am seeing the timeouts, but no more than 
prior. And even with the timeouts the roams are successful.

After doing more looking in the spec I did see that there is 
dot11ReassociationDeadline which may be coming into play here. Of course 
these APs aren't advertising any TIE or even support FT resource 
requests that so its impossible to know for sure, and hostapd AFAICT 
doesn't enforce any deadlines even if you set it... But in any case the 
timeout reduction is helping immensely and avoiding a disconnect.

Thanks,

James




