Return-Path: <linux-wireless+bounces-8329-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1778D53D2
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 22:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C286B2595E
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 20:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792DC142E90;
	Thu, 30 May 2024 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DKvG4OEb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17324140E5F;
	Thu, 30 May 2024 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100630; cv=none; b=YxVSbpVGlIMhf+0IG9Dwqx7hI/SOxc04mbfEM+N5L8F0AcM4rpuTty3yWyRHBj/9gh0Os1Uh+/w0BhVUYUpmRrdogReSlEReeK9jlhhD60zIYO3K6moZF+Sw1YvOyhZ5dxPYsykkur1aSroltT6PRTvUERRo13IN7FGOraL9u+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100630; c=relaxed/simple;
	bh=XXMw+ZTSDnCdxLTvkpBjeLqu7VMK4bvazDtv1ynunEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUH0wQqrWsw58APFPPZulh1PUtTjaFn2eS0fBkYjmp869oaYnZZI+bQHrnmE6oVPEcP43guzck5lnD6Ys5KPuBl0M3T1I60Yfs+IsjKjKh3VYr42HDQVU1mfj6/7zn8YCo6dv+fo59JyVw1pgkn4cvUG0FZaajTu9I+yCRFDwek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DKvG4OEb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fOkX5krpYlFdww4fg3P/piF/9wX4dpPVy6HAgxw/xHE=; b=DKvG4OEbza4zqH4F7Jrg8Fs/w9
	bm2Rc4qR+S73/JhHR7bBPlNYz13fm/8aOItqQ6StEuIq+ylxlcZLiqf5Ucr8Zn3PUYWb7PmYGKiL0
	MN/sZykwfPxq+UM5VSS1haTwdcL16yNrYTuvXRwvnAwxhnC30dT5Hk6RDMEb4LSYvhcK71ilMMSHA
	bqnY2Gztj4XDTB9gM0xEhlyoNfIbYJYXBI/7sqEs+4HccZQZ66TsyX6PNILQA+O6MQjGJL1j3f483
	dgKfNLx8DrOBioWFoxb9tV8zHcJtRqlG1Mzbpi0x5nxWipbQxkw/e8Fy548bTxPquOvA8YoI8J/0n
	Vpe/nASA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57336)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sCmJG-0007mD-32;
	Thu, 30 May 2024 21:23:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sCmJI-0005QW-Bx; Thu, 30 May 2024 21:23:40 +0100
Date: Thu, 30 May 2024 21:23:40 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kalle Valo <kvalo@kernel.org>, Michael Nemanov <michael.nemanov@ti.com>,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless] wifi: wlcore: fix wlcore AP mode
Message-ID: <ZljgTGX/c490HtKo@shell.armlinux.org.uk>
References: <E1sBsK3-00E8Uo-Ab@rmk-PC.armlinux.org.uk>
 <d5ac0440ff009f6975728a87384bb3f4b92ee548.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5ac0440ff009f6975728a87384bb3f4b92ee548.camel@sipsolutions.net>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, May 28, 2024 at 10:54:31AM +0200, Johannes Berg wrote:
> On Tue, 2024-05-28 at 09:36 +0100, Russell King wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> 
> Honestly, while I did write a good chunk of the patch itself, all the
> commit log, actually making it compile/work etc. was all you, so I'd
> suggest to reverse our roles here in the authorship/credits.

Sent v2 with this changed. Thanks.

---
pw-bot: cr

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

