Return-Path: <linux-wireless+bounces-437-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F7D805EF8
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 21:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701831F21674
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 20:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681696ABB8;
	Tue,  5 Dec 2023 20:00:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA2F188;
	Tue,  5 Dec 2023 12:00:42 -0800 (PST)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 3D6CC1F8F7;
	Tue,  5 Dec 2023 21:00:41 +0100 (CET)
Date: Tue, 5 Dec 2023 21:00:37 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH] wifi: mwifiex: added extra delay for firmware ready.
Message-ID: <ZW+BZRHDta7vKZgs@francesco-nb.int.toradex.com>
References: <20231128082544.613179-1-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128082544.613179-1-yu-hao.lin@nxp.com>

Hello David,

thanks for your patch. Planning to run some test on this over the next
days and we'll provide some actual feedback if this really solves the
issue we are affected by.

Just a couple of nitpicky comments on the actual patch.


On the commit message you should use imperative mood, e.g.

`wifi: mwifiex: add extra delay for firmware ready`

with no period at the end of the line.

On Tue, Nov 28, 2023 at 04:25:44PM +0800, David Lin wrote:
> For SDIO IW416, in a corner case FW may return ready before complete full
> initialization.
> Command timeout may occur at driver load after reboot.
> Workaround by adding 100ms delay at checking FW status.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>

Add

Cc: stable@...

> ---
>  drivers/net/wireless/marvell/mwifiex/sdio.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
> index 6462a0ffe698..744e9403430a 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sdio.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
> @@ -783,6 +783,9 @@ static int mwifiex_check_fw_status(struct mwifiex_adapter *adapter,
>  		ret = -1;
>  	}
>  
> +	if (!ret)
> +		msleep(100);
> +

you could just add the delay after

  if (firmware_stat == FIRMWARE_READY_SDIO) {

this would be more read-able to me. Adding also a short comment like

  /* Firmware might pretend to be ready, when it's not.
   * Wait a little bit more as a workaround */


Francesco


