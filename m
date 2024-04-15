Return-Path: <linux-wireless+bounces-6331-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 683858A5728
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 18:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F311C21EAB
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 16:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18CC745FA;
	Mon, 15 Apr 2024 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPhHb5ak"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB754BA94
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197398; cv=none; b=ewAo2Gz1L7y7Po9CuT+JeWiNhm4KK4pXgusoda2xhZeZIylctT4nRNE9itmK4k2nmPwj1+fwW9YARSNRA3G+WqpymDmSQoSk63OG509OpORToGSY4NtOmyZBkgeJAAk6h6g0aiq4dHwBA2cUj8Ug1sSeHL2LQq8UgvsTKap9nEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197398; c=relaxed/simple;
	bh=m7G9vgei/v/vHrX65n+JYaPqUiA0vcXyBGm0nxXE2/g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=QmITLvwrMJanY7Ql/ilorkPm3RN9PufE4xehvpUX+L9ebHGYysyRKcIxzuaA+pm7SugluAR4sGZig5/8F0BdxthqmIESFzrvs2HjaYNLgE0+dxeel/WwgFBjWj/S6KUtTXkDdf0X7I2PCppRhM3oFhrJM+QztyRNLC14nJh6oM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPhHb5ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64649C113CC;
	Mon, 15 Apr 2024 16:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713197398;
	bh=m7G9vgei/v/vHrX65n+JYaPqUiA0vcXyBGm0nxXE2/g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=YPhHb5aklQtMf8S6UplvckanWOA7BdF9dAG9i/epuoDkRWEoKmXlViHAZJMdeQ00o
	 nKepbl7/HlizFXD8XVZljsSB3PjL4Nd/u2tRXL7ZGXMXCUWW2MuKdUth6osLo+xu8+
	 vrHf9v7ZcodFLkogBuOEXeGjtYm7MClgRWRNjkYFZ8fKhVX0YJGv4oF6w4tVr5mAld
	 vJWw1O+VIXm4mZsK+oN41TlTkNJmzgceaoY+HwRYj42EfNDH/Uo3t8I5qIRFknDyQf
	 1a6SzjjcBDtV5NuGNx9p+vUESnJ9yupgHAGr8durg/6Zev32MJsq7mncf3YCittqtA
	 nsDHFuNKJBQTg==
From: Kalle Valo <kvalo@kernel.org>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath11k: modify the calculation of the average
 signal strength in station mode
References: <20240309121129.5379-1-quic_lingbok@quicinc.com>
	<171034681684.2322265.9660346495295315212.kvalo@kernel.org>
	<e40eb820-438b-415e-b91a-d448ac60d9a4@quicinc.com>
Date: Mon, 15 Apr 2024 19:09:55 +0300
In-Reply-To: <e40eb820-438b-415e-b91a-d448ac60d9a4@quicinc.com> (Lingbo Kong's
	message of "Sun, 14 Apr 2024 21:33:58 +0800")
Message-ID: <87pluqy5d8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lingbo Kong <quic_lingbok@quicinc.com> writes:

> On 2024/3/14 0:20, Kalle Valo wrote:
>> Lingbo Kong <quic_lingbok@quicinc.com> wrote:
>> 
>>> Currently, the calculation of the average signal strength in station mode
>>> is incorrect.
>>>
>>> This is because before calculating the average signal strength, ath11k need
>>> to determine whether the hardware and firmware support db2dbm, if the
>>> hardware and firmware support db2dbm, do not need to add noise floor,
>>> otherwise, need to add noise floor.
>>>
>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
>>>
>>> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> What about AP chipsets like QCN9074, do they also work similarly?
>> 
> Hi, kalle,
>
> I observe this patch's status is deferred.
> https://patchwork.kernel.org/project/linux-wireless/patch/20240309121129.5379-1-quic_lingbok@quicinc.com/
>
> I think it belongs to bug-fix, so, could you please merge it? :)

I need to test it first which takes time.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

