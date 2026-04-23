Return-Path: <linux-wireless+bounces-35243-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAYVGKUh6mnKuwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35243-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 15:41:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF8B453275
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 15:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30F72301224C
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 13:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C6E289E13;
	Thu, 23 Apr 2026 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="CTOxuYDe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B7929D26C
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951580; cv=none; b=DH4IUFeuf9M5VcnJbacDeCKyj0wz8zcksrtFBZAwe+r6J+CV6/exyM/6FrmI+EzQYdcjiS/j9RGElNEZTOO/bWgvmH0q2TLwxh0579eF2RDchGDX5hbV0WAg/bLAkN/kOwdHVbg8IdEB2TiJd8om6HOJWlWaJDuczn5I4JBsW1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951580; c=relaxed/simple;
	bh=9CROr8pnB7yS9k8SGzmXXx72owjtmyyq9MVTkVneo9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZOIgGasY/0sNIKDnVuJnQkkcdWjt47Oo63kFwsrsnwpM8qBph/4JdHXxOOTcrPbQ0BO47FJ1OQmVi5JKJZ+lO7c1ZSZUBkS8OgKynd3JeYc7xcL8ui8IlfYUOlzJ99IR6rWfQoRIBujVnIdcTVN4/ghYgVCQE4WqeDIXsdrTrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=CTOxuYDe; arc=none smtp.client-ip=188.68.63.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4g1cdh0PCQz44Vc;
	Thu, 23 Apr 2026 15:39:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1776951576;
	bh=9CROr8pnB7yS9k8SGzmXXx72owjtmyyq9MVTkVneo9c=;
	h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
	b=CTOxuYDe/2yMDQcFeka/AbsLUVNFnXLsPMkmnqfxC7A1+M/1VG4XZBLGd6Kv/rlXG
	 hf3ORVCjFCqGVN5Yqi9FFcSPHiOCwQBhykQIX8edHHaxk9jsdpC1ufL3vOHXYq2GPx
	 jfburY1eg/D3363g5T1g7xfN5TmeURJ0cr2wI3vnS0zKajMqacA/Zn583LafVNkDry
	 FC88+maD7QqMZ1Px/Z4AAODt543FzNwQ6p9FVxYOywd+m1oY/RosXsvo5iLMbYInEb
	 Jqo4bkuSz6lxPBAMrHL/FCezEspbrH+Ic9DqcIl9LUaJJSahc7v9ywP/zbb0Ghgy9g
	 EVmfbPwVymz3Q==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4g1cd61Zhmz3psy;
	Thu, 23 Apr 2026 15:39:06 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4g1cd53Z6Bz8sWT;
	Thu, 23 Apr 2026 15:39:05 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id DE7C6632E5;
	Thu, 23 Apr 2026 15:39:04 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <8a4c664f-231f-437e-b010-b741c7ed7be8@leemhuis.info>
Date: Thu, 23 Apr 2026 15:39:03 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v2 5/5] wifi: rtl8xxxu: Enable 40 MHz width by
 default
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>,
 art1310@proton.me,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <c54a69c8-9c7a-4249-ac9c-8d6544483ae9@gmail.com>
 <4f053103-adfd-4ead-acb3-ef69127a4bab@gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: de-DE, en-US
X-Enigmail-Draft-Status: N11222
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <4f053103-adfd-4ead-acb3-ef69127a4bab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177695154523.962063.8502374308296710241@mxe9fb.netcup.net>
X-NC-CID: 6YBJTaf+yPW32GJHgXkB6tH+I5gZHyWKxXJ6a8glKo25EjRCLfk=
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35243-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,proton.me,lists.linux.dev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,leemhuis.info:dkim,leemhuis.info:mid];
	DMARC_NA(0.00)[leemhuis.info];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	HAS_REPLYTO(0.00)[regressions@lists.linux.dev];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:server fail];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8CF8B453275
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 11/20/25 15:13, Bitterblue Smith wrote:
> 40 MHz support is hidden behind the ht40_2g module parameter with
> this comment:
> 
> /*
>  * Some APs will negotiate HT20_40 in a noisy environment leading
>  * to miserable performance. Rather than defaulting to this, only
>  * enable it if explicitly requested at module load time.
>  */

FYI: this patch causes a regression that was reported to bugzilla
(reporter CCed here): https://bugzilla.kernel.org/show_bug.cgi?id=221394

"""
Since kernel 6.19.0, the rtl8xxxu driver fails to maintain a connection
with the Realtek RTL8188FTV (0bda:f179) USB Wi-Fi adapter. The device
gets stuck "configuring interface" and eventually times out, effectively
disappearing from the network manager.

Regression Window:
Works perfectly on: 6.12.x (LTS) and 6.18.x (LTS and non LTS).
Broken on: 6.19.x, up through 7.0.0.

Notes:
- The device remains visible on the USB bus (lsusb still shows 0bda:f179).
- The wlan0 interface is created.
- NetworkManager attempts to associate, but authentication times out.
- Disabling USB autosuspend (usbcore.autosuspend=-1) does not resolve
the issue.

Hardware:
Bus 001 Device 002: ID 0bda:f179 Realtek Semiconductor Corp. RTL8188FTV
802.11b/g/n 1T1R 2.4G WLAN Adapter
"""

Then later:

"""
I confirmed that the Commit dbf9b7b "wifi: rtl8xxxu: Enable 40 MHz width
by default" is the cause of the regression.

I tested passing cfg80211_disable_40mhz_24ghz=1 to the cfg80211 module
on 6.19.x and 7.0, and the adapter works perfectly again.

In Windows, forcing the adapter to 20_40MHz causes it to be unable to
connect to any AP, and it only works in 20MHz mode. In Linux 6.19+, it
gets stuck configuring the interface and crashes. So this is most
probably a hardware issue.
"""

Ciao, Thorsten

> This parameter was added in commit 26f1fad29ad9 ("New driver:
> rtl8xxxu (mac80211)"). Back then rtl8xxxu only supported RTL8723AU
> and the RTL8192CU family. It's entirely possible the miserable
> performance was due to mistakes in the channel switching function,
> which were fixed in a previous patch.
> 
> Delete the ht40_2g module parameter. If someone still needs to
> disable 40 MHz support, cfg80211 has the module parameter
> cfg80211_disable_40mhz_24ghz. That works too.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> v2:
>  - Add Reviewed-by.
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/core.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> index a18f73aea837..c06ad064f37c 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> @@ -20,7 +20,6 @@
>  #define DRIVER_NAME "rtl8xxxu"
>  
>  int rtl8xxxu_debug;
> -static bool rtl8xxxu_ht40_2g;
>  static bool rtl8xxxu_dma_aggregation;
>  static int rtl8xxxu_dma_agg_timeout = -1;
>  static int rtl8xxxu_dma_agg_pages = -1;
> @@ -45,8 +44,6 @@ MODULE_FIRMWARE("rtlwifi/rtl8192fufw.bin");
>  
>  module_param_named(debug, rtl8xxxu_debug, int, 0600);
>  MODULE_PARM_DESC(debug, "Set debug mask");
> -module_param_named(ht40_2g, rtl8xxxu_ht40_2g, bool, 0600);
> -MODULE_PARM_DESC(ht40_2g, "Enable HT40 support on the 2.4GHz band");
>  module_param_named(dma_aggregation, rtl8xxxu_dma_aggregation, bool, 0600);
>  MODULE_PARM_DESC(dma_aggregation, "Enable DMA packet aggregation");
>  module_param_named(dma_agg_timeout, rtl8xxxu_dma_agg_timeout, int, 0600);
> @@ -4896,8 +4893,7 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>  				sgi = 1;
>  
>  			highest_rate = fls(ramask) - 1;
> -			if (rtl8xxxu_ht40_2g &&
> -			    (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40))
> +			if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40)
>  				bw = RATE_INFO_BW_40;
>  			else
>  				bw = RATE_INFO_BW_20;
> @@ -7851,7 +7847,8 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
>  	sband->ht_cap.ht_supported = true;
>  	sband->ht_cap.ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
>  	sband->ht_cap.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16;
> -	sband->ht_cap.cap = IEEE80211_HT_CAP_SGI_20 | IEEE80211_HT_CAP_SGI_40;
> +	sband->ht_cap.cap = IEEE80211_HT_CAP_SGI_20 | IEEE80211_HT_CAP_SGI_40 |
> +			    IEEE80211_HT_CAP_SUP_WIDTH_20_40;
>  	memset(&sband->ht_cap.mcs, 0, sizeof(sband->ht_cap.mcs));
>  	sband->ht_cap.mcs.rx_mask[0] = 0xff;
>  	sband->ht_cap.mcs.rx_mask[4] = 0x01;
> @@ -7860,15 +7857,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
>  		sband->ht_cap.cap |= IEEE80211_HT_CAP_SGI_40;
>  	}
>  	sband->ht_cap.mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
> -	/*
> -	 * Some APs will negotiate HT20_40 in a noisy environment leading
> -	 * to miserable performance. Rather than defaulting to this, only
> -	 * enable it if explicitly requested at module load time.
> -	 */
> -	if (rtl8xxxu_ht40_2g) {
> -		dev_info(&udev->dev, "Enabling HT_20_40 on the 2.4GHz band\n");
> -		sband->ht_cap.cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40;
> -	}
> +
>  	hw->wiphy->bands[NL80211_BAND_2GHZ] = sband;
>  
>  	hw->wiphy->rts_threshold = 2347;

#regzbot introduced: dbf9b7b
#regzbot title: wifi: rtl8xxxu: 40 MHz mode breaks things (just like in
Windows)
#regzbot dup: https://bugzilla.kernel.org/show_bug.cgi?id=221394

