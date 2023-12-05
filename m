Return-Path: <linux-wireless+bounces-443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0AB8062C8
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 00:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70244B20E6D
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 23:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC96405EB;
	Tue,  5 Dec 2023 23:15:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69244AC;
	Tue,  5 Dec 2023 15:15:13 -0800 (PST)
Received: from c-76-132-34-178.hsd1.ca.comcast.net ([76.132.34.178]:39188 helo=sauron.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1rAedB-0004yz-W0 by authid <merlins.org> with srv_auth_plain; Tue, 05 Dec 2023 15:15:09 -0800
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
	(envelope-from <marc@merlins.org>)
	id 1rAedB-000naT-BZ; Tue, 05 Dec 2023 15:15:09 -0800
Date: Tue, 5 Dec 2023 15:15:09 -0800
From: Marc MERLIN <marc@merlins.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	linux-wireless@vger.kernel.org, ilw@linux.intel.com,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [RFC PATCH] net: ethtool: do runtime PM outside RTNL
Message-ID: <20231205231509.GA181276@merlins.org>
References: <20231204200710.40c291e60cea.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
 <20231204200038.GA9330@merlins.org>
 <a6ac887f7ce8af0235558752d0c781b817f1795a.camel@sipsolutions.net>
 <20231204203622.GB9330@merlins.org>
 <24577c9b8b4d398fe34bd756354c33b80cf67720.camel@sipsolutions.net>
 <20231204205439.GA32680@merlins.org>
 <20231204212849.GA25864@merlins.org>
 <20231205024652.GA12805@merlins.org>
 <1d986c73c1d39b0cced7d8d2119fba4b2a02418b.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d986c73c1d39b0cced7d8d2119fba4b2a02418b.camel@sipsolutions.net>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-SA-Exim-Connect-IP: 76.132.34.178
X-SA-Exim-Mail-From: marc@merlins.org

On Tue, Dec 05, 2023 at 08:33:02PM +0100, Johannes Berg wrote:
> On Mon, 2023-12-04 at 18:46 -0800, Marc MERLIN wrote:
> > 
> > [13323.572484] iwlwifi 0000:09:00.0: TB bug workaround: copied 152 bytes from 0xffffff68 to 0xfd080000
> > [13328.000825] iwlwifi 0000:09:00.0: TB bug workaround: copied 1272 bytes from 0xfffffb08 to 0xff42c000
> > [13367.278564] iwlwifi 0000:09:00.0: TB bug workaround: copied 1328 bytes from 0xfffffad0 to 0xfec41000
> > [13389.737971] iwlwifi 0000:09:00.0: TB bug workaround: copied 572 bytes from 0xfffffdc4 to 0xff091000
> > [13389.860480] iwlwifi 0000:09:00.0: TB bug workaround: copied 148 bytes from 0xffffff6c to 0xfe412000
> > [13393.435354] iwlwifi 0000:09:00.0: TB bug workaround: copied 360 bytes from 0xfffffe98 to 0xfedcd000
> > [13409.827199] iwlwifi 0000:09:00.0: TB bug workaround: copied 1348 bytes from 0xfffffabc to 0xfd057000
> 
> That's fine, just working around a HW bug on 2^32 address boundaries.
> 
> I had a patch a long time ago to make those messages not appear ... not
> sure where it ended up.

About this wifi chip (AX210/AX211/AX411), one last issue I have with it is when I go to
batteries, it burns a lot of power:
> The battery reports a discharge rate of 36.8 W
> The power consumed was 772 J
> The estimated remaining time is 1 hours, 56 minutes
> 
> Summary: 1657.3 wakeups/second,  0.0 GPU ops/seconds, 0.0 VFS ops/sec and 121.5% CPU use
> 
> Power est.              Usage       Events/s    Category       Description
>   24.1 W     59.6 pkts/s                Device         Network interface: wlp9s0 (iwlwifi)
>   200 mW     80.6%                      Device         Display backlight
>   139 mW      0.0 µs/s      0.00        Process        [PID 8005] /usr/bin/pipewire
>  5.37 mW     18.0 ms/s     537.1        Timer          tick_sched_timer
> 
> 
> The battery reports a discharge rate of 36.1 W
> The power consumed was 744 J
> System baseline power is estimated at 28.9 W
> 
> Power est.    Usage     Device name
>   24.0 W    100.0%        Radio device: iwlwifi
>   4.43 W    205.2%        CPU core
>   230 mW    100.0%        Audio codec alsa:hwC0D0: thinkpad (Realtek) (pipewire )
> 
> autosuspend is on:
>    Good          Runtime PM for PCI Device Intel Corporation Wi-Fi 6 AX210/AX211/AX411 160MHz


Obviously unloading iwlwifi fixes it:
> The battery reports a discharge rate of 26.0 W
> The power consumed was 534 J
> The estimated remaining time is 2 hours, 40 minutes
> 
> Summary: 927.2 wakeups/second,  0.0 GPU ops/seconds, 0.0 VFS ops/sec and 85.5% CPU use
> 
> Power est.              Usage       Events/s    Category       Description
>   6.95 W    100.0%                      Device         USB device: Yubico Gnubby (gnubby1) (Yubico)
>   2.09 W      0.0 µs/s      0.00        Process        [PID 8005] /usr/bin/pipewire
>   185 mW     80.6%                      Device         Display backlight
> 
> The battery reports a discharge rate of 26.0 W
> The power consumed was 534 J
> System baseline power is estimated at 11.5 W
> 
> Power est.    Usage     Device name
>   6.95 W    100.0%        USB device: Yubico Gnubby (gnubby1) (Yubico)
>   2.09 W    100.0%        Audio codec alsa:hwC0D0: thinkpad (Realtek) (pipewire )
>   2.02 W     85.5%        CPU core

What's very interesting is if I re-insert the iwlwifi module after that, 
it works and used a lot less power last time I tried, but this time around
it's still shown as high although probably with a wrong Watt value because powertop
is confused somehow:
  28.8 W    470.9 pkts/s                Device         Network interface: wlp9s0 (iwlwifi)

  24.4 W    100.0%        Radio device: iwlwifi

Is this something I should persue separately on
linux-wireless@vger.kernel.org or ilw@linux.intel.com or elsewhere?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

