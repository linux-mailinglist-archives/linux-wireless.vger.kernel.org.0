Return-Path: <linux-wireless+bounces-8171-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8C98D16A1
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 10:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1C91C221A6
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 08:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7981317579;
	Tue, 28 May 2024 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yNdi1PKY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3141517E8FC;
	Tue, 28 May 2024 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716886238; cv=none; b=VTY3VX8bOmPhwcGRfESyTLJ12B1BesM08I72cbjHEGugbQP/caN/fE/VWZqLcuEbFGMZWuRoiXLf8CfpV12D5T/zjJuZlfjb5y1YgnVxSu1YnLvLwFV+7W0J11c6WJnjiIQRA/S6mMUwT971ThZdDrQ4HXp0VMT8eXiDk6Im7AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716886238; c=relaxed/simple;
	bh=BblAZuAEPd+Twh5i+qyTAhKdPmRL/pgrlP0i6GJFcKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDiR5A+mCPROc3yhZsAJik0cd9DAsuvN7AJvIne9ZyHvPYzxQofAUkpqATjxkMP9Wk+y8YFL1ker52K5Pqxh0R2yZ1pxzw3HX7RWxKFemC/CkjrPEyljRYhYNzzYZQhX2+tVLVDuVd8OGkvz1JKDf+NxULoM0jqiC5D+ts0bFIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yNdi1PKY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9Zc40UHqT1754C4pJY6oNIU+MZfNpaKujrXSA577kL8=; b=yNdi1PKYWNcTFuoSzspqPk5xNq
	x4NK2sflqhRY1Tv/Js1Id2NALZtTG8aZXD4OqA93Sg/NigEU6RXToSVRAuPfbTcY6hVHvBvLbvIY+
	yHI+hL53VfUVetEystcnlWb9L+5rVdTKIzy7nfOX/KmhW+srYxaCoYV84ItPX4NB4iwrv57O1IPKt
	pqfzojbmNC4KfMufsmcOP8HB9hihCtg1NNwfE9J7k4pYnlUuU+ilH4I93GrDJcMHKnJJ+MqW4mje6
	VpV+sHY+qEXh4PssDJSMubUn8XUkr3V/6RHxzdbziF0Jwcrr+dlrjehSzJ5JRxwTB9FkX2hw5E+W5
	g+KnwOzw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50462)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sBsXJ-0004Ui-0J;
	Tue, 28 May 2024 09:50:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sBsXJ-000389-K4; Tue, 28 May 2024 09:50:25 +0100
Date: Tue, 28 May 2024 09:50:25 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>,
	Michael Nemanov <michael.nemanov@ti.com>,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless] wifi: wlcore: fix wlcore AP mode
Message-ID: <ZlWa0dJ7eIvcpU9c@shell.armlinux.org.uk>
References: <E1sBsK3-00E8Uo-Ab@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sBsK3-00E8Uo-Ab@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, May 28, 2024 at 09:36:43AM +0100, Russell King wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Using wl183x devices in AP mode with various firmwares is not stable.
> 
> The driver currently adds a station to firmware with basic rates when it
> is first known to the stack using the CMD_ADD_PEER command. Once the
> station has finished authorising, another CMD_ADD_PEER command is issued
> to update the firmware with the rates the station can use.
> 
> However, after a random amount of time, the firmware ignores the power
> management nullfunc frames from the station, and tries to send packets
> while the station is asleep, resulting in lots of retries dropping down
> in rate due to no response. This restricts the available bandwidth.
> 
> With this happening with several stations, the user visible effect is
> the latency of interactive connections increases significantly, packets
> get dropped, and in general the WiFi connections become unreliable and
> unstable.
> 
> Eventually, the firmware transmit queue appears to get stuck - with
> packets and blocks allocated that never clear.
> 
> TI have a couple of patches that address this, but they touch the
> mac80211 core to disable NL80211_FEATURE_FULL_AP_CLIENT_STATE for *all*
> wireless drivers, which has the effect of not adding the station to the
> stack until later when the rates are known. This is a sledge hammer
> approach to solving the problem.
> 
> The solution implemented here has the same effect, but without
> impacting all drivers.
> 
> We delay adding the station to firmware until it has been authorised
> in the driver, and correspondingly remove the station when unwinding
> from authorised state. Adding the station to firmware allocates a hlid,
> which will now happen later than the driver expects. Therefore, we need
> to track when this happens so that we transmit using the correct hlid.
> 
> This patch is an equivalent fix to these two patches in TI's
> wilink8-wlan repository:
> 
> https://git.ti.com/cgit/wilink8-wlan/build-utilites/tree/patches/kernel_patches/4.19.38/0004-mac80211-patch.patch?h=r8.9&id=a2ee50aa5190ed3b334373d6cd09b1bff56ffcf7
> https://git.ti.com/cgit/wilink8-wlan/build-utilites/tree/patches/kernel_patches/4.19.38/0005-wlcore-patch.patch?h=r8.9&id=a2ee50aa5190ed3b334373d6cd09b1bff56ffcf7
> 
> Reported-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Co-developed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Tested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>"
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Please note that this patch fixes just one of the issues with the
driver. There remains other firmware bugs that make AP mode
unreliable. For example:

When a station, e.g. a phone, moves out of range of the AP, and the
station is in power saving mode, packets become stuck in the transmit
queue. With additional debugging added to the driver:

Unable to flush all frames for station xx:xx:xx:ee:11:fe for hlid 3
FW time: 1675524181
 Frame 0: expires 1394140264 MAC xx:xx:xx:ee:11:fe FC 17032
 Frame 1: expires 1394264633 MAC xx:xx:xx:ee:11:fe FC 17032

These packets get removed by the firmware when the peer is removed.
However, if the broadcast hlid was in power saving at the time, then
it appears the broadcast hlid gets similarly stuck, leading to the
entire network eventually falling over due to the AP effectively
blocking broadcasted ARP requests.

I can find no way around this - and I suspect there is some kind of
refcounting bug in the firmware when told to remove a peer which has
queued packets.

My best workaround for this at the moment is to monitor the state of
the driver via debugfs, and when this problem presents, to take the
AP down and bring it back up, restarting the firmware (but has the
effect of kicking all connected devices off the network.)

Another workaround for is to turn wifi off on the phone before moving
it out of range!

I will attempt to get captures of the network at some point - both
from the packets at the AP network interface, but also the radio
side as well.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

