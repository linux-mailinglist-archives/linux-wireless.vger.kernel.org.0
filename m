Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C84616301
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2019 13:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfEGLn4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 May 2019 07:43:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44734 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfEGLn4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 May 2019 07:43:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id b8so18390883edm.11
        for <linux-wireless@vger.kernel.org>; Tue, 07 May 2019 04:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0kgIETqFDt+tqtqx6uKvzhB6Qv6yCVJRdyuTHvfTidU=;
        b=XCGxgLj8C2btnNrX1y/E/0cDDREqfQGbzlf2obmNvkFzFP1iFTDaUHV63Qf3uwRJMP
         G6vqYXHT8tvwjh4USRIy87H8fpQ3fNcQNIKeuuFo+gIQH57TLzNF9tELev2Xi4qTfK0C
         Kg1ccpVV4x2gCzVSYsx8DocXvrGVSuORS54PMaCkwd/gHqQO93K8otc6fyDGepfJCX5n
         bdVDIvq7NAlnwuDnmZ76bRzk6PdRU/1St8OVLXFI2uCZL0r25mkbNEEInyqZqK9cDBis
         E+2WzQX/MFXcL8hN8QgAHNGA/h7hkP8GlaCOXjBNQKFCg1vcnhg9TOs99n1EAO2KlVre
         ZcaQ==
X-Gm-Message-State: APjAAAUAYqxDCQ1XuY3NmSD1F8BWTnNd2XvcQZu5mg9KWMvHNLbWJrMm
        WgHx3H9AvbDe76tVXfPM1nT2jA==
X-Google-Smtp-Source: APXvYqwodIXCnEmMk+cj678f55sRblfeRoVgVWWJHcnptgzsAlbB5kfIHlBTL8fgZtSwhlwexToOkw==
X-Received: by 2002:a17:906:6d58:: with SMTP id a24mr11402671ejt.104.1557229434480;
        Tue, 07 May 2019 04:43:54 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.vpn.toke.dk. [2a00:7660:6da:10::2])
        by smtp.gmail.com with ESMTPSA id 65sm594134edk.88.2019.05.07.04.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 04:43:53 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DFBA71803A4; Tue,  7 May 2019 13:43:52 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     leiwa@codeaurora.org
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] ath10k: fix different tx duration output
In-Reply-To: <ef8c4fec57a8117b98e30c904fc1a3f5@codeaurora.org>
References: <1555489045-18070-1-git-send-email-leiwa@codeaurora.org> <87mukprnie.fsf@toke.dk> <298a645b17aac0f5c466f011225533b0@codeaurora.org> <875zrbrb1q.fsf@toke.dk> <ef8c4fec57a8117b98e30c904fc1a3f5@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 07 May 2019 13:43:52 +0200
Message-ID: <87y33i7amf.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

leiwa@codeaurora.org writes:

> On 2019-04-18 16:07, Toke Høiland-Jørgensen wrote:
>> leiwa@codeaurora.org writes:
>> 
>>> On 2019-04-17 17:26, Toke Høiland-Jørgensen wrote:
>>>> Lei Wang <leiwa@codeaurora.org> writes:
>>>> 
>>>>> TX duration output of tx_stats in debugfs and station dump had big
>>>>> difference because they got tx duration value from different 
>>>>> statistic
>>>>> data. We should use the same statistic data.
>>>> 
>>>> So are you sure you picked the most accurate one of the two? :)
>>>> 
>>>> -Toke
>>> 
>>> Hi Toke,
>>> 
>>> Yes.
>>> Now for ath10k, there are two ways to get tx duration output.
>>> One is got from tx_stats in debugfs reported by firmware. It is a 
>>> total
>>> value including all the frames which created by host and firmware sent
>>> to the peer.
>>> And the second is calculated from
>>> ath10k_htt_rx_tx_compl_ind()-->ieee80211_sta_register_airtime(), here
>>> the tx duration just includes the data frames sent from host to the
>>> peer.
>> 
>> So the difference is that the former includes control frames as well? 
>> Is
>> that the only difference? And what exactly is a "big difference" (from
>> the commit message)?
>> 
> Yes,it adds the duration time of receiving ACK frames.
>  From my test,TX from AP to station with iperf UDP test in 
> 10s,tx_stats->tx_duration:5496623us,
> and another value is 3934327us.

Hmm, that's quite a big difference. Is this really only ACKs, or is it
also a question of whether retries are accounted? If so, it may actually
be that what we should do is change which value is passed to
ieee80211_sta_register_airtime()?

>>> So the first value is preferable for station dump.
>> 
>> Hmm, I'm not sure if I agree with this. I specifically added the
>> tx_duration to the station dump to be able to get the values used by 
>> the
>> airtime scheduler. This breaks with this patch.
>> 
>> -Toke
>  From our internal discussing, we will revert this change.

Cool, but see above :)

-Toke
