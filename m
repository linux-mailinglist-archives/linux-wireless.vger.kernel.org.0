Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C947024B049
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 09:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgHTHoE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 03:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgHTHoD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 03:44:03 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FB0C061757
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 00:44:03 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m22so1023959ljj.5
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 00:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lOosbkd/sbSx1kkNMW30FniQnqOexHL+k7p4fZf0/lc=;
        b=rVb2183Cv5Kf6NLptbCV/7Kwwpo5qkqQyVQx3JXY4MaXePSMINUkuxa4pyOmf5s9PE
         iYMRyl2Gh3RphK30MfJY4dlkOTGjAx5A870dYsHwMmg0Lj0K9DwBTYe3eJGCbvv8a8W2
         /h7SjexTwJjb6NGH5qKzBTplB6oVeFIUvJQwmR7FoPT6Jsg57UsPB3lMY8w22dkiXCIV
         +wPBp2+EgPOSTa5cP1p1uo26YJG5u+adbwklHLDrx4QmQBNQsGzcf7S3vl0/UbFH9FYV
         rRPzMgSNEw6kxA7yYOMlVMa0COksc6O6+XaPl7YXsPlkW/OdA/+GBeBt/53FmmOwUWOi
         KxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lOosbkd/sbSx1kkNMW30FniQnqOexHL+k7p4fZf0/lc=;
        b=U7s9PeNG4mILiW6PDICitbn/z7jEbeZk04abtvLe774e5bEsDT91LCWh2c4fzngk0o
         eWCptZCFRHfiloxVPeIV2weWtcRQ8CGuUpui3FdfSlfPm1lo9n3972GD5YS4yQSgh1+G
         tRBSNzrNfMcnIdvULOx9uMAUSWSUdNgfOvrvYNXzchfyTT4Utk9HN/gA6H/L5skia59U
         lP3JnkMZeTgD0h91wvzdTyfRVD/AwhjgyqkP1vO30mD5XZbwKcVlwFeovb55yyxK1ccG
         3qBAPnXkHmW8GrEStCal5oxZlKU2uVh9VQ8hZTN6YeWkpSbdOHGQC4PUczd2noLKhNfS
         V11A==
X-Gm-Message-State: AOAM531UwvlTbzRZhkabzC7A3e/o0psp4/cmSTI7QRtvpiUfm9xaJau6
        /p7ICAp/K7k8XhcHhWeHSPM/EFkpebY=
X-Google-Smtp-Source: ABdhPJyJL2U1nv/fk1maVOcSPXiR4UgWQAALO7UqBTmzRdpr12KGOS7YJLJy0BQE3xvRd0aeOnC+lg==
X-Received: by 2002:a2e:8615:: with SMTP id a21mr1019876lji.357.1597909442026;
        Thu, 20 Aug 2020 00:44:02 -0700 (PDT)
Received: from curiosity ([5.188.167.236])
        by smtp.gmail.com with ESMTPSA id u16sm313583lff.71.2020.08.20.00.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 00:44:01 -0700 (PDT)
Date:   Thu, 20 Aug 2020 10:49:26 +0300
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     Tamizh Chelvam <tamizhr@codeaurora.org>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] iw: add TID specific Tx bitrate configuration
Message-ID: <20200820074926.GA2255@curiosity>
References: <1597903916-8674-1-git-send-email-tamizhr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597903916-8674-1-git-send-email-tamizhr@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Tamizh,

> Add TID specific Tx bitrate configuration by using
> handle_bitrates already APIs.
> 
> Examples:
> 	$ iw dev wlan0 peer xx:xx:xx:xx:xx:xx tids 0x2 bitrates auto
> 	$ iw dev wlan0 peer xx:xx:xx:xx:xx:xx tids 0x2 bitrates limit vht-mcs-5 4:9
> 
> Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
> ---
>  bitrate.c   | 27 ++++++++++++++++++++-------
>  interface.c | 34 +++++++++++++++++++++++++++++++++-
>  iw.h        |  3 +++
>  3 files changed, 56 insertions(+), 8 deletions(-)

...

>  COMMAND(set, tidconf, "[peer <MAC address>] tids <mask> [override] [sretry <num>] [lretry <num>] "
> -	"[ampdu [on|off]] [amsdu [on|off]] [noack [on|off]] [rtscts [on|off]]",
> +	"[ampdu [on|off]] [amsdu [on|off]] [noack [on|off]] [rtscts [on|off]]"
> +	"[bitrates <type [auto|fixed|limit]> [legacy-<2.4|5> <legacy rate in Mbps>*] [ht-mcs-<2.4|5> <MCS index>*]"
> +	" [vht-mcs-<2.4|5> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*] [sgi-2.4|lgi-2.4] [sgi-5|lgi-5]]",
>  	NL80211_CMD_SET_TID_CONFIG, 0, CIB_NETDEV, handle_tid_config,
>  	"Setup per-node TID specific configuration for TIDs selected by bitmask.\n"
>  	"If MAC address is not specified, then supplied TID configuration\n"
> @@ -955,4 +985,6 @@ COMMAND(set, tidconf, "[peer <MAC address>] tids <mask> [override] [sretry <num>
>  	"  $ iw dev wlan0 tids 0x5 ampdu off amsdu off rtscts on\n"
>  	"  $ iw dev wlan0 tids 0x3 override ampdu on noack on rtscts on\n"
>  	"  $ iw dev wlan0 peer xx:xx:xx:xx:xx:xx tids 0x1 ampdu off tids 0x3 amsdu off rtscts on\n"
> +	"  $ iw dev wlan0 peer xx:xx:xx:xx:xx:xx tids 0x2 bitrates auto\n"
> +	"  $ iw dev wlan0 peer xx:xx:xx:xx:xx:xx tids 0x2 bitrates limit vht-mcs-5 4:9\n"

It just occured to me that I wrote incorrect help message in the patch
adding tidconf command. IIRC the correct usage should be: 

$ iw dev wlan0 set tidconf peer 1:2:3:4:5:6 tids 0x3 ampdu off tids 0x2 sretry 10 lretry 100
$ iw dev wlan0 set tidconf tids 0xff ampdu off amsdu off sretry 10 lretry 100 noack off

Could you please update new help entries and fix the existing ones ?


Regards,
Sergey

