Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDB82669C3
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 22:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgIKUus (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 16:50:48 -0400
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:39806
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725803AbgIKUur (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 16:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gbvhytky6xpx7itkhb67ktsxbiwpnxix; d=codeaurora.org; t=1599857446;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=VQC35HEbIxbU+Twz7xc/x7f59k8DvMWV2U6tyZSVrGI=;
        b=RxywQoCjIcI/Jr1OtUmlLGULEKSrD8Xdwx4CMYHEx3mz34M4nA4uouRw3cIZ6dgf
        G3Z47byJ9iiOIbyh4cB8SsWLJHKEh482xaw+tz1ShxJuFy45KNg0AqlmhYs/6/Qql6G
        fECDA0/u+yWkkD3ZXJfmhKsVsPXChhB75BJDY68s=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599857446;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=VQC35HEbIxbU+Twz7xc/x7f59k8DvMWV2U6tyZSVrGI=;
        b=BHWkYVRR/CEGq6mzlbAMiUrjCBcf8KxwLMhYhU/Zu6cqn6O8gC4XSN3KY6kF58UW
        0YR3SDkuaFrq19WFpNAN+a7+cWzCQf2glXU618ED8YFx8ftweU693YEzTpIwH5rLZL1
        7qQCxjKlCCDzEMJyB6Y6N+aMKm7JjTtl85dlcpoc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 11 Sep 2020 20:50:46 +0000
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH] mac80211: Fix radiotap header channel flag for 6GHz band
In-Reply-To: <1cc7242cd00cd5141a56f17a7f5c80700485aa39.camel@sipsolutions.net>
References: <010101747ab7b9c0-45fa1c2a-3bb5-44e8-8e6d-457cad2e9845-000000@us-west-2.amazonses.com>
 <1cc7242cd00cd5141a56f17a7f5c80700485aa39.camel@sipsolutions.net>
Message-ID: <010101747eef4de4-f80bae2e-6ab2-48c5-bc89-bf21e5ac41fc-000000@us-west-2.amazonses.com>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.11-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-11 00:36, Johannes Berg wrote:
> On Fri, 2020-09-11 at 01:11 +0000, Aloka Dixit wrote:
>> Radiotap header field 'Channel flags' has '2 GHz spectrum' set to
>> 'true' for 6GHz packet.
>> Change it to 5GHz as there isn't a separate option available for 6GHz.
>> 
>> Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
>> ---
>>  net/mac80211/rx.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
>> index 836cde516a18..a959ebf56852 100644
>> --- a/net/mac80211/rx.c
>> +++ b/net/mac80211/rx.c
>> @@ -451,7 +451,8 @@ ieee80211_add_rx_radiotap_header(struct 
>> ieee80211_local *local,
>>  	else if (status->bw == RATE_INFO_BW_5)
>>  		channel_flags |= IEEE80211_CHAN_QUARTER;
>> 
>> -	if (status->band == NL80211_BAND_5GHZ)
>> +	if (status->band == NL80211_BAND_5GHZ ||
>> +	    status->band == NL80211_BAND_6GHZ)
>>  		channel_flags |= IEEE80211_CHAN_OFDM | IEEE80211_CHAN_5GHZ;
> 
> I guess we should just not set any of those flags?
> 
> Not that anything even cares ... so there's no point in adding a 6GHz
> flag to radiotap.
> 
> johannes

Separate flag for 6GHz would have been best option, but I still think 
better to set 5GHz as 6GHz frequencies start in 5GHz range.
Thanks.
