Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6ED218A67
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2019 15:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfEINQT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 May 2019 09:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfEINQT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 May 2019 09:16:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C4732089E;
        Thu,  9 May 2019 13:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557407778;
        bh=GIqliF5524DxevnKWgo78eBvg6VnxUicwiq331kQDDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9oTIHI/Dcm0AdykEFqZzoKAdYcrBCpBA6FDOW6h3zLbopvc6rM99UP+vUPko+e+y
         ugTveD2krX6Jrd1S8gi614rBDgyrhBeKVZma4NbX5pKS122P/eOPRZD3SqQMYZC9OV
         wkNDcwxTduWYxdZJk1krvIKkSTZngIAUC2r9G8EI=
Date:   Thu, 9 May 2019 15:16:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     kvalo@codeaurora.org, ath10k@lists.infradead.org,
        andreyknvl@google.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath10k: Change the warning message string
Message-ID: <20190509131616.GB19094@kroah.com>
References: <20190509121500.4730-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509121500.4730-1-festevam@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 09, 2019 at 09:15:00AM -0300, Fabio Estevam wrote:
> The "WARNING" string confuses syzbot, which thinks it found
> a crash [1].
> 
> Change the string to avoid such problem.
> 
> [1] https://lkml.org/lkml/2019/5/9/243
> 
> Reported-by: syzbot+c1b25598aa60dcd47e78@syzkaller.appspotmail.com
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/net/wireless/ath/ath10k/usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
