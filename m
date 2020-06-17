Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692DF1FC7CA
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2020 09:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgFQHpg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Jun 2020 03:45:36 -0400
Received: from simonwunderlich.de ([79.140.42.25]:57774 "EHLO
        simonwunderlich.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFQHpf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Jun 2020 03:45:35 -0400
X-Greylist: delayed 77322 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jun 2020 03:45:35 EDT
Received: from [IPv6:2003:c5:9715:4400:7e76:35ff:fe14:e6d7] (p200300c5971544007e7635fffe14e6d7.dip0.t-ipconnect.de [IPv6:2003:c5:9715:4400:7e76:35ff:fe14:e6d7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by simonwunderlich.de (Postfix) with ESMTPSA id 9E47A62055;
        Wed, 17 Jun 2020 09:45:34 +0200 (CEST)
Subject: Re: [PATCH] mac80211: mesh: add mesh_param "mesh_nolearn" to skip
 path discovery
From:   =?UTF-8?Q?Linus_L=c3=bcssing?= <ll@simonwunderlich.de>
To:     =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
References: <20200616095358.20143-1-linus.luessing@c0d3.blue>
 <cbe4863e-44f3-c0e4-a4f3-1b0a69f7a386@simonwunderlich.de>
Message-ID: <6bef8071-f897-b972-dbf9-17198361dc4e@simonwunderlich.de>
Date:   Wed, 17 Jun 2020 09:45:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <cbe4863e-44f3-c0e4-a4f3-1b0a69f7a386@simonwunderlich.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 16/06/2020 12:16, Linus Lüssing wrote:
>> The new mesh_nolearn parameter allows to skip the PREQ/PREP exchange in
>> this scenario, leading to a reduced delay, reduced packet buffering and
>> simplifies HWMP in general.

And a third observation we've made with HWMP:

When running iperf with 16 parallel TCP streams and the default HWMP 
parameters over two 4x4 802.11ac Wave 2 wifi cards transmitting about 
800-1000 MBit/s in total, HWMP becomes quite unstable. We see frequent 
PREQ/PREP retransmissions and also PERR messages, leading to spurious 
break downs in the throughput.

When using just 8 TCP streams, so with a little less saturation and 
stress of the channel, iperf staticstics are stable.


So maybe there would be some potential for optimizations, too, like 
somehow prioritizing HWMP messages more, or maybe making the default 
HWMP parameters a bit more conservative.


Or just disabling the HWMP PREP/PREQ/PERR exchange with this new 
configuration option would at least help the ones that are using another 
mesh routing protocol on top, who are maybe more familiar with the 
parameters of their specific routing protocol than with the HWMP parameters.

Regards, Linus
