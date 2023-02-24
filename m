Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003BF6A1885
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Feb 2023 10:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjBXJKw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Feb 2023 04:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBXJKv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Feb 2023 04:10:51 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF2422036
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 01:10:48 -0800 (PST)
Received: from [192.168.0.66] ([92.154.77.116]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MQ5jC-1p9Ol12Mvw-00M1X3; Fri, 24 Feb 2023 10:05:31 +0100
Message-ID: <11fe74b3-c4fc-6a91-911f-a733864d7ae8@green-communications.fr>
Date:   Fri, 24 Feb 2023 10:05:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
References: <20230222204945.6716-1-Larry.Finger@lwfinger.net>
 <2564165999cf5319e58aa0898a2866612f8af293.camel@sipsolutions.net>
 <c4f8074a-3f01-5d4c-864f-a0144eb46d46@lwfinger.net>
From:   Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Subject: Re: [PATCH] wifi: wext: Eliminate log spamming in
 wireless_warn_cfg80211_wext()
In-Reply-To: <c4f8074a-3f01-5d4c-864f-a0144eb46d46@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:mUS0SQ5OYXex2F6LW9NRjiwOcdiCIyLaY5Cm1iP/NDks9/XLrzd
 BcHGa03e9zOkTZ+hZtsaBjz4+D2KSH2vIsQovOf5eMWgz47uoJ9x0NEzK4iBN+6sth9lg5t
 IjmzejyttRjh19re6GMSGjTyhuubDnbXBd9iNkDu3SIYVHQtsujgUX7aTyEIiwOYlL//HFl
 g71bFB++bvxQfR12vHOIg==
UI-OutboundReport: notjunk:1;M01:P0:u+8kxHk3z8g=;fZeUSPRT0dKrOpu2ui5e7Invor7
 Jvy62enfyCwJfAAYfV0nGbJFLuSWn4zEYpDE0Co0A53V/vBYgSctQyG0ilrE09UoWX6nOxZ/v
 qfbjxBs50H/wNlVipHcCcVqM1GUTPVDMSO411M7F0gSmFhGGXo/eEziQDbvbf26EBA7xIlf7/
 tuhd60FvSn0JZlH4QpzdXdtWyPIOsR8gGtOQgZN+DDcHptAgQsXaqVYpEKM7iBcrdqGgmuolE
 AQxBl0XEcuUz4sdl5g+vBrW2fQvVVoIeeBPG5cPoBLyeW45xuX6voq7AVye6uJi0pRJCTfH9A
 mF8hEpHCVBvcph9/38l5BDvZDPun8W0/KpOeQss9MCVAo75q0/Sln86dOLPj51InOwFm+sptK
 S/3WBLwAo1X8C+zEhxbqHyVl3+fCfoTxRdDWonMPLeRNS0+jODF/zsQ3OpEFAttm1gLhjHcvn
 1/UZk5IMX+YA4f2PFNiVf9JhGTUXPrd2FKtr0TTL0ODff3DkNt+N1f2WUyfN95LhK61Xhs2Ep
 j/1oFtVV5xepiaYaerg9he381AQhEm2qCU30Z86qTjdbGVJ9eKjFYsPzmITcp3T1olMyCeNzw
 6qaNj4LtRgG/1N72UrEqICI1/H4oahYytoo+3bxCOEZKFU8WZ3nbMOuLRC+k6JMfJk47glDrE
 fXaiCAnCk5IwrnONBylWs9DukZ1yge3/Pn5QUXkZCA==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 23/02/2023 17:07, Larry Finger wrote:
> There are various tasks/applications that generate this warning early after
> startup, but the ones from `Qt bearer threa' are the ones that persist. Those
> were the only ones that I had seen once the dmesg buffer wrapped around.
> Obviously any kind on "once" restriction would lose information.
> 
> In my case, I support devices that need WEXT, thus disabling it in the
> configuration would not work. Logging one per application would entail a bit of
> work, but that would clear up the log spamming and work for me.

Wouldn't it be simpler to use custom rate limit parameters ? I see the defaults 
hardcoded in pr_warn_ratelimited() are 10 messages every 5 seconds before the 
rate limit triggers.

Changing them would require some layer busting, but it is still significantly 
simpler than caching names in an array.
