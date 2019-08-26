Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4BEB9D487
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2019 18:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbfHZQ4A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Aug 2019 12:56:00 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43626 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731603AbfHZQz7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Aug 2019 12:55:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id h15so15731172ljg.10
        for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2019 09:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=neUUe6izlW2YSFhsPDka8y7efVuU1RFZ0BA0ZiRsZkQ=;
        b=eb0gFOdmbv++1BKVSisN3IyaMyYkr60kiNgCyxQxyXUjNCMgeggucG7+ktJzoFjV/1
         s6doEulqrHS7+SO9vpChOyp2kDHQnWbtQopLEcOJiWLp7nXgWi0TAxKOGtHMM1x6NtTK
         uGEWJpa+AqwJEnHNC0E7L0nTeGiQSOc1ITq3LLEeWp1oqbPkw5+Flo1R4ZrN6F0Bh7VY
         KExg+ZM52Iu6BfpqijbHOYbcE1zJLjQiJCbFsIOfMmr4cHubAyCRVnfTZMeXhWv8kLhl
         HRyRn13Nwqsii5b91wIzq/Mp63KCtuTSMTzthdj+mNORVFeRc16XaV8w+f7g+9U4i6Ac
         3TOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=neUUe6izlW2YSFhsPDka8y7efVuU1RFZ0BA0ZiRsZkQ=;
        b=Pqhqgs1libYB4Pq4HxlqcwjJi+0W55mN2YQELbROvhaWSyA4DUxtciYyjjhLjSicM/
         btt2v6hvw1i1voMNxA4KlENwtfC/JVVd1JUops8CYkICGFgEyyH07hEowfh45AXjVsVI
         Ydw32SaQAbe/BRqO8uBogz5BJdZCdMYSav/xOfs9tu524+t8SQb5rIA6D3iqDM8qqcC7
         QMZ0AfR/gmChX8YBGMUfK5lTro8SYIc1rJ+UozH+35rrYdOdUCyG9+lr2DVWTYTiFrDC
         AgcbpoCYidZsT18fbQ0XUHsHVVUk1Nwebfwuu4NxMJGmGKzObZ4VaoxT/AQs4iia9ZOU
         8LUw==
X-Gm-Message-State: APjAAAW73xa8wx+D8rN9IoJWxvQMHQp/rB5TXdaeeSZmSX7Iu4ZOm9oy
        0A6TeQ+a+CKC4ouvChisM9I=
X-Google-Smtp-Source: APXvYqyp5CUSwmR+nEPU5dI4Ah9LNeS1xAdAf4B3V+XhtRmdlnz15hd1HiQECRdwbrlPB9yEwJwMBA==
X-Received: by 2002:a2e:3e18:: with SMTP id l24mr11327221lja.67.1566838557599;
        Mon, 26 Aug 2019 09:55:57 -0700 (PDT)
Received: from [192.168.1.244] (81-233-89-221-no75.tbcn.telia.com. [81.233.89.221])
        by smtp.gmail.com with ESMTPSA id o5sm2033709lfn.42.2019.08.26.09.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2019 09:55:56 -0700 (PDT)
Subject: Re: [PATCH] ath10k: remove TX lock from ath10k_htt_tx_inc_pending
To:     Wen Gong <wgong@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
References: <20190824134857.4094-1-erik.stromdahl@gmail.com>
 <4cd30880ae754f5599e6b1a4c1ac6a74@aptaiexm02f.ap.qualcomm.com>
From:   Erik Stromdahl <erik.stromdahl@gmail.com>
Message-ID: <70fe66cc-e966-70bb-3dcf-4de55fc52cf9@gmail.com>
Date:   Mon, 26 Aug 2019 18:55:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4cd30880ae754f5599e6b1a4c1ac6a74@aptaiexm02f.ap.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 8/26/19 4:44 AM, Wen Gong wrote:
>> -----Original Message-----
>> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Erik
>> Stromdahl
>> Sent: Saturday, August 24, 2019 9:49 PM
>> To: Kalle Valo <kvalo@qca.qualcomm.com>; linux-wireless@vger.kernel.org;
>> ath10k@lists.infradead.org
>> Cc: Erik Stromdahl <erik.stromdahl@gmail.com>
>> Subject: [EXT] [PATCH] ath10k: remove TX lock from
>> ath10k_htt_tx_inc_pending
>>
>> This commit removes the call to ath10k_mac_tx_lock() from
>> ath10k_htt_tx_inc_pending() in case the high water mark is reached.
>>
>> ath10k_mac_tx_lock() calls ieee80211_stop_queues() in order to stop
>> mac80211 from pushing more TX data to the driver (this is the TX lock).
>>
>> If a driver is trying to fetch an skb from a queue while the queue is
>> stopped, ieee80211_tx_dequeue() will return NULL.
>>
>> So, in ath10k_mac_tx_push_txq(), there is a risk that the call to
>> ath10k_htt_tx_inc_pending() results in a stop of the mac80211 TX queues
>> just before the skb is fetched.
>>
>> This will cause ieee80211_tx_dequeue() to return NULL and
>> ath10k_mac_tx_push_txq() to exit prematurely and return -ENOENT.
>> Before the function returns ath10k_htt_tx_dec_pending() will be called.
>> This call will re-enable the TX queues through ath10k_mac_tx_unlock().
>> When ath10k_mac_tx_push_txq() has returned, the TX queue will be
>> returned back to mac80211 with ieee80211_return_txq() without the skb
>> being properly consumed.
>>
>> Since the TX queues were re-enabled in the error exit path of
>> ath10k_mac_tx_push_txq(), mac80211 can continue pushing data to the
>> driver. If the hardware does not consume the data, the above mentioned
>> case will be repeated over and over.
>>
>> A case when the hardware is not able to transmit the data from the host
>> is when a STA has been dis-associated from an AP and has not yet been
>> able to re-associate. In this case there will be no TX_COMPL_INDs from
>> the hardware, resulting in the TX counter not be decremented.
>>
>> This phenomenon has been observed in both a real and a test setup.
>>
>> In order to fix this, the actual TX locking (the call to
>> ath10k_mac_tx_lock()) was removed from ath10k_htt_tx_inc_pending().
>> Instead, ath10k_mac_tx_lock() is called separately after the skb has
>> been fetched (after the call to ieee80211_tx_dequeue()). At this point
>> it is OK to stop the queues.
> Is this patch will impact throughput?
No, I haven't seen any performance degradation.

I can't see that it should impact the throughput even in theory (rather the opposite
actually since we reduce the likelihood of dropping packets).
