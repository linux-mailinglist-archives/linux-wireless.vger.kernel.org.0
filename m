Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A82263F8C4
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 21:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLAUGA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Dec 2022 15:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiLAUF6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Dec 2022 15:05:58 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC9CDF85
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 12:05:57 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 9B585320094A;
        Thu,  1 Dec 2022 15:05:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 01 Dec 2022 15:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airpost.net; h=
        cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1669925156; x=
        1670011556; bh=0yx9xBHcY+m/emerB1uFepGxrxW4+lEw8YfbIk+JlTY=; b=C
        JMJkFDLlsliPkiOZn5iVf6DiHbDoiAI9kT2EXbCFrvaFAi/JC5YiwY/7DhgAC5rQ
        MrpyK/prcfjToQKMRtHfvmx895nlmUE+yXc120hagVecBMd2ySyZkoFySWth574d
        bbbYazglALIvPh24C8VizXdLzjcNogJSJIAXpqOhUeI0HjS0C3T/fM8yXqGVw7yW
        jCZNa9HLfBHAEXJTUSQo/5kPaD34UiVlkgSaddHyLELHMjF/qw9Pu+60AucRcwrg
        /bC8QuV4VwhV5F8YSWm/uDFzaDJjXHuKXWzONj30tu6afOtw9AoqN9WnO/RHHm79
        0LqGCIqiEw0JjXsDA0Q6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1669925156; x=1670011556; bh=0
        yx9xBHcY+m/emerB1uFepGxrxW4+lEw8YfbIk+JlTY=; b=gWRw9ZFnzOQiTgbMA
        gULMgZB5qCIkOkVKFynO/oy3XmitF1GXNEQ9CxmJ+XAJYg+BYAuPzb6witL6Kux6
        EzbA0r7USaCFrenUSD99YQa9FTa+t6rXMcc7RG3t0f9jOsyUb2gOTm5QBmLv9vFB
        Wb2iWEscOkMlxkaA7SbeVD5aavFWkUfmgndZR5FsskLmcCmWKfcKh6XQQT88MvF9
        LBgiTLTyATcSQoOUHSXWCwUcbl/vH0X5WidFS07vLA4ii+gzMvsQahaEtNN9vOh1
        RYacLuL+JAx61G2l6v3xFMs/8joSAsdA+Zvhkt7n+8GqKc+u/SR7viE7DiwW14Xw
        0BKOw==
X-ME-Sender: <xms:JAmJY42GjVvY-iAJVyqkK9eGexWxKnfW9Q6LNr0moPOKO4zGlSix-Q>
    <xme:JAmJYzEUF7qiC1ftdI8cH9Y2a3CzDnA2riziGXgnEkVv7KQI5b4mHubw-jrD4wqHw
    Exa1EhKiHnJ9dRn>
X-ME-Received: <xmr:JAmJYw73gwr_wfUiI2SCnMkgc2dvXx4ucuwId3XckAWuQeTWHOwZWOwmCqyvtop98M4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdehgddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepuehruhhn
    ohcuffgrnhhtrghsuceouggrnhhtrghssegrihhrphhoshhtrdhnvghtqeenucggtffrrg
    htthgvrhhnpeevhfffgfeuvdehhfehheehkeettdfgueehffdvvdejudelhfethefgleej
    feeiveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gurghnthgrshesrghirhhpohhsthdrnhgvth
X-ME-Proxy: <xmx:JAmJYx0x8jOjtKCYHPbrlQfJBpzClIFw7FKaEGjWMMVT2J9h7JRFXg>
    <xmx:JAmJY7G7Pl9rVZ_56rZ8fUo-uTCMnpL1nLLxZK73WxX03PzYVltz8g>
    <xmx:JAmJY6-MafDaTO2GnPuNWXbBa0leL9BeT8tKyUKxU9gsjCFep1H8dQ>
    <xmx:JAmJY-Onx-CmQAFWL8r-PU_nGrZzFBd-aVXGEE3kBeuRhJyZMAKFMQ>
Feedback-ID: i1cfa4199:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Dec 2022 15:05:55 -0500 (EST)
Subject: Re: every other wireless scan shows bogus (too low) signal strengths
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <b48efa92-9eee-d491-1149-a7cee08300c0@airpost.net>
 <80556c56e69405d7c8f8bc3d57e2ba697074c660.camel@sipsolutions.net>
From:   Bruno Dantas <dantas@airpost.net>
Message-ID: <9093c08e-302d-578c-3e16-619d238b4022@airpost.net>
Date:   Thu, 1 Dec 2022 15:06:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <80556c56e69405d7c8f8bc3d57e2ba697074c660.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, Johannes. Thank you for your help.

To exclude a bad network card, I replaced my laptop's card with a different one (with the same Intel AC 7265 chipset). The replacement card fared no better. Therefore, I put the original card back and ensured that the two antenna wires are securely connected. There is no doubt now that the wires are secure, but the problem persists.

Unfortunately I cannot seem to make  trace-cmd  work:

bruno@x230:~$ sudo trace-cmd record -e iwlwifi
trace-cmd: No such file or directory
  No events enabled with iwlwifi
bruno@x230:~$ sudo trace-cmd record -e iwlwifi -e mac80211 -e cfg80211 -e iwlwifi_msg
trace-cmd: No such file or directory
  No events enabled with iwlwifi

Perhaps the  iwlwifi  kernel module was not configured to allow this operation? I found this line in my kernel's configuration:

$ cat /boot/config-5.10.0-9-amd64
---snip---
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
---snip---

Oh, well. This is proving to be a tough nut to crack. My workaround for the time being is to discard every other wifi hotspot scan. Since my minimalistic laptop only performs wifi scans in one shell script, this is easy to achieve:

iw dev wlan0 scan flush >/dev/null 
iw dev wlan0 scan flush >/tmp/scan_results.txt

It's a kludge alright, but it will tide me over until I figure out what the real problem is (if ever).

-Bruno
