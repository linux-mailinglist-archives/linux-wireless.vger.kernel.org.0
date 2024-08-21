Return-Path: <linux-wireless+bounces-11736-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE08959A8F
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 13:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3213EB292C1
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 11:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791D81CB12B;
	Wed, 21 Aug 2024 11:11:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47451C9431
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238700; cv=none; b=tc2bZWeCo2qZr2Xth7K3qppmmyOXzfeKTnujDP0koX5BWqrsXVRHt3n9Q+UQsgnO94KKnBI/vQJpSBXoRFv/AN5adPxoAgviSKnkkek7S7fXp32n4Yz37rXIO8ddWFJtzjfaPRWsjsnZi1Ajh4pNYkXnKpKRORp4oe7QFrpqaOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238700; c=relaxed/simple;
	bh=hFw47CKql1898Jz7qJoeobQSUqyubuobzVRlBMYF/r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6C97DPGnyoinkQOq+t7RJNdAmsLIq6jtmC+baEbLnz9WJ3qrshCnS2/Nn7kh7hgVlijY03cW9+bBnU04VJsFucVnms5uWs0gD45UgkRToCOfqhWF+3x5AU1Kqylbh7eCAHVWyCZfMSYriu1D1Wpxx9tZsvPXeQ6FeqRVpAdK+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sgjFT-0003wZ-9e; Wed, 21 Aug 2024 13:11:31 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sgjFS-001zqB-GS; Wed, 21 Aug 2024 13:11:30 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sgjFS-00FVKX-1I;
	Wed, 21 Aug 2024 13:11:30 +0200
Date: Wed, 21 Aug 2024 13:11:30 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 00/31] wifi: mwifiex: cleanup driver
Message-ID: <ZsXLYgLfZ8nIns5z@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
 <1B5E3131-0595-47A8-BB8E-14B7B6C3FA7F@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1B5E3131-0595-47A8-BB8E-14B7B6C3FA7F@dolcini.it>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Tue, Aug 20, 2024 at 03:34:12PM +0200, Francesco Dolcini wrote:
> Hello Sasha,
> thanks for the patches.
> 
> Il 20 agosto 2024 13:55:25 CEST, Sascha Hauer <s.hauer@pengutronix.de> ha scritto:
> >This series has a bunch of cleanup and bugfix patches for the mwifiex
> >driver
> 
> Would it make sense to sort the patch series in such a way that bug
> fixes can be backported to stable/long-term versions?

I anticipated this question, but I was too lazy this time. Given that
Kalle asked to split up this series I'll reorder this series and send
the bug fixes first.

> Are those bug
> you could reproduce or just something you noticed while looking into
> the driver?

There are bugs I noticed because the driver didn't work as expected
which made me dive into this code. There are others that I only noticed
by looking at the code.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

