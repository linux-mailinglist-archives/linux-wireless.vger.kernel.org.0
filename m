Return-Path: <linux-wireless+bounces-27676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B40DBA38F9
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 14:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51AA54E0F3E
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 12:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3102E093E;
	Fri, 26 Sep 2025 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="pIlTah4I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B92310E3
	for <linux-wireless@vger.kernel.org>; Fri, 26 Sep 2025 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758888117; cv=none; b=byf2SYVkiOte4Dbx8JIaYyijN1Uefis5KwPp9njcW0aUyyXnTGMph9JqSQmdBQT8Es/at//s/yPBoFEMZnFb9VEiPh6U96PjZlJz1KrCeCE3ps8t8aek3NSTNeJ03SdOiXgmdwhz+bMqBehle5FB/QMQ2pZ13r2niMVF33Sy1c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758888117; c=relaxed/simple;
	bh=MpyFepxaLT7pC2Nsspl7xQoGfb1CJvxK0CsEc89YWLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fvrt2+970ZzwEGGwadjNtFvxSMHlh2naP6vtrq9eiEnsPMt0+41bkJIyvFr8Z63tiB4Qr2Esjm77KJMRR1kKJx3oUQROIzu3ZNOvecS5YgdWjhheY89lhnr4pSHw8GhMjzFzd3kYuvLrmHrSt99Q1IplgNDNOf9e6SRJQOVhqbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=pIlTah4I; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46de78b595dso10542385e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 26 Sep 2025 05:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1758888113; x=1759492913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jT5PnBOVYefWF4N5Q+X75nicfOGFJ6TJnFIzE88eVLI=;
        b=pIlTah4IIwRN43JOVoaYF47yYR8XDpwzu2nXJ3GVwgRoLYsGd4U7QH7rtoxhttputQ
         d4yFt8fAdJw0691ZHb9nrnIbBCT5GcB6nO+KnxrcFPfN7VwBoT5rGlNIq2U6sFFyYEsQ
         6nkZ3v1du9st6PjYrr71Sgr9G+PZHvhaY5tULE0I1DWpmPNfzrHpgVAq0yjWOzqbqp0f
         aRP1lDerYQMCUilJnfUnSX0j6KjZ69+Hl9bBGnDVy14kAdLctJnUmovvmTcj2frLShZg
         xWrkYRP/MjDYzrJxfBjwmmxJQapPRQSV3q0/cvbbskWVzUroZDMFji+DkYMixOGQ+bRP
         VoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758888113; x=1759492913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jT5PnBOVYefWF4N5Q+X75nicfOGFJ6TJnFIzE88eVLI=;
        b=crPw21aaXEuRR5dwG7b2JRvnTwnTlPD4UfDl6WBDL+LSDbbfyAOOODI13Lje9fQLdI
         C07cxOU5/DKrl5+sWPC6htkrFkar1OjUuuzVJj5FVVzyOJ+wjIknBuYzp/aOHm884jfW
         OD07lZ1+9nrKlMx4l+RRXVD4Tne7Xm7xnjaCXC0Q7ZDMvEyiwWUAv4NrBhmo8vRCNKBh
         KTSCvNpuF0rM6RYRqAVkeJ+MOHSkDJlkSjg0VkqofPr7auDnO7JoWgFKTLZ42k72zJCr
         Ra2MowNE5IOFHnhy7SQ+3iMQvJXUmWQYRbA9jYyVTwEIf1IxdmKz1M1PigjhFnb2LfuX
         Sy4g==
X-Gm-Message-State: AOJu0YwREwslHzJUkTX0rw8NzyvBTtrRsunA6JNmyGN51JLfTlwwi9Bs
	U9hYgN+lsHjB6sVHtGYb8/+xnImfLxRsqmJsItTzC5wSJ1lJOwtNwRqC40TdcgQRvVY=
X-Gm-Gg: ASbGncvnluZlROVyAM5wze3F9bHmE6En1JhG3q+qDyu5TTLAmeZV1FtVtiLMgaCwU8V
	lX+O/uWo19rp+XMzjNw9H/zOoUs6Qc8wsJdQd2xyO4a1C6HJ6NWDdbfYA9rV1QXk9X+vIEF+tpt
	CRzrEo0+zlfQvnk47pmyYhEu2+wl3GDC4l2MRTvWCK1Up1MXEfke30ulpmzfUY1OyeI3e3S7We4
	DmG4e+T/OzSb/s6JPe9uzyIvdWBshfyODZzQxofX8PaO8w1FDKyu0+EJPTPWcfBdygs/aAXDcAT
	/WQx9GUzBBUQwYVLLsp/NhqIWfOr7QHPoqWQqoyoBmaF3pLov8a5RNtnaJdzTDd5J+AmeiKaNQX
	fr3mme2x3tstrAOOLxPBlLqQ689YpkzhzqWZJnFXkYbQLNSkGZl5Raw==
X-Google-Smtp-Source: AGHT+IHVMxAcZaCT9uCQmHmUS6tvIuZvxVDAY8a+ZbjKonhCefPZZBDIYQg4hpqzP9Anc2jhZM7jQQ==
X-Received: by 2002:a05:600c:354d:b0:46e:3f75:da49 with SMTP id 5b1f17b1804b1-46e3fb24746mr12655805e9.37.1758888113258;
        Fri, 26 Sep 2025 05:01:53 -0700 (PDT)
Received: from [192.168.108.124] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc749b8f9sm6744862f8f.50.2025.09.26.05.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 05:01:52 -0700 (PDT)
Message-ID: <f207dda9-c830-44c9-962d-fbad1e6718be@freebox.fr>
Date: Fri, 26 Sep 2025 14:01:52 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac: driver crash with iOS 18.6.1, potential DoS
To: Hsien Chou <s311332@gmail.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
 brcm80211@lists.linux.dev
References: <CAE3HL_yv8t1Rkd+jLfQMkc3YrNONQp0pRFESV+v92ECf_+7Xjw@mail.gmail.com>
 <02ff0c6e-f2e5-450e-9666-3ce8b8404f86@broadcom.com>
 <CAE3HL_zPi2szh-_kPSvBcwHnYrSSYa51hwK_Kb4DqZbKAQct_w@mail.gmail.com>
Content-Language: en-US
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
In-Reply-To: <CAE3HL_zPi2szh-_kPSvBcwHnYrSSYa51hwK_Kb4DqZbKAQct_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/09/2025 03:36, Hsien Chou wrote:
> Hi Arend,
>
> Attachement is the kernel .config file. Thanks for the quick response!
>
> Regards,
>
> --
> Ken Chou
>
Hi Ken,

By any chance, do you have a PCAP capture of when the problematic AQNP 
Action frame is sent? I have experienced some elusive connectivity 
issues with some Apple's devices with a ath12k-based AP, I wonder if the 
frame is malformed and could cause a problem on other drivers too.

BR,

Pablo MG



