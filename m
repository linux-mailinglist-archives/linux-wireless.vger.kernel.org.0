Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB83271A97
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 08:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgIUGDs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 02:03:48 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:46460 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726011AbgIUGDs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 02:03:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id A134F4F9B83;
        Mon, 21 Sep 2020 06:03:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OSQancsSMmUu; Mon, 21 Sep 2020 06:03:45 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 0CF7D4F9B64;
        Mon, 21 Sep 2020 06:03:44 +0000 (UTC)
MIME-Version: 1.0
Date:   Sun, 20 Sep 2020 23:03:44 -0700
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 15/22] mac80211: don't calculate duration for S1G
In-Reply-To: <d922fa0215d8617c92948e1ddee5d23f77610723.camel@sipsolutions.net>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
 <20200831205600.21058-16-thomas@adapt-ip.com>
 <d922fa0215d8617c92948e1ddee5d23f77610723.camel@sipsolutions.net>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <b9d1a036f2b10a640a3e88fd23fb8ef3@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-18 03:52, Johannes Berg wrote:
> On Mon, 2020-08-31 at 13:55 -0700, Thomas Pedersen wrote:
>> For now just skip the duration calculation for frames
>> transmitted on the S1G band and avoid a warning.
>> 
>> Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
>> ---
>>  net/mac80211/tx.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
>> index d2136007e2eb..bef19616c5f0 100644
>> --- a/net/mac80211/tx.c
>> +++ b/net/mac80211/tx.c
>> @@ -82,6 +82,10 @@ static __le16 ieee80211_duration(struct 
>> ieee80211_tx_data *tx,
>> 
>>  	erp = txrate->flags & IEEE80211_RATE_ERP_G;
>> 
>> +	/* TODO */
>> +	if (sband->band == NL80211_BAND_S1GHZ)
>> +		return 0;
> 
> 
> I'm not even sure I'd leave a TODO there ... just say
> 
> 	/* device is expected to do this */

Eventually it would be nice if mac80211 could calculate duration for 
S1G? Do you know why it doesn't for HT/VHT?

-- 
thomas
