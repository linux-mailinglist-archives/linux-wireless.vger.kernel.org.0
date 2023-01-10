Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11A7664081
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jan 2023 13:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjAJMbw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 07:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjAJMbu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 07:31:50 -0500
Received: from mail1.systemli.org (mail1.systemli.org [93.190.126.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A4017040
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 04:31:48 -0800 (PST)
Message-ID: <3a9c2bae-6c33-2211-1368-85d839680de8@systemli.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=systemli.org;
        s=default; t=1673353905;
        bh=8MrIVoSwNKEoib1mQqEtGP64FkBi7pmFZVrt0/+zocE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=F881JbGt8xXGWF1vszUshRpo1fS9YOqXtgGpCROdKXLCKoP0XwlhOxVlmZE44yai+
         626HylZzCY4wiUrBdkm5hUQUrClcXcnUKl7Y8RHe9DcL2k2CHVrXiATrjSfHfosOlh
         NmNGEWQTsUNn1gmnoVCkXqQK+sq/wqKyVL5frroNoTNj8LjACSTSGXZY+C7dOiqvrJ
         vJp3+IETewPv5N7jhzSCYYupUA8mL51MU0SYMaL9mO0x5NJJegEWNo1HG72cMSaBB3
         t1o1I2v19/qbawEMtD78qMoKS63g2Xb4v1JHgEjZMs0bz5Mtjn8YMoUMr+aL1Q/+pt
         UQIz+Yostp7gw==
Date:   Tue, 10 Jan 2023 13:31:42 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] wifi: mac80211: add support for scanning in ap mode
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20230110110524.511258-1-vincent@systemli.org>
 <a7ccf0e6a1481f592fa9ff81f7b6545a4f4a653f.camel@sipsolutions.net>
 <cc230245-2599-7665-3785-150dee0bf873@systemli.org>
 <e41d9701282ba434871e3c3e28798fa4f16c582b.camel@sipsolutions.net>
 <9a2e054444a84e2645cf6397934313b0c41fb725.camel@sipsolutions.net>
Content-Language: en-US
From:   Nick <vincent@systemli.org>
In-Reply-To: <9a2e054444a84e2645cf6397934313b0c41fb725.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sorry, I made a mistake. NL80211_SCAN_FLAG_AP seems to do everything I 
want. Initially I thought there was something special about the 
"NL80211_FEATURE_AP_SCAN" that was also needed, since it is not being 
set by the ath9k. Also, the OpenWrt patch does not test for 
"NL80211_FEATURE_AP_SCAN", so I thought it was necessary to skip this 
check as well. However, I just noticed that this flag is set for ath9k 
in mac80211. I have just tested it again with ath9k (iw dev wlan0 scan 
ap-force) and it works as expected.

As far as I know, tools like iwinfo do not include this "force" option. 
OpenWrt's Luci interface heavily relies on iwinfo. So far this is not an 
issue, as the default behavior of mac80211 in OpenWrt currently allows 
scanning regardless of "NL80211_FEATURE_AP_SCAN" or 
"NL80211_SCAN_FLAG_AP". So if I want to get rid of this downstream patch 
I have to rewrite the iwinfo logic and maybe always include 
NL80211_SCAN_FLAG_AP as default.

Thank you very much for your time and feedback.

Bests
Nick

On 1/10/23 12:20, Johannes Berg wrote:
> On Tue, 2023-01-10 at 12:19 +0100, Johannes Berg wrote:
>> On Tue, 2023-01-10 at 12:18 +0100, Nick wrote:
>>> Thanks for your feedback. Can you suggest a better way to do this?
>>>
>> Well there already is NL80211_SCAN_FLAG_AP?
>>
> Oh sorry you want it independent of the driver.
>
> But why? This was primarily a thing for "does the firmware even support
> this".
>
> So really then your driver should set it?
>
> johannes
