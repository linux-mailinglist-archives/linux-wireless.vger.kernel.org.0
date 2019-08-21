Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 468B79769B
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 12:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfHUKCK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 06:02:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfHUKCK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 06:02:10 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C74185362
        for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2019 10:02:10 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id i10so1083682edv.14
        for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2019 03:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=07D+Vb3VLQ7yy1uusVKQzDL7GcVauqDp+oTev9vZRJc=;
        b=n22YNFtMQQGwB463pN4pfu1RpN6HMReIJMzY7/LqH1FxqcKxkLRTKn50kBMfte/VKA
         bnqg2/q1kvHu/UdDouqUYQMj0I/ckVd2ybusDjZ2Z2BEhAQu7Sx2fmm6RD8wIcbJVHv8
         YgcyYRXiErOOheAr4YNqT0Hj+hpM4Rm1yWUyKZ9aDScrPvYAdwsUxpFTu43FlkQKMg9n
         W5Khb2U8eh3tVr/+hi3lAEYvbWZzavOFTmwf/hS3cdBw5c4qCxqDn6RxKzon1+pGI3e1
         vNXkcTg1C0D3RELjFbHMmtFNj+50nJxlWsoLq+xNb7t/e/7hzm3ejTNF+YY5gwbpkzg5
         c35g==
X-Gm-Message-State: APjAAAUo/fpfSJ5LDySHRKGbvI/btL0ud+TijKTe/AFFxv+vz0CNOhVU
        w76wHIIDwsA+lZ426OwkuFVJVI5+qbyiQNWUVj72ydw57JW/40WmY/lKP4+Hfe5kFjyL2jkcyLA
        18H6cVn4amT8K3iS5EnHXgpDDJo8=
X-Received: by 2002:a17:906:80da:: with SMTP id a26mr14494756ejx.222.1566381728590;
        Wed, 21 Aug 2019 03:02:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw0JI0SafZ9Vvbuugd0J1jl5yuOT94aDRH1vgoNYwg1udQjTld/BlgZzN9lZuYSJZCyNtPcGQ==
X-Received: by 2002:a17:906:80da:: with SMTP id a26mr14494741ejx.222.1566381728442;
        Wed, 21 Aug 2019 03:02:08 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id v6sm3043620ejx.28.2019.08.21.03.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 03:02:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 27C49181CEF; Wed, 21 Aug 2019 12:02:07 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Wen Gong <wgong@qti.qualcomm.com>, Wen Gong <wgong@codeaurora.org>,
        "ath10k\@lists.infradead.org" <ath10k@lists.infradead.org>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 2/7] ath10k: change max RX bundle size from 8 to 32 for sdio
In-Reply-To: <59f668bda688419e9b6f44587d391135@aptaiexm02f.ap.qualcomm.com>
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org> <1566302108-18219-3-git-send-email-wgong@codeaurora.org> <87ef1gt49d.fsf@toke.dk> <59f668bda688419e9b6f44587d391135@aptaiexm02f.ap.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 21 Aug 2019 12:02:07 +0200
Message-ID: <878srmsuow.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@qti.qualcomm.com> writes:

>> -----Original Message-----
>> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Toke
>> Høiland-Jørgensen
>> Sent: Tuesday, August 20, 2019 8:23 PM
>> To: Wen Gong <wgong@codeaurora.org>; ath10k@lists.infradead.org
>> Cc: linux-wireless@vger.kernel.org
>> Subject: [EXT] Re: [PATCH 2/7] ath10k: change max RX bundle size from 8 to
>> 32 for sdio
>> 
>> Wen Gong <wgong@codeaurora.org> writes:
>> 
>> > The max bundle size support by firmware is 32, change it from 8 to 32
>> > will help performance. This results in significant performance
>> > improvement on RX path.
>> 
>> What happens when the hardware doesn't have enough data to fill a
>> bundle? Does it send a smaller one, or does it wait until it can fill
>> it?
>> 
>
> The bundle is filled by firmware. 
> It will not wait until it can fill it.
> For example, if you do ping per second, it will have only 1 ping packet
> In the bundle.

Right, cool.

-Toke
