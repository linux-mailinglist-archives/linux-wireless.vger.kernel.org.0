Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFB1130EC7
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 09:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgAFImB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 03:42:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42616 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAFImA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 03:42:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so48610277wro.9
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jan 2020 00:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M8EUuah2JQYFbZVRs4FZbIzhWD8SMtL+msO/T9weTJI=;
        b=cOVWGtwbDXYSvf0c0GX5XlAiVh+TPkIgTWgHF6Tabz3GUbi9aAt+qWys5MuUOzY1OP
         XovJm8QftmdmY7GzMtQhlpOmnoXiNnZuTOkQP6f3ogZi1KeQ0JpiKUYAHJyEA5zvCZvT
         ytT+NqePYbZk0eGryXBzDhB/luNCVNDoitk8W+QNh8DpUWKt8FK306UKWgXV7OL4xT6N
         3zjMC5v1tiFnKzH1qVP8um0np30HxiA+0xMnEfJWabnzitBa/Au5DtyU1tnQpMW4J5ZW
         cAxNdMCoEkbfWH4BH3H4IwMIYLseffge0XbsYwaptB2KwkzEBwMTIZab8l4ukezP/IEq
         5ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M8EUuah2JQYFbZVRs4FZbIzhWD8SMtL+msO/T9weTJI=;
        b=S2iBLeTMlTH3HCYe/6Gxzak8xv5RQQ026111KrRfU7ob04PTMgexrJRVIJvnV15Aak
         0UZSBCKPmozpmVPf4sxmubtSIuEiLMab2ykyps9oMy2i0YFy+3u6NqvT9c+Vx+tDLUHX
         kMPSCAt6+FyKBacBMR/BvA/A7IUfYGcICl6plbh0bME7orkWAEHm9nNJ4SZoeHCj9s7M
         M61Ow6AxyzlMmpMEaw8izgkLyOSKQQUxJxeAh8JAxXsuFPheAHAQxiggReb+gYlc023P
         dt2HCa3Yt7F7SxPjDjI2GWqGNsQfp+NDGGZ9VOFdHVLJtktx4x/ipfbR/yh+8STKaYe4
         sG9g==
X-Gm-Message-State: APjAAAULk+Quw83Z5+iEAo6wEw9ihP5gq7yYpmbgiheBzbVGwr03kMIj
        o9JflrryNJVW/Djc/fvO+hhnFA==
X-Google-Smtp-Source: APXvYqyXJ1E8kAivSw7L5PiTuqmj6FvNr+aT48bF+Uyd9IWHg2Ch1S32YoUtE1yw0rjXlM+ROZu6TA==
X-Received: by 2002:a5d:4749:: with SMTP id o9mr53851412wrs.242.1578300118793;
        Mon, 06 Jan 2020 00:41:58 -0800 (PST)
Received: from netronome.com ([2001:982:756:703:d63d:7eff:fe99:ac9d])
        by smtp.gmail.com with ESMTPSA id a1sm22350876wmj.40.2020.01.06.00.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 00:41:58 -0800 (PST)
Date:   Mon, 6 Jan 2020 09:41:57 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Maya Erez <merez@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        Francois Romieu <romieu@fr.zoreil.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next v2 0/3] ethtool: allow nesting of begin() and
 complete() callbacks
Message-ID: <20200106084156.GA10460@netronome.com>
References: <cover.1578292157.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1578292157.git.mkubecek@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jan 06, 2020 at 07:39:26AM +0100, Michal Kubecek wrote:
> The ethtool ioctl interface used to guarantee that ethtool_ops callbacks
> were always called in a block between calls to ->begin() and ->complete()
> (if these are defined) and that this whole block was executed with RTNL
> lock held:
> 
> 	rtnl_lock();
> 	ops->begin();
> 	/* other ethtool_ops calls */
> 	ops->complete();
> 	rtnl_unlock();
> 
> This prevented any nesting or crossing of the begin-complete blocks.
> However, this is no longer guaranteed even for ioctl interface as at least
> ethtool_phys_id() releases RTNL lock while waiting for a timer. With the
> introduction of netlink ethtool interface, the begin-complete pairs are
> naturally nested e.g. when a request triggers a netlink notification.
> 
> Fortunately, only minority of networking drivers implements begin() and
> complete() callbacks and most of those that do, fall into three groups:
> 
>   - wrappers for pm_runtime_get_sync() and pm_runtime_put()
>   - wrappers for clk_prepare_enable() and clk_disable_unprepare()
>   - begin() checks netif_running() (fails if false), no complete()
> 
> First two have their own refcounting, third is safe w.r.t. nesting of the
> blocks.
> 
> Only three in-tree networking drivers need an update to deal with nesting
> of begin() and complete() calls: via-velocity and epic100 perform resume
> and suspend on their own and wil6210 completely serializes the calls using
> its own mutex (which would lead to a deadlock if a request request
> triggered a netlink notification). The series addresses these problems.
> 
> changes between v1 and v2:
>   - fix inverted condition in epic100 ethtool_begin() (thanks to Andrew
>     Lunn)

Reviewed-by: Simon Horman <simon.horman@netronome.com>

