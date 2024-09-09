Return-Path: <linux-wireless+bounces-12657-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5623A971657
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 13:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096611F23084
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 11:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC8E38DD4;
	Mon,  9 Sep 2024 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZY0k346"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADF3FC11
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880561; cv=none; b=CxybrwFSn7UDhubsKt8ovyFtNhEpczfG1jlYkuLP0Hc/PyIcxRYWQBwIMfuLqS/DX5Pbhw5qx1ta3J+n5yH094CGy6i3UaBk3kc6DnPDmlIWsKJJcDMYAmITZJ2CiDwR6Oh5mGSbR9m4F7MEpIMOneYHHEaaUl0t8GKsjfSjr8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880561; c=relaxed/simple;
	bh=gI4k7l5Rqg8Klpd5dFoSqxAyG7irJrJaa5QtMh4qaro=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=hOZa8hhBRZ1/h+SRMNeMMzV1F2uQvtSLHCpwZYbQyHtmWIdpz/Ng79swxsJLdA7yO5grGkm+84eTA1V408qCWg5XwuseIe/f79zT5Ae+B/s6X30Eo/2ge7oHyGM+fXUNGWji1uCj/KRQ485Rmy+UuTLMyN/AwBfktEVUGfKFDig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZY0k346; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25162C4CEC5;
	Mon,  9 Sep 2024 11:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725880561;
	bh=gI4k7l5Rqg8Klpd5dFoSqxAyG7irJrJaa5QtMh4qaro=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=nZY0k346Ug/1rIbbm7btCJ50f7An1eBauRJVOqlu/a+EqdoJiAJJQOY9DLHX4zOI0
	 j4xcRpau+dL9/mAGqVOSwRDBUk4NJ/9qcPKZL4n87EI7eOVIXOHNYU46wphbaY6qMu
	 PRgsGzco+AZM9qpS0wWa91+FRbO1L3naNaSivqz/v9DVU+eceulgimXJDqVxW7b8V5
	 2QrCK6iqo+7FbK3b41V9n7RIxIejLQps9+COg+Fefym4TRLzv//Pw5le9Vc1jPSCUe
	 kH64/fOehRAiYgKqwbqi9GPfiqFqD/xdMNXxmpKLrHO3EMpVt/FAC+PAGWnAg4w7Sc
	 IyCRX0eNg7Bgg==
From: Kalle Valo <kvalo@kernel.org>
To: "Nicolas Escande" <nico.escande@gmail.com>
Cc: "Santhosh Ramesh" <quic_santrame@quicinc.com>,
  <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  "Sathishkumar Muruganandam" <quic_murugana@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: fix tx power, max reg power update to
 firmware
References: <20240909073049.3423035-1-quic_santrame@quicinc.com>
	<D41LUTO0MIC3.12475D2J3VNX3@gmail.com> <87mskhgpox.fsf@kernel.org>
	<D41OHKZYZR9E.2JD7SQKZBBYGH@gmail.com>
Date: Mon, 09 Sep 2024 14:15:58 +0300
In-Reply-To: <D41OHKZYZR9E.2JD7SQKZBBYGH@gmail.com> (Nicolas Escande's message
	of "Mon, 09 Sep 2024 12:23:48 +0200")
Message-ID: <87a5ghgjrl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Nicolas Escande" <nico.escande@gmail.com> writes:

> On Mon Sep 9, 2024 at 11:07 AM CEST, Kalle Valo wrote:
>
>> "Nicolas Escande" <nico.escande@gmail.com> writes:
>>
>> > On Mon Sep 9, 2024 at 9:30 AM CEST, Santhosh Ramesh wrote:
>> >
>> > [...]
>> >
>> >> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> >> index 137394c36460..6d7a005d83b4 100644
>> >> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> >> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> >> @@ -7217,9 +7217,9 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
>> >>  							chandef->chan->band,
>> >>  							arvif->vif->type);
>> >>  	arg.min_power = 0;
>> >> -	arg.max_power = chandef->chan->max_power * 2;
>> >> -	arg.max_reg_power = chandef->chan->max_reg_power * 2;
>> >> -	arg.max_antenna_gain = chandef->chan->max_antenna_gain * 2;
>> >> +	arg.max_power = chandef->chan->max_power;
>> >> +	arg.max_reg_power = chandef->chan->max_reg_power;
>> >> +	arg.max_antenna_gain = chandef->chan->max_antenna_gain;
>> >>  
>> >
>> > For what it's worth, I already got a similar patch from QCA a few month ago, and
>> > it fixed some tx power problems when scanning so I know there is truth in this.
>>
>> What hardware and what firmware did you use? The firmware branches can
>> behave differently so whenever testing something it's good to include
>> that info.
>
> Well what I tested was with the additionnal patch provided. So depending on
> Santhosh response, I'll either give the proprer tested by tag, or if the patch
> isn't needed. I'll need to find some time to test it :)

Can you say what hardware (QCN9274 or WCN7850) you are using? I'm not
asking for Tested-on tag, just some extra information to help the
review.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

