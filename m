Return-Path: <linux-wireless+bounces-19024-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B570A3756A
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 17:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A483AED33
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 16:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA00198A11;
	Sun, 16 Feb 2025 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlM6MgGh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DD7DF78;
	Sun, 16 Feb 2025 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722056; cv=none; b=djw/o42l3eiyhIaZlUyOwGdIyRw+dCcDzm46STbb5i7L+yV9E0NHxIp7ZajI9X2hpGFIoKJtBvE7qBfKCL0hOa2ieIJuEScNsjIhARSwOZoXLs99Q9+temDOTGczJLKlklax8TPChdebhbvPT7nR4iQ4DlCN45EkrT0kuhuvR+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722056; c=relaxed/simple;
	bh=43hB0V5xGtsW08Wu4x/+54J0/oLkkgqApWLJEGgtdtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDr6774fUlMOKALnvM8CYPrQwk7DviZ1kWpwUg3aNDUPu0iEVz5luI41Kjfkjpmn+VliPJAZLklghx1/+UyVY1BvhdvcoS4Su4lIBItxMKPNvfYXdlvBxeUJhkuTldv0LgMe+6tok/2spirTYLNatOpaR3Xo+mxa5eD09jrTX6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlM6MgGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BB6C4CEDD;
	Sun, 16 Feb 2025 16:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739722056;
	bh=43hB0V5xGtsW08Wu4x/+54J0/oLkkgqApWLJEGgtdtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LlM6MgGh//jb+HqFo2mNjO2abwlassCQW6QN1S0IhXrx9UWPKTL5lXIMRVICZOzHG
	 +aYnJH6ZYStPAMiRJq9BoaA6fzzHLdcCGBjnpM5huUWXgAncyX5dPH9jTWi91Cv77M
	 +3WB5YZYxAlEHNJp704sGJRxxnh02eUtAbNDOw2MfHkvNQ059CHOsRU99vDxYhKXt7
	 vit/P0fUJ3Q1Fdij3Rpolx/Bjd5n5gQEy+dOsP9hDJgFvZpHViTnJNBLuCntrxlzRm
	 45+oqW8LoqDcKA8k4nG/gqp6QP/yPQubFrpCeejequuS5/T2OBUF34Br4sw9waNrgt
	 jsqu0/NtZNKhw==
Date: Sun, 16 Feb 2025 16:07:29 +0000
From: Simon Horman <horms@kernel.org>
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kalle Valo <kvalo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Marek Vasut <marex@denx.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 09/12] wifi: wilc1000: disable firmware power save if
 bluetooth is in use
Message-ID: <20250216160729.GG1615191@kernel.org>
References: <20250212-wilc3000_bt-v1-0-9609b784874e@bootlin.com>
 <20250212-wilc3000_bt-v1-9-9609b784874e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250212-wilc3000_bt-v1-9-9609b784874e@bootlin.com>

On Wed, Feb 12, 2025 at 04:46:28PM +0100, Alexis Lothoré wrote:
> If the wlan interface exposed by wilc driver has power save enabled
> (either explicitly with iw dev wlan set power_save on, or because
> kernel is built with CONFIG_CFG80211_DEFAULT_PS), it will send a power
> management command to the wlan firmware when corresponding interface is
> brought up. The bluetooth part, if used, is supposed to work
> independently from the WLAN CPU. Unfortunately, this power save
> management, if applied by the WLAN side, disrupts bluetooth operations
> (the bluetooth CPU does not answer any command anymore on the UART
> interface)
> 
> Make sure that the bluetooth part can work independently by disabling
> power save in wlan firmware when bluetooth is in use.
> 
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> ---
>  drivers/net/wireless/microchip/wilc1000/bt.c       | 29 +++++++++++++++++++---
>  drivers/net/wireless/microchip/wilc1000/cfg80211.c |  5 +++-
>  drivers/net/wireless/microchip/wilc1000/netdev.h   |  3 +++
>  3 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/microchip/wilc1000/bt.c b/drivers/net/wireless/microchip/wilc1000/bt.c
> index b0f68a5479a5bd6f70e2390a35512037dc6c332b..f0eb5fb506eddf0f6f4f3f0b182eaa650c1c7a87 100644
> --- a/drivers/net/wireless/microchip/wilc1000/bt.c
> +++ b/drivers/net/wireless/microchip/wilc1000/bt.c
> @@ -7,6 +7,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <net/wilc.h>
> +#include "cfg80211.h"
>  #include "netdev.h"
>  #include "wlan_if.h"
>  #include "wlan.h"
> @@ -261,22 +262,36 @@ static int wilc_bt_start(struct wilc *wilc)
>  int wilc_bt_init(void *wilc_wl_priv)
>  {
>  	struct wilc *wilc = (struct wilc *)wilc_wl_priv;
> +	struct wilc_vif *vif;
>  	int ret;
>  
> +	wilc->bt_enabled = true;
> +
>  	if (!wilc->hif_func->hif_is_init(wilc)) {
>  		dev_info(wilc->dev, "Initializing bus before starting BT");
>  		acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
>  		ret = wilc->hif_func->hif_init(wilc, false);
>  		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
> -		if (ret)
> +		if (ret) {
> +			wilc->bt_enabled = false;
>  			return ret;
> +		}
>  	}
>  
> +	/* Power save feature managed by WLAN firmware may disrupt
> +	 * operations from the bluetooth CPU, so disable it while bluetooth
> +	 * is in use (if enabled, it will be enabled back when bluetooth is
> +	 * not used anymore)
> +	 */
> +	vif = wilc_get_wl_to_vif(wilc);
> +	if (wilc->power_save_mode && wilc_set_power_mgmt(vif, false))
> +		goto hif_deinit;

Hi Alexis,

Jumping to hif_deinit will result in the function returning ret.
But ret may not not be initialised until a few lines below.

Flagged by Smatch.

> +
>  	mutex_lock(&wilc->radio_fw_start);
>  	ret = wilc_bt_power_up(wilc);
>  	if (ret) {
>  		dev_err(wilc->dev, "Error powering up bluetooth chip\n");
> -		goto hif_deinit;
> +		goto reenable_power_save;
>  	}
>  	ret = wilc_bt_firmware_download(wilc);
>  	if (ret) {
> @@ -293,10 +308,14 @@ int wilc_bt_init(void *wilc_wl_priv)
>  
>  power_down:
>  	wilc_bt_power_down(wilc);
> -hif_deinit:
> +reenable_power_save:
> +	if (wilc->power_save_mode_request)
> +		wilc_set_power_mgmt(vif, true);
>  	mutex_unlock(&wilc->radio_fw_start);
> +hif_deinit:
>  	if (!wilc->initialized)
>  		wilc->hif_func->hif_deinit(wilc);
> +	wilc->bt_enabled = false;
>  	return ret;
>  }
>  EXPORT_SYMBOL(wilc_bt_init);

...

