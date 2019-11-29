Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A63E10D280
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 09:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfK2Ie2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Nov 2019 03:34:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfK2Ie2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Nov 2019 03:34:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BECA215F1;
        Fri, 29 Nov 2019 08:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575016467;
        bh=9xfVeBMuoPsrT6tgf6LSYwQjTpkVaWFjePAm1wmIETc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oMU2axWG5p+KzObpNxeyNoYV6vPXkZggh61cs0Cx+K+cNLr7Aphi3X04/dTZ49enx
         EdKUy8owgJLWgLHi1INvU66oxMOP1VseSnM5Rrr1ha+2+f9i3RNUaD+T2nbhLPfU8/
         UT+9v/gJgDX9LbEzrTrEbu47y64UXn3ARjf4ygR4=
Date:   Fri, 29 Nov 2019 09:34:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     qize wang <wangqize888888888@gmail.com>
Cc:     linux-wireless@vger.kernel.org, amitkarwar <amitkarwar@gmail.com>,
        nishants <nishants@marvell.com>, gbhat <gbhat@marvell.com>,
        huxinming820 <huxinming820@gmail.com>,
        kvalo <kvalo@codeaurora.org>, security <security@kernel.org>,
        linux-distros <linux-distros@vs.openwall.org>,
        "dan.carpenter" <dan.carpenter@oracle.com>,
        Solar Designer <solar@openwall.com>
Subject: Re: [PATCH v2] mwifiex: Fix heap overflow in
 mmwifiex_process_tdls_action_frame()
Message-ID: <20191129083425.GA3579842@kroah.com>
References: <CAGftXBHnkYt2KR=kqJfDhEqEuW52ckbepCmTnQQcDyDcVG0WZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGftXBHnkYt2KR=kqJfDhEqEuW52ckbepCmTnQQcDyDcVG0WZg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some minor problems with your patch:

On Fri, Nov 29, 2019 at 04:18:21PM +0800, qize wang wrote:
> mwifiex_process_tdls_action_frame() without checking
> the incoming tdls infomation element's vality before use it,
> this may cause multi heap buffer overflows.
> 
> Fix them by putting vality check before use it.
> 
> IE is TLV struct, but ht_cap and  ht_oper aren’t TLV struct.
> the origin marvell driver code is wrong:
> 
> memcpy(&sta_ptr->tdls_cap.ht_oper, pos,....
> memcpy((u8 *)&sta_ptr->tdls_cap.ht_capb, pos,...
> 
> Fix the bug by changing pos(the address of IE) to
> pos+2 ( the address of IE’s value ).
> 
> Signed-off-by: wangqize <540263207@qq.com>

This has to match the name on the From: line.

> ---
> v2: change commit log
>  drivers/net/wireless/marvell/mwifiex/tdls.c | 70
> ++++++++++++++++++++++++++---
>  1 file changed, 64 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c
> b/drivers/net/wireless/marvell/mwifiex/tdls.c
> index 09313047beed..7caf1d26124a 100644
> --- a/drivers/net/wireless/marvell/mwifiex/tdls.c
> +++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
> @@ -953,59 +953,117 @@ void mwifiex_process_tdls_action_frame(struct
> mwifiex_private *priv,
> 
>   switch (*pos) {
>   case WLAN_EID_SUPP_RATES:
> + if (pos[1] > 32)
> + return;

All of your whitespace is totally damaged here, making this patch
impossible to apply :(

Please fix up your email client to not do that (you can just use 'git
send-email' directly) and resend a v3.

thanks,

greg k-h
