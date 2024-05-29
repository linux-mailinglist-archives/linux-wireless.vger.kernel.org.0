Return-Path: <linux-wireless+bounces-8263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2B18D37A8
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 15:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6FCE288B03
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 13:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737D6E554;
	Wed, 29 May 2024 13:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zscgljYt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008BB14292;
	Wed, 29 May 2024 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989504; cv=none; b=bj21HYhXi2m31HUcDW43iBijS+CrM8VGNS9Wxf01aPJIzLLSG/Ml6h/2Tb7ZtB4K8Ai22GFZyk4N/8iEEAnMhPKe2xYwMoLC85w3pOpnGp9L/NqJEEyGRODTJlLcpV8RWFE4BaZg+HJiJeUoIZYzc6HgoThTWUEvP4PfG2qOfxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989504; c=relaxed/simple;
	bh=0P7pXe69+4YQNTzp+01XM7mW8AzJM2VfMIN8IkVeLr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7airbZXD7/djTxlRP/R/YkkrTZaKbbbBnynRY/DG9sT8F6yT0mC/A7MC8rnPXsblxaUzL+sNYPi2WG651FxdQoWjrMTmz2BKtuZSM9+1ywdGCKybUAh4KYaVF6amWZdZ8bJq00e74tDRpflVbNqKVC1wCEdG+b302XtArg7pzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zscgljYt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YwVYPPJP91MPMhgrxE4Hs+BEo5W7xjePcgEPmhKjh1w=; b=zscgljYtzLTJlyx/fGphVnJySG
	bUqRQNp+j7Mfg+4pAii6SajhZMrSNx8POI7e/GLTQJAML08YpEifJVg6FpwQqKf4HJOcyqHIALgBr
	Hyhx8wVF4IoupXktezL13bFtrLv2VNUSD/FmygUIKDM5nUh4+odtQnH+HdIAIcAwwsniD9aSpF+jm
	RMWYkgAZ0drA2jfCzH8mxwuMGSj5yALv8qTUonZd5tkw9sBVOfp4B1LVRTUlKMrQksgexc1pe5nZT
	IG1Eh8pBDGV8fLY40EQP9LVCO1lP6yL3m7vSvDsqXskUpqXjLuky9zrno0LdVC300G+9d2uwLgH1V
	74sX9bwA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37240)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sCJOv-0006Bl-2l;
	Wed, 29 May 2024 14:31:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sCJOx-0004Ek-70; Wed, 29 May 2024 14:31:35 +0100
Date: Wed, 29 May 2024 14:31:35 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Nemanov, Michael" <michael.nemanov@ti.com>
Cc: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless-next 4/8] wifi: wlcore: pass "status" to
 wlcore_hw_convert_fw_status()
Message-ID: <ZlcuNxmpMlHOMPXL@shell.armlinux.org.uk>
References: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
 <E1sBsxx-00E8vi-Gf@rmk-PC.armlinux.org.uk>
 <abbb5c02-6cda-41c6-9900-06e7f4920541@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abbb5c02-6cda-41c6-9900-06e7f4920541@ti.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, May 29, 2024 at 04:15:13PM +0300, Nemanov, Michael wrote:
> On 5/28/2024 12:17 PM, Russell King (Oracle) wrote:
> > @@ -392,7 +392,7 @@ static int wlcore_fw_status(struct wl1271 *wl, struct wl_fw_status *status)
> >    	if (ret < 0)
> >    		return ret;
> > -	wlcore_hw_convert_fw_status(wl, wl->raw_fw_status, wl->fw_status);
> > +	wlcore_hw_convert_fw_status(wl, wl->raw_fw_status, status);
> >    	wl1271_debug(DEBUG_IRQ, "intr: 0x%x (fw_rx_counter = %d, "
> >    		     "drv_rx_counter = %d, tx_results_counter = %d)",
> > -- 
> > 2.30.2
> 
> Agree this is more consistent. Maybe *status shouldn't be an argument to
> wlcore_fw_status at all? It's called only in one place with wl->fw_status
> anyway.

I did consider that, and if we removed the argument, it would make sense
to add a local "status" variable at the top of this function anyway,
otherwise endlessly referring to wl->fw_status.foo instead of
status->foo becomes quite tiring and needlessly verbose (which means
less readable.)

That's something which could be done as a separate patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

