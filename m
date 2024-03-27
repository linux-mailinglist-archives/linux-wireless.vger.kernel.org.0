Return-Path: <linux-wireless+bounces-5317-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCFB88DA16
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 10:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1B41C27F19
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 09:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A67129D03;
	Wed, 27 Mar 2024 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQKYYzIw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546E324B26
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711531126; cv=none; b=Ixz7TrcReVir2jNwR6U68VzWEoMIwjXv+zoM7ExNivCl16sob3uFEJ95qX5WHcSCW5Hczr/Co/3TeYxi0qIO0R8g1Z0EqZIToTlXaKoARcn/AJbmV2CFD+C4nm2EFpdUKjUHFbo1Kz0AV90ak32KmhE+m6Yc7al7hLcdBdlys3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711531126; c=relaxed/simple;
	bh=pXJBIn3/yHYZoNBzASByKDP3tGP88hTWf82ffXkylfs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ts3ivBDSDk1oOGcMFoE7q7v+MIVwY4t53iIYypWlNDan4iz8wcbIU7Pk1Q9tLMFBlQsHx4jr3TwHsPWWoVAnzTxvBOId4225qvS4rtHtTQo6xqfMD7edQ/hSw1OuU3kWa6VFAPwaV86kye3QLJtulswpWzXEoq5OfDprNWv43+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQKYYzIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0FBC433F1;
	Wed, 27 Mar 2024 09:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711531125;
	bh=pXJBIn3/yHYZoNBzASByKDP3tGP88hTWf82ffXkylfs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=BQKYYzIwXeTryHe+g08v3+4Cs79y38cfk6ebX6C1LGv5Jv3Rzuw6/KSi33mMAcTJu
	 KFUpXNgGmgk6YEkp3nZ4uQTUov19iNVQV81ID0s4abhU1Ue+7SobupfETiGgEnlFnu
	 3Y/wWkK0D2EsYB9K1KrBQNvFnbixy62PvS/mndJUG0aqn2aBT7gE8sP/8s8QgI/17v
	 O9FM0HWbHDjd1yMQm4u02R3uG2KwA+QsrYJPymQxcR79acdrhMWzLO+/XPyvakqWV0
	 IfAkNZr5CTQh5VOT1qQwLBSmHpXuoiqy32muTn8gpR87Bj20cgG0F/o64nwM1l4wGb
	 htrhZzmZj1Jyw==
From: Kalle Valo <kvalo@kernel.org>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>,  "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>,  "Larry.Finger@lwfinger.net"
 <Larry.Finger@lwfinger.net>,  "s.l-h@gmx.de" <s.l-h@gmx.de>,
  "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: Re: [PATCH v3 04/12] wifi: rtlwifi: Add rtl8192du/table.{c,h}
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
	<ed50254c-889e-4dcd-93db-f63b776e3503@gmail.com>
	<5170c29a7b565fdec2e004f9391d325328ef5a72.camel@realtek.com>
	<8a90f3cb-7218-4f23-8aa7-fcc68e2f4a93@gmail.com>
Date: Wed, 27 Mar 2024 11:18:42 +0200
In-Reply-To: <8a90f3cb-7218-4f23-8aa7-fcc68e2f4a93@gmail.com> (Bitterblue
	Smith's message of "Tue, 26 Mar 2024 19:30:11 +0200")
Message-ID: <87y1a4yqvh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:

>>> --- /dev/null
>>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.c
>>> @@ -0,0 +1,1675 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/* Copyright(c) 2009-2012  Realtek Corporation.*/
>>> +
>>> +#include <linux/types.h>
>>> +
>>> +#include "table.h"
>>> +
>>> +u32 rtl8192du_phy_reg_2tarray[PHY_REG_2T_ARRAYLENGTH] = {
>> 
>> static const ?
>> 
>>> +
>>> +u32 rtl8192du_phy_reg_array_pg[PHY_REG_ARRAY_PG_LENGTH] = {
>> 
>> static const ?
>> 
>
> I can make them static if I move them to table.h. Only phy.c
> includes this header, so that should be fine.

Do note that .h files can't contain static variables, otherwise there
will be duplicate data.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

