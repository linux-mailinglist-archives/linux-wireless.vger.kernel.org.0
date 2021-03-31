Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9654D34F8C4
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Mar 2021 08:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhCaG2d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Mar 2021 02:28:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233813AbhCaG2S (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Mar 2021 02:28:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5ADB619B1;
        Wed, 31 Mar 2021 06:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617172098;
        bh=5uxPRQ9GoiYbpBHn54+wtuQFW30M/xjIPiCOTwrMBSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=noJoS3xCXbQxkZIoxlhtm2lqBSeAbmRg3OjfCbmdDLvut9dUqUW0Ue7GPo+nFa9Sj
         H+vQ8ADEdWmtri/15hr21P3RFLDJlyV9BbNLQa7TzP6/WVzr7MikpjiLrwMAoaCQw3
         razPCSoEQR/nelUYjPyjNyJc0MD8M+2yLnyaVqV0=
Date:   Wed, 31 Mar 2021 08:28:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     brookebasile@gmail.com, ath9k-devel@qca.qualcomm.com,
        davem@davemloft.net, kuba@kernel.org, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        syzbot+89bd486af9427a9fc605@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: Memory leak in ath9k_hif_usb_dealloc_tx_urbs()
Message-ID: <YGQWf1lP4ZOUFiG5@kroah.com>
References: <20200911071427.32354-1-brookebasile@gmail.com>
 <20210330193652.10642-1-paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330193652.10642-1-paskripkin@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Mar 30, 2021 at 10:36:52PM +0300, Pavel Skripkin wrote:
> Hi!
> 
> I did some debugging on this
> https://syzkaller.appspot.com/bug?id=3ea507fb3c47426497b52bd82b8ef0dd5b6cc7ee
> and, I believe, I recognized the problem. The problem appears in case of
> ath9k_htc_hw_init() fail. In case of this fail all tx_buf->urb krefs will be
> initialized to 1, but in free function:
> 
> static void ath9k_hif_usb_dealloc_tx_urbs(struct hif_device_usb *hif_dev)
> 
> ....
> 
> static void ath9k_hif_usb_dealloc_tx_urbs(struct hif_device_usb *hif_dev)
> {
>     ...
> 	list_for_each_entry_safe(tx_buf, tx_buf_tmp,
> 				 &hif_dev->tx.tx_buf, list) {
> 		usb_get_urb(tx_buf->urb);
> 		...
> 		usb_free_urb(tx_buf->urb);
> 		...
> 		}
> 
> Krefs are incremented and then decremented, that means urbs won't be freed.
> I found your patch and I can't properly understand why You added usb_get_urb(tx_buf->urb).
> Can You explain please, I believe this will help me or somebody to fix this ussue :)

I think almost everyone who has looked into this has given up due to the
mess of twisty-passages here with almost no real-world benefits for
unwinding them :)

Good luck!

greg k-h
