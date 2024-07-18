Return-Path: <linux-wireless+bounces-10365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891DB9370E3
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 00:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EDF2B21062
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 22:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAD2145A00;
	Thu, 18 Jul 2024 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NfqGCVNn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A8A7E0E9
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 22:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721343321; cv=none; b=qeuTY1GlMLVvw1pIksBrHelBK/y+CEZthllkMRCm+UR8TXOckj85BMM0WMHd0bj8l5nORogp6sss9sQ38Ty05Hw+C0Fvg/trrHsJUY4QckrAb3PmtpO1DTaR/B+ioTsAXEvOl/vr5NUcjuBLprGPPza0MAzi3OIaLA2kPHsyDaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721343321; c=relaxed/simple;
	bh=GOfYFhDLUQ4SAuosej7e1TQonx93ed170tiVJhPnL2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqzQJij4orBLCNTlaDAOwjE4Q0CybOZPjOa6IcVATzd36JZ6EbpE5r1u+Kc0i4dz+jjC21qi0R8Sl6xX++vn1/1EM1oRDYDSn4i8ojXeYMjXHyzt0Ef1EAc+qOQ5vfoRjU5rQLMh7cZBG+7ddgpgQaa2DojR8j7XIW/phr1K/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NfqGCVNn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fb53bfb6easo11294355ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 15:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721343320; x=1721948120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vdk6amR3ns9k94lR5EZk37+L9hpzLXv/vSzrTyKW9k4=;
        b=NfqGCVNnHUDhtCb2vPEP3tw/AvhLL9qbLHV07TwWVA0YZQf0t9vymeBWZu7QBCGE91
         zoUTRYamAez2i7DliE/YB3sCxT6suwE6i7irEztBvSfuXzGjncmILqkcP7sT7+AQ+sZp
         tnH9U4sIHvZpvQmW6rL1FsDbNccuOWuiwscvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721343320; x=1721948120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vdk6amR3ns9k94lR5EZk37+L9hpzLXv/vSzrTyKW9k4=;
        b=GqBTc2D3IS4Gu6xdfAHhJbTzNFblzebkyclhP1qX5k1CLDLP63dwDWaOnnVZs1pdMq
         4+7KlCjrbxxVvAlXxgVi4IPU8IYkgD7dKXI3aVTCGz9Zl8zTy+P28O/G+/TwUrdc5Twy
         +muLHY/qRot4H2/Ug9XCLSrJeFm/Dp5tEmyq1/61uh1C8FEaDWwfQsXLSSCwV1Rrd+XG
         /kWSZrZJfE2S84L/c+JlksjREsMk3McwWOVY2k6XbdIxzCGhwcYIBBKjvlScXW3wA+IB
         jFo+we5PQbLFxNzMPjAwypz7WR6O5z9EXplzzO6dl7Ozy0EjU5+IcqLrWIS473t5sNzb
         PAoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2kuLhcP/H1rKhPagWOJx3yZx3yZBsx+jbZ6l7FBxdAtpDkMikr2DMaRD+XN1MYyK2I+Jo4HWFqneWrFHHB9MnvKJZR1APz/if5pQHpc4=
X-Gm-Message-State: AOJu0YytVbiLZuqk9np5k9CK4PV9fySmkmaqZ0A1lEeuRedG/lWFTpk2
	bOL3e01DZ7AMdWOWJZl+g7Yr8nvfHTwbdqw0eF2u/b2GQILbVoMDK4yHYS1lKg==
X-Google-Smtp-Source: AGHT+IHxqkJVExwWDt6K0KKTzJbmP4SxnCojPaN81CJY7ukRJquPtmiyHtpquREgFCuVrflVFmQoaA==
X-Received: by 2002:a17:902:c401:b0:1fb:dffb:bc99 with SMTP id d9443c01a7336-1fc4e68cd5amr63135225ad.53.1721343319735;
        Thu, 18 Jul 2024 15:55:19 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:35aa:f87d:7549:3938])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1fd64d20160sm973385ad.228.2024.07.18.15.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 15:55:19 -0700 (PDT)
Date: Thu, 18 Jul 2024 15:55:18 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 2/2] wifi: mwifiex: add support for WPA-PSK-SHA256
Message-ID: <ZpmdVq2CkxRcLxvO@google.com>
References: <20240717-mwifiex-wpa-psk-sha256-v2-0-eb53d5082b62@pengutronix.de>
 <20240717-mwifiex-wpa-psk-sha256-v2-2-eb53d5082b62@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717-mwifiex-wpa-psk-sha256-v2-2-eb53d5082b62@pengutronix.de>

Hi Sascha,

On Wed, Jul 17, 2024 at 10:30:08AM +0200, Sascha Hauer wrote:
> This adds support for the WPA-PSK AKM suite with SHA256 as hashing
> method (WPA-PSK-SHA256). Tested with a wpa_supplicant provided AP
> using key_mgmt=WPA-PSK-SHA256.
> 
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/net/wireless/marvell/mwifiex/fw.h      | 1 +
>  drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
> index 3adc447b715f6..1c76754b616ff 100644
> --- a/drivers/net/wireless/marvell/mwifiex/fw.h
> +++ b/drivers/net/wireless/marvell/mwifiex/fw.h
> @@ -415,6 +415,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
>  #define KEY_MGMT_NONE               0x04
>  #define KEY_MGMT_PSK                0x02
>  #define KEY_MGMT_EAP                0x01
> +#define KEY_MGMT_PSK_SHA256         0x100
>  #define CIPHER_TKIP                 0x04
>  #define CIPHER_AES_CCMP             0x08
>  #define VALID_CIPHER_BITMAP         0x0c
> diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> index 7f822660fd955..c055fdc7114ba 100644
> --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> @@ -60,6 +60,9 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
>  		case WLAN_AKM_SUITE_PSK:
>  			bss_config->key_mgmt = KEY_MGMT_PSK;
>  			break;
> +		case WLAN_AKM_SUITE_PSK_SHA256:
> +			bss_config->key_mgmt = KEY_MGMT_PSK_SHA256;
> +			break;

I feel like this relates to previous questions you've had [1], and while
I think the answer at the time made sense to me (basically, EAP and PSK
are mutually exclusive), it makes less sense to me here that PSK-SHA256
is mutually exclusive with PSK. And in particular, IIUC, this means that
the ordering in a wpa_supplicant.conf line like

  key_mgmt=WPA-PSK WPA-PSK-SHA256

matters -- only the latter will actually be in use.

Is that intended? Is this really a single-value field, and not a
multiple-option bitfield?

Or if these are really mutually exclusive, then maybe we're on the wrong
track here:
  https://patchwork.kernel.org/project/linux-wireless/patch/20240530130156.1651174-1-s.hauer@pengutronix.de/
  wifi: mwifiex: increase max_num_akm_suites

In any case, something feels off here, because the nl80211 API doesn't
say anything about the ordering of AKM suites being relevant.

Brian

>  		default:
>  			break;
>  		}
> 
> -- 
> 2.39.2
> 

[1] Subject: Re: [EXT] Re: [PATCH v10 2/2] wifi: mwifiex: add host mlme for AP mode
    https://lore.kernel.org/all/Zmvjw3aG9j8kW0Ld@pengutronix.de/
    https://lore.kernel.org/all/PA4PR04MB9638B7F0F4E49F79057C15FBD1CD2@PA4PR04MB9638.eurprd04.prod.outlook.com/

