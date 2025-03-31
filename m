Return-Path: <linux-wireless+bounces-20986-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D69A75EB6
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 08:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847403A6629
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 06:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6290914F121;
	Mon, 31 Mar 2025 06:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uYE1f7JT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E873320E6;
	Mon, 31 Mar 2025 06:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743401118; cv=none; b=ie63NNqiSn+KzrvYfu+i05F1vW+Of45lMF74/OPUOEeWNb83sOFDJdyORj8tJv2t6iuLzbUkt39TztmI49nHQeUgDdS0s4ICSZgBcrlwlvlPB3P0tjp5ypJ7NuyFBUz+lK36/bEMqstb+AmG65vMxzhIaXTox4UONwCpLTmLz/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743401118; c=relaxed/simple;
	bh=mu8qc/H0Ji8c0nrIbZGL3y2aD+ZAMu1WKi7yAqEZ8RU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JzDWbBdIPW4/9/NJoZTKik4GsIlmW9BBQrmnFtwSE9TKj1ycqRmlEtsZIhRYvUwMvKylSUpRnVynqV4AUq3yAMO77ACRcJCQivnxM/D8q6Jxrvp9LeJDnY2hODhk/SI/pLgOl3TrbUDjYtdny6Sfil0MBp/fAjYP2Tmz8EnIRFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uYE1f7JT; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52V64Oar2697776
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 01:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1743401064;
	bh=EgWUKMQVvlDBHJMOpfOyaq0FyfdEaBQLxQjy0QudGdU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=uYE1f7JTKGXmOgrnGMCWjH4qWOIeeitcpPwQjoXXxQU9dTxz9EoyiBwQhehYbZSwf
	 ey7DghtlyEuemQGQkhCoLyKgeS4LttkpX8I/HOWiOUM7lkxRrmRQK1h9ld7mXEVE4l
	 CzhPBbO1H0dZYl0QjDZnHg4oR98jAivWPCruJskc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52V64NQP065831
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Mar 2025 01:04:24 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Mar 2025 01:04:23 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Mar 2025 01:04:23 -0500
Received: from [137.167.1.99] (lt5cg1094w5k.dhcp.ti.com [137.167.1.99])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52V64Mff055814;
	Mon, 31 Mar 2025 01:04:22 -0500
Message-ID: <3876f271-b13d-414b-800d-c9a3bae5a436@ti.com>
Date: Mon, 31 Mar 2025 09:04:21 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: wl1251: fix memory leak in wl1251_tx_work
To: Abdun Nihaal <abdun.nihaal@gmail.com>, <kvalo@kernel.org>
CC: <linville@tuxdriver.com>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250330104532.44935-1-abdun.nihaal@gmail.com>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <20250330104532.44935-1-abdun.nihaal@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 3/30/2025 1:45 PM, Abdun Nihaal wrote:
> The skb dequeued from tx_queue is lost when wl1251_ps_elp_wakeup fails
> with a -ETIMEDOUT error. Fix that by queueing the skb back to tx_queue.
> 
> Fixes: c5483b719363 ("wl12xx: check if elp wakeup failed")
> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com
Reviewed-by: Michael Nemanov <michael.nemanov@ti.com>


