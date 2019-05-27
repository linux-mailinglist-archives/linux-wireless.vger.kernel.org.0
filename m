Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDF62BB7E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2019 22:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfE0Uq6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 May 2019 16:46:58 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:42900 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfE0Uq6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 May 2019 16:46:58 -0400
Received: by mail-pg1-f178.google.com with SMTP id 33so6656746pgv.9
        for <linux-wireless@vger.kernel.org>; Mon, 27 May 2019 13:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c6eMB8+X9g+GMzRG2keMO6Vm78NswSXM6+zzJgYioN8=;
        b=C1NGWm+ELnqUUGQXQnsl7hsHzxVhnp+3qcjLVapHZJiAXGABNfB+vMCJ2aBc4HrkBj
         Wmri1XvKtkrD8+JnBzy6Nd872KwrCIHlYl6h/LnnexXcQ9iDiWaw2t8RY+zcn/2hUR//
         vB4v1kDPAYqe1Lg7Pi9lV50sEB+uvy37ArEEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c6eMB8+X9g+GMzRG2keMO6Vm78NswSXM6+zzJgYioN8=;
        b=TtcZ8GZ1DUvKYIx4WQ0wg32n18/XCSvMudI0PUYm+NBYiV28OBIThWC4/p60BMHf2j
         BQcqt5gzbbEpnuNrpvWorhfgay4sBX0B+LtgWJU9sB+mJpf64K0U2dPI5vOIFYHwDyub
         SAUocxUifhIm/ZrmrqruAzCI7yomzLlxmmFo/LmU9Qe5I9D8ebRx8mZWgvxw+AH6RbLY
         ZPEeyyqlKosSrXpPYa/PfucoE+SI9EqUJWyqVVAnNNAhxxlVaSK/RUgxws8AWffojh/L
         hIVKEeP0YapFmW8bZdGw1P+BRyR8mWZcO3EV60dh35Fc9gda9txLvwqtLPJKyWo94Oqt
         P34g==
X-Gm-Message-State: APjAAAWV3lrMxhUSMr33GlGJBFAvdIP2DLix0IpQqPTDJ3PycdUC2Fe6
        ruRMqa9ta2AfnI+a1xXgwygWSLHqcGGRCOK4rC3+VyfVjH+KQoDwiVpXF5wJENBNrSnnMjrbefg
        5B9pEzCLoQWuMDuO1m1Fl1C3fMMQJnRWNx9TvT9Kq8JJmLBgiUmMX9keHcJ8+6d5/fDP75tbHBS
        XM4dNAyD1PxrPGyw==
X-Google-Smtp-Source: APXvYqxFAKxv/JEXch1onVDGIGfxqMVqRgyQfz1EMKtAPqvv273SDOyKmegCJt3b66sqmQaM+aOJ9w==
X-Received: by 2002:a17:90a:af8a:: with SMTP id w10mr863704pjq.132.1558990017639;
        Mon, 27 May 2019 13:46:57 -0700 (PDT)
Received: from [10.230.40.234] ([192.19.215.250])
        by smtp.gmail.com with ESMTPSA id e5sm9530872pgh.35.2019.05.27.13.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:46:56 -0700 (PDT)
Subject: Re: [RFC 0/8] nl80211: add 6GHz band support
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
 <df53f969297fea1f3c8101cd2c1571a957985d2a.camel@sipsolutions.net>
 <16aeb2310e8.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Message-ID: <9ba78df6-18a3-5c1c-6c57-3fa71531b460@broadcom.com>
Date:   Mon, 27 May 2019 22:46:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <16aeb2310e8.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/24/2019 8:38 PM, Arend Van Spriel wrote:
> On May 24, 2019 1:56:43 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> 
>> Hi Arend,
>>
>> On Mon, 2019-05-20 at 14:00 +0200, Arend van Spriel wrote:
>>> In 802.11ax D4.0 a new band has been proposed. This series contains
>>> changes to cfg80211 for supporting this band. With 2GHz and 5GHz there
>>> was no overlap in channel number. However, this new band has channel
>>> numbers with a range from 1 up to 253.
>>
>> At the wireless workshop in Prague, we looked at this and sort of
>> decided that it'd be better to put all the 6 GHz channels into the 5 GHz
>> "band" in nl80211, to avoid all the "5 || 6" since they're really the
>> same except for very specific places like scanning.
> 
> Would have liked to be there, but attending is no longer an option for 
> me. We now have two autistic, non-verbal children and I am the primary 
> caregiver for the oldest because my wife can't handle him. Guess I 
> should have checked the workshop notes before working on this :-) Do you 
> have URL?

Found the netdev wifi workshop page and looked over the slides quickly, 
but the notes page is pretty empty ;-)

> Agree that most functional requirements for 6 GHz are same as 5 GHz. 
> There are some 6 GHz specifics about beaconing as well.

This came up in discussion with my colleagues today and I would say from 
mac80211 perspective there is more to it than just scanning. In short 
the 6GHz band is for HE-only operation so for example only HE rates may 
be used. As the bitrates are in ieee80211_supported_band having a 
separate 6GHz band seems to have a (slight?) advantage.

Regards,
Arend
