Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2657673CE0
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 15:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjASO6N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 09:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjASO6L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 09:58:11 -0500
X-Greylist: delayed 309 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Jan 2023 06:58:09 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C672247EF3
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 06:58:09 -0800 (PST)
Received: from [192.168.0.203] ([151.127.53.97]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MTzve-1pAEpA2DTu-00R2wF; Thu, 19 Jan 2023 15:52:46 +0100
Message-ID: <1609a645-3e23-7e37-9aa1-94f970e481e2@green-communications.fr>
Date:   Thu, 19 Jan 2023 15:52:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] nl80211: add support to enable/disable bss color
 collision detection
Content-Language: fr, en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <20221226083328.29051-1-quic_ramess@quicinc.com>
 <20221226083328.29051-2-quic_ramess@quicinc.com>
 <74c57dc34af10537f98f5bb9b6ce80e5676e09b0.camel@sipsolutions.net>
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
In-Reply-To: <74c57dc34af10537f98f5bb9b6ce80e5676e09b0.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HHBEj0U4WXgOh3ukuJSMwstGODz3ephBJOC5ByETGYIfJ8RUnuv
 mTnX23rMJ1dW27IT4pu4tEjNWyXqrekRq7/loOX7ZQ6ihk/SGXfhNk41d+0J95Xjp1vnROM
 8CVCrZG2i2OiL2tCYtw3EEm0bNa5av7QUsv2NWbjabDZCWu5o2iBvNmjZKr/CXGo9TXTEDf
 I2TcYvOCA5LWr41UQLPDQ==
UI-OutboundReport: notjunk:1;M01:P0:mSiwyjdmb+c=;QDCLMCDxALx4n8ibZvmIytVJwML
 XjAx/++6So73JYDg77L6qgSA69tC3w4MdX1UObn95NhfW4xbanauLMw649NNDafDqf6cA2eZM
 aQXwjwgOLpeyXd0jNGGpwuxPsdQPIquD/1/x0ifsDvGNbc+hecr4O33qW0lUL5GroLbqmD0Pa
 o1tSGmaWATEbZWOD6pmd1jK2zXO0y9GwkReWEbsZGTWqEaHumQ8gfVhzdHACwofDvNidGSe4b
 Uffpk7KrlEhTRgPO6EOlmq1W7zeNSFCG//Fha6uRoV50c3J/600/pKwvtqhvdEvpItxDCb1kH
 XnoSYa8AJHsZfsXU7lPLpqOT6QY2LNP8Ia692iT7ZGYbZnriRgCjYd1CkkvJWvLY93sPWYO08
 HSprqUvfPndmtMxn9VL/7Buq/ZkOWl8TGV1djlBuoqhtHL0Ctgbd8oQkmSX5R4Qq9UX4UJzo6
 W7Z63u75XomBmG7wHgR8JVo9O4lfD8LW/Z70yyQzzkY0lfISiA307ctAMRL/iFs6mfKIzOY6J
 /QPcY+kP8UnRoB7bmLGLIWIrhhvS6gL0IBkVXRL/R0hQu68nSoGshKB0rrTCgF0QTl2duzCTE
 0o3OxAKRwhTWZzJz5J0bxsYHBpVK+uE0NWqMJCmte7SxSYTcNDkmDdn/bJblVp+Y5WRgl58PO
 y3N99XTgv+AamSya9MMWqO4fwqu9cYaWig8kSWfxqQ==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19/01/2023 15:02, Johannes Berg wrote:
> On Mon, 2022-12-26 at 14:03 +0530, Rameshkumar Sundaram wrote:
>> As per 802.11ax-2021, STAs shall process BSS Color Change Announcement
>> (BCCA) from AP and switch to new color, but some STAs aren't processing
>> BCCA from AP and not doing color switch, causing them to drop data
>> frames from AP post color change.
>>
>> Provide an option to disable color collision detection and therefore
>> not to do BCCA to mitigate the same from AP. If it's required in case
>> where STA supports BCCA handling, then it can enabled in AP using this
>> option.
>>
> 
> You should probably split this into cfg80211 and mac80211.
> 
> Also, this doesn't really seem to make a lot of _sense_ since nothing in
> the kernel actually acts on detection of a color collision - hostapd is
> acting on that.
> 
> So since you can easily make hostapd ignore the event, why do you even
> need this?

This may not be related, but the software color collision detection 
sends a netlink message for every colliding frame and it can hose up the 
system if the other network is very active.

Also, cfg80211_bss_color_notify() complains that the wdev lock isn't held.
