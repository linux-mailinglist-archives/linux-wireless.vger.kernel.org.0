Return-Path: <linux-wireless+bounces-13452-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB4198EBC2
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 10:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4B51C21348
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 08:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1052913CA95;
	Thu,  3 Oct 2024 08:37:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from amphora2.sui-inter.net (amphora2.sui-inter.net [80.74.147.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA1D13B59E;
	Thu,  3 Oct 2024 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.74.147.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727944658; cv=none; b=ooOo6sak4YsrF9VhfL23qYPIOAzxGC9KDncSyKclAx3gfPq632Sd4SEwpLXG1CeEapcEH1WN6L8EANFyMKB6d5HJE7Kodqd79iYt1vC9TObe1BRvsoawB9boT2rydftMycfJt8LQJhll0r0+bmwTGO6T6MIJaGZ+ypU68mcLiKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727944658; c=relaxed/simple;
	bh=VlXGFUPTnxuv01crg2y/kTICfz398V5hg/J67+gmyOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/bsJFz+YdvqAvjdHrm+kNU8EVjpFDAZQbP31E1umZ5vShkzQWzB2iiyITrwRFW5TUxKahtVvBcJowvYA9hAeOCs7thDEpw8skJ92vIabiQtkFJiWEIOMl0QFdVLIkhCcD9YyWLoRXYZH6Mibnrt0Id23EpOHlPDWwIzQ8t7UvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hqv.ch; spf=none smtp.mailfrom=hqv.ch; arc=none smtp.client-ip=80.74.147.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hqv.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hqv.ch
Received: from [IPV6:2a02:16a:3e26:1:3cd5:9e06:a16e:30ce] (localhost [127.0.0.1]) by amphora2.sui-inter.net (Postfix) with ESMTPSA id 026E79680A0D;
	Thu,  3 Oct 2024 10:37:34 +0200 (CEST)
Authentication-Results: amphora.sui-inter.net;
        spf=pass (sender IP is 2a02:16a:3e26:1:3cd5:9e06:a16e:30ce) smtp.mailfrom=rs@hqv.ch smtp.helo=[IPV6:2a02:16a:3e26:1:3cd5:9e06:a16e:30ce]
Received-SPF: pass (amphora.sui-inter.net: connection is authenticated)
Message-ID: <5e7195e3-60fa-4aa4-9b8d-82d4f740deb6@hqv.ch>
Date: Thu, 3 Oct 2024 10:37:33 +0200
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
 <1a53a5bc-b314-4037-87ab-c86f48844405@hqv.ch>
 <PA4PR04MB9638365BF47644D6140365B3D1712@PA4PR04MB9638.eurprd04.prod.outlook.com>
Content-Language: en-US, de-CH
From: Reto Schneider <rs@hqv.ch>
In-Reply-To: <PA4PR04MB9638365BF47644D6140365B3D1712@PA4PR04MB9638.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

On 03.10.24 06:30, David Lin wrote:
> With this I hope you would support nxpwifi upstream. Please let me know if you have any further concerns.

Just to be clear: I am not a Wi-Fi developer. Just a (potential) 
customer trying to express that the way NXP is (not) taking care of its 
upstream Wi-Fi drivers does not inspire confidence in me.

More words are unlikely to change my opinion about this. What would 
change my mind: NPX becoming maintainer of the 
drivers/net/wireless/marvell drivers. Two of them are even orphaned.

Kind regards,
Reto


