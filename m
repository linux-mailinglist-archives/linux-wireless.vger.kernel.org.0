Return-Path: <linux-wireless+bounces-20842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D651A7165A
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 13:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2A116F120
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 12:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB0856B81;
	Wed, 26 Mar 2025 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="i2y/+akQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA071799F;
	Wed, 26 Mar 2025 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991504; cv=none; b=UOUh3WRI3Ioue8H7zfGDwlGURGxOW+dSF4SiercWyNKuy4GXrH9MRCZR8ghSd9uKdqzoyC7zfHUXZuuN9B0oP34TQkiKRLEIH4Hzb3+2AsKx+nzaS46LYMgOKs+cZPbybhLhpGipMm9qTpvG7wyc6sj4rXuo6onXeYqSGaK6ZSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991504; c=relaxed/simple;
	bh=zG4vbF65PHAnfVOZGy+ENwZEFfSF2q/SBVWSGtFFQr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLQ+aspiMN75A5yKpB2Z0zRRmWEpYWHbKJ1vfwlYVJcI1n9X6l1Mm1k8OX1WquftXyEdwGOtc9Nh5OWjuy8PV6HqDcYqFmhNzs56ny7nildL2G1YTI0+tSKQO4fQI5EXubZRcBn8uBFjcel+6CcHaBFzgLf/y5x1OIG1fPTQCW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=i2y/+akQ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id EEF991FE13;
	Wed, 26 Mar 2025 13:18:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1742991491;
	bh=4Au+P3GwIfQbeWhiTsUSF5cUj7XIGx6NiyDPRZQtBnQ=;
	h=Received:From:To:Subject;
	b=i2y/+akQ2AIj7mmV3o+tdVK77ECT0/K7VrwHQp32aAfGt8VsNW7wRVllxeQPj33tl
	 psTJJojwxHrX4lVssNStoWSly3XC5MQDHRpxn4nPpGC8hrh9AZC+fbMmZ4+9ZgB10W
	 0J81KgwstuVu/bRhH7VJHzd6VWaYqfdqT39jvjj0v2KijfPMwIFWdmC7AB1xKjDm+8
	 Lqw44nYDK8sinTo3RiUM18GEJIxVRngcarfnhkjI+LApiyEY5j3birDArMIOPAB+3F
	 3Y4ZcbIhJxwQTy+jCvm5CnwP48Fro2zv7Rk+j4o18T3MIS5ScIAjPa88I2k3ETHBHh
	 CEl3kn8rSH9MA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id A2B1D7F95B; Wed, 26 Mar 2025 13:18:10 +0100 (CET)
Date: Wed, 26 Mar 2025 13:18:10 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Jeff Chen <jeff.chen_1@nxp.com>,
	"briannorris@chromium.org" <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [EXT] Re: [PATCH v4 1/2] wifi: mwifiex: Fix premature release of
 RF calibration data.
Message-ID: <Z-PwgtSRNoCd2L3z@gaggiata.pivistrello.it>
References: <20250220061143.1417420-2-jeff.chen_1@nxp.com>
 <20250318050739.2239376-2-jeff.chen_1@nxp.com>
 <20250319162842.GA46894@francesco-nb>
 <PAWPR04MB9910FE139C88507DE5904ABD9CA72@PAWPR04MB9910.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAWPR04MB9910FE139C88507DE5904ABD9CA72@PAWPR04MB9910.eurprd04.prod.outlook.com>

On Tue, Mar 25, 2025 at 04:43:33PM +0000, Jeff Chen wrote:
> From: Francesco Dolcini <francesco@dolcini.it>
> > On Tue, Mar 18, 2025 at 01:07:38PM +0800, Jeff Chen wrote:
> > > This patch resolves an issue where RF calibration data was being
> > > released before the download process. Without this fix, the external
> > > calibration data file would not be downloaded at all.
> > >
> > > Fixes: d39fbc88956e ("mwifiex: remove cfg_data construction")
> > > Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
> > 
> > The code looks ok to me, however I do not understand the commit you
> > selected as fixes tag.
> > 
> > From what I understand releasing the data before using it was done since the
> > initial commit 388ec385d5ce ("mwifiex: add calibration data download
> > feature"). What am I missing?
> 
> Thank you for reviewing the patch. You are correct-the Fixes tag I included was incorrect.
> After re-examining the issue, I found that the premature release of RF calibration data 
> cannot be reproduced, which invalidates the problem statement for this patch.  
> 
> I have decided to withdraw the patch. I appreciate your feedback and attention to detail, 
> which helped identify this oversight.  

To me the code change is correct, and it is also merged in wireless-next. No
reason to drop it because of my comment on the fixes tag.

Brian: are you ok with that?

Francesco


