Return-Path: <linux-wireless+bounces-12064-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5DD960937
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 13:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08E628118D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 11:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2651A00C9;
	Tue, 27 Aug 2024 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwvqaVWm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587C219FA72
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759126; cv=none; b=lmydfv5tDR4oOhWfZWm6gMtqijfZjGo+wZG3Txw3+LRi8MeBb9GbzRzQ4GID8MVICwZnjK23ZpsAQhWWCOS72jKr7SzzLh0GLEZ7wkdvmbUAm+QPwLJ68mtrXxzTJC0umyBSn7RTk/iAOO9OOhogj/5jY85fQ/TwlkgZ/ht4lf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759126; c=relaxed/simple;
	bh=P2RbAb44MrCKiyQ65QKa4zsMh7kX9jbcaXngW1O/Izw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=PmapkHTruzdglWKGtT+bF8FqD77hsDX6NPqUX07vKG6WRRyXTfWfBCoh9r3RbpSg/hlTB070cLbOEJ3/oBaLXV25Nskc0zyMZdZMrXCNApz4/XKdlAxXv9KnDrblgMKaRlNsFhVIrUbUR85Q+K1qQ6fsUK39HEd+82plTIuRgvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwvqaVWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1135C6104D;
	Tue, 27 Aug 2024 11:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724759123;
	bh=P2RbAb44MrCKiyQ65QKa4zsMh7kX9jbcaXngW1O/Izw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=uwvqaVWmcn/LTPL/u6n1CZPirGd9f+Vyd5bTfw5QNrFVafG3NByiS8yiYfo/US0D+
	 JJqAz+hAHPtzs1N43g9SVe5Ld9792Vats3kRFRSj6fbFcutlqtmzRFK8Q9KGDsezbS
	 mD1ljxrWh6QeqR/teaL/rSBOA/aywEXlgdybeIe1hacfzs9yRV/4T8f0cv+pgiDiS/
	 QOiUecraM0/OYH15VuG/Qe5uf5JlOPKqVelB09zpp79cSMCB/ydjKGI/AzlBdshwHB
	 ugmhglN0lWT7ogFrt/L9JorqycnIVRekvezo6v5mRjRSJw1BWgjaqV1dejzbGqj0UE
	 gAiWnRsD1JbFw==
From: Kalle Valo <kvalo@kernel.org>
To: Kavita Kavita <quic_kkavita@quicinc.com>
Cc: <johannes@sipsolutions.net>,  <linux-wireless@vger.kernel.org>,
  <quic_mpaluri@quicinc.com>
Subject: Re: [PATCH] wifi: cfg80211: skip regulatory checks when the channel
 is punctured
References: <20240826123341.5405-1-quic_kkavita@quicinc.com>
	<87cylvf6k5.fsf@kernel.org>
	<1cb1976c-ef81-4f9f-8bf5-bc48195855dc@quicinc.com>
Date: Tue, 27 Aug 2024 14:45:21 +0300
In-Reply-To: <1cb1976c-ef81-4f9f-8bf5-bc48195855dc@quicinc.com> (Kavita
	Kavita's message of "Tue, 27 Aug 2024 14:58:58 +0530")
Message-ID: <87wmk2dwa6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kavita Kavita <quic_kkavita@quicinc.com> writes:

> On 8/27/2024 12:35 AM, Kalle Valo wrote:
>> Kavita Kavita <quic_kkavita@quicinc.com> writes:
>> 
>>>
>>> Co-developed-by: Manaswini Paluri <quic_mpaluri@quicinc.com>
>>> Signed-off-by: Manaswini Paluri <quic_mpaluri@quicinc.com>
>>> Signed-off-by: Kavita Kavita <quic_kkavita@quicinc.com>
>>
>> Kavita, is your first and last name really the same? Just trying to
>> verify that s-o-b is correct.
>
> Yes, My first name is same as last name.

Thanks for confirming, you have a cool name :)


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

