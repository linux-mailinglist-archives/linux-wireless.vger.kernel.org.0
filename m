Return-Path: <linux-wireless+bounces-27954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1410DBD248B
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Oct 2025 11:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE791883EE7
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Oct 2025 09:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDBD2FD7BB;
	Mon, 13 Oct 2025 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J0hf9tWR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A79C2F28EF
	for <linux-wireless@vger.kernel.org>; Mon, 13 Oct 2025 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347570; cv=none; b=EGKmPpLTjh0Lzy1qjVKFaiSoblYkY9MAIcr+a+iAeNa2nnHhM1ZWMxlSMo34kbpVJou3y2o5FtrcAiwP21YqD04i6ImVTd1M4jn1lY0fE+bwcFj/X7Vn3HJrogyeAUneQm5jvGQhCFL1gaBl0h/Nn/Pph3pD8k70w35J0N8pYzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347570; c=relaxed/simple;
	bh=382/roRFqkOwJECYdfbCfLLziMSqs9guVhAUjCFzQjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q63RtMcPjCq3UmATLQKwlzD1fszHMTCZOo2cq/4wn8p6Xp5FV3B/KjtEfSyeYTDi5qFHJTrvOpSeK43M+r+qSLyRTPCugqjBr028V/S6GsJLCuShu5EJ1NdR8CZYctmOuFrrKyTK5twYxBqAdjJwMSJE6JynxfUA22ZgNboaQXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J0hf9tWR; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-93bccd4901aso414091039f.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Oct 2025 02:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760347566; x=1760952366;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+WyV8pCzt+hpRaPvT/xOVlqiGN48UdZ8Ff3wBlnLB4=;
        b=w/c493C4YxuTZMiJcLoY7LlQa8/jeizfemZwRzudmDcS6aiGEj24PdOaPS4p+kNa22
         pwoVTq4bHOprSRJAiwjab2tY6lwrC6wYXFTQDHA0oPhVME42Epp+j2sy/14tdgiPNsfc
         ghjaNpypqXuO9szNtjvKiSLpybwokuc/0vKfFZVErHPXUHSfPHue6RZ/W5pqsmg+4zIy
         lypANT9Wr0OGlcl/K98Z2LH3DYVjjr/MpBPJLaEEPHrK4QOXbUnsXLjbz/YkyVJ5Ibjv
         uyltXHYk959AjLMVyjERslScXWFXGwuaZaVrVYs1I/9BehFrlmPsCah/hclF21mbeV8g
         b/mw==
X-Forwarded-Encrypted: i=1; AJvYcCW5jjLbF9ebN3DMosisUhMEYbH/vDiBd2CG/LeubuUpu/FAxv1zC6jhEXgU8z06A9VpEDquJL5fuV289htwQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiZTijQHRiZr7bsKONMxDg7e4GXQjYutW3GgwsIfUUlJKwJRP4
	CI9JJN4zglc+KTOJwFVXp+u1mq8b9sp9Los6x5pX/CxIFVMgDFh2qD8+l7VDd7jeZlfJn545zwI
	VGisCb0F9KYQn5EG8KpW5TNQqAy2oxG6Mfk1flJEtZee4kv6AZXZo2Ew0Le6t0yeZf+2KLR4fVk
	Je9Kyle7t2xDk4AUO2V0Na3KUxqRnVtM4l3YMM3N4HLNyu1cqG1F3qsgvclhphKbgL2Vdu5yMb0
	uazD246xTQzijriKKDfecE98ASr
X-Gm-Gg: ASbGncunXtMa+2RdI4XIGPcBrvYdgRDucA3QsKC4CBQCuet2ysBWQBnZ8XwgSjrp0rp
	4aY1KfIK6spt5L0RmY5cTMt9iIW++IRZDhd+bBPpLXB/LB5sqkQ+LmWXAU1whUe5mj9UvgISB0T
	gwy2itjFo+EPJW1imuWErAk/BltDSQ0lyIeDZB5x5dxUdlWpHb8W8qYahTIj3ZtLilWLAcICyiO
	9vLgOyULIr8jQJu3PO4Xb68LFJGizyZFtTTb2ikZ+nF6MoRRBPBxSm1+t5ylAEDJvjUj04Sp6+K
	fifmkzJBVi25RfjyR8lolR8qrh74eeomcfAAmR+eyFI272pu+qbjNh8tiVyzkedQ/cKWwWM1Ktn
	i1Ks2NG65To+un8Z9i/y281sv9l9uDylKmTD+cVMamzlXtjLx2AJPRBGmD2gEt8NF0u1jcEIx9D
	KMgJs=
X-Google-Smtp-Source: AGHT+IH/GMXVtpryyho3pSnbzC0IMgK8w9bS3dGRJScldsqDE9GbvMjA50kdSUuflV+WRcblMNwlZO8p1O2a
X-Received: by 2002:a05:6602:15c7:b0:920:865c:a8a9 with SMTP id ca18e2360f4ac-93bd19623bbmr2562590939f.14.1760347566233;
        Mon, 13 Oct 2025 02:26:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-93e25981f84sm63771039f.8.2025.10.13.02.26.05
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Oct 2025 02:26:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-78e30eaca8eso337359846d6.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Oct 2025 02:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760347565; x=1760952365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a+WyV8pCzt+hpRaPvT/xOVlqiGN48UdZ8Ff3wBlnLB4=;
        b=J0hf9tWRlfK9bpCDlkB/YXIYUM6WtrbuicT6rneANaVVuaDW0c1Nn5WA4FLrQNv/M0
         AcjvdIwFHvmwWHggqWnEKNGhxKdhOP3FgsVlAub731b/f2V9mvFjEtuo2Fy8I0Ag+AUg
         j5HTeaTVozO2DQLhGld1rwHcpA2YziPSY96sg=
X-Forwarded-Encrypted: i=1; AJvYcCWXfNe2jZBdYhh5FGOW/YQL/aIw6s2y0C5ZOygrYrd6G1ZstkjiBD6cEBxagDw/EvQE4j5iakXTJjTRuMXibw==@vger.kernel.org
X-Received: by 2002:ad4:5ccc:0:b0:79c:f4b0:6813 with SMTP id 6a1803df08f44-87b21065472mr297538816d6.21.1760347565051;
        Mon, 13 Oct 2025 02:26:05 -0700 (PDT)
X-Received: by 2002:ad4:5ccc:0:b0:79c:f4b0:6813 with SMTP id 6a1803df08f44-87b21065472mr297538586d6.21.1760347564680;
        Mon, 13 Oct 2025 02:26:04 -0700 (PDT)
Received: from [10.176.2.222] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc3479578sm68700836d6.19.2025.10.13.02.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 02:26:04 -0700 (PDT)
Message-ID: <4d24f3ed-0b7d-45cb-9dfc-b8b5e0b37fd2@broadcom.com>
Date: Mon, 13 Oct 2025 11:26:01 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: brcmfmac: fix crash while sending
 Action Frames in standalone AP Mode
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
Cc: brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 chris@streetlogic.pro, linux-wireless@vger.kernel.org, richard@govivid.ai,
 s311332@gmail.com, wahrenst@gmx.net, wlan-kernel-dev-list@infineon.com,
 johannes@sipsolutions.net
References: <9a0849d8-befd-4fca-9d5d-a24520ccfa26@broadcom.com>
 <20251009073928.6803-1-gokulkumar.sivakumar@infineon.com>
 <08368241-6b89-49e5-81cf-8e7874c91696@broadcom.com>
 <aOyqOnKEnkNqfg9u@ISCN5CG14747PP.infineon.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <aOyqOnKEnkNqfg9u@ISCN5CG14747PP.infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/13/2025 9:28 AM, Gokul Sivakumar wrote:
>>> -     reinit_completion(&p2p->send_af_done);
>>> +     init_completion(&p2p->send_af_done);
>> I think we should not do this here. It used to be init_completion() here
>> but the kernel API changed introducing the reinit_completion() to make
>> explicit distinction between init and reinit. So I would suggest to do
>> the init_completion() in brcmf_p2p_attach() which is always invoked and
>> leave the reinit_completion() here.
> That works too. Will create an updated v2 patch after making this change
> and submit it for the wireless tree instead of wireless-next.

Great.

Thanks,
Arend

