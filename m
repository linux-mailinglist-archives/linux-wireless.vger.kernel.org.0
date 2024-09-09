Return-Path: <linux-wireless+bounces-12648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B599712F7
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 11:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172B82877A6
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 09:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF131B29D7;
	Mon,  9 Sep 2024 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfvJjYSe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCECC1B29D6
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872881; cv=none; b=OjAnPDzH30PRS30bqJoC+rSWRhmb4yHSSoScVwmVI1eMVUgod20K1FxdpF37l94tWinHGawUWX0giX/AKgz75g+vh8T5oSytZHK1eyTa52rjc+Dz199V/ciC6YN3KgNFfGel5h6Milqjh1zcG2sh6ZNwS4XBN8pqhSokPp3Xp7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872881; c=relaxed/simple;
	bh=aMXIYRngvNW5mNgwQ1XXr2MOsadY5DrTWID8JdS5+40=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=TCp3BXRuDTciuXRgZBAqi02d6Gv8uyfBzMyri+k6X1zHZDKVkki6FjWMdckhCi5HvPROXJV6FxyI/Pa6nXTEoszQXu+vr1qEdRO7ytJ5t9B15xJKk1x1ElXImhHAfsNgKHuE+LTXgNu0gRWXhd6nbaLMqRvmBHuIlUEvZqfhqwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfvJjYSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF05C4CEC6;
	Mon,  9 Sep 2024 09:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725872881;
	bh=aMXIYRngvNW5mNgwQ1XXr2MOsadY5DrTWID8JdS5+40=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=QfvJjYSe92yYekweG8olMivv0KOalcSzNq6yaikJeYh5DQqVErTdh/5igBcgzlHtl
	 4FDwtyNWpz7hOHF4tVDVvIQx9TlDT508VbZy6M12gE4MUKirq2yM/OfKj5+8pjOH/U
	 Sds1bbclhiHhGC00pbXlgInaKkkH+cO/xLhiIMxfrOglc46h62RTYMUKoyk3b/yohw
	 S2hgYIJFQeSihEprMIiM2o1YitTVub1TejcVBO9HJqx0IkRsejnWzEQbdDz/c2UykK
	 61LqqqLpySLjRE3rkc+93KSBNZJ0JUew23MvbH+H3vuk6XXEPHkizwJsODfRiu4hsi
	 N8Jmg1sQV+3rQ==
From: Kalle Valo <kvalo@kernel.org>
To: "Nicolas Escande" <nico.escande@gmail.com>
Cc: "Santhosh Ramesh" <quic_santrame@quicinc.com>,
  <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  "Sathishkumar Muruganandam" <quic_murugana@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: fix tx power, max reg power update to
 firmware
References: <20240909073049.3423035-1-quic_santrame@quicinc.com>
	<D41LUTO0MIC3.12475D2J3VNX3@gmail.com>
Date: Mon, 09 Sep 2024 12:07:58 +0300
In-Reply-To: <D41LUTO0MIC3.12475D2J3VNX3@gmail.com> (Nicolas Escande's message
	of "Mon, 09 Sep 2024 10:20:02 +0200")
Message-ID: <87mskhgpox.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Nicolas Escande" <nico.escande@gmail.com> writes:

> On Mon Sep 9, 2024 at 9:30 AM CEST, Santhosh Ramesh wrote:
>
> [...]
>
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 137394c36460..6d7a005d83b4 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -7217,9 +7217,9 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
>>  							chandef->chan->band,
>>  							arvif->vif->type);
>>  	arg.min_power = 0;
>> -	arg.max_power = chandef->chan->max_power * 2;
>> -	arg.max_reg_power = chandef->chan->max_reg_power * 2;
>> -	arg.max_antenna_gain = chandef->chan->max_antenna_gain * 2;
>> +	arg.max_power = chandef->chan->max_power;
>> +	arg.max_reg_power = chandef->chan->max_reg_power;
>> +	arg.max_antenna_gain = chandef->chan->max_antenna_gain;
>>  
>
> For what it's worth, I already got a similar patch from QCA a few month ago, and
> it fixed some tx power problems when scanning so I know there is truth in this.

What hardware and what firmware did you use? The firmware branches can
behave differently so whenever testing something it's good to include
that info.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

