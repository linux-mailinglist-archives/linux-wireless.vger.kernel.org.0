Return-Path: <linux-wireless+bounces-5145-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90E988687B
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 09:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77B80B24CDB
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 08:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6757179B8;
	Fri, 22 Mar 2024 08:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="UXAqmSSS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7718C171AC
	for <linux-wireless@vger.kernel.org>; Fri, 22 Mar 2024 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097372; cv=none; b=hAeZhJrAABI6swnpNV7wXPM4pP8S4wFuITYl/qomXeMddhlizC2lWBHR5xfsYl17l4XXyYrmsEYl40MY5A+PPeFyn5lvSMPYoYMiuTVnja3ZwnKany5fa9lP/9XPMDVC+g9RHqeYL3GJftFjlOvN6TiwBK7gEwfhLaZW3Dsef0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097372; c=relaxed/simple;
	bh=NcOmuevuFHSTb+H9Tw/jfPQowbn1ztK0Q0/M/9EoPv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXzXDaYGrVqt30UbFxw6oe9Khb+WMbzBvuvSDbB7X68+HLcD/IRDTKK9ZNKe/bWaO3NuKwTy99ooBr+BJHr3Ig93y5jf3FtSvSZLMfYV0x4im30laW4zg18U3ERlSQ2FsRbA1TajUOLYZTsUE7cZclQ/dX0nw/wBGEyv8AbIvhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=UXAqmSSS; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:40a4:0:640:8f61:0])
	by forward500c.mail.yandex.net (Yandex) with ESMTPS id DC10C60E33;
	Fri, 22 Mar 2024 11:41:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id FfCcx7QOnGk0-hPjpQ52i;
	Fri, 22 Mar 2024 11:41:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1711096876; bh=NcOmuevuFHSTb+H9Tw/jfPQowbn1ztK0Q0/M/9EoPv8=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=UXAqmSSSd+YdD8GFNX6E7qF+kdA2INAx0+pfUjatBKnQdEUY8OA0zYPGl9hSTMM0V
	 ThczpzzS6XuSuNaeWH58dojHJgG0HllyjR800MrFIraJ90b7DzjnaiH4iD9qm45VIw
	 MrhRJQ8b5DSOUA5yp37m5kkc6MILAcLr5vHxnZjQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <5b0ae31f-11e0-4c31-928e-8b0e22abb799@yandex.ru>
Date: Fri, 22 Mar 2024 11:41:15 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: rtlwifi: drop WMM stubs from rtl8192cu
Content-Language: en-US
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240320084324.109506-1-dmantipov@yandex.ru>
 <167eca8d-0a6b-4203-b8c8-f7ea431547c3@RTEXMBS04.realtek.com.tw>
From: Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <167eca8d-0a6b-4203-b8c8-f7ea431547c3@RTEXMBS04.realtek.com.tw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/24 09:56, Ping-Ke Shih wrote:

> 2 patch(es) applied to rtw-next branch of rtw.git, thanks.

Thanks. Should I use rtw-next of rtw.git for further similar
cleanups (if there will be)?

Dmitry


