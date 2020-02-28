Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01ABA173B5E
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2020 16:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgB1P0m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Feb 2020 10:26:42 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:58818 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgB1P0m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Feb 2020 10:26:42 -0500
Received: from [192.168.254.4] (unknown [50.46.151.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id D03E7137595;
        Fri, 28 Feb 2020 07:26:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D03E7137595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1582903602;
        bh=VRC4ydjF3rfGbXZ5RwzngvxF78BWMJyyIvT1hy/9z7Q=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=ZdUYmNBlj+7KQFzzjC1qBZ3SE9Q0vUJEWIybyScIddJj4RJxcEjA7LLS54WFqOzKq
         W7GL4al+y8HnZSrDV46jDwFNxKGeHZFcXv8+8Fh8oTzHdLVareaV8v2rsv92ak9Rr8
         ocaECaIQQNodDNYEZHgdmZUXNkMf3/1clMrc5DWk=
Subject: Re: Any reason AID is not in the NL80211_STA_INFO enumeration?
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <5E4B39B2.8050905@candelatech.com>
 <3fcaaf0ba9ed726c863f9f1e7c5d61c08ca40795.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <29006a9e-4de2-1733-1a8a-a5aae686fd42@candelatech.com>
Date:   Fri, 28 Feb 2020 07:26:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <3fcaaf0ba9ed726c863f9f1e7c5d61c08ca40795.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 02/28/2020 02:06 AM, Johannes Berg wrote:
> On Mon, 2020-02-17 at 17:11 -0800, Ben Greear wrote:
>> To sniff /AX stations, it is helpful to know their AID.  So, any problems
>> with adding it to 'iw station dump' output?
>
> No, no problem at all. I guess it was just never added because it
> originally comes from userspace (hostapd), and so didn't really need to
> be sent back. But yeah, we have trivial infrastructure to send it back,
> so sure, why not.

Ok, thanks for the response.

 From looking at debugfs for a station device, there is the netdev AID:

cat /debug/ieee80211/wiphy0/netdev\:wlan0/aid
1

And there is a peer AID:

cat /debug/ieee80211/wiphy0/netdev\:wlan0/stations/04\:f0\:21\:c2\:fd\:b0/aid
0

For sniffing AX, I'd need to use '1' here as far as I can tell.  Maybe for station
devices the peer is always zero?  And for AP devices, the peer IDs are what is useful
and the netdev AID is not?


Thanks,
Ben

>
> johannes
>

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
