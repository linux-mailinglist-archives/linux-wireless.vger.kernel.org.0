Return-Path: <linux-wireless+bounces-4153-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AEB86AA85
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578441C21613
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961B621379;
	Wed, 28 Feb 2024 08:56:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4641D53D
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110564; cv=none; b=VGg5P+RcWEY5sM4fOBPGOYRAILBAwM4HYV7nJa7CbvCQXJ2sh4EuB9+MBdFM+P4byybpoHT/N+Ium0xxvRsXFxgGJBfo1hZOKteLrkhOg/JYJeNDYU/iXpWOThpI7KrtVflTEfEZbez/9QnUchN0amjliKWT8u9uIA2GZxn1ls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110564; c=relaxed/simple;
	bh=bpSJsPzCKvfYSFJ9bhNv8qfnQIhkLP+ASnqF+eIx8gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8jHgeFR5BF5SbqJgKRhSSwz2kLMUccBjUU0EE0n0/M8n46vRxrAPUkVwDyRw9A32RXNq3Eze4gHVz8XnHEH706D3EiaChApSYZk3F5V63DzAjR8kyAYBZVKKGZ/IeXCK5rSUll1DJKMT8NZbqhaXcZ8Ky1sTMLy3dUWGmGM9AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1rfFjE-0004ae-3R; Wed, 28 Feb 2024 09:55:52 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1rfFjB-003MEG-KX; Wed, 28 Feb 2024 09:55:49 +0100
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1rfFjB-00C2L8-1j;
	Wed, 28 Feb 2024 09:55:49 +0100
Date: Wed, 28 Feb 2024 09:55:49 +0100
From: Sascha Hauer <sha@pengutronix.de>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>, Sean Mollet <sean@malmoset.com>
Subject: Re: [PATCH 1/4] wifi: rtw88: 8821cu: Fix firmware upload fail
Message-ID: <Zd71FWoTDn5plI5R@pengutronix.de>
References: <731ea688-04ef-4f02-9d01-3e9026981057@gmail.com>
 <Zd3b81m3_Hh47lww@pengutronix.de>
 <aacc9bf5-90e3-4e7a-af44-33d11fe89c18@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aacc9bf5-90e3-4e7a-af44-33d11fe89c18@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Tue, Feb 27, 2024 at 06:27:51PM +0200, Bitterblue Smith wrote:
> Adding Sean Mollet because I forgot earlier.
> 
> On 27/02/2024 14:56, Sascha Hauer wrote:
> > On Tue, Feb 27, 2024 at 02:18:20PM +0200, Bitterblue Smith wrote:
> >> +	if (addr < 0xFE00) {
> >> +		if (addr <= 0xff)
> >> +			current_reg_sec = REG_ON_SEC;
> >> +		else if (0x1000 <= addr && addr <= 0x10ff)
> >> +			current_reg_sec = REG_ON_SEC;
> >> +		else
> >> +			current_reg_sec = REG_OFF_SEC;
> >> +	} else {
> >> +		current_reg_sec = REG_LOCAL_SEC;
> >> +	}
> >> +
> >> +	if (current_reg_sec != REG_ON_SEC)
> >> +		return;
> > 
> > Is there something we want to do with current_reg_sec == REG_LOCAL_SEC
> > or current_reg_sec == REG_OFF_SEC later? If not the above could be
> > rewritten as:
> > 
> > 	if (addr > 0xff && addr < 0x1000)
> > 		return;
> > 	if (addr > 0x10ff)
> > 		return;
> > 
> > 	...
> 
> Dunno, I just copied the code from the other drivers:
> 
> https://github.com/morrownr/8821cu-20210916/blob/5b39398e2de146edeb76716420f3288f508bea61/os_dep/linux/usb_ops_linux.c#L171

Ok, nothing is done with current_reg_sec here as well, so I suggest
rewriting the check like I suggested.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

