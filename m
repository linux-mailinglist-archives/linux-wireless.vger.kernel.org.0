Return-Path: <linux-wireless+bounces-21436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE22A856F7
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 10:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F04F07A61D9
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 08:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E35F285404;
	Fri, 11 Apr 2025 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="PPqMHCDI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3442D38FB0;
	Fri, 11 Apr 2025 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744361403; cv=none; b=XqYmpJkfqQ+DWNfJcNeq2Rrx2b3nnqRAxHl41s1HLG2KdRopLcUQIBj0lQTyAeYFF1KbJ1hmrNW7zgTRNQEkw2Z05zpgHoIRBGls7Tvx+DYb6HA5syos3N76Li95i4ayjC7FbGG5tcVqs5r9YI5vzJBtWVZIFqm0x5OskVlzaW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744361403; c=relaxed/simple;
	bh=V6Fu4VrxxO+l9OZXsluyJdviLxbdbOK0bDXx3CckqI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paS+UEJsmXi8KLQxaSb9lZn7ou4Obujmw/I8Wj1NjnVATpiO12zM/h2QCWvR5qhlZH6JhRsmfCqmu/tOilpSrzT5thNXMDLWApQdtqbrAiUXgVwgoCE5BtYKq8uXKaw3c4DD+NDbf9oGgBFH1lwDoyJfXZBaWdNUS8j1omm8H6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=PPqMHCDI; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id BA1CA1FBE7;
	Fri, 11 Apr 2025 10:49:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1744361398;
	bh=gPPyNPscjBGAPcxizRLq/wo01rgRCKMweMYk9HxkjrI=; h=From:To:Subject;
	b=PPqMHCDIgBBA0F4F9wv9dAeM3d9AXchpcsYAlWig8HXS5xnia6ItNspSB2TDqzurV
	 HlBpY8nDhOfxA8oBere45btV2jQ25SaGSz8r94TOjPLst5eRhkGHvTTP44PPQHVkuF
	 G4w3Mw69d3xwbOdfjSfGcKi9YNfMo6s9si1tF2aJbZ8LXPBeMd6QV2vHqIPF9JN3PF
	 28rW/E5wDRtr2lleCDIHofR2UQPaHB4gE7WS33Km9pNxS/D8xGHGJPwewKL8S9y/Hf
	 rDOi37AB0VRRpdlVlmhSUiR1eFf9aGMkSycH8eamUV6a0r7VK34RZ3NU5uLVQMHf7k
	 i+Xy3oywA8Lfw==
Date: Fri, 11 Apr 2025 10:49:54 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 3/4] wifi: mwifiex: drop asynchronous init waiting code
Message-ID: <20250411084954.GA24608@francesco-nb>
References: <20250410-mwifiex-drop-asynchronous-init-v1-0-6a212fa9185e@pengutronix.de>
 <20250410-mwifiex-drop-asynchronous-init-v1-3-6a212fa9185e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-mwifiex-drop-asynchronous-init-v1-3-6a212fa9185e@pengutronix.de>

On Thu, Apr 10, 2025 at 12:28:45PM +0200, Sascha Hauer wrote:
> Historically all commands sent to the mwifiex driver have been
> asynchronous. The different commands sent during driver initialization
> have been queued at once and only the final command has been waited
> for being ready before finally starting the driver.
> 
> This has been changed in 7bff9c974e1a ("mwifiex: send firmware
> initialization commands synchronously").

> With this the initialization is finished once the last
> mwifiex_send_cmd_sync() (now mwifiex_send_cmd()) has returned.

Just for me, the rename/refactor happened in commit fa0ecbb9905d
("mwifiex: remove global variable cmd_wait_q_required"), in v3.14.


> This makes all the code used to wait for the last initialization
> command to be finished unnecessary, so it's removed in this patch.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/net/wireless/marvell/mwifiex/cmdevt.c  | 16 ----------------
>  drivers/net/wireless/marvell/mwifiex/init.c    |  5 +++--
>  drivers/net/wireless/marvell/mwifiex/main.c    | 12 ++----------
>  drivers/net/wireless/marvell/mwifiex/main.h    |  6 ------
>  drivers/net/wireless/marvell/mwifiex/sta_cmd.c |  4 ----
>  drivers/net/wireless/marvell/mwifiex/util.c    | 18 ------------------
>  6 files changed, 5 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
> index 5573e2ded72f2..c07857c49a713 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
> @@ -900,18 +900,6 @@ int mwifiex_process_cmdresp(struct mwifiex_adapter *adapter)
>  		ret = mwifiex_process_sta_cmdresp(priv, cmdresp_no, resp);
>  	}
>  
> -	/* Check init command response */
> -	if (adapter->hw_status == MWIFIEX_HW_STATUS_INITIALIZING) {

What about the code path from mwifiex_add_card()?

mwifiex_add_card()
 -> hw_status = MWIFIEX_HW_STATUS_INITIALIZING
 -> mwifiex_init_hw_fw(adapter, true))
   -> request_firmware_nowait(..., mwifiex_fw_dpc)

mwifiex_fw_dpc()
 ...
     -> mwifiex_init_fw()
       -> adapter->hw_status = MWIFIEX_HW_STATUS_READY  

mwifiex_fw_dpc() is called asynchronously, is everything as safe as
before, here?


Francesco


