Return-Path: <linux-wireless+bounces-13316-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A837989D34
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 10:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93991B2425D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 08:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EB61865E3;
	Mon, 30 Sep 2024 08:47:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from amphora2.sui-inter.net (amphora2.sui-inter.net [80.74.147.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BF417C7A3;
	Mon, 30 Sep 2024 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.74.147.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686045; cv=none; b=elRSvsQOok5QT5z7R79ud9ByCyyBIXOrKRHQIuBruRt0bgYitWu44cnqxx7Q2Shm9DOws/S5n/Vao3C5OttQ2OExNBgK4YdhfUJFeyQmWKBLxJK/xV3tc97XlKxiaIScu2yr/spTaHg8ihgDhkR9IHWMia1WnD/PIv/D0OJc+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686045; c=relaxed/simple;
	bh=QxhZnwlrbbVVbS/DyQWT/dfY83S0RBvX1CzyA0kvaDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i377IY6KKe/09pSu65eRDE9+89d4DhCVv0sMPhjM4H4Nht58bm8W/vUKz1MlbNxqMk9rHauzWleZCXQQI7wMDEKd2XGnp1W3wX8RLXgTSFwIFdu71saKeO7FabBIPorNiGH1vDIWNjCnxbfbszz3uo1w5Eq/k58fnLdVye+MvHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hqv.ch; spf=none smtp.mailfrom=hqv.ch; arc=none smtp.client-ip=80.74.147.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hqv.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hqv.ch
Received: from [192.168.172.95] (localhost [127.0.0.1]) by amphora2.sui-inter.net (Postfix) with ESMTPSA id 76C5A96824BD;
	Mon, 30 Sep 2024 10:41:59 +0200 (CEST)
Authentication-Results: amphora.sui-inter.net;
        spf=pass (sender IP is 178.197.176.65) smtp.mailfrom=rs@hqv.ch smtp.helo=[192.168.172.95]
Received-SPF: pass (amphora.sui-inter.net: connection is authenticated)
Message-ID: <e93e1dd6-c215-4168-83e9-b8199599bc09@hqv.ch>
Date: Mon, 30 Sep 2024 10:41:58 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
To: David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org, kvalo@kernel.org,
 francesco@dolcini.it, tsung-hsien.hsieh@nxp.com, s.hauer@pengutronix.de
References: <20240930063701.2566520-1-yu-hao.lin@nxp.com>
Content-Language: en-US, de-CH
From: Reto Schneider <rs@hqv.ch>
In-Reply-To: <20240930063701.2566520-1-yu-hao.lin@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

Answering here because an OEM proposed using the IW612 in an upcoming 
product of my employer.

On 30.09.24 08:36, David Lin wrote:
> [1] We had considered adding IW61x to mwifiex, however due to FW
>      architecture, host command interface and supported features are
>      significantly different, doing this on mwifiex will carry a lot of
>      burdens. The effort of making sure no regression is also a huge effort.
>      We must create a new driver nxpwifi. Subsequent NXP chipsets will be
>      added and sustained on nxpwifi only.

As developer, this sounds like a huge red flag. In the long-term 
interest of my employer, I'd oppose using this type of hardware in our 
products even if you manage to upstream the driver (as is).

Kind regards,
Reto


