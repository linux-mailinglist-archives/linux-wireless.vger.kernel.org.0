Return-Path: <linux-wireless+bounces-5478-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A708906F3
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 18:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18F72A2089
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 17:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB4840842;
	Thu, 28 Mar 2024 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="VPUpwU4I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4568140841
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645795; cv=none; b=Jn5gPAXcSYxeqBdH6dgDOuJwEKTWVINo3PTJ98RBRfk8/+lhYzCrLVJvwqfoyd9VqFmKbg6VDrzQ/CTIXBJs0XwB5wB7GIrU5wAVll6KD/4OEE4l8GIOdrAKkqEKlDbxMExQB+uD2YJYn7xMf+etMmTt113dvLbCoGrdTOaT90s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645795; c=relaxed/simple;
	bh=4aGtlYQa6LOd2OEmaA7FHOw6SQYqs0vT1Qz4Tis7MSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HlBPbTxRuAvIbTs2bZmF9VTL46Jy8bN+wGi24IlXvOnnh/ymktVb0bZDpdlOFI59Cr3ortVhaNUlukKLesIU+IUSIKr+V8F3vrhN3V0BM+8k5Mo2+dAUBb3HF0A0R3FNSf/WipW5mDNTXY/SFKAQm9q4y9uKA6avYP5NoCgKFGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=VPUpwU4I; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41494c0405eso7401425e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 10:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1711645788; x=1712250588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y8/g+cHkPSXhHlEKcSVfgwp5KAJjPgctuVitEMx931o=;
        b=VPUpwU4I2a1Do4aFNdRh5a63esOYYUo4RY9x2pYYPz0rW0e0OePa96Ae1Fn+87NzjE
         C70CVl2i3EgQlrlInY47WgkAJNMeBu9PYH0d6IRYF/pBo8KJ/YLE/ZIuF3ydE1aDqn46
         REZrGLZO0LqVbzxWiO0Pi2B1Fb06baU0NjlaTHLt6xvO+HVaPDzXjTii0BplnmJ3XSR+
         t/yuKlbMZlk/k+Bsjy4k0vsGMT4S7vI3y28hkTWErDO5CCUWPzYKiOaAjHFvzoOPXQ7B
         noU0k252QBDvakeYGRscsgJck2ZVUzksxYRu7MpoM5hj307Lrw+T97Z6i+1HPdbkM3Nw
         FeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711645788; x=1712250588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8/g+cHkPSXhHlEKcSVfgwp5KAJjPgctuVitEMx931o=;
        b=oloDEfhypWZn3c1vX8kVCKz1vosvzlq6Wr5d2aAgQLhUQi9y9LUwpbZoi3v50P/CxE
         SbOgMz87z4LD+oRPruY0jsT9/7Ofraf1S+E8otPylPmJHCA04rZzNOTGW1lXI+bGgRh7
         frC6y2cGiYL5MfHRb8EufzfZQse9Dnbv8gPm9EKs3CmbiRxSrv/vGVZPj+M5Ib+49Fb+
         R1eoAlCPHfh4wYjtPFSq+ZlbSJbigo4zuPlKCSSvYgFSzKR0rePqWxORrd3frDnFgDC8
         JJL888tsOZ6a3SyqCEdtv42KHdBHYYHM91rP50M+aAwTBVTFYL7Vcw6ReFLUj/K7jVc8
         DvGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6rsYkFOpuvirWlC0/w2bnpS2ckImCuUiMvjMkSsZ7O7en0VhTuKPQa0DLRfnhhYouyKE+/7QHJgH8zoOK/mlbczUWRUmISbvJE+dZgZE=
X-Gm-Message-State: AOJu0YyHVv3+719Qt0hPoxUtXv4kB/iQ+bbi+r+p6IYto87SEiwu/nlS
	Qmekh8HH33jGdjBw7Z5PZmRDL3FprCSWWXLuPgzLjzOkRVel+xpl1nlFbBE+lnM=
X-Google-Smtp-Source: AGHT+IHOl+8pLp638KlWCuohcoJcoPfMOHatFiZG43JVDO7VUY/xCGKW1oVbaGfCkvHbEXNELOF7jw==
X-Received: by 2002:a05:600c:3ba6:b0:415:43f2:332b with SMTP id n38-20020a05600c3ba600b0041543f2332bmr2148445wms.2.1711645788367;
        Thu, 28 Mar 2024 10:09:48 -0700 (PDT)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id o10-20020a05600c510a00b004148a5e3188sm5997405wms.25.2024.03.28.10.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 10:09:47 -0700 (PDT)
Message-ID: <c908125e-84fb-42f3-bbb5-3d4a909038d8@freebox.fr>
Date: Thu, 28 Mar 2024 18:09:47 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: ath10k <ath10k@lists.infradead.org>,
 wireless <linux-wireless@vger.kernel.org>, DT <devicetree@vger.kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>, Arnaud Vrac <avrac@freebox.fr>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Jeffrey Hugo <quic_jhugo@quicinc.com>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr> <871q8wk7o3.fsf@kernel.org>
 <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr> <87wmqoilzf.fsf@kernel.org>
 <c58e67e6-6a7f-4963-86b9-580165bf05ba@freebox.fr> <87cyse8j9m.fsf@kernel.org>
 <6d4b1381-c121-4cda-a8c9-9ccac56bd447@freebox.fr> <87plw87nsc.fsf@kernel.org>
 <0816f7bb-3c97-4b90-8e19-191552ea6e26@freebox.fr> <87h6hk7aee.fsf@kernel.org>
 <fb0ffdd9-923a-4191-8304-583243ad528b@freebox.fr>
 <243a97b7-c298-4307-9f06-8b3a7c3e24fd@freebox.fr>
 <9293793d-00e8-42ce-87b2-05abc3b49387@freebox.fr>
 <CAA8EJppn6M9dpzyu9d283AUtaeN-i-L=-aM5P9BEELXPLFS8YQ@mail.gmail.com>
 <4b7bf7cc-ede6-4c2a-983c-da4c8c09c5d1@quicinc.com>
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <4b7bf7cc-ede6-4c2a-983c-da4c8c09c5d1@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 21:21, Jeff Johnson wrote:

> On 3/26/2024 10:51 AM, Dmitry Baryshkov wrote:
> 
>> On Tue, 26 Mar 2024 at 19:45, Marc Gonzalez wrote:
>>> 
>>> [ It has been pointed out to me that the previous message was unclear. ]
>>> [ Below is my 2nd attempt at a clearer message. ]
>>> 
>>> Problem: firmware-5.bin has not been parsed yet when we have to handle
>>> the ATH10K_QMI_EVENT_SERVER_ARRIVE case, so we can't rely on feature bits
>>> to work around the lack of MSA_READY indicator.
>> 
>> Then, I'd say, we have to resort to the DT property, unless Kalle or
>> Jeff have other proposals.
> 
> Another option is to follow the downstream driver model and only expect this
> based upon static configuration within the driver.
> 
> Downstream driver has:
> 	if (priv->device_id == ADRASTEA_DEVICE_ID) {
> 		ret = wlfw_msa_mem_info_send_sync_msg(priv);
> 		ret = wlfw_msa_ready_send_sync_msg(priv);
> 	}
> 
> https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/platform/-/blob/wlan-platform.lnx.1.0.r4-rel/icnss2/main.c?ref_type=heads#L968
> 
> The downstream MSA logic (including some other code that populates MSA-related
> fields in the QMI messages) is only invoked for ADRASTEA_DEVICE_ID.
> 
> We could introduce a new hw_params parameter to have the same semantics.
> 
> But I'm OK with the DT option as well.
> 
> Kalle?

I'll send a v2 series with the DT option + setting the quirk flag for
all msm8998 devices. I'll include msm8998 board maintainers for feedback.

Regards



