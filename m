Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64CD3F8DA7
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 20:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhHZSM4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 14:12:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229733AbhHZSM4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 14:12:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AF0760F92;
        Thu, 26 Aug 2021 18:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630001528;
        bh=twz5qjfjs3FJbsj6czhiTtitZVCzSoSTVpLqfp7OECg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hq4hit2omb/F8USIQBiXwf1s6cMa8i8CXlt8xq4CmxL7+SfKgMzzS3yqMmWZEPCVd
         A+i9B4sjCH8uc8iYmSdp0+NQE5Ol98Z0mqWkHM3Eh+QTf9q04vw9D95qYiwOfaodk1
         8b55k25Q8VjIUZ4OABbF7OSB5lk/+W7DI2eZjPc3WK24UETY3AJqRRQn9xFNaKsozZ
         IrnvZVwOuAkMpdn411eeWQuLTz2TnrOm6H19zFPmX4KaTDX1B5yRuw4uGfbjDDfg46
         9wQnPDtHGLxmHCW/4c83P1tSowb96r3r01zAIBAJr32QqaMKFaBTq0FQPiEPEyXZgb
         gekelTGW6N5DQ==
Date:   Thu, 26 Aug 2021 11:12:07 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Wren Turkal <wt@penguintechs.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, regressions@lists.linux.dev,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Nicolas Schichan <nschichan@freebox.fr>
Subject: Re: [regression] Re: 5.14 rc6 broken for QCA6390 on Dell XPS 13
 9310
Message-ID: <20210826111207.364d0ba5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <87y28o5cw4.fsf@codeaurora.org>
References: <a8cddf24-ecfc-088e-27f4-98cbbb5fb67c@penguintechs.org>
        <87y28sqq4l.fsf@codeaurora.org>
        <843e7689-fa1e-441b-c49a-ed7291046d5f@freebox.fr>
        <87tujgqcth.fsf@codeaurora.org>
        <87mtp47073.fsf_-_@codeaurora.org>
        <YSenaxWzxRkYkucv@kroah.com>
        <20210826074850.16768dee@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <87eeag6yjr.fsf@codeaurora.org>
        <87y28o5cw4.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 26 Aug 2021 20:33:47 +0300 Kalle Valo wrote:
> >> Also no objections here. FWIW I'm about to send the last PR for
> >> networking, still waiting on BPF. You can send the revert to netdev, 
> >> or directly to Linus as you prefer. LMK.  
> >
> > I prefer take it via the net tree if possible, so if you can wait ~2h
> > and I'll send it to you.  
> 
> I now submitted the revert, please take it into the net tree if you
> still can:
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20210826172816.24478-1-kvalo@codeaurora.org/
> 
> I also tested the build with various QRTR options and didn't see any
> build errors.

Done, thank you!
