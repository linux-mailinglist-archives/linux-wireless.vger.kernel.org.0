Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAD34BECF3
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 09:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfIZH4j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 03:56:39 -0400
Received: from mail.fedux.com.ar ([116.203.58.232]:59768 "EHLO
        mail.fedux.com.ar" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfIZH4j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 03:56:39 -0400
Received: from mail.fedux.com.ar (mail.fedux.com.ar [IPv6:::1])
        by mail.fedux.com.ar (Postfix) with ESMTP id AE928291C44;
        Thu, 26 Sep 2019 09:56:37 +0200 (CEST)
Authentication-Results: mail.fedux.com.ar; dmarc=pass (p=none dis=none) header.from=fedux.com.ar
Authentication-Results: mail.fedux.com.ar; spf=pass smtp.mailfrom=fedux@fedux.com.ar
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fedux.com.ar;
        s=default; t=1569484597;
        bh=QET6zNQhXT2tJoETWWESzJdgnagrDZnmtZ8ioMhA0+s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FqcK9BMAhIiDuzLzFdG803HJ0NQkDOwN6knuNDUluIZT8BKNtOZIoOnv021IzLaJs
         /BU6L4lobPY5k+BNuA329GFcxgedJvN3dSuw3qgTSVzppXbebe2vlBidh9Bfj8yrG0
         0RlYQ2RiBhNEAUEjHby9YLu5/vnDV/038U4lQf1Y=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Sep 2019 09:56:37 +0200
From:   Federico Cuello <fedux@fedux.com.ar>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Wen Gong <wgong@codeaurora.org>
Subject: Re: ath10k: Poor performance with kernel 5.3 fixed
In-Reply-To: <CA+ASDXOCqZxbASdF4S3z1derWxJO44_hWfdTkjZS0FSoswRvxw@mail.gmail.com>
References: <20190925090856.6964-1-fedux@fedux.com.ar>
 <CA+ASDXOCqZxbASdF4S3z1derWxJO44_hWfdTkjZS0FSoswRvxw@mail.gmail.com>
Message-ID: <81765f82aaeecc85dea9ce0d6524743e@fedux.com.ar>
X-Sender: fedux@fedux.com.ar
User-Agent: Roundcube Webmail/1.3.10
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-25 18:24, Brian Norris wrote:
> On Wed, Sep 25, 2019 at 2:16 AM Federico Cuello <fedux@fedux.com.ar> 
> wrote:
>> When upgrading to 5.3 my AP started to work really slow. I tracked the 
>> problem to 4504f0e5b5714d9d26b1a80bf1fc133c95830588 and fixed the 
>> issue.
> 
> For the record, that's:
> 4504f0e5b571 ath10k: sdio: workaround firmware UART pin configuration 
> bug


> 
>> The attached patch fixes the issue when uart_print is false and 
>> uart_pin_workaround also false.
> 
> -ENOPATCH

Sorry, I sent it in a different email "attached to the thread", but in 
any case, there was the same fix already applied to kvalo's tree.

Here is the patch and link to already applied fix:

   https://patchwork.kernel.org/patch/11160267/


It would be great if we can get this to stable, in my case, my WiFi 
speed went from 150 Mbit/s to 1-5 Mbit/s without this fix.
