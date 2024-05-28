Return-Path: <linux-wireless+bounces-8173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FDF8D1707
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 11:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BAB51C21E41
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 09:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A281DA5F;
	Tue, 28 May 2024 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ah9vRWN9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426E217E8F3;
	Tue, 28 May 2024 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887847; cv=none; b=U294+vBIq5nXRBo90Xk/uGikuSgDsfjrr1GvgO90X7K3TUrg2OGH/srZhvGE/4R8HEV2oOAo25GG+Zv454/Qo3kMPh/ZUTfNe7ZhLSAuhYwlYIcMuIzsd7HcHPswjg0Fc5uJlM7NAm2x41vhLC6NVUkBRGabG7FQcyMVDqM+GMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887847; c=relaxed/simple;
	bh=9nGaRpSSr4m0AjaqXyE2OZqjk+b7Q1tmrvDRw9Crbck=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W93RRaSNU5k0kxmPgISxQOJnjFfm/JG6xmFOtxo7pX2W1J8eV8BrCkHK7cSDKRHEJM1+NWka2BcGS4Pi3col6rsqxhcDBCp1xVI19q08b4uxOuEqSp97oYOVJG0jy76hcmWIXeoouyaGpzo42iYuEVgH2yS+hSVd71sTiQmgI9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Ah9vRWN9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cQCErIWXiKewo6xWSlOhzCwi4ksrVdBdsLAzuf90APY=; b=Ah9vRWN9krXnqGkce1qBRnCK+H
	J1gqZMCpgRnTlSv2fg9vTBt6mLhMCjJpKGyMrT3ySDtdFEFV61Y5uGxRawf3qkddyiskRl8Vz8d7u
	0/ZKKj9m5XrhvVl8BKOummQVDEO4q53VH7bUPVDIlzfCd8Fz6uVxj/pQMgcuoMynbYB8aT+dy4uY/
	oO4VH6ekDNrQ2Hz5jDOnW98hiX/f2N+NTN9IN3BpeyaqUjyoW+LXLOKnXtL2xPekeC8R92sPbPi8p
	8J3ZUmlULpDbKWzDUO7l0H5eh6xr9knKvX7YDAG3r0wJ4fd04pm78MGAfQqxtzeFhHGcZRN0FYYwG
	/5gVdHlg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39508)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sBsxK-0004XO-0G;
	Tue, 28 May 2024 10:17:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sBsxL-00039E-B6; Tue, 28 May 2024 10:17:19 +0100
Date: Tue, 28 May 2024 10:17:19 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Michael Nemanov <michael.nemanov@ti.com>
Subject: [PATCH wireless-next 0/8] wifi: TI wilink8 updates
Message-ID: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

This series updates the TI wilink8 driver targetting two issues.
First are four driver correctness and/or improvements to the driver.

Patch 1 ensures that if the firmware log pointer somehow ends up
beyond the buffer limit, we will wrap back to the start, rather
than relying on an exact match for the end of the buffer.

Patch 2 avoids using the modulus operator for the loop over the
WL18xx completed packet circular buffer, which can be expensive for
some CPUs. Since we only ever increment the index by one, it is
trivial to detect when we need to wrap.

Patch 3 improves the code in wlcore_fw_status() to make what's
going on with status->counters.tx_lnk_free_pkts[] more clear.

Patch 4 removes a potential aliasing issue - wlcore_fw_status()
is passed wl->fw_status as an argument, yet rather than using
that for wlcore_hw_convert_fw_status(), we use wl->fw_status,
and then go back to using the passed-in status to access the
data written by this function.

Patch 5 is taken from one of TI's wilink8 patches adding support
for later firmwares. This adds support for storing the AP key type,
which will be used in connection with the pn16 changes found in
newer firmware.

Patch 6 adds the necessary code for pn16 support, also taken from
one of TI's wilink8 patches, augmented in two ways. First, if
wlcore_hw_convert_fw_status() did not provide the pn16 array, then
this code does nothing (thus maintaining compatibility with existing
firmware.) Second, this is an array of 16-bit quantities, and so is
subject to endian issues. Use the appropriate type and conversion
functions for it.

Patch 7 adds support for parsing the status data structures with
the new pn16 field buried in the middle (!). Since mainline has to
maintain compatibility with existing firmware, and we can't do TI's
silly lock-step "upgrade the firmware at the same time" thing, we
maintain support for the old layout, and select the appropriate
parsing function. We also resize the raw status array as appropriate.

Patch 8 allows the driver to accept both 8.9.0.x.>58 and 8.9.>=1.x.x
firmwares.

 drivers/net/wireless/ti/wl18xx/main.c     |  71 ++++++++++++++++++++-
 drivers/net/wireless/ti/wl18xx/tx.c       |  13 +++-
 drivers/net/wireless/ti/wl18xx/wl18xx.h   |  62 +++++++++++++++++-
 drivers/net/wireless/ti/wlcore/cmd.c      |   9 +++
 drivers/net/wireless/ti/wlcore/event.c    |   2 +-
 drivers/net/wireless/ti/wlcore/main.c     | 101 +++++++++++++++++++++++++++---
 drivers/net/wireless/ti/wlcore/wlcore_i.h |   4 ++
 7 files changed, 246 insertions(+), 16 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

