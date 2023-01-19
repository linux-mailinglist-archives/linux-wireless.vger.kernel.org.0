Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05EC67437E
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 21:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjASUZc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 15:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjASUZb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 15:25:31 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC6E9B136
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 12:25:30 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 6C0015C00D5;
        Thu, 19 Jan 2023 15:25:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 19 Jan 2023 15:25:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airpost.net; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1674159928; x=
        1674246328; bh=4xbrnFLhcmh1rZxMU27tTFyIb/ImY7Dp6wUugS/RQIo=; b=0
        oQu4hmfwHOzYwmjrDeFIYr4bWrI6UtWdfgwxj5f4qg06hVHg59l4QhFLBK+RW0wC
        YsZ201pxJemCpBpSw+3B0jD2SDMpOgS/DS9UjMNLOsRLNV8GuFQiPtuAQB5L+u8A
        4wtzdehEWdI7VJvdpgXDYpLj3Nozef85KDeGxw+p2QbpmugCBbTtTW5Mv2O51Nsn
        6TCKLkRkCT7pG4QmRABb6+BZe9lgX5fuu6qScMO++tJPGGflEHzgV1xzAzEJRQhb
        WsDUlNFSE3nM8jO/vqEAy0E7CC99KC+dbMTAb9SC1/nI3kNBQTaz3iowyv3TtGOp
        EBpWzsmX48712GLktS3Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1674159928; x=
        1674246328; bh=4xbrnFLhcmh1rZxMU27tTFyIb/ImY7Dp6wUugS/RQIo=; b=m
        ehJyXhfafCDp+ZFhWpxGGq3Y7j0uUDoBdWzMT1eeO193v/JJ//l9GYkO2gwrwAhV
        xVrjeJ0Krmhj59KnBQwaCvjgwppcqX149UvUNVQGHCbzHhPHNITOOQ2Vkfg9+8jF
        BJ8d28SH/FWvCLFtfsJV7p0k3dUD/Af/kA9Nq02aGWKOlesmGc7tJ1KEsIStTQXS
        ykZyB/4jZOPWzAXMVmkOpJZ6SD8iealby0ICT5kcL7AnfNLPB29GO7EFhI5+KRx/
        0i0CGyS57QY5s9zCNbThXV+ffBW9hLPXkNfNlqJ6R1OGEHye7Np8ID+l6dlud8Cd
        7lFfjOunzhs1Ju+66dqng==
X-ME-Sender: <xms:OKfJY5gszboOJmwg-RllErADmycr_x6kn9zBQhZc_7xsorRD0gmH2A>
    <xme:OKfJY-CoghOQTR5yog9QZ3u6Nhhx2g35cmudcVAbOubbkvmdmBk134984MIfpNQu4
    dkZ3iAYwW7su5jz>
X-ME-Received: <xmr:OKfJY5F_O5h_rc17Ovi84tslvbwTBUOAGJ__F0HmgqGugSPDHD2YTwUcqlvxmpdX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddutddgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfhfvefhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepuehr
    uhhnohcuffgrnhhtrghsuceouggrnhhtrghssegrihhrphhoshhtrdhnvghtqeenucggtf
    frrghtthgvrhhnpedtheevgeeiteehgfetkefhleeftdejheffheeuhfffgeduveeffeel
    gffhtedvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegurghnthgrshesrghirhhpohhsthdrnhgvth
X-ME-Proxy: <xmx:OKfJY-QCgeLKq7U2gylGKtZpt-9KNjEL1DDHWfboSM69Iszm1Jsvuw>
    <xmx:OKfJY2zX-vcLKWRBEbHmCTIWpIqcTCX_zNcCeYBLybhEfWSkqVTAFg>
    <xmx:OKfJY05dz7P3UOUaLhAqabh8kafR62Jef07_17NBjSXgTCZaHi0tiA>
    <xmx:OKfJY7oGuHVtTCY7egeJ46Re3V06wQPfhuvXL2i6bEovMeYW5ac3fA>
Feedback-ID: i1cfa4199:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jan 2023 15:25:28 -0500 (EST)
Subject: Re: every other wireless scan shows bogus (too low) signal strengths
To:     Johannes Berg <johannes@sipsolutions.net>,
        Julian Calaby <julian.calaby@gmail.com>
References: <b48efa92-9eee-d491-1149-a7cee08300c0@airpost.net>
 <80556c56e69405d7c8f8bc3d57e2ba697074c660.camel@sipsolutions.net>
 <9093c08e-302d-578c-3e16-619d238b4022@airpost.net>
 <CAGRGNgVGsii7+jdN3PnMWdCSeRyCDF96ivVOfxzi8xDufUigNw@mail.gmail.com>
 <90bb34e9-4e83-dcc2-91f2-e6f28ddbcc73@airpost.net>
 <1592b9b4354d67c104d2782915e1a66d0a972b92.camel@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
From:   Bruno Dantas <dantas@airpost.net>
Message-ID: <2920b7de-5515-3f5e-5982-abaf5bb8bc91@airpost.net>
Date:   Thu, 19 Jan 2023 15:25:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1592b9b4354d67c104d2782915e1a66d0a972b92.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thank you for getting back to me, Johannes. My hypothesis was a wild guess based on almost no evidence, so I'm not surprised that it was totally wrong :)

Despite remaining unexplained, the behavior is perfectly consistent. Plus, my system is very minimalistic (e.g., there is no network manager, all network scans are explicitly initiated by me, I only use iw for scans). Because of this, I wrote a wrapper script around iw. If action is anything other than scan, the script bails out and passes all arguments to the iw executable. If action is scan, script does a disposable scan then passes all arguments to the iw executable. It's ugly as heck but I can live with it.

Happy hacking,
Bruno
