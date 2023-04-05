Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EAE6D81F6
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Apr 2023 17:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238792AbjDEPbq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Apr 2023 11:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238842AbjDEPbf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Apr 2023 11:31:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B195251
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 08:31:21 -0700 (PDT)
Message-ID: <26840cf1-9403-3d09-a4d2-352bc198efff@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680708678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dhMF+udcUP9FrFV9Hu4mIeidh9p+xIOR/iNotBOg3pY=;
        b=kXIQ7gIQLMIimR7hoPrxQiOCttCUMVapLxPNg6PWw6pjt+G/USbufbnJygA7c2k6WliSxb
        +HbcVtdbTIswOpj3Z0nOuqYgjLCSlRrljWEyiliHKrv0bQqJIZU0PECUI6NXnRlXqkn1Rt
        d7E7IXoz1twrof691Jxw3g3M7UPZQmVX5lNfDGYRe1UVXsHUs1bk2SdQw7lKA06QuszSxn
        0cZ8jU8XdW8dW1g7kHAhalxtSJNBYEP/qYMSsiRoVOfj1SJ/GwvnsjJVi0LnSqhPl1DUst
        LUGi17q2w0DVnhHh/DzCmQNOFVD9HHc/9xcVjlyOMFAD8l9cuI5hihpp7QuyBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680708678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dhMF+udcUP9FrFV9Hu4mIeidh9p+xIOR/iNotBOg3pY=;
        b=qKHSkLZgjsD0PljA32EWdi9UrFWIT+MQn5hNFpxe3ydCf13fQ3Kfp+bx6iDrfemBeSkpbf
        jbiroAd2DQonNLBQ==
Date:   Wed, 5 Apr 2023 17:31:18 +0200
MIME-Version: 1.0
Subject: Re: [RFC PATCH 00/14] wifi: rtl8xxxu: Add AP mode support for 8188f
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-wireless@vger.kernel.org
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <bbcc03ad-3003-c26e-3b8d-d2340243c8bf@gmail.com>
Content-Language: de-DE
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

Hi

I could reproduce a frozen system with my hostapd setup, though it 
doesn't happen reliably and I don't have an error message when it happens.

What I can see on the other hand, are WARNING messages which happen 
sometimes in include/net/mac80211.h:2936 (ieee80211_get_tx_rate()).
This might be unrelated, I am not sure.

Is this function even supposed to work in combination with 
HAS_RATE_CONTROL set? Also, why are we putting rate into txdesc for all 
packets (ie. also when USE_DRIVER_RATE is not set) when the firmware 
sets the rate based on the rate_mask?

> 
> My system is a laptop with RTL8822CE internal wifi card connected to my
> ISP's router. The connections are managed by NetworkManager 1.42.4-1,
> which uses wpa_supplicant 2:2.10-8 and dnsmasq 2.89-1. The operating
> system is Arch Linux running kernel 6.2.5-arch1-1.
> 
> I used Plasma's NetworkManager applet to create a new "Wi-Fi (shared)"
> connection with mode "Access Point", band 2.4 GHz, channel 1, no
> encryption, and "IPv4 is required for this connection".
> 
> 
> Unrelated to anything, just out of curiosity, what brand/model is your
> RTL8188FU?


