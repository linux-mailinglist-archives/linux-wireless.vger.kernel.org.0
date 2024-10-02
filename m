Return-Path: <linux-wireless+bounces-13430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA3498DF6B
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 17:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1160B2EA3E
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 15:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFFA1D0E25;
	Wed,  2 Oct 2024 15:26:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from amphora2.sui-inter.net (amphora2.sui-inter.net [80.74.147.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206A31D0B86;
	Wed,  2 Oct 2024 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.74.147.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882799; cv=none; b=VtknZawguon74bigapj/RLw93O4dSDWyiVcmGvB3758yWdBazManond7Zkj3qu2h/oE3BV7eHW+C/fJxFSVZvm8ZknOloUHv1ZoYEVG+fmH5YsBw9PtPXhzUIAQmqgO202ZQrKXvDZTAyQuFtDtvAwBCdgMMC5QysaNhQeDEC90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882799; c=relaxed/simple;
	bh=dS0t9UpACVbkUwB+alBgK5bzrJbfQUIH4VNrFnEDi8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qy12VjAghRkJu1tbS0mjOIG42ktgcGnHoFwgGXcocLXDDOB9m4hQmPSGUlii+ukmqiJwqXHFrxMvkYuk3uULGUOqYRFeRcddnW0Z8xPEcxNgmA5USq1iatm8XULZn4bQakGQ6J1KR/rVsSihDKd4THyIg+bSPyKv7qs5SfuwRPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hqv.ch; spf=none smtp.mailfrom=hqv.ch; arc=none smtp.client-ip=80.74.147.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hqv.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hqv.ch
Received: from [IPV6:2a02:16a:3e26:1:e903:b094:c916:b028] (localhost [127.0.0.1]) by amphora2.sui-inter.net (Postfix) with ESMTPSA id AFE2A968065D;
	Wed,  2 Oct 2024 17:26:28 +0200 (CEST)
Authentication-Results: amphora.sui-inter.net;
        spf=pass (sender IP is 2a02:16a:3e26:1:e903:b094:c916:b028) smtp.mailfrom=rs@hqv.ch smtp.helo=[IPV6:2a02:16a:3e26:1:e903:b094:c916:b028]
Received-SPF: pass (amphora.sui-inter.net: connection is authenticated)
Message-ID: <1a53a5bc-b314-4037-87ab-c86f48844405@hqv.ch>
Date: Wed, 2 Oct 2024 17:26:27 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v3 00/22] wifi: nxpwifi: create nxpwifi to
 support iw61x
To: David Lin <yu-hao.lin@nxp.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "briannorris@chromium.org" <briannorris@chromium.org>,
 "kvalo@kernel.org" <kvalo@kernel.org>,
 "francesco@dolcini.it" <francesco@dolcini.it>,
 Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20240930063701.2566520-1-yu-hao.lin@nxp.com>
 <e93e1dd6-c215-4168-83e9-b8199599bc09@hqv.ch>
 <PA4PR04MB96380EE5216693C9CCE16030D1702@PA4PR04MB9638.eurprd04.prod.outlook.com>
Content-Language: en-US, de-CH
From: Reto Schneider <rs@hqv.ch>
In-Reply-To: <PA4PR04MB96380EE5216693C9CCE16030D1702@PA4PR04MB9638.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

On 02.10.24 03:29, David Lin wrote:
> Mwifiex has been put in “Odds Fixes” state for quite some time.

What I read: NXP (who has taken over the Marvell BLE/Wi-Fi business) is 
not willing to maintain products once they have sold it.

> Now we have planned to add series of new chips and features.
> Although some of the codes are from Mwifiex, we do spend much effort to enhance the FW/driver interfaces and a few other areas
> Our proposal is, mwifiex continues support only existing devices.

mwifiex does not continue to do anything on its own, it requires 
continuous maintenance. And NXP is not doing that:

$ git log --no-merges --oneline drivers/net/wireless/marvell/mwifiex/ | 
wc -l
643
$ git log --no-merges drivers/net/wireless/marvell/mwifiex/ | grep 
^Author:.*nxp.com | wc -l
7

> New NXP connectivity chips and features will be added to nxpwifi only.
> We are also committed to regular QA and maintenance for nxpwifi.

What I read: NXP is eager to support new hardware, but does not take 
adequate support of hardware they sold in the past.

> May I know what is your concern on upstream this driver so we can better address it?

 From my PoV as a potential customer: NXP cleaning up the mwifiex driver 
would give me confidence that whatever comes next from NXP will be taken 
care of adequately too. Also in the long term, which is a must when 
choosing components for products that need to be supported for many 
years to come.

Kind regards,
Reto


