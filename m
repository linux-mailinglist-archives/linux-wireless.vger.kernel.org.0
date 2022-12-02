Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEC564093D
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Dec 2022 16:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbiLBPWK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Dec 2022 10:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbiLBPVy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Dec 2022 10:21:54 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966EF73F4F
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 07:21:42 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1FAA33200392;
        Fri,  2 Dec 2022 10:21:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 02 Dec 2022 10:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airpost.net; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1669994499; x=
        1670080899; bh=ZbGnu9nM0EKExBlJjpWMMI9TgXdxG/1hM3Xz/PRZmrU=; b=l
        JSgNqed8XQXhoTRP05mAl66BdCvLRuwuNl4G+tKAuUglvPNI9EvF8PnavpThajR7
        H6DVg45XjPxuMGwJl5DuUozmHXGljJP7IyRQWfNBNK5aAryyEK0jezA8MP838JkX
        GCQeA4s2tRBaeHSPMOT7DiukC67JqOz2J9Da/qrpoiVIKgD13vIPlKowSDSueR3K
        bAuGHTNlv8q5F/B4DqjAL4fOHPZ0+eSwvvc87PB2whdO78AgTUeaph6On7inYP6Z
        TPYBrPLHnqye2O1iBgZ7ZkPKVR4uHlLRmCoHwGKytdPXsymuasGn3yH40IubYxFX
        MGGO5INa0ft1ZRr8PwV0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669994499; x=
        1670080899; bh=ZbGnu9nM0EKExBlJjpWMMI9TgXdxG/1hM3Xz/PRZmrU=; b=c
        VZ5bjhmicIxjtD1eYpmPMDeLonb8Y6nz28sAwobp6BU9HUiIeNzkLHdsOmYxRNY0
        b5JFu1t2Sped4SRrtU+JkC6NEBj7LiddkAzOOAfhDG1ATGNnolm/zG6quGC+nc9I
        MIL7QUMHQsTELyntRIE89iOnC8g/Ut2DgghJe1fPPwtvJZPLhc7i5HzOz6cf00cM
        aUrw86wWAcXPW01zTPhqzsFIagv6l7OKTWVsPnmMSKnTHuKxlPnehnlOpxSeNXBH
        STu8EmC1EwrCHkUAdN3m0Dgk9CWUMrshOr1Wa5ghVeGFv9Zvpbwk1a5k25nJ53GO
        ZBthwi2d7AY3v19yKzXbQ==
X-ME-Sender: <xms:AxiKY-1gbhWLWFP9EAxF5eKveTIddSp2X1q66WwhBvBXmtrr5jxLaQ>
    <xme:AxiKYxFPhnOg4NbaadmQtsgBqW8leH5cVYcR4AzuKXEPytIYvE-kIsooEGLWd8Ht6
    AzcT82zqE5M4o0r>
X-ME-Received: <xmr:AxiKY25IRXSn2U4BAt5Gw6BZsMlJKFGbQjQmwPktmbgC-9REULQf257DQsMao408S_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdekgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfvefhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepuehruhhn
    ohcuffgrnhhtrghsuceouggrnhhtrghssegrihhrphhoshhtrdhnvghtqeenucggtffrrg
    htthgvrhhnpedtheevgeeiteehgfetkefhleeftdejheffheeuhfffgeduveeffeelgffh
    tedvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gurghnthgrshesrghirhhpohhsthdrnhgvth
X-ME-Proxy: <xmx:AxiKY_0W3i5KNzHe8voa66q9LqooZmsaM1AOFyGyRvzCH81FaKY_1A>
    <xmx:AxiKYxHctlD7FLVR6dpn40yGlC-WqoiyB3INx6ul0cjgT-iMHey6Lw>
    <xmx:AxiKY4-VJcZcoDMA7kI1qDO55kaKRvHPxuAgMBuL-OgZLSUTJjIr_A>
    <xmx:AxiKY_Mk0Iu38mLJBZe3B1GuLWpUMkN0AXa8J_8px72gllvrc7K1tw>
Feedback-ID: i1cfa4199:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Dec 2022 10:21:39 -0500 (EST)
Subject: Re: every other wireless scan shows bogus (too low) signal strengths
To:     Julian Calaby <julian.calaby@gmail.com>
References: <b48efa92-9eee-d491-1149-a7cee08300c0@airpost.net>
 <80556c56e69405d7c8f8bc3d57e2ba697074c660.camel@sipsolutions.net>
 <9093c08e-302d-578c-3e16-619d238b4022@airpost.net>
 <CAGRGNgVGsii7+jdN3PnMWdCSeRyCDF96ivVOfxzi8xDufUigNw@mail.gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
From:   Bruno Dantas <dantas@airpost.net>
Message-ID: <90bb34e9-4e83-dcc2-91f2-e6f28ddbcc73@airpost.net>
Date:   Fri, 2 Dec 2022 10:21:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAGRGNgVGsii7+jdN3PnMWdCSeRyCDF96ivVOfxzi8xDufUigNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, Julian.

> Stupid question, is there any chance that one of the antennas is damaged?
As best as I can tell, both antennas (black and gray wires) are intact.

> You might get slightly different behaviour if you swap them - if your
> X230 is anything like my X200, there should be enough slack do that.
Good idea, so I gave it a shot. Alas, behavior is the same when I swap the black and gray antennas.

I have a stash of these Intel AC 7265 half-height mini PCIe WiFi adapters, so thought I'd try yet another one. Interestingly, with the third adapter the behavior is worse: Every scan gives me the spuriously low signal strengths. I put my original adapter back in, of course.

Maybe doing a wifi network scan requires more power than just authenticating with an AP and using the network? And maybe my after-market 802.11ac adapter requires a bit more power than the 802.11n adapters that were around when this laptop was made? If so, maybe it takes this old laptop's PCI bus two attempts before the 802.11ac adapter has enough power to do an accurate network scan? That's a lot of maybes, but it's my best guess given the behavior I'm observing.

I'm ready to give up on troubleshooting this (for now, anyway). I can live with my workaround of discarding every other network scan result.

Thank you guys for your help.
