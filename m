Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A61627252
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Nov 2022 20:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbiKMTt0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Nov 2022 14:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbiKMTtY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Nov 2022 14:49:24 -0500
Received: from titan5.planetwebservers.net (titan5.planetwebservers.net [51.222.33.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE96DF03F
        for <linux-wireless@vger.kernel.org>; Sun, 13 Nov 2022 11:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
        References:In-Reply-To:Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xQ2kwgkWVR95JotDbZDMv+SWOPwlqIwTBYJIDtbTGUI=; b=r3hgFhdnrHeXwiMR0SES2EmSup
        cQycz5PZ+zxSOX2tZKLXkK4Qr7o+hpEpUJAAptu/B2qOoIjJl9qNMCuw9U/ZPuD4KlFCorS47SAUc
        xtDmFyYV7QjaXMQEx8EryJYxILNNy2hQ3yahBqxtZ86TeEuvXUcz30fcXUUu5OUCLCIp8zegE11oR
        7VVCDYPNnMFhYNVrgt7i7zozyrSh/MD3zAQ6exzebmQyfn5UhHJe9ORGXY/S0C78saw9KeDOsuYWN
        fdV5HZhIxYOAe8Z9OZFC5adkzlI06b5HzkkFMBwQV9f+mTVuEBBEbsFKGgYidXiZ3Yjdqq7emyvWH
        /ZXnBlDg==;
Received: from [76.75.122.26] (port=40729 helo=dummy.faircode.eu)
        by titan.planetwebservers.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <bjlockie@lockie.ca>)
        id 1ouIyn-000415-0Y;
        Mon, 14 Nov 2022 06:49:21 +1100
Date:   Sun, 13 Nov 2022 14:49:19 -0500 (EST)
From:   James <bjlockie@lockie.ca>
To:     Ray Jantz <ray.jantz@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Message-ID: <22dd461a-f53f-4ef3-9f96-ca1fe0bbf51b@lockie.ca>
In-Reply-To: <CAPh_e-gaCqdyFkmTRvHsYdCFwcBrK0yb+qC=BA0Uy+-uQO_BpQ@mail.gmail.com>
References: <ba072331-b7db-edc3-de77-4496d402f497@gmail.com> <150de978-0abf-d1a5-5c1a-82a18ff89d00@lockie.ca> <CAPh_e-gaCqdyFkmTRvHsYdCFwcBrK0yb+qC=BA0Uy+-uQO_BpQ@mail.gmail.com>
Subject: Re: [BUG REPORT] mt76: LED not working on ASUS AC51 USB (mt7610U)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <22dd461a-f53f-4ef3-9f96-ca1fe0bbf51b@lockie.ca>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.planetwebservers.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lockie.ca
X-Get-Message-Sender-Via: titan.planetwebservers.net: authenticated_id: bjlockie@lockie.ca
X-Authenticated-Sender: titan.planetwebservers.net: bjlockie@lockie.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sounds like the driver should at least create the /sys directories.

Nov. 13, 2022 13:57:27 Ray Jantz <ray.jantz@gmail.com>:

> I thought that article looked promising, but the only directories in
> /sys/class/leds are
> 
> input0::capslock
> input0::numlock
> input0::scrrolllock
> mmc0::
> platform::mute
> tpacpi::thinklight
> 
> so there doesn't seem to be anything for the mt76 driver.
> 
> 
> On Sat, Nov 12, 2022 at 7:41 PM James <bjlockie@lockie.ca> wrote:
>> 
>> 
>> Try some this stuff:
>> https://www.topbug.net/blog/2015/01/13/control-the-led-on-a-usb-wifi-adapter-on-linux/
>> 
