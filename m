Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FDB37A46B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 12:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhEKKRu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 06:17:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47805 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhEKKRt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 06:17:49 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lgPRS-0001td-Qa; Tue, 11 May 2021 10:16:42 +0000
Subject: Re: [RFC PATCH] mt7601u: make the driver work again
To:     Rui Salvaterra <rsalvaterra@gmail.com>,
        Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     lorenzo@kernel.org, kuba@kernel.org, linux-wireless@vger.kernel.org
References: <20210504212828.815-1-rsalvaterra@gmail.com>
 <20210505045044.GA735251@wp.pl>
 <CALjTZvYZ8Rr-UFyqFststt+vG+Ei1avUvPVxQwHe72QU0NEeKA@mail.gmail.com>
 <20210505092542.GA757514@wp.pl>
 <CALjTZvausPmK+AubwcV71b1Vi+JxN23fM-AfUr1+jRD+NbnW1g@mail.gmail.com>
 <20210505132513.GA759295@wp.pl>
 <CALjTZvaQjGDc2iO7gLvTzXp1xWs78UqFVFxdGVD9ta971bRYSQ@mail.gmail.com>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <ab30bf35-b05b-685f-2b31-5d211f896e2e@canonical.com>
Date:   Tue, 11 May 2021 11:16:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CALjTZvaQjGDc2iO7gLvTzXp1xWs78UqFVFxdGVD9ta971bRYSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/05/2021 11:13, Rui Salvaterra wrote:
> Hi, again,
> 
> Well, this was "fun"… I rebased my patch on top of 5.13-rc1 and now my
> MT7601U adapters are broken again. I tried different combinations of
> mine and the the last two upstream patches [1][2], but the result is
> the same, so now I have no idea of what's going on.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/mediatek/mt7601u?h=v5.13-rc1&id=87fce88658ba047ae62e83497d3f3c5dc22fa6f9
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/mediatek/mt7601u?h=v5.13-rc1&id=670d9e53886c942b7f29c475b2b494278e586921

If reverting the above patches does not work, I suspect a bisect is
required to corner the exact reason.

> 
> Thanks,
> Rui
> 


