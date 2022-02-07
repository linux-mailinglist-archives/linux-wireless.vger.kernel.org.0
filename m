Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E2C4AC860
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Feb 2022 19:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbiBGSQl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Feb 2022 13:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343813AbiBGSJX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Feb 2022 13:09:23 -0500
X-Greylist: delayed 466 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 10:09:22 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EACCC0401E0
        for <linux-wireless@vger.kernel.org>; Mon,  7 Feb 2022 10:09:22 -0800 (PST)
Received: from [192.168.0.175] ([151.127.53.97]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mnac7-1o07aC2DAL-00jYjW; Mon, 07 Feb 2022 18:56:21 +0100
Message-ID: <bea2f2a7-85f0-1768-4625-9dc1da94f604@green-communications.fr>
Date:   Mon, 7 Feb 2022 18:56:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 09/13] cfg80211: Save the regulatory domain when setting
 custom regulatory
Content-Language: fr
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgens?= =?UTF-8?Q?en?= 
        <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org
References: <20201129153055.1971298-1-luca@coelho.fi>
 <iwlwifi.20201129172929.290fa5c5568a.Ic5732aa64de6ee97ae3578bd5779fc723ba489d1@changeid>
 <e8e6afa6-275e-2cc5-6351-e1ed5eb0e0af@green-communications.fr>
 <87ily325t4.fsf@tynnyri.adurom.net>
 <cedc93ef-496f-a403-0089-b2a82477fe0f@green-communications.fr>
 <0848f5eba90a2125425da52b6b5f6f47ba9d6630.camel@sipsolutions.net>
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
In-Reply-To: <0848f5eba90a2125425da52b6b5f6f47ba9d6630.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:OuwS8Fss+UEi3QYRXx5qu6BbDmQjhjz9K6o9mixT64bOoAwGohu
 mS3dGu6CjYVVPZbWm8oi/B1NwoOAH4Dg530br0TkTFgfT39VeMTgMZ59dJwVTT3N0qgcwjT
 qS1RqygKEED7QgDpkJcpU45yqMQaFihJ/NTpKzqHp0eoNO1gqxl1xSx407l9dGCsam3iqeF
 7L83dSMjqegVfnpd9s4bA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UZWY2v8Sr84=:R/pbfgUpGlOpU3TXhrCOhK
 h3otz/CUgjIBSGag/tu+EmzKcxOOktfWQXNt2VpmwEdGsHDN7g5SQRUUBA0P1cSyc0z2ehlIG
 UV93W6rFXl16wo/ajZ6tOEehPoJ2piI3LW56eF7fwoyrp39Us/iDJBNNlZblRC8L5ZZqUtJOE
 cCgTUmORmmk0Zp02Ul/SrY0HHOhmx3cHcFDJNdRICG7GbJRmt73foIwGMy6Mzb587q199DJ+v
 aNicG09b6ga/J4CswP2Df4e8tUfyR5hv6f/pTb4NVLvCZq5hwiHMpy2FbvRCB1mAm37gzpteM
 hF4qTqV03/bQd9mahq8XYoFoXOzVI9acLWD07PFDrHbFXsomRE+azQw8DCaNF2MDcHQw3vWTX
 bcyD8W+tnFiB7hR4w6+KN/kkn+S6+dDktnGujz+2NRsySLnGOmTqhSSvgmKFGRNQ580HTyirH
 q/XntZssbo5dGkZCUYVPIdZO1JWJN2y9zb/17gfbrOAoF5RXaXff1EgdNKL/0NbMMaUUVyQhN
 +5zolnn/thbIRZwlMIEEJBquKsTFwsnWO7PrjQ2S1feig4M4BZVitTyQJtbGkuUsvNwPee9jd
 gvcF3JPhtTLCBYAGjZQLlFMduxj6Lur0qsLx4EzmdSV7FljUT8QOUdrjPSXk2qitXThs5JCSK
 QRQDBBgPuqU0oTRzpjwdRkqODX2l5ii7HDHY1ynvpptuu3xtazj1UKitYqHiwm7dgcTcfEzqy
 hTGQsjfUQtyRJB3SJqm5RsiP608IZ8JeMxL3eA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 03/02/2022 23:30, Johannes Berg wrote:
> On Tue, 2021-10-12 at 12:24 +0200, Nicolas Cavallari wrote:
>>>>
>>>> This patch somehow appears to break ath9k's eeprom hints and restrict
>>>> it to the world regulatory domain on v5.12.10.
>>>>
>>>> ath9k calls wiphy_apply_custom_regulatory() with its own kind of world
>>>> regulatory domain, before it decodes hints from the eeprom and uses
>>>> regulatory_hint() to request a specific alpha2.
>>>>
>>>> With this patch, applying the hint fails because wiphy->regd is already set.
>>>> If i revert this patch, ath9k works again.
>>>
> 
> Hm. It stands to reason that perhaps ath9k should call
> wiphy_apply_custom_regulatory(NULL) (if that's possible) to reset the
> knowledge of having a custom regulatory domain, before requesting the
> correct one be applied by cfg80211 (and possibly even crda userspace).

wiphy_apply_custom_regulatory(NULL) is apparently not possible.
The regulatory code is still a black box to me...


