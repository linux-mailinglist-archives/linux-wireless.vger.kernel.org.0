Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B56B02D03C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 22:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfE1U14 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 16:27:56 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:40677 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfE1U14 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 16:27:56 -0400
Received: by mail-ed1-f54.google.com with SMTP id s19so5533824edq.7
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2019 13:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cPP04IloFnPa5c9+YmxzQndzfuK3JG2EmKKmkSkTymk=;
        b=TVqEK++cs6d68l17eMOOwsj1y0iplkc2yY+Q7mFXoUU7dQ/Sh4kFcae3HHneyNiG2L
         yKuJgon5q1ZpHpkC6UiS8QPwt1tY8TOqmeogQ+gSKU5q/93X3XRrawKeOSNYyf0WdSqp
         MHsaNF//h1NKru5bGKA9WytTHTJur15+WyRto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cPP04IloFnPa5c9+YmxzQndzfuK3JG2EmKKmkSkTymk=;
        b=M0xxP8zLAgn3HjIyPKT5F5FOG24TqEU9O6hSIjy4gYMIPEQ9bEY/10cEEJ8IZ6Fm5u
         9yNFAuAruaSX0/es4wjlAUrzAyfwFerSH6zpP1tinr7n+ILYIR7Y3YyS86E7GIFIChrN
         8q7zYjKxzU2Uvi23iBmHJCz1bQGD1uW6gVPzo5NG01ujiuGM8PW9C91xvcL/iVNZDAjw
         PC356E4qvxjxfpXorNKL+xAM97PIi/8Uev7lhxM0zSaVtRGJFqRHIOx7zCjB4VyoU/rl
         DpuLad9uymcb+N38ENB6rxjPjs+3m+fqQ5wyfjes4dJ+tHTs9SQG14xO0Tzm/611zKu1
         1FwA==
X-Gm-Message-State: APjAAAVWnaA+bPu/d473KuRK63AB6B5ugvf974ZD0YrcUcO0F4n4LKLf
        vB5rA8XIBFmats0Rf1KW6QM0xQL2bRrhjWSQf0KsvZytYKN5w6R6p8X/GBEJbhxrJssxSVQL9FX
        i7K6vBIc8xm01PYHFhdhFFbaCFdOOkdfag8rGRFSr35cS6jNG+V305Pjqb2pWwlau+Yqzkl7mgU
        uMVhw43fjcwQKdbRgQ
X-Google-Smtp-Source: APXvYqwLWTUmCN4Acox7uQM8nCikEEBjt0DWvz9E6ha4e3e2tgwrqnv/IPDFrVz0nIIat1loRnGfcg==
X-Received: by 2002:aa7:c0d3:: with SMTP id j19mr99838732edp.179.1559075274825;
        Tue, 28 May 2019 13:27:54 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id h4sm2415748ejx.81.2019.05.28.13.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 13:27:54 -0700 (PDT)
Subject: Re: brcmfmac & DEL_INTERFACE
To:     Denis Kenzior <denkenz@gmail.com>
References: <089d2d0a-a802-3c2b-4993-e17326028d1f@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5679a6a1-e4a1-1f55-5b6d-21b178201078@broadcom.com>
Date:   Tue, 28 May 2019 22:27:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <089d2d0a-a802-3c2b-4993-e17326028d1f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/28/2019 8:16 PM, Denis Kenzior wrote:
> Hi Arend,
> 
> We noticed that brcmfmac doesn't support .del_virtual_intf for 
> non-p2p/ap interface types.  Any chance this can be added?
> 
> We currently remove all wifi interfaces and re-create the needed ones 
> with SOCKET_OWNER set, and it would be nice if we didn't need to treat 
> brcmfmac specially.

This came up recently. During probe the driver creates a network 
interface that we refer to as primary interface. We consider this 
non-virtual and ownership is with the driver. My guess is that this 
concept comes from the WEXT era, where we did not have the ieee80211 phy 
objects to interact with the driver from user-space. I suppose you don't 
mind the creation of this interface and just want to allow removing it, 
right?

Regards,
Arend
