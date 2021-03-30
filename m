Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15A934EDF8
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Mar 2021 18:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhC3QeQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Mar 2021 12:34:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232134AbhC3Qdw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Mar 2021 12:33:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B66861957;
        Tue, 30 Mar 2021 16:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617122032;
        bh=4FgOS9K+15DNGaV+Wk/LS6dsKMwSObsl+CaQw/GLnF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5OP4d/a4RWsT9ulv4YkXnawtC00KKtoRLzHXArvDeHWEGUOVyYIZuXdgKQyOjfLV
         3WW3GRknjcveMKAJWByfq/17uV3mtl74rDhPGtEQnBlBwJeCzLyhaQlI1v1NY9aX8u
         7h36RmGoRHcKbiO3utpafxyqB1Q2Hr/CjQ0mRTH8=
Date:   Tue, 30 Mar 2021 18:33:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?0JHQvtCz0LTQsNC9INCf0LjQu9C40L/QtdC90LrQvg==?= 
        <bogdan.pylypenko107@gmail.com>
Cc:     linux-wireless@vger.kernel.org, Larry.Finger@lwfinger.net
Subject: Re: rtw88 kernel module error report (UBSAN:
 array-index-out-of-bounds in drivers/net/wireless/realtek/rtw88/phy.c)
Message-ID: <YGNS7WKlBmLrM9/d@kroah.com>
References: <CALw23pC5kFE23g8M97KJY5vK8-eP1dWPj3jze=j4Mi=NjHks0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALw23pC5kFE23g8M97KJY5vK8-eP1dWPj3jze=j4Mi=NjHks0w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Mar 30, 2021 at 07:26:15AM -0900, Богдан Пилипенко wrote:
> Hi!
> I finded your emails at:
> - https://github.com/lwfinger/rtw88
> - https://wireless.wiki.kernel.org/en/users/drivers/rtl819x
> 
> I have an error in dmesg:
> *dmesg | grep rtw88*
> 
> > [   26.518691] UBSAN: array-index-out-of-bounds in
> > drivers/net/wireless/realtek/rtw88/phy.c:1661:35
> > [   26.518804]  rtw_get_tx_power_params+0xc66/0xd80 [rtw88_core]
> > [   26.518822]  ? check_hw_ready+0x4f/0xa0 [rtw88_core]
> > [   26.518836]  rtw_phy_get_tx_power_index+0x4d/0x1e0 [rtw88_core]
> > [   26.518850]  rtw_phy_set_tx_power_level+0xcc/0x1a0 [rtw88_core]
> > [   26.518864]  rtw_set_channel+0xc1/0x120 [rtw88_core]
> > [   26.518878]  rtw_ops_config+0x87/0xc0 [rtw88_core]
> 
> 
> And many-many cyclic errors like (size 224 & size 512):
> *cat /sys/kernel/debug/kmemleak*

Can you submit a patch for this to resolve the issue as you can
reproduce it easily?

thanks,

greg k-h
