Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67F87E835C
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 09:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfJ2Ilj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 04:41:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38382 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfJ2Ilj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 04:41:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id 22so1435813wms.3
        for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2019 01:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncentric-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DUE+XOir+sEq8Jjt6ZqFoZP8jxttvHmbtNjKbTObY9Y=;
        b=pPHnC2jzOsNQtFwKWKM84eQfcMIczrZRRakDJasaSgNDYqEpq5bkSkEmSQokHT5Ic7
         TRSTsQEjnG5bXDRhJwN6zbp6rsw+ArB8T4EtOiOcOm+FLZcBXvf/mOhOEDupb0/h79/2
         poyjiibNRB2bUGgklHNODDYzLXaLXEHJlmgyQgv7uWTBAE9SPXY9QfUbhN8hAWurOdOA
         2IQgVfDF1Ep1VFPJ/UuLp4xFEBXmOI7/OemGOj7GR8w2XjcHS1V9Q30wADyPsF9qP9hz
         HO1g0lEOtJPqfjsd5amgxY+Ff1OAs2aF2+t0sb2auBJJ7qKfq4gT+RdxkUC4rQOgEz65
         2EYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DUE+XOir+sEq8Jjt6ZqFoZP8jxttvHmbtNjKbTObY9Y=;
        b=Ots+vXDPQAGLvJnL0kfSnrbVlX/c0qhucIFTcpQmeLFsDQNAgUWXgdV1tIj2KaQ4xi
         AXUYxXaN4K+qYwHALPnGFdkqI8eZV6R2SQXha1tFBNOwvxsYFi15mqLnMzD3lW/8nZAW
         aJ/mS9bAPDYZ9PCjk+iYMhitkpv9WaC9sz70dikMth6u5xU5vtyeLhCFqaQ8fnRaFSd5
         hK3D+ejuc106AVxqXzKJr+y1ToCTUfw6sI/x3QLPjuHfCSCPFVpJuaczUFQ3gX/qC+X7
         7cSHCjzEGWK5Ce6zBHSp6HbBzfqoN/Jq6Sbnd6yzAvdTDp5ZSibrvYVgB7A+jM/Odbbk
         L52g==
X-Gm-Message-State: APjAAAWpC1Ux8U5iHmkj8hOUVepSfTe6qjU2EN7yMQOh4qV4Dux71ic6
        uL54TVm2qFFdwYFEji8cslK+yA==
X-Google-Smtp-Source: APXvYqyftOvlRJ9dg8wL3C+zw81qRJgiCNNRVg6nEmYDGwPHS05minYwSNVy0ezRwvY2ORWwUG3b8g==
X-Received: by 2002:a1c:a4c5:: with SMTP id n188mr2887218wme.30.1572338496714;
        Tue, 29 Oct 2019 01:41:36 -0700 (PDT)
Received: from [192.168.3.176] (d515300d8.static.telenet.be. [81.83.0.216])
        by smtp.gmail.com with ESMTPSA id u21sm2275041wmu.27.2019.10.29.01.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 01:41:36 -0700 (PDT)
Subject: Re: [PATCH v2] 802.11n IBSS: wlan0 stops receiving packets due to
 aggregation after sender reboot
To:     Johannes Berg <johannes@sipsolutions.net>,
        =?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <m34l02mh71.fsf@t19.piap.pl> <m37e4tjfbu.fsf@t19.piap.pl>
 <e5b07b4ce51f806ce79b1ae06ff3cbabbaa4873d.camel@sipsolutions.net>
From:   Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <30465e05-3465-f496-d57f-5e115551f5cb@ncentric.com>
Date:   Tue, 29 Oct 2019 09:41:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e5b07b4ce51f806ce79b1ae06ff3cbabbaa4873d.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 28.10.19 13:21, Johannes Berg wrote:
> On Fri, 2019-10-25 at 12:21 +0200, Krzysztof Hałasa wrote:
>> Fix a bug where the mac80211 RX aggregation code sets a new aggregation
>> "session" at the remote station's request, but the head_seq_num
>> (the sequence number the receiver expects to receive) isn't reset.
>>
>> Spotted on a pair of AR9580 in IBSS mode.
>>
>> Signed-off-by: Krzysztof Halasa <khalasa@piap.pl>
>>
>> diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
>> index 4d1c335e06e5..67733bd61297 100644
>> --- a/net/mac80211/agg-rx.c
>> +++ b/net/mac80211/agg-rx.c
>> @@ -354,10 +354,13 @@ void ___ieee80211_start_rx_ba_session(struct sta_info *sta,
>>   			 */
>>   			rcu_read_lock();
>>   			tid_rx = rcu_dereference(sta->ampdu_mlme.tid_rx[tid]);
>> -			if (tid_rx && tid_rx->timeout == timeout)
>> +			if (tid_rx && tid_rx->timeout == timeout) {
>> +				tid_rx->ssn = start_seq_num;
>> +				tid_rx->head_seq_num = start_seq_num;
>>   				status = WLAN_STATUS_SUCCESS;
> This is wrong, this is the case of *updating an existing session*, we
> must not reset the head SN then.
>
> I think you just got very lucky (or unlucky) to have the same dialog
> token, because we start from 0 - maybe we should initialize it to a
> random value to flush out such issues.
>
> Really what I think probably happened is that one of your stations lost
> the connection to the other, and didn't tell it about it in any way - so
> the other kept all the status alive.
>
> I suspect to make all this work well we need to not only have the fixes
> I made recently to actually send and parse deauth frames, but also to
> even send an auth and reset the state when we receive that, so if we
> move out of range and even the deauth frame is lost, we can still reset
> properly.
>
> In any case, this is not the right approach - we need to handle the
> "lost connection" case better I suspect, but since you don't say what
> really happened I don't really know that that's what you're seeing.
>
> johannes

Hi all,

I can confirm the issue as I'm also seeing this sometimes in the field here.

Sometimes when a devices goes out of range and then re-enters,
the link refuses to "come up", as in rx looks to be "stuck" without any 
reports in system log or locking issues (lockdep enabled)

I have dozens of devices installed offshore (802.11n based), both on 
static and moving assets,
which cover from short (250m) up to very long distances (~35km)

So .. while there is some momentum for this issue,
I'm more than happy to provide extensive testing should fixes be posted 
regarding IBSS in general.

Regards,

Koen

