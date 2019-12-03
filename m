Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0473D10FD73
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2019 13:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfLCMOP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Dec 2019 07:14:15 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52975 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbfLCMOO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Dec 2019 07:14:14 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2111322484;
        Tue,  3 Dec 2019 07:14:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 03 Dec 2019 07:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm2; bh=E
        YOPuf7xvIS+4duuNHYF9d4g3puRuvE7RB4e+PKt1OI=; b=bnADDfDsYpLDkLdIt
        2WrZvLUfk5dC1RrLBKLHG+/24HRrlVc1m0hlsdZOjzvTPqud5eXnGZn+idYBugCT
        tvI622WGqYULnK/rDxFlSOOd4noe+UM8J6Yx1U10krxeqK69HmzKfsotz6U13P/d
        lX6XH2dntKGKutt+NwdBpHDOzKW+WZXtA/lDKDxBUykGyFjF2opEmsvh/hmoXVth
        YhRMqLGkYLLwrhQnkTxiBO+f7BBviC+9yNIQQq8nh5ILxZlkSRmMaHCbWfxi+kgn
        EmsJTglYpHKN+4wwK/VWOhjOQNM3+mdxKn50/mGwWXsfRG/0MzjITHYi/2fl0qEI
        dIJVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=EYOPuf7xvIS+4duuNHYF9d4g3puRuvE7RB4e+PKt1
        OI=; b=ZjII+OlwM+CbXItLVpgRjwD/w4IPrPV1Z+H3I8T7eX35lTJgIuwfWcV9c
        Qmr16PczDS1DGF6q6S4BD2beOlbTa94kFwosJ9e2amjI5kNV703ebhId0UNlDftJ
        nwQIF5LzKbaQOpvdlwVDW7Zq6nAan0lMKe4ut2mGpij0z0jedn3io0GIYq8PfPxz
        H4KP9iKNNnVmhQjJVDq6TAv9DfDPTVm0qv/TufbbHBZmZwE3m2dvJJ33+wP+/+1y
        J/h3Q02J6DOvmAzN7CtjjeSWHXZO8ENcy+a3hh8GXCUlVMdGDinLKvJBHlxCKS8+
        eI5u7s9GutZXwMssVfcBV7aTZMU7g==
X-ME-Sender: <xms:lVHmXZOFY7jdaPKjDBJgzlAjUFkmHdSG4M3u4q-ynIhzRBPUltFZag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjggfsehtkeertddtreejnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrd
    dutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:lVHmXUxh-eBqtiVomfccRfebypLI0UyVin0NEsH3BnsAzTScTLtGsg>
    <xmx:lVHmXfNvfXNeKv1BNGYHARzV0SwabEqZj0phwDJIp5bJqWzPkvm-ig>
    <xmx:lVHmXfQxdJerKHH_sh_d91AHMoHM-AFPSxK-12Q4Pr4KoQWd1ofs2g>
    <xmx:llHmXfn67z97L3AkEztW8Yds-pIDdCaAQNWrDIG3UIU-3ISYEyqHrQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 59FA83060158;
        Tue,  3 Dec 2019 07:14:13 -0500 (EST)
Date:   Tue, 3 Dec 2019 13:14:06 +0100
From:   Greg KH <greg@kroah.com>
To:     Brian Norris <briannorris@chromium.org>
Cc:     qize wang <wangqize888888888@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        amit karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Solar Designer <solar@openwall.com>
Subject: Re: [PATCH v3] mwifiex: Fix heap overflow in
 mmwifiex_process_tdls_action_frame()
Message-ID: <20191203121406.GA2127957@kroah.com>
References: <20191129101054.2756-1-wangqize888888888@gmail.com>
 <CA+ASDXOj0rz4S3BoMdF1pqOiVZ4yhVE_Qy+s6iTObCnhFfwFLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+ASDXOj0rz4S3BoMdF1pqOiVZ4yhVE_Qy+s6iTObCnhFfwFLw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 02, 2019 at 03:16:35PM -0800, Brian Norris wrote:
> A bit late, but a few readability and maintainability thoughts:
> 
> On Fri, Nov 29, 2019 at 2:12 AM qize wang <wangqize888888888@gmail.com> wrote:
> >
> > mwifiex_process_tdls_action_frame() without checking
> > the incoming tdls infomation element's vality before use it,
> > this may cause multi heap buffer overflows.
> >
> > Fix them by putting vality check before use it.
> >
> > IE is TLV struct, but ht_cap and  ht_oper aren’t TLV struct.
> > the origin marvell driver code is wrong:
> >
> > memcpy(&sta_ptr->tdls_cap.ht_oper, pos,....
> > memcpy((u8 *)&sta_ptr->tdls_cap.ht_capb, pos,...
> >
> > Fix the bug by changing pos(the address of IE) to
> > pos+2 ( the address of IE value ).
> >
> > v3: change commit log
> >
> 
> Would have been great to have a
> 
> Cc: <stable@vger.kernel.org>
> 
> tag here. I'm not sure if "just have GregKH on CC" is the right process...

Not at all :)

