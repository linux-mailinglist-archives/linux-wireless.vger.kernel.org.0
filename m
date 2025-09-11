Return-Path: <linux-wireless+bounces-27246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C66B536CC
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 17:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189413B25F1
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 15:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33AD343D96;
	Thu, 11 Sep 2025 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="brIU77ia"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835081E1DE9
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602799; cv=none; b=Ytr24NtmKIqZHGb9yFubpfW0ByX1xCfEcSx/5dlEv38JOgF5vzUgiq0haUdIY1WIJS7FyPhVSfFpC6iqTcEb5N/uEcP+j9WM2fCwOdGtv8umeS7KClVswC7G6mJvOZEJayH15L42L2PijalUoSAZdqr2r6+HQfHppTVFOwmvhDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602799; c=relaxed/simple;
	bh=GrOcQnBLWq/c9i0O3OkQRM27F/LyB+oMciRYUhpkKwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFT6hD3pzdDoSeHzzQQWlIaSSUNY8LwpursTpHOBIHLrRopaxy8llW7oD7L8msSt9brZDvmwB2He85PpQoGeuFIOba258sCVIKfh0A1fIgoXqMMON3Iw3WNEpCVR4EzmSg+DrJzosiUYC7sNVfJhTCX5/y1n/7nQYkVZA3oIJNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=brIU77ia; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 14891 invoked from network); 11 Sep 2025 16:33:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1757601194; bh=TGeg6yZAFhxk6E30jsoP8yK/VdbAxegeXuN/6bbXYUk=;
          h=From:To:Cc:Subject;
          b=brIU77ia3dcPg0JVDYPw4Kcq62BqVfYQpqdnOCSB+Bm3z629cEHoghIbZicygCijK
           qv9FGq+sAoEn/ZUsw7TlOUfgKGe1hz71GYhgT/20zShq40oz2wbRSQAO5ozgaBC9Sf
           JQCmyyW7Vx5YIDYENyiHj5UwxdxDqraMgzlBUGRvyAZbD/aKpK9NZLLUO5K7405B2n
           Kyk18QYhw1G9G5cii7ecvEU3+U7Baiq6CSe2lgi/YJhxHo3B14HkNimvIzf1R0hX55
           h/Is8ynJ7c1bGifiimkBhfvuBOWK3vE5Xmn4iNaIfDg8b5HduIO9tJUkUgmaBojtE+
           pr8dKdRVchXDA==
Received: from 89-64-9-45.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.45])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <chenyufeng@iie.ac.cn>; 11 Sep 2025 16:33:14 +0200
Date: Thu, 11 Sep 2025 16:33:13 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Chen Yufeng <chenyufeng@iie.ac.cn>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] iwlegacy: Add sanity check for il->stations[] array
 index
Message-ID: <20250911143313.GA9823@wp.pl>
References: <20250911133950.1152-1-chenyufeng@iie.ac.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911133950.1152-1-chenyufeng@iie.ac.cn>
X-WP-MailID: b4a2a4e13c52ed79e0d31ba5731b8dc7
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [YROB]                               

On Thu, Sep 11, 2025 at 09:39:50PM +0800, Chen Yufeng wrote:
> In the il_process_add_sta_resp function, the index sta_id in 
> il->stations[sta_id] is not validated, which may lead to memory 
> corruption if the sta_id index is out of bounds.
> 
> Fixes: 0cdc21363cc2 ("iwlegacy: merge common .c files")
This tag is most likely not correct one. I don't think we need
one though.

> Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>
> Reviewed-by: Stanislaw Gruszka <stf_xl@wp.pl>
No, I haven't review the patch.

> ---
> Changes in v2:
> - Add header file commands.h to get IL_STATION_COUNT
> - move the validation of sta_id to il_process_add_sta_resp
> 
>  drivers/net/wireless/intel/iwlegacy/common.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
> index b7bd3ec4cc50..2840d0935650 100644
> --- a/drivers/net/wireless/intel/iwlegacy/common.c
> +++ b/drivers/net/wireless/intel/iwlegacy/common.c
> @@ -22,6 +22,7 @@
>  #include <net/mac80211.h>
>  
>  #include "common.h"
> +#include "commands.h"
>  
>  int
>  _il_poll_bit(struct il_priv *il, u32 addr, u32 bits, u32 mask, int timeout)
> @@ -1766,6 +1767,11 @@ il_process_add_sta_resp(struct il_priv *il, struct il_addsta_cmd *addsta,
>  		IL_ERR("Bad return from C_ADD_STA (0x%08X)\n", pkt->hdr.flags);
>  		return ret;
>  	}
> +	
> +	if (sta_id >= IL_STATION_COUNT) {
> +		IL_ERR(il, "invalid sta_id %u", sta_id);

Again, compile test your patches!

Regards
Stanislaw

> +		return -EINVAL;
> +	}
>  
>  	D_INFO("Processing response for adding station %u\n", sta_id);
>  
> -- 
> 2.34.1
> 

