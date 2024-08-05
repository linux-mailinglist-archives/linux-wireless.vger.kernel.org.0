Return-Path: <linux-wireless+bounces-10924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811A6947607
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 09:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3557D2822A3
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 07:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC13A1494C4;
	Mon,  5 Aug 2024 07:27:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CA4146A6F
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722842849; cv=none; b=MqMz9zFqUeoCKKmJdmuwYynu7TWhZrac/3AKkYfq8laQQYhW24U/cX4XgLNMAbVK+zTev96XQLPuKKNvTvCjyZflikyYgKDze3huIRpORCfbDtgLHpOAOSRmvN5wDB2K7ExkGkk3TWZLua9pNUlBx4ACtTu9nWhDkIhk7OnbRA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722842849; c=relaxed/simple;
	bh=zHQyVbDefV1/i4J9e0fn9pzDEblnDJketstKER5oeik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKCgroV9UDp2Y/6zN4jx8MNoQSl2NnMsCx5/76FlZ63g1b3W1MEkn5XItrgc5on/yYFI6/HutKL+EtCcifKYKqWKGp1hJ50+TVP2Dy7hYZi9vyMspkHEgTRpnA6q2HNJW/Y2yqDQEG6e8vmI6Uw6vxgWo9l1oFGyosKl4PUgNjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sas7p-000242-IF; Mon, 05 Aug 2024 09:27:25 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sas7p-004ecc-4j; Mon, 05 Aug 2024 09:27:25 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sas7p-002wdl-08;
	Mon, 05 Aug 2024 09:27:25 +0200
Date: Mon, 5 Aug 2024 09:27:25 +0200
From: Sascha Hauer <sha@pengutronix.de>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH v2 1/4] wifi: rtw88: usb: Init RX burst length according
 to USB speed
Message-ID: <ZrB-3UtaYe9pTFLE@pengutronix.de>
References: <60856bbc-8701-4aee-804c-3d8c00d4f5c5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60856bbc-8701-4aee-804c-3d8c00d4f5c5@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Sat, Aug 03, 2024 at 12:31:57AM +0300, Bitterblue Smith wrote:
> This is needed in order to make USB RX aggregation work with RTL8811CU
> (and presumably RTL8822BU and RTL8822CU also).
> 
> I don't know what BIT_DMA_BURST_CNT, BIT_DMA_MODE, and BIT_DROP_DATA_EN
> are doing.
> 
> Tested with RTL8811CU and RTL8723DU.

I gave this series a test on a RTL8822CU. Works fine here with about
100% receive speed increase.

Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

