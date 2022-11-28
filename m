Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1970F63A5AA
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Nov 2022 11:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiK1KFa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Nov 2022 05:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiK1KF3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Nov 2022 05:05:29 -0500
X-Greylist: delayed 554 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Nov 2022 02:05:28 PST
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2552D10BD
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 02:05:28 -0800 (PST)
Received: from smtpclient.apple (p4fefca0f.dip0.t-ipconnect.de [79.239.202.15])
        by mail.holtmann.org (Postfix) with ESMTPSA id F0141CECBE;
        Mon, 28 Nov 2022 10:56:12 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: PRO/Wireless 2200BG Intel WPA3 SSID connection problem #1
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CADUzMVbgf2dcu0yM=XO37GbTvgGK=mJpfELHrqDqbBECSuLKJg@mail.gmail.com>
Date:   Mon, 28 Nov 2022 10:56:12 +0100
Cc:     linux-wireless@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <3898EA13-74B9-43DD-960A-44FDF6BAE007@holtmann.org>
References: <CADUzMVbgf2dcu0yM=XO37GbTvgGK=mJpfELHrqDqbBECSuLKJg@mail.gmail.com>
To:     Ioannis Barkas <jnyb.de@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_20,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ioannis,

>> Well, keep in mind that WPA3 requires all kinds of new things, and the
>> *most recent* NIC you tried is already ~11 years old afaict.
> Yes and no. Yes it needs new things. No this is not the case here. I
> tested cards from 2021 back to 2003.
> 
>> This probably means they use SW crypto for everything.
> Sounds good to me since it works.
> 
>> What makes you believe that?
> The fact that some just work. Why not use SW crypto on legacy devices?
> 
>> Umm, no? Why would we break NICs that work well with most existing
>> networks, just not WPA3 ones?
> You got it wrong here. What I mean is to use a flag that some devices
> are not WPA3 compatible. That way when an attempt to connect at such
> an SSID would print a message suggesting to use a WPA2 network. This
> will help novice users and save time from bug reports. Most routers
> now support WPA3.

have you tried iwd instead of wpa_supplicant? I think we have taken care
of ensuring that WPA3 (or more precise SAE) is only tried when all
ciphers are correctly supported by the card. Otherwise it is going to
stick with WPA2. In case of WPA3-only network, we will have to see
what happens and if the error reported is correct.

You can try iwd behind NM or standalone with iwctl command line client
and it will also give you iwmon tracing tool that allows more capturing
the nl80211 traffic.

Regards

Marcel

