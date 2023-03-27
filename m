Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8BD6C9CFB
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 09:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjC0H6W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 03:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjC0H6V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 03:58:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE6140F0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 00:58:18 -0700 (PDT)
Message-ID: <56168075-01f9-3e22-123f-e8e25afff293@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679903896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zf0lVCqZyFizLl02QQ27gdYJCMSWF+bcgHWh1luJP0I=;
        b=KZPFMfb4Fp+7LlAqxUfoGC45fPxcykx2CJNd4t2duPOd5XrxrRoYBLcyGeD0RRh/QIKDne
        9W+6Rsu2+96yRRnbOJ8YCqCMlFTZTNaq36JhU3qvSqX9dl9J+gF3H1YXw471tlDYfEPfB6
        0b/JuZWF10GsYAKS6H8pXlLspt8XlEJ4Gd8DJK/xmqClmEj93LLzr/zYaEZ6zzz1dqSYz/
        9zErHLtOJjYcsBlg2pws21CgnVe4dT2g5iPpWESJLwl03Q1vJH6Ggj+9XaWYNMdbTQLWqg
        3fYRTxt5Ku6gwCtXcrBJCIamZfYp5WwxTA2ghxbkr9F3Li3kmpPpSam9xBK6yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679903896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zf0lVCqZyFizLl02QQ27gdYJCMSWF+bcgHWh1luJP0I=;
        b=C8mFK0T5M9dGUiAXRITt6xXkr5baOctT5WKUYQ6I+Uck/unjb3J8V4EzMfSLC6DlD0yyU9
        l7lC20RTdFdqEXAQ==
Date:   Mon, 27 Mar 2023 09:58:16 +0200
MIME-Version: 1.0
Subject: Re: [RFC PATCH 00/14] wifi: rtl8xxxu: Add AP mode support for 8188f
Content-Language: de-DE
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <bbcc03ad-3003-c26e-3b8d-d2340243c8bf@gmail.com>
From:   Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <bbcc03ad-3003-c26e-3b8d-d2340243c8bf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Am 23.03.23 um 18:12 schrieb Bitterblue Smith:
> On 22/03/2023 19:18, Martin Kaistra wrote:
>> This series intends to bring AP mode support to the rtl8xxxu driver,
>> more specifically for the 8188f, because this is the HW I have.
>> The work is based on the vendor driver as I do not have access to
>> datasheets.
>>
>> This is an RFC, so that there can be a discussion first before
>> potentially implementing support for the other chips in this driver, if
>> required.
>>
> 
> Hi!
> 
> I ran into some problems while testing this.
> 
> First, a null pointer dereference in rtl8xxxu_config_filter() when
> turning on the AP. priv->vif was NULL:
> 
> 	if (priv->vif->type != NL80211_IFTYPE_AP) {
> 
> I changed it like this:
> 
> 	if (priv->vif && priv->vif->type != NL80211_IFTYPE_AP) {
> 
> Then I was able to turn on the AP and connect my phone to it. However,
> the system froze after a few seconds. I had `journalctl --follow`
> running. The last thing printed before the system froze was the DHCP
> stuff (discover, offer, request, ack). The phone said it was connected,
> but speedtest.net didn't have time to load before the freeze.
> 
> My system is a laptop with RTL8822CE internal wifi card connected to my
> ISP's router. The connections are managed by NetworkManager 1.42.4-1,
> which uses wpa_supplicant 2:2.10-8 and dnsmasq 2.89-1. The operating
> system is Arch Linux running kernel 6.2.5-arch1-1.
> 
> I used Plasma's NetworkManager applet to create a new "Wi-Fi (shared)"
> connection with mode "Access Point", band 2.4 GHz, channel 1, no
> encryption, and "IPv4 is required for this connection".

Thanks for your bug report.
I did use hostapd for testing, I will try to see, if I can reproduce any 
problems when using NetworkManager.

> 
> 
> Unrelated to anything, just out of curiosity, what brand/model is your
> RTL8188FU?

This should be the one I have: 
https://www.fn-link.com/6188S-UF-Wi-Fi-Module-pd41531470.html (Fn-Link 
6188S-UF)


   Martin
