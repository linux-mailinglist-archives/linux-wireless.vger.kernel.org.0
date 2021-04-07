Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7795E356384
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Apr 2021 07:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344858AbhDGFyf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Apr 2021 01:54:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243610AbhDGFyf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Apr 2021 01:54:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD9D66139B;
        Wed,  7 Apr 2021 05:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617774865;
        bh=LhBy7QXsuE9/aFZMQru+IxA36pqYuIRIfddA1HAvekM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vPaOS3fQXeAE1WHslGB1ZQ4kuTzdrDIIxOVi1g1AXd10kbyBlsAvfhfaMgTB9I2Oe
         fs7daSn8oN7O+1iEsJnFIX5KpKQr7F0ANPlpkCoiV0g+AacmDFB+UOe5NXLStffAkq
         nlmGec4sPL/xf+tQZ1ztSCdxDqnyUcX9ipna5X+Q=
Date:   Wed, 7 Apr 2021 07:54:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Du Cheng <ducheng2@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        syzbot+5f9392825de654244975@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: wireless: convert WARN_ON() to pr_warn() in
 cfg80211_sme_connect
Message-ID: <YG1JDsaRpws1FkzI@kroah.com>
References: <20210407021903.384158-1-ducheng2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407021903.384158-1-ducheng2@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Apr 07, 2021 at 10:19:03AM +0800, Du Cheng wrote:
> A WARN_ON(wdev->conn) would trigger in cfg80211_sme_connect(), if
> multiple send_msg() system calls are made from the userland, which
> should be anticipated and handled by the wireless driver. Convert this
> WARN() to pr_warn to prevent a kernel panic if kernel is configured to
> "panic on warn".
> 
> Bug reported by syzbot.
> 
> Reported-by: syzbot+5f9392825de654244975@syzkaller.appspotmail.com
> Signed-off-by: Du Cheng <ducheng2@gmail.com>
> ---
> link to syzkaller:
> https://syzkaller.appspot.com/bug?extid=5f9392825de654244975
> this patch has passed syzbot test.
>  net/wireless/sme.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/wireless/sme.c b/net/wireless/sme.c
> index 07756ca5e3b5..87a65a4c40ae 100644
> --- a/net/wireless/sme.c
> +++ b/net/wireless/sme.c
> @@ -529,8 +529,10 @@ static int cfg80211_sme_connect(struct wireless_dev *wdev,
>  		cfg80211_sme_free(wdev);
>  	}
>  
> -	if (WARN_ON(wdev->conn))
> +	if (wdev->conn) {
> +		pr_warn("%s: wdev->conn != NULL, sme connect in progress", __func__);

You have a real device, please always use 'dev_warn() for stuff like
this, or the netdev equivalent.  Also no need for __func__ for stuff
like this, that's just clutter.

Also, what can a user do if they get this information?  What does it
mean to them?  Try making the text more informative.

thanks,

greg k-h
