Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 901A517AF94
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2020 21:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgCEUOH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Mar 2020 15:14:07 -0500
Received: from mail.adapt-ip.com ([173.164.178.19]:57538 "EHLO
        mail.adapt-ip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCEUOH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Mar 2020 15:14:07 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.adapt-ip.com (Postfix) with ESMTP id 512452F2F1D;
        Thu,  5 Mar 2020 20:07:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at web.adapt-ip.com
Received: from mail.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UgjMG_soPL7A; Thu,  5 Mar 2020 12:07:29 -0800 (PST)
Received: from [10.1.10.44] (vpn.adapt-ip.com [173.164.178.20])
        (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: thomas@adapt-ip.com)
        by mail.adapt-ip.com (Postfix) with ESMTPSA id 8EA782F2F16;
        Thu,  5 Mar 2020 12:07:29 -0800 (PST)
Subject: Re: [PATCH] mac80211: Do not send mesh HWMP PREQ if HWMP is disabled
To:     Nicolas Cavallari <cavallar@lri.fr>, linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.com>
References: <20200305140409.12204-1-cavallar@lri.fr>
From:   Thomas Pedersen <thomas@adapt-ip.com>
Message-ID: <0deb25c7-4880-a29b-6a38-396e1d235180@adapt-ip.com>
Date:   Thu, 5 Mar 2020 12:07:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200305140409.12204-1-cavallar@lri.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/5/20 6:04 AM, Nicolas Cavallari wrote:
> From: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
> 
> When trying to transmit to an unknown destination, the mesh code would
> unconditionally transmit a HWMP PREQ even if HWMP is not the current
> path selection algorithm.
> 
> Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
> ---
>  net/mac80211/mesh_hwmp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
> index d69983370381..38a0383dfbcf 100644
> --- a/net/mac80211/mesh_hwmp.c
> +++ b/net/mac80211/mesh_hwmp.c
> @@ -1152,7 +1152,8 @@ int mesh_nexthop_resolve(struct ieee80211_sub_if_data *sdata,
>  		}
>  	}
>  
> -	if (!(mpath->flags & MESH_PATH_RESOLVING))
> +	if (!(mpath->flags & MESH_PATH_RESOLVING) &&
> +	    mesh_path_sel_is_hwmp(sdata))
>  		mesh_queue_preq(mpath, PREQ_Q_F_START);
>  
>  	if (skb_queue_len(&mpath->frame_queue) >= MESH_FRAME_QUEUE_LEN)
> 

The skb would still get queued onto the mpath->frame_queue. Is it
this expected? ie. do you have a non-hwmp path selection algorithm which
will handle it, or are you really checking if path selection is
disabled?

-- 
-- thomas
