Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0CEA105D21
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 00:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfKUXYG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 18:24:06 -0500
Received: from nbd.name ([46.4.11.11]:60472 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfKUXYG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 18:24:06 -0500
Received: from p5dcfba68.dip0.t-ipconnect.de ([93.207.186.104] helo=[192.168.45.104])
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1iXvnw-00025o-NS; Fri, 22 Nov 2019 00:24:04 +0100
Subject: Re: [PATCH] iw: scan: fix double-free in error paths
To:     Brian Norris <briannorris@chromium.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <20191121224139.58281-1-briannorris@chromium.org>
From:   John Crispin <john@phrozen.org>
Message-ID: <e86eb7a3-95e1-f9e1-4ab9-aa38a4f4481e@phrozen.org>
Date:   Fri, 22 Nov 2019 00:24:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191121224139.58281-1-briannorris@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 21/11/2019 23:41, Brian Norris wrote:
> Hit when, for instance, I'm stupid enough to type an invalid scan
> command:
> 
>    # iw wlan0 scan -h
>    BUG at file position lib/msg.c:572:void nlmsg_free(struct nl_msg *)
>    iw: lib/msg.c:572: void nlmsg_free(struct nl_msg *): Assertion `0' failed.
>    Aborted (core dumped)
> 
> Fixes: 2f74c59cf11e ("iw: fix memory leaks inside handle_scan")
> Cc: John Crispin <john@phrozen.org>
wasn't me, nobody saw do anything
try
367e7dd3 (Amit Khatri            2015-06-26 09:02:36 +0000  451) 
                nlmsg_free(ssids);
367e7dd3 (Amit Khatri            2015-06-26 09:02:36 +0000  452) 
                nlmsg_free(freqs);
???
 > Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>   scan.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/scan.c b/scan.c
> index 1418da73a624..bfd39e4b1a1c 100644
> --- a/scan.c
> +++ b/scan.c
> @@ -448,8 +448,6 @@ static int handle_scan(struct nl80211_state *state,
>   			}
>   			/* fall through - this is an error */
>   		case DONE:
> -			nlmsg_free(ssids);
> -			nlmsg_free(freqs);
>   			err = 1;
>   			goto nla_put_failure;
>   		case FREQ:
> 

