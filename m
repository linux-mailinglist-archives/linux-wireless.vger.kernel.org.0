Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0AF32F0DA
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Mar 2021 18:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhCERLJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Mar 2021 12:11:09 -0500
Received: from gateway24.websitewelcome.com ([192.185.50.71]:18372 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231514AbhCERKk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Mar 2021 12:10:40 -0500
X-Greylist: delayed 1240 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Mar 2021 12:10:40 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 99C4AC73B
        for <linux-wireless@vger.kernel.org>; Fri,  5 Mar 2021 10:49:56 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id IDeGlRQYdA1KVIDeGlqZ7Z; Fri, 05 Mar 2021 10:49:56 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xxm6vs574ulUJk2+2dsCPFn//qghqTGxbJvH0vJzGgk=; b=aMfNY8eoM19UyWCS1qqtPCIhLO
        KwZphr7O6FJ5HOby6ab4G1cHNaj1hrB9KY3oXA+1PPWesypR7o/1vhn780tncN3+dFmL4PYqDUjcQ
        JuyTAj1zimVKLeX4yQGKlAGUc/QQBaldbhiV4dhXOJgRK+hdQqFfzdh+qrV17ZfJ+3xFyrdzEThKR
        6k/Q5pu8kmQ7fQhOdm0gdsDUnnfgFPrsBde5FKm9ARUKFGA3V7ACgaL7iVXdghh3yHHbdrkk/Wx/s
        2VxtFSA4uZDQiK+e2IzYd+Q3DQp7rrYJ2Vw4i4vdp2e6nAYAJWs4lVdZEMR6TVYmwm/BwK4v9XsFX
        +IQYrs9A==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:34376 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lIDeG-002J3r-67; Fri, 05 Mar 2021 10:49:56 -0600
Subject: Re: [PATCH RESEND][next] rtl8xxxu: Fix fall-through warnings for
 Clang
To:     Kalle Valo <kvalo@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210305094850.GA141221@embeddedor>
 <871rct67n2.fsf@codeaurora.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <a988a651-1233-0ac3-7018-4ea24096f167@embeddedor.com>
Date:   Fri, 5 Mar 2021 10:49:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <871rct67n2.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lIDeG-002J3r-67
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:34376
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 3/5/21 07:40, Kalle Valo wrote:
> "Gustavo A. R. Silva" <gustavoars@kernel.org> writes:
> 
>> In preparation to enable -Wimplicit-fallthrough for Clang, fix
>> multiple warnings by replacing /* fall through */ comments with
>> the new pseudo-keyword macro fallthrough; instead of letting the
>> code fall through to the next case.
>>
>> Notice that Clang doesn't recognize /* fall through */ comments as
>> implicit fall-through markings.
>>
>> Link: https://github.com/KSPP/linux/issues/115
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> It's not cool that you ignore the comments you got in [1], then after a
> while mark the patch as "RESEND" and not even include a changelog why it
> was resent.

I'm a bit confused. I replied to the same thread at the time. You can see
my response there. No one replied back. :/

--
Gustavo

> 
> [1] https://patchwork.kernel.org/project/linux-wireless/patch/d522f387b2d0dde774785c7169c1f25aa529989d.1605896060.git.gustavoars@kernel.org/
> 
