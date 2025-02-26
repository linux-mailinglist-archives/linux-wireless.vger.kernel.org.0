Return-Path: <linux-wireless+bounces-19503-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B29A46EC5
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 23:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33DDD3AF880
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 22:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460B525E827;
	Wed, 26 Feb 2025 22:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs1yeZ23"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CD725E81A
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740610219; cv=none; b=f0s3lv9Ov7aUFyfoE8gBU0drOWxuxs12tJpmXPPV0ceXzZGBXIJ13d8aJDoYMs/Nl20cWjUXkFRtJdXvjMcyyrSTIVyRsfq94PaG/zosdHaE367CQZq8vHGcyuztm2VNsqQT83FMT+5WZ40ps08O/0w0H30fi3E6O/E9+R1ANtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740610219; c=relaxed/simple;
	bh=UMRCM1mu7qGQlFlTbEMFXdDJWp2w8gRiz32MHCIgqq0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=QHN9PqllNTtANoFLxq8Or1PN9xbTyZMLMWzhiCf1I/Zl/9/+LQV/NUfme6yS+wfL7LSyxmKU3mFICNMDoUdwTBKKDC+Bl4CvoGDT9YWrciWJO2ZOSisOh4K6HZWNpvRWimBlYstbDBxgjs8CGZOGEnqHWSCNoUNy9uUnGYNf2i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs1yeZ23; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e0b70fb1daso385216a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 14:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740610216; x=1741215016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAoSh3/F93Puvpaz435ar2rHgUGrMZvGB1NTA78Sz9M=;
        b=Xs1yeZ23+A/vcBYHzdiqa9ua2Z+5GIm6EykIOmW2syaUsOURfiLk/J1F+tADnnQHlp
         m82oNefZY7lg3NYGvsMR9iR7H2o7zaRcxxQhFxUY4yZudHsue7Sn8S186v0GlCQFNkXD
         FUYvOvOXa2toj0uL8IzYiqMNdb6rFHuZOR1k+wM1O84QEqoj4xezkLSnFBmrH7NL0W/c
         mR0AUBaZ4HpOTg6UWnRU2h2ItCFSSW10iGUHXWG1OPivrFJ6wW/VckCY9Ut4T1M+Qmax
         gQX8cwPmLn4bXHM97MDwf1mmhqo+2E/zGaPcwzA45t7mefU9f3jNxKn9iYsGmNV6tNc8
         oAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740610216; x=1741215016;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CAoSh3/F93Puvpaz435ar2rHgUGrMZvGB1NTA78Sz9M=;
        b=vw3WUI4w2gGz3xS0BtEikNfga/sSpCpcBfT13aRpkmhK/1ZsT9oHrfSLMntpmxp2/6
         cUI6cNZq+9w9iT9ORDaLrhsb5AD5mw9PC7O1rYNOs0prG2Q/PFcJT8ShzuYqBxdrF8Ex
         wXnrrOQrOSAKO5evNwOK6xUgg+Qequ9Z3opCraE37w5QaQCEGBMScOGoVg+qle3fVfAH
         LlBxH30pJ9jul3SwbKa1px4rCwEEh3CXWZOXarsc02zelzwbIN7qQRRSRzDazfDW9W3+
         u4BVAXgnVh3Jk5xEzcAvAyJNs0bn5lEZo38E7v4OThCv21seMiJC23da8nRcrBn8pKyH
         SaFg==
X-Forwarded-Encrypted: i=1; AJvYcCUQAozEEEDKiwYSR50R+rIECcUSTj6VS/mHe08E6Eb10hhub44TcfqN/2hMoPHpi6PdmFIdpkz+HkkMbDwTAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXddnFXzn9q7o+OMSw6fULXXAkZ/VqaMIBjOpTs6qGD7PsnbD5
	5SFI/PkJcrgw+vzMRvsOPNTHB2b4jCdDRcZq8xZe3CY48FZ5D0wUp93xwA==
X-Gm-Gg: ASbGncsJpKleGGj2ey62eBsCUyLfd0HSj3IZZYDZjyJlv87qkwf/xylVNP+JQwbVdFg
	NZVPrc+nROg5VbHCQfYYb8Ml49MY1SGOcKF0Ba7/DCXzxU0vrvQWzD0ZBIEed6QBlsCiW9qhuvE
	qCQoblcHMjXifAKg01nnYijh5eorL/u9jrzVe07U4qUvAPyl/9/if5/NN/JfeN+fgaUadf9e7cm
	/8ZJmKpKZU996QyEtU2mniWkflO2PlSxEButxStRFLBMtcurjVTdnDuxpYPx6zPgPzWOyGkdGlY
	l7JGDecigm8QXB+oY0XpClJ7YUyQoNvSrEU=
X-Google-Smtp-Source: AGHT+IEAItlUAg3TSAPGlU6+0lwTWjU+NMy+dCJjsXRvf+RQiiWQmqHsg3xprZOApiUVh7XGRCkumg==
X-Received: by 2002:a05:6402:401a:b0:5d3:cff5:634f with SMTP id 4fb4d7f45d1cf-5e4a0dfc57amr8064846a12.24.1740610215450;
        Wed, 26 Feb 2025 14:50:15 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a5acdsm125514a12.77.2025.02.26.14.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 14:50:14 -0800 (PST)
Message-ID: <609560e0-8393-4feb-8153-0c6147598763@gmail.com>
Date: Thu, 27 Feb 2025 00:50:13 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH] wifi: rtlwifi: pci: Fix condition to wake the queues
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <0c91ac77-a652-4ab4-b911-e0a2386fb863@gmail.com>
 <1a11b3b765404ab0b64b0e0614e44ac9@realtek.com>
Content-Language: en-US
In-Reply-To: <1a11b3b765404ab0b64b0e0614e44ac9@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2025 08:20, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> The TX queues should be woken when there are at least 4 available
>> entries, not when there are at most 4.
>>
>> Tested with RTL8821AE.
>>
>> Fixes: d0311314d002 ("rtlwifi: rtl8192ee: Fix handling of new style descriptors")
> 
> I agree your change looks more reasonable. Did you really meet the case
> and this patch solves it?
> 
> By the changes of d0311314d002, I can't really understand why the initial
> version and the commit do. Considering the commit "fix" some situations,
> I don't know if this patch would break them again. Could you look into
> rtlwifi PCI flow deeper and share your ideas? 
> 

I saw several problems with rtl8821ae but I can't say if this
patch fixes any of them:

- After a few hours it randomly stops receiving beacons and data
  frames for at least 10 seconds ("AP off, try to reconnect now"
  in dmesg). Then it may or may not be able to reconnect.

- Sometimes the TX speed measured by iperf3 is limited to ~80 Mbps.
  Normally it's over 250.

- Sometimes there are duplicate pings:
      19 packets transmitted, 14 received, +151 duplicates, 26.3158% packet loss, time 18098ms

- Testing the RX speed with iperf3 sometimes makes the mouse cursor
  stutter. (It's usually ~300 Mbps.)

I don't know how to reproduce any of these.

<= seemed like a clear, simple mistake. I'm not sure about it
anymore, so please drop the patch. Maybe I will look into it
again some time.

