Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A1A7AA83
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2019 16:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfG3OEj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jul 2019 10:04:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:50774 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728255AbfG3OEj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jul 2019 10:04:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3328ADCB;
        Tue, 30 Jul 2019 14:04:37 +0000 (UTC)
Date:   Tue, 30 Jul 2019 16:04:36 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Peter Lebbing <peter@digitalbrains.com>,
        Felix Fietkau <nbd@nbd.name>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] Revert "mac80211: set NETIF_F_LLTX when using
 intermediate tx queues"
Message-ID: <20190730160436.78b72b50@endymion>
In-Reply-To: <20190730125412.1446-1-johannes@sipsolutions.net>
References: <20190730125412.1446-1-johannes@sipsolutions.net>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 30 Jul 2019 14:54:11 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Revert this for now, it has been reported multiple times that it
> completely breaks connectivity on various devices.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8dbb000ee73b ("mac80211: set NETIF_F_LLTX when using intermediate tx queues")
> Reported-by: Jean Delvare <jdelvare@suse.de>
> Reported-by: Peter Lebbing <peter@digitalbrains.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  net/mac80211/iface.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
> index 06aac0aaae64..8dc6580e1787 100644
> --- a/net/mac80211/iface.c
> +++ b/net/mac80211/iface.c
> @@ -1222,7 +1222,6 @@ static void ieee80211_if_setup(struct net_device *dev)
>  static void ieee80211_if_setup_no_queue(struct net_device *dev)
>  {
>  	ieee80211_if_setup(dev);
> -	dev->features |= NETIF_F_LLTX;
>  	dev->priv_flags |= IFF_NO_QUEUE;
>  }
>  

Thanks Johannes.

Tested-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
