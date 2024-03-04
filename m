Return-Path: <linux-wireless+bounces-4342-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A838706E5
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 17:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9B11C2147E
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 16:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AF947A6C;
	Mon,  4 Mar 2024 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="NgVQlMgg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF8E482DA
	for <linux-wireless@vger.kernel.org>; Mon,  4 Mar 2024 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569304; cv=none; b=qIW40hBgnxh+9L7R7pJc530ErPehc/roQ/a7DahX41hX7yi2WlAwDLWYc+4XRp0RxjkuqpSzB0FArAl1rZQadLeTNW/YFwTmWaS2jfGgcNBsx6Fm4HuusGqNgYUqgwQgw37CWUhn0W8gKW/qNAFb0XDeVVn4bUgk6S5ztBJbCxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569304; c=relaxed/simple;
	bh=4xTBM2H/u8UluDDjHyyVTU6zuFLKL29UdTc9YUE4eAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRgI3SMLF0KU04TBShqyde1WVEyYQNAr0QWtmFdufCEJmKKlTdqBYbPtykKgA8wgrXOoIcMSoKIcA5PKXcbzCMny3NLEBU3C0UGBzltgm4BM8C7cqk4lT24VwdWvHFhHmyLwroPpyxsIpre60klSMUUSld4n3jxPWjjfcV6zNjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=NgVQlMgg; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33dd2f0a0c4so2647465f8f.0
        for <linux-wireless@vger.kernel.org>; Mon, 04 Mar 2024 08:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1709569299; x=1710174099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2NauviWk607nxbEN2DlOAU5kjIWJKRTn3ayaQZc8Isw=;
        b=NgVQlMgge4QCpUwVlDmIxRcygs/OVn2MjAQqsCzTNYhDpRKe8DO9xodhUUJdjU6uJ4
         28G7n7/ihslT3+vyEN0rBz1wLPRNtBq7xVa3nblODgrUaQwSv2BTeoZod9N3T9mp2+OG
         R5jRY0grd/4RlVcoCtc1qVSIO1eDBit6lwub+hvboMgt8bkOkaGi20QzKLTiuLS2YmIE
         a/QDgVWXNjzqtW9NPrpFhiEnnrg5aavxQrpz2gGR9zYMJ9vEe/ZPi4NgfMKobQyvIM2m
         J1beEG6N/6vEvqj+GoxDYD2Yz6lB5t5AnoV52ymmgE1sIxsak9pNfY6uFqXzxYAzm1TA
         /Wsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709569299; x=1710174099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2NauviWk607nxbEN2DlOAU5kjIWJKRTn3ayaQZc8Isw=;
        b=jIjWi1zOpCUeP0KGD3xw6qEk8UsBbdk81696vxODY2ZnGxQu5WGvHVdgowS/vsiMmr
         DurczkQvc1VUS1s2lf+EgfW0nBH4laU5VvWfVyrnRVd7rFGdxW0LWsgK9YHzENnHGths
         zSrvLPrbR9LKdWGlcP+mWD3SQMEwNcQ4+lppTnIaqGpnx9D0m/pRAuU35T4vJtejIgni
         eVSmf4gm+OoBlo955GjhrlxJqfQvTDTwA1QcxRRz+tHYtliGc1EtVuadRXxuMH6WVWZz
         g5RAl137nbBNtEBI0OqChxjaWDxLl10cUb+L4mUJpYFTZ9y/1mWExgErE5Mj2JIeTZaj
         FedA==
X-Forwarded-Encrypted: i=1; AJvYcCUXlMJ49BeR+nfQq+cZqYIdH4MST1nnlbWy2UlQnpGDY7BmQzAl9WHxSRfHaI544q01ryVJj/XJPgjWypOfohALWlZ2O5+oKHnd7RDrXy8=
X-Gm-Message-State: AOJu0YySdV7vzQd6okaoxWs4ll0UVerbrBrljKZIPZ+4YQCQIYVfU+Cc
	iYnqFk95L/aPZTlKqSPyARaTgKIt9v5cAAhyBbUvjqOIkDgFj/VkwHRYeHdUMrY=
X-Google-Smtp-Source: AGHT+IFeuAkLZo+7SpvCw19rJhG+qBzOg0lkgNPbLPmlzxdr5EnioyfQyd2ksDtt5/vGI8oC1ahhPQ==
X-Received: by 2002:a5d:42cb:0:b0:33d:d84f:1ef0 with SMTP id t11-20020a5d42cb000000b0033dd84f1ef0mr6098847wrr.12.1709569298835;
        Mon, 04 Mar 2024 08:21:38 -0800 (PST)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id az23-20020adfe197000000b0033e4403c6a9sm1552302wrb.22.2024.03.04.08.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 08:21:38 -0800 (PST)
Message-ID: <68a49964-7c05-4575-a4f3-35848c08fefc@freebox.fr>
Date: Mon, 4 Mar 2024 17:21:37 +0100
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
To: Conor Dooley <conor@kernel.org>, Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
 ath10k <ath10k@lists.infradead.org>,
 wireless <linux-wireless@vger.kernel.org>, DT <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr> <871q8wk7o3.fsf@kernel.org>
 <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr> <87wmqoilzf.fsf@kernel.org>
 <20240229-ageless-primal-7a0544420949@spud>
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <20240229-ageless-primal-7a0544420949@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/02/2024 19:40, Conor Dooley wrote:

> On Wed, Feb 28, 2024 at 06:37:08PM +0200, Kalle Valo wrote:
>
>> Marc Gonzalez wrote:
>> 
>>> As mentioned in my other reply, there are several msm8998-based
>>> devices affected by this issue. Is it not appropriate to consider
>>> a kernel-based work-around?
>>
>> Sorry, not following you here. But I'll try to answer anyway:
>>
>> I have understood that Device Tree is supposed to describe hardware, not
>> software. This is why having this property in DT does not look right
>> place for this. For example, if the ath10k firmware is fixed then DT
>> would have to be changed even though nothing changed in hardware. But of
>> course DT maintainers have the final say.
> 
> I dunno, if the firmware affects the functionality of the hardware in a
> way that cannot be detected from the operating system at runtime how
> else is it supposed to deal with that?
> The devicetree is supposed to describe hardware, yes, but at a certain
> point the line between firmware and hardware is invisible :)
> Not describing software is mostly about not using it to determine
> software policy in the operating system.

Recording here what was discussed a few days ago on IRC:

If all msm8998 boards are affected, then it /might/ make sense
to work around the issue for ALL msm8998 boards:

diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index 0776e79b25f3a..9da06da518fb6 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -1076,6 +1076,9 @@ int ath10k_qmi_init(struct ath10k *ar, u32 msa_size)
 	qmi->ar = ar;
 	ar_snoc->qmi = qmi;
 
+	if (of_device_is_compatible(of_root, "qcom,msm8998")
+		qmi->no_point_in_waiting_for_msa_ready_indicator = true;
+
 	if (of_property_read_bool(dev->of_node, "qcom,msa-fixed-perm"))
 		qmi->msa_fixed_perm = true;
 

Thus, anyone porting an msm8998 board to mainline would automatically
get the work-around, without having to hunt down the feature bit,
and tweak the FW files.


-- 
Regards


