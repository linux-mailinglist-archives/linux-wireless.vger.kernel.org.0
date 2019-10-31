Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBBC7EB02B
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 13:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfJaMXv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Oct 2019 08:23:51 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:53482 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfJaMXv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Oct 2019 08:23:51 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iQ9UT-00027K-Fd; Thu, 31 Oct 2019 13:23:49 +0100
Message-ID: <e18ba5a1e71561223677243efb19561be55d0f30.camel@sipsolutions.net>
Subject: Re: [PATCH v2] mac80211: fix insane values that sometimes appear in
 inactive_time
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ahmed Zaki <anzaki@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 31 Oct 2019 13:23:48 +0100
In-Reply-To: <20191031121243.27694-1-anzaki@gmail.com> (sfid-20191031_131303_213675_40076E91)
References: <20191031121243.27694-1-anzaki@gmail.com>
         (sfid-20191031_131303_213675_40076E91)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-10-31 at 06:12 -0600, Ahmed Zaki wrote:
> In the first 5 minutes after boot (time of INITIAL_JIFFIES),
> ieee80211_sta_last_active() returns zero if last_ack is zero. This
> leads to "inactive time" showing jiffies_to_msecs(jiffies).
> 
>  # iw wlan0 station get fc:ec:da:64:a6:dd
>  Station fc:ec:da:64:a6:dd (on wlan0)
> 	inactive time:	4294894049 ms
> 	.
> 	.
> 	connected time:	70 seconds
> 
> Fix by returning last_rx if last_ack == 0.
> 
> Signed-off-by: Ahmed Zaki <anzaki@gmail.com>

Thanks for the updates :)
 
> -	if (time_after(stats->last_rx, sta->status_stats.last_ack))
> +	if (!sta->status_stats.last_ack ||
> +		time_after(stats->last_rx, sta->status_stats.last_ack))
>  		return stats->last_rx;

The indentation is still wrong :)

I guess I could fix that too.

johannes

