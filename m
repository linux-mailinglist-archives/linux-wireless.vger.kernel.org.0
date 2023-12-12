Return-Path: <linux-wireless+bounces-684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A33E80E2E8
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 04:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6E71C21926
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 03:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562798F65;
	Tue, 12 Dec 2023 03:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="U6WEvZCx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E001FAC
	for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 19:46:36 -0800 (PST)
Received: (wp-smtpd smtp.wp.pl 40790 invoked from network); 12 Dec 2023 04:46:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1702352789; bh=KEnyD0G9lUx4nu5+rapx3vQ3jzs5K2y6u+B86vS4Spg=;
          h=From:To:Cc:Subject;
          b=U6WEvZCxvP26U467tukZG5fiewSwlnRchWXKljjTWMmWzRdXI/nRb6HLZormOaO96
           0eBY30iUfiAQTpbjNywsWiE/oB+o3bQDy85Guf76cbv7KQDo9OxjhEZuIMSmD5S7rr
           jUeshJilBr4iO+/ouML1OOhOxQFRt6z/mMo1q8C0=
Received: from 89-64-13-61.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.13.61])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <chentao@kylinos.cn>; 12 Dec 2023 04:46:29 +0100
Date: Tue, 12 Dec 2023 04:46:29 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kunwu Chan <kunwu.chan@hotmail.com>
Subject: Re: [PATCH] iwlegacy: Add null pointer check to il_leds_init
Message-ID: <20231212034629.GA24323@wp.pl>
References: <20231211033019.238149-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211033019.238149-1-chentao@kylinos.cn>
X-WP-MailID: a1807858da1ce335e0bf330da43f922c
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [kVNU]                               

On Mon, Dec 11, 2023 at 11:30:19AM +0800, Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  drivers/net/wireless/intel/iwlegacy/common.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
> index 054fef680aba..17570d62c896 100644
> --- a/drivers/net/wireless/intel/iwlegacy/common.c
> +++ b/drivers/net/wireless/intel/iwlegacy/common.c
> @@ -541,6 +541,9 @@ il_leds_init(struct il_priv *il)
>  
>  	il->led.name =
>  	    kasprintf(GFP_KERNEL, "%s-led", wiphy_name(il->hw->wiphy));
> +	if (!il->led.name)
> +		return;
> +
>  	il->led.brightness_set = il_led_brightness_set;
>  	il->led.blink_set = il_led_blink_set;
>  	il->led.max_brightness = 1;
> -- 
> 2.39.2
> 

