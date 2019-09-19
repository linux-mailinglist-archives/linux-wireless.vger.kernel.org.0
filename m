Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D766CB8052
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 19:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388719AbfISRqb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 13:46:31 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:50418 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfISRqb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 13:46:31 -0400
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id D89EA13C2BA;
        Thu, 19 Sep 2019 10:46:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D89EA13C2BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1568915191;
        bh=y5pMe5OXBDLj1brmPp3mYaakMnMvxIS3GLjvZ9fewmw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Yk/OFYoCeIVx8I3SfYtfhUE1LWicnfchgPrXuElPZkg0I0J3862fR/A4s7YNGJPHu
         JnYUWsS55YE2wjwGQiIHltangODPJktHo5FciQiw7VWWUAKdqw98ZtDPxvS8/hAbW7
         d72VaMzwluI5DEDKD57K6ksWQVosMi180pf6DmCg=
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit
 (AQL) on packet dequeue
To:     Peter Oh <peter.oh@eero.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
 <156889576869.191202.510507546538322707.stgit@alrua-x1>
 <f21b10fd-02ae-af59-8e2f-88f654627ab3@eero.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <879913e9-4254-1381-07f6-d860fb0b8de0@candelatech.com>
Date:   Thu, 19 Sep 2019 10:46:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f21b10fd-02ae-af59-8e2f-88f654627ab3@eero.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/19/19 10:44 AM, Peter Oh wrote:
> On 9/19/19 5:22 AM, Toke Høiland-Jørgensen wrote:
>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>>
>> This patch ports that idea over to mac80211. The basic idea is simple
>> enough: Whenever we dequeue a packet from the TXQs and send it to the
>> driver, we estimate its airtime usage, based on the last recorded TX rate
>> of the station that packet is destined for.
> 
> The way to decide the last recorded TX rate could be vary among drivers. In terms of ath10k driver and FW, they use 4 PPDUs to update the Tx rate. Isn't it too 
> small sampling number to be used for AQL?

Probably it is not exactly the last 4 either, since the report comes back indirectly and not
synchronized with the tx path?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

