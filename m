Return-Path: <linux-wireless+bounces-12700-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E40FD972365
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 22:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A3A1F22B82
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 20:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2F218A6A8;
	Mon,  9 Sep 2024 20:15:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BCC175D20
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 20:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912908; cv=none; b=D6XRDhOqJ095byc9w2k1Az42XLXFygkBk9StoVfjnleBmRLV52rjqvRzVCpTDMYKzoEni1h49RCs/gL7eZ7Ne0xMWPIBjXz0SMSUx0otKDJiURiGedVaEl8gyYaw/5Iryh/aqYESJqBe8Pg+Ca0PWf6gNu4oDPpdyuGt4BduCXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912908; c=relaxed/simple;
	bh=w1ZHnNttzigHIHgU3HoX7VsXdlnd/+MdjNaNiG/viAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dX4gY7RB21y5RpNOaKegOwqAFnwzbKfKJrVnaqEwzsbgEIJQAbsaU+k+8iDmP/+x3J0DNOZiwucrgTeMwc0tHvnMuTgo+umx+cX6J1ApKMKg7yuAsEAMAC3n78cYPfdiWQ/hqEGgSkOtJ/WsUkx84ZDWlzI/MQQ//62CLYGlP+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1snkmn-0004zD-Jb; Mon, 09 Sep 2024 22:14:57 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1snkmm-006jWb-RV; Mon, 09 Sep 2024 22:14:56 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1snkmm-00Fo7L-2Q;
	Mon, 09 Sep 2024 22:14:56 +0200
Date: Mon, 9 Sep 2024 22:14:56 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] wifi: mwifiex: drop asynchronous init waiting code
Message-ID: <Zt9XQNnrdgwly0yO@pengutronix.de>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
 <20240826-mwifiex-cleanup-1-v1-12-56e6f8e056ec@pengutronix.de>
 <Zt8s4xEun6VL-pHW@gaggiata.pivistrello.it>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt8s4xEun6VL-pHW@gaggiata.pivistrello.it>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Mon, Sep 09, 2024 at 07:14:11PM +0200, Francesco Dolcini wrote:
> On Mon, Aug 26, 2024 at 01:01:33PM +0200, Sascha Hauer wrote:
> > Historically all commands sent to the mwifiex driver have been
> > asynchronous. For this reason there is code that waits for the
> > last initialization command to complete before going on. Nowadays the
> > commands can be sent synchronously, meaning that they are completed
> > when the command call returns. This makes all the waiting code
> > unnecessary. It is removed in this patch.
> 
> I am not sure to understand this. Is the code to have asynchronous command gone
> or it is just not used anymore? In the code here you remove waiting for the
> firmware init to be complete, but from the patch is not clear why this is not
> needed anymore.  Maybe a specific commit you can reference in which such
> support was removed?

Commands can still be sent asynchronously by passing sync=false to
mwifiex_send_cmd(), but this is no longer done in the initialization
phase as of:

| commit 7bff9c974e1a70819c30c37d8ec0d84d456f8237
| Author: Stone Piao <piaoyun@marvell.com>
| Date:   Tue Sep 25 20:23:39 2012 -0700
| 
|     mwifiex: send firmware initialization commands synchronously
| 
|     The driver will send some commands to firmware during the
|     initialization. Currently these commands are sent asynchronously,
|     which means that we firstly insert all of them to a pre-allocated
|     command queue, and then start to process them one by one. The
|     command queue will soon be exhausted if we keep adding new
|     initialization commands.
| 
|     This issue can be resolved by sending initialization commands
|     synchronously because each command is consumed and the buffer is
|     recycled before queuing next command.
| 
|     Signed-off-by: Stone Piao <piaoyun@marvell.com>
|     Signed-off-by: Bing Zhao <bzhao@marvell.com>
|     Signed-off-by: John W. Linville <linville@tuxdriver.com>

I'll mention this commit in the commit message next round.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

