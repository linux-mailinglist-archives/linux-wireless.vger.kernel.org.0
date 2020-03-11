Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28A5618153A
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 10:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgCKJoN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 05:44:13 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:37965 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgCKJoN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 05:44:13 -0400
Received: from [141.24.212.108] (thunderstorm.prakinf.tu-ilmenau.de [141.24.212.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 93545580065;
        Wed, 11 Mar 2020 10:44:10 +0100 (CET)
Subject: Re: [PATCH 1/3] nl80211: add monitor mode scan feature
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org
References: <20200303115017.9845-1-markus.theil@tu-ilmenau.de>
 <8445336f5d71533acf17b6c53fcc88e7faeab3bf.camel@sipsolutions.net>
 <91e4b8c4-5fc3-536f-9209-124b0cfc230f@tu-ilmenau.de>
 <75fcee24b6eacd59473731087f854dfc451cab40.camel@sipsolutions.net>
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Autocrypt: addr=markus.theil@tu-ilmenau.de; prefer-encrypt=mutual; keydata=
 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
 sGZPq8zmOtvOyZtafA==
Organization: TU Ilmenau
Message-ID: <9a69f20e-8bab-33f1-b607-cfd0e6751a75@tu-ilmenau.de>
Date:   Wed, 11 Mar 2020 10:44:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <75fcee24b6eacd59473731087f854dfc451cab40.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11.03.20 10:36, Johannes Berg wrote:
> On Wed, 2020-03-04 at 10:30 +0100, Markus Theil wrote:
>> I used this patchset for some time to build a combined monitoring and
>> channel survey tool.
>> A mt76 based USB dongle is used, because mt76 supports the channel
>> survey cmd which yields the channel's busy time.
>> At the same time, the tool listens for beacons over the monitor
>> interface to log available networks and their RSSI to the user.
>> When the user changes into heatmap mode, he can issue active scan
>> requests at different points on the floor plan. All of this this
>> can be done with a single interface in monitor mode. I change the
>> frequency of the monitoring interface periodically to passively listen
>> at other channels.
>>
>> nl80211 is able to receive scan results in my setup. "iw dev $MON_IF
>> scan" also works as expected.
>>
>> A combination of an unassociated STA VIF and a monitor VIF (scan on STA
>> VIF, receive Wi-Fi frames on monitor VIF) does not work, because
>> I cannot freely set the channel on an unassociated STA VIF. Trying to
>> set the operating frequency on the monitor VIF also fails, when the STA
>> VIF is up.
>> Bringing the STA VIF up would be needed for scanning on it.
>>
>> Therefore this patches solved my solely monitoring-oriented use-case.
> Yeah, I kinda see where you're coming from, but I still don't think this
> makes a lot of sense. I'm actually surprised that "iw dev mon scan"
> works (in that it prints results) - would have expected the results to
> just go nowhere?
>
> And as you say, you're actually sending probe requests here, while you
> cannot even set the MAC address properly on a radiotap monitor
> interface.
>
> I don't really think we should mix all these concepts, the more things
> we try to allow in monitor mode, the more confusing that becomes (is it
> active now? or passive?)
Ok, I see your point. I think I'll just rework my tool in the way Steve
has already
suggested (use additional STA VIF and set it up for every active scan,
set it down afterwards).

So please feel free to drop these patches, if you haven't already :)
>
> johannes
>

