Return-Path: <linux-wireless+bounces-8261-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F8C8D375B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 15:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021DC1C23D9E
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 13:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A5E12E40;
	Wed, 29 May 2024 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D15IPLoT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AF014285;
	Wed, 29 May 2024 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716988531; cv=none; b=nR7U3zsAp+V6Z2g3envbUKsZoqeRiFP7ehiBG3OusChpYQ5ZF9z08rVnqGsIOYRxVhdstShu5b8IVufjXd/7pxcwNbFEyJDvrRghm2IIl7dgn/eM0M8xWhplfFVsO8fvFcpjErKauAkzSOYPlrCTklU3mLyVLKxyi+L1ZSKWsQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716988531; c=relaxed/simple;
	bh=OmM5PAMFbN4dfmCw525+OX5fDy1sVOYxPtyU5Ru9uAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o0o7vaLZLGxbE8hDPjl2R+r45k4r9wuYGGaRPUNrLy9iaTQOt2oxMrA/0YOGCvJhUwWMEllUqEI6G1ddJZ8wdwONizZL/wVazJUBOySUf8t5ckj5dlccozDoLMKGInVP4EcOXQ6GJs4q6IHHEIgrksJBHGV0l8K/Hqmj78AxSRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=D15IPLoT; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44TDFFRq127926;
	Wed, 29 May 2024 08:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716988515;
	bh=SGXEU/HXs2xZG2V9QTv7x2JhjWA83Vf2BvYxteRQpkU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=D15IPLoTypsUVfAq5iNhZrhWsUCKh0AF7+uShdkTIG36aZfOnTrkDPZ+xfKyzLFEL
	 ppygFvpRKcjOXg99cmZL8s9xPkiIyYF4CpdmatwL0byu8qHD6lSyihZD8hQEHYVNKq
	 z8WTMv9sAorzvdGZgxcSzwLLMXPc7IRGbH8mTIH8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44TDFFPB062731
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 May 2024 08:15:15 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 08:15:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 08:15:15 -0500
Received: from [137.167.6.219] (lt5cg1094w5k.dhcp.ti.com [137.167.6.219])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44TDFDUW119086;
	Wed, 29 May 2024 08:15:14 -0500
Message-ID: <abbb5c02-6cda-41c6-9900-06e7f4920541@ti.com>
Date: Wed, 29 May 2024 16:15:13 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 4/8] wifi: wlcore: pass "status" to
 wlcore_hw_convert_fw_status()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Kalle Valo
	<kvalo@kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>
References: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
 <E1sBsxx-00E8vi-Gf@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <E1sBsxx-00E8vi-Gf@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 5/28/2024 12:17 PM, Russell King (Oracle) wrote:
> wlcore_fw_status() is passed a pointer to the struct wl_fw_status to
> decode the status into, which is always wl->fw_status. Rather than
> referencing wl->fw_status within wlcore_fw_status(), use the supplied
> argument so that we access this member in a consistent manner.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>    drivers/net/wireless/ti/wlcore/main.c | 2 +-
>    1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
> index a98b26dc3cb8..3defe49c5120 100644
> --- a/drivers/net/wireless/ti/wlcore/main.c
> +++ b/drivers/net/wireless/ti/wlcore/main.c
> @@ -392,7 +392,7 @@ static int wlcore_fw_status(struct wl1271 *wl, struct wl_fw_status *status)
>    	if (ret < 0)
>    		return ret;
>    
> -	wlcore_hw_convert_fw_status(wl, wl->raw_fw_status, wl->fw_status);
> +	wlcore_hw_convert_fw_status(wl, wl->raw_fw_status, status);
>    
>    	wl1271_debug(DEBUG_IRQ, "intr: 0x%x (fw_rx_counter = %d, "
>    		     "drv_rx_counter = %d, tx_results_counter = %d)",
> -- 
> 2.30.2

Agree this is more consistent. Maybe *status shouldn't be an argument to 
wlcore_fw_status at all? It's called only in one place with 
wl->fw_status anyway.

Michael.


