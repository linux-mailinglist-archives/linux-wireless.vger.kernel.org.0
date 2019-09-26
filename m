Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4718BF36A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 14:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfIZMyT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 08:54:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41512 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfIZMyT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 08:54:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4C4A2614DB; Thu, 26 Sep 2019 12:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569502458;
        bh=eNhcs/ZYjvDCzx5+kNiqVivk1OFEH6ODOV34ybe75B0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GoNKLRGXAscx5Zx6mLnc1qOUtFzm4C62UjGIi9AzKmfXM4ZaPzxsWRjRzF3ODgr7C
         +7WdO1pD4aIIm6umtEtGGRLn9mTt24jVzgBR4udsqI5ywMO3r3BdK/1lcIe7pEz1/r
         Fbhau1GgXoAOgXoudKJJbXYf0W+rqXdR/URTTZVU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 333B261378;
        Thu, 26 Sep 2019 12:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569502455;
        bh=eNhcs/ZYjvDCzx5+kNiqVivk1OFEH6ODOV34ybe75B0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=InyQzI9yKHf18w1C52eyTlG3Q+pNdSEv2Cyb6muVZQKBBQ7W3LRpPHjIKOpvCYbR0
         ElHU3nz0zNsnWDs9bb0xz6BiL5QPfLLehBjeyDwgzWpEFdC8zugthzehVM610sT3GU
         8I7Zx11gl/BiZ+LpXo7i4iDRph4Yn4z5ZXWVhpYQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 333B261378
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Federico Cuello <fedux@fedux.com.ar>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Wen Gong <wgong@codeaurora.org>,
        Miaoqing Pan <miaoqing@codeaurora.org>
Subject: Re: ath10k: Poor performance with kernel 5.3 fixed
References: <20190925090856.6964-1-fedux@fedux.com.ar>
        <CA+ASDXOCqZxbASdF4S3z1derWxJO44_hWfdTkjZS0FSoswRvxw@mail.gmail.com>
        <81765f82aaeecc85dea9ce0d6524743e@fedux.com.ar>
Date:   Thu, 26 Sep 2019 15:54:11 +0300
In-Reply-To: <81765f82aaeecc85dea9ce0d6524743e@fedux.com.ar> (Federico
        Cuello's message of "Thu, 26 Sep 2019 09:56:37 +0200")
Message-ID: <87k19vi5fw.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ Miaoqing

Federico Cuello <fedux@fedux.com.ar> writes:

> On 2019-09-25 18:24, Brian Norris wrote:
>> On Wed, Sep 25, 2019 at 2:16 AM Federico Cuello <fedux@fedux.com.ar>
>> wrote:
>>> When upgrading to 5.3 my AP started to work really slow. I tracked
>>> the problem to 4504f0e5b5714d9d26b1a80bf1fc133c95830588 and fixed
>>> the issue.
>>
>> For the record, that's:
>> 4504f0e5b571 ath10k: sdio: workaround firmware UART pin
>> configuration bug
>
>
>>
>>> The attached patch fixes the issue when uart_print is false and
>>> uart_pin_workaround also false.
>>
>> -ENOPATCH
>
> Sorry, I sent it in a different email "attached to the thread", but in
> any case, there was the same fix already applied to kvalo's tree.
>
> Here is the patch and link to already applied fix:
>
>   https://patchwork.kernel.org/patch/11160267/
>
>
> It would be great if we can get this to stable, in my case, my WiFi
> speed went from 150 Mbit/s to 1-5 Mbit/s without this fix.

I didn't know that the bug was severe and I applied the patch to
ath-next, which means it will go to v5.5 which is bad. (This is why I
always ask people to clearly describe the bug in the commit log!)

In theory I could also push it to v5.4 but I just don't want to deal
with the possible conflicts coming from duplicate commits.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
