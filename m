Return-Path: <linux-wireless+bounces-8305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3108D46A8
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 10:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AEB81C20D72
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 08:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFF81459EF;
	Thu, 30 May 2024 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GD/Y+GHC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3613176AD2;
	Thu, 30 May 2024 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717056427; cv=none; b=dlKOihIdW3+F5VXgTed5PpSxMSILggiuUJgph+/4j5+IbjRZXeyLztjtvlTbDFhtq552HJaHzKx/QAarDvd3R5SQFHEpYYmruAQqbH7/YNyS+gqhLU+AAbjozL1Yp+ZRL9ipjenVwVRNcjlTKc3AUMM8bg3vIhdoUUHeJtBAvsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717056427; c=relaxed/simple;
	bh=f2yIws9zTPZwAdY+cKgAvCt/JJvMVgXx7fnZPjo/WDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L4q1yaq4rmNACvUY0nLvpxs/0knd00eLrN9RtNqd1V9pw0beuyGJcKVFPFVjeAI3IJe5gg5vZLshLFBHh/9UQ+2+CZ20CvOecj4aESke22LTQjCRq1NDIezQR95rQ2x/7cYCBLZmb5c8CrtxfakUF+dCFGLaHNhAySmxhDuzi38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GD/Y+GHC; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44U86hXQ105654;
	Thu, 30 May 2024 03:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717056403;
	bh=qexI4QGXkxBpctS6P9RXu0XZbRrPHyV+9mwGN0BskeU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=GD/Y+GHCbkPQTFf6M2YTDR8OyFvHUL59wDoTRQrO10+HyldYZ8mjfUDv7WODoQn8f
	 R4cZkh9uD9i5J22DvXx3FzPH88Ytcg7ZWgO0ECK78sWsx1SbP3hxyRmGIWBEIFsiHZ
	 kP+8EfKBN84/DVb/zWVS2pXvUyaabueSpimu9qpQ=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44U86hTg009239
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 May 2024 03:06:43 -0500
Received: from lewvowa02.ent.ti.com (10.180.75.80) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 May 2024 03:06:43 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by lewvowa02.ent.ti.com
 (10.180.75.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Thu, 30 May
 2024 03:06:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 May 2024 03:06:42 -0500
Received: from [137.167.6.219] (lt5cg1094w5k.dhcp.ti.com [137.167.6.219])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44U86fDk114845;
	Thu, 30 May 2024 03:06:41 -0500
Message-ID: <e6ae6dfa-6554-4e88-abb0-31dbbd8df03f@ti.com>
Date: Thu, 30 May 2024 11:06:40 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH wireless-next 6/8] wifi: wlcore: add pn16
 support
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Kalle Valo
	<kvalo@kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>
References: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
 <E1sBsy7-00E8vu-Nc@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <E1sBsy7-00E8vu-Nc@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 5/28/2024 12:18 PM, Russell King (Oracle) wrote:

[...]

>    
>    static int wlcore_fw_status(struct wl1271 *wl, struct wl_fw_status *status)
>    {
> +	struct wl12xx_vif *wlvifsta;
> +	struct wl12xx_vif *wlvifap;
>    	struct wl12xx_vif *wlvif;
>    	u32 old_tx_blk_count = wl->tx_blocks_available;
>    	int avail, freed_blocks;
> @@ -410,23 +412,100 @@ static int wlcore_fw_status(struct wl1271 *wl, struct wl_fw_status *status)
>    		wl->tx_pkts_freed[i] = status->counters.tx_released_pkts[i];
>    	}
>    
[...]
>    	for_each_set_bit(i, wl->links_map, wl->num_links) {
> +		u16 diff16, sec_pn16;
>    		u8 diff, tx_lnk_free_pkts;
> +
>    		lnk = &wl->links[i];
>    
>    		/* prevent wrap-around in freed-packets counter */
>    		tx_lnk_free_pkts = status->counters.tx_lnk_free_pkts[i];
>    		diff = (tx_lnk_free_pkts - lnk->prev_freed_pkts) & 0xff;
>    
> -		if (diff == 0)
> +		if (diff) {
> +			lnk->allocated_pkts -= diff;
> +			lnk->prev_freed_pkts = tx_lnk_free_pkts;
> +		}
> +
> +		/* Get the current sec_pn16 value if present */
> +		if (status->counters.tx_lnk_sec_pn16)
> +			sec_pn16 = __le16_to_cpu(status->counters.tx_lnk_sec_pn16[i]);
> +		else
> +			sec_pn16 = 0;
> +		/* prevent wrap-around in pn16 counter */
> +		diff16 = (sec_pn16 - lnk->prev_sec_pn16) & 0xffff;
> +
> +		/* FIXME: since free_pkts is a 8-bit counter of packets that
> +		 * rolls over, it can become zero. If it is zero, then we
> +		 * omit processing below. Is that really correct?
> +		 */
> +		if (tx_lnk_free_pkts <= 0)
>    			continue;
>    
The original code was
         tx_lnk_free_pkts = status->counters.tx_lnk_free_pkts[i];
         diff = (tx_lnk_free_pkts - lnk->prev_freed_pkts) & 0xff;

         if (diff == 0)
             continue;

I wonder if comparing tx_lnk_free_pkts to 0 was added intentionally? 
This is monotonously incremented counter so 0 is not significant, unlike 
the diff.
Have I missed something?

Michael.


