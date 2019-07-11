Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B56126558D
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2019 13:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbfGKLa5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 07:30:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54827 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbfGKLa5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 07:30:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so5307493wme.4
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2019 04:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yW+GDL/0xzuWFYG1dt9AKDi+uSTLAaKPId3krw+eDsU=;
        b=NQe7F0FRLkvk7Jpq2pd3GV3TWa0pivIUG3oRyKtQr2AwQGQWo0a8EwhPEhB3Xf3YZL
         MU5GdZK6v3g31LTO8DZDqu5r+TMbiHq6Wp+Ny91Tl7P1PG8eIaIi1qLAlc4sGAStnLga
         XKeLKb71ZMVpS3gbXYbxf4MtzGp/vXVsj2XTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yW+GDL/0xzuWFYG1dt9AKDi+uSTLAaKPId3krw+eDsU=;
        b=JPUZYgLejU56H8UD/NFsd9HNTeuXq5Ks80kgDQY2pm+OAslrLeddDiNCxkw92WX3v/
         1Zaq9B796zzndlNCe/1SzOm0VIuZC7vwCyqJR/0pMcg2A0S61RJ7ckgkvp75Qy8dOTth
         s3ntuBvFpffpoWtAQDz5w5s5fXOOVeJCXE5c0dJwTp3MLHx4mynBLh/O63r1CKfbdonQ
         4Z7owCPCJkyAEN3iC422QplnqgXaquY+yg70t0wh6zaYeBlxcO/lbJbpGMKykhKaaFu7
         +bg4uxliL9G1wj3I4J+qb5vrfINU1kwtYLgNi1cfioPWnNHKj8W+tzG53Nrehu6UbuGf
         Oppw==
X-Gm-Message-State: APjAAAV8rlqzwv7HXNMsrCAHz1i4EBAHHArnnvCVQW0NfBlpOu80CWnW
        n3nPg7QNfeR+TH3hIbC/nFFc3w==
X-Google-Smtp-Source: APXvYqztDbOMNIwjTfmX1MK94WoJ8IzN/fjWOu8hWAMzOICOfr9x8dKUN9pXxIqljj/3WVtSxDhM7g==
X-Received: by 2002:a1c:4041:: with SMTP id n62mr3991085wma.100.1562844655028;
        Thu, 11 Jul 2019 04:30:55 -0700 (PDT)
Received: from [10.176.68.244] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id e19sm6975024wra.71.2019.07.11.04.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 04:30:54 -0700 (PDT)
Subject: Re: [RFC 0/8] nl80211: add 6GHz band support
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Jouni Malinen <j@w1.fi>,
        Tova Mussai <tova.mussai@intel.com>
References: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
 <df53f969297fea1f3c8101cd2c1571a957985d2a.camel@sipsolutions.net>
 <16aeb2310e8.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <9ba78df6-18a3-5c1c-6c57-3fa71531b460@broadcom.com>
 <48a43287e65e1d24082dea2cc32ca14998acb8d1.camel@sipsolutions.net>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <8ca6ef2e-b41b-da40-b29a-77666d440495@broadcom.com>
Date:   Thu, 11 Jul 2019 13:30:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <48a43287e65e1d24082dea2cc32ca14998acb8d1.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/28/2019 3:04 PM, Johannes Berg wrote:
> Hi Arend, all,
> 
> Sorry. No, my thoughts aren't really more concrete, but Tova is starting
> to work on this now.
> 
>> This came up in discussion with my colleagues today and I would say from
>> mac80211 perspective there is more to it than just scanning. In short
>> the 6GHz band is for HE-only operation so for example only HE rates may
>> be used. As the bitrates are in ieee80211_supported_band having a
>> separate 6GHz band seems to have a (slight?) advantage.
> 
> Hmm, that's a good point too, I hadn't really looked _too_ much at 6GHz
> stuff.
> 
> Jouni, what do you think?
> 
> Perhaps we should just have both. I mean, we can treat this as a
> separate band, and still have code to handle operating classes properly,
> right?

I assume user-space does not necessarily need the band, but hostapd 
needs to be aware that it is operating in 6GHz to setup the correct 
(information) elements in the beacon. Obviously the operating classes 
can be used there, but I don't think there is any issue with nl80211 
exposing a 6G band.

Regards,
Arend
