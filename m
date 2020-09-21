Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3257F271A1B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 06:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgIUEeN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 00:34:13 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:45582 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726011AbgIUEeN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 00:34:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id CFF804F9809;
        Mon, 21 Sep 2020 04:34:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mGmi6slOP08h; Mon, 21 Sep 2020 04:34:10 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 2E7414F2252;
        Mon, 21 Sep 2020 04:34:10 +0000 (UTC)
MIME-Version: 1.0
Date:   Sun, 20 Sep 2020 21:34:09 -0700
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 08/22] nl80211: support S1G capabilities
In-Reply-To: <56d639c4f045b205ab311ab80c0ff5a18d4af7fb.camel@sipsolutions.net>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
 <20200831205600.21058-9-thomas@adapt-ip.com>
 <56d639c4f045b205ab311ab80c0ff5a18d4af7fb.camel@sipsolutions.net>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <19a455508af9f394e9c6ad1defff86bf@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-18 03:47, Johannes Berg wrote:
> On Mon, 2020-08-31 at 13:55 -0700, Thomas Pedersen wrote:
>> @@ -3046,6 +3054,7 @@ enum nl80211_attrs {
>>  #define NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY	24
>>  #define NL80211_HT_CAPABILITY_LEN		26
>>  #define NL80211_VHT_CAPABILITY_LEN		12
>> +#define NL80211_S1G_CAPABILITY_LEN		15
> 
> Maybe that would make more sense in ieee80211.h? Renamed, of course?

Makes sense, thanks I'll take care of that and the other comments in 
this
patch.

-- 
thomas
