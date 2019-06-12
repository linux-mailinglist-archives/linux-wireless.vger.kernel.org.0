Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30932421FB
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 12:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407412AbfFLKHU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 06:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405946AbfFLKHU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 06:07:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 486A22080A;
        Wed, 12 Jun 2019 10:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560334039;
        bh=Z0uFGeIYb8NOCYuMjBbf2vGG/B/zrmYzY6IbKTW5PuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hsygi9Ouhowtd80jDBfZMIFp2HBWyjceyODdZKcUaH5kE3NwpTtenD0Mm6GUm9FN+
         0q6Kn9vtxWzaqK/bOOvpEOyM1pB4lhLrD8vJS4FyORGsx/1nj1J/qc12ElUOZNRCLS
         Q8iksG83usxRGq1o56wF+1ZcxL7KiSJOM6b2kX58=
Date:   Wed, 12 Jun 2019 12:07:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maya Erez <merez@codeaurora.org>, Kalle Valo <kvalo@codeaurora.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Subject: Re: [PATCH] wireless: wil6210: no need to check return value of
 debugfs_create functions
Message-ID: <20190612100717.GA19167@kroah.com>
References: <20190611191024.GA17227@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611191024.GA17227@kroah.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jun 11, 2019 at 09:10:24PM +0200, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Maya Erez <merez@codeaurora.org>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-wireless@vger.kernel.org
> Cc: wil6210@qti.qualcomm.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/wireless/ath/wil6210/debugfs.c | 80 ++++++----------------
>  1 file changed, 22 insertions(+), 58 deletions(-)

Oops, 0-day finally woke up and shows I messed this patch up.  Please
drop it, I will submit a v2 soon.

thanks,

greg k-h
