Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FF37D3935
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 16:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjJWOUy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 10:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjJWOUx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 10:20:53 -0400
X-Greylist: delayed 611 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Oct 2023 07:20:51 PDT
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F96110B;
        Mon, 23 Oct 2023 07:20:51 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 63CC4581579;
        Mon, 23 Oct 2023 10:10:39 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 23 Oct 2023 10:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698070239; x=1698077439; bh=Cd
        D00F6lo71GUCVAQ5trDcf1jHXe2aUX3dC/0CHjbQ4=; b=qXXUQDlq0gAM5PfthE
        tj0+25tcD8B0dHKH53Y8/RBXX924Jv6+TCHgZ2DmBOPjpvDgoA6vfpQG4R5hBMmt
        yHtfzcx94RUzYA4BDrAoin2MGZ9kXM/rf7x82Q//kq1W0KkIWXdbljW91rPjUY10
        iRUXdIVSZOXRcMy+b0MSGV4mTsBo28657zFxjy3PRri+A74kVikmvO6Xd/Sb8C1A
        oMniFTNPeg0h1+dV/VIixGCsQ9XQZL88wvFFNQCjTxIPUd7T5AlibIF/mb+73/mn
        rD6df1qJCAMghE6/MeI4S6hQKhruJM8DpbU8wOeo3F8pqdD07HqekPFue6fcWKC2
        Nfyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698070239; x=1698077439; bh=CdD00F6lo71GU
        CVAQ5trDcf1jHXe2aUX3dC/0CHjbQ4=; b=hwUXLudllnoVroI4li0WSBuEKuS0m
        x5JRGf4/rrt20gTiLKboQBd6YiuI3HjGNfNnZ9Qt/2j90IzlMAv0YnNIbqMbmY55
        jVswrzfOKf8HCvbXFn/kXKL9/sGSehUbUCFycV0fu7SSdmzd2sLmz31QFbgIxbd0
        EhrKOBsPWx2hBCzFogyLfVylT3+4xDBLCoPQKZtY7fPCOnYGrDFcS9nep+3kBW4I
        jQet8pbe+BVl0IMhMejxkIqBU0Qd47FVWAuQTSGij7McKriKYUY8QW6/R4Fbk+2C
        Z6myKGW5RtMaGCBgn86OL+EXsFoa64U8ph445g0QiK8ba1orns8o2vIHg==
X-ME-Sender: <xms:3X42ZQ_ItFV-GbRI3mbqY1F_ZfsutV9aIgWdaivjEnFtaDWXrbZDOg>
    <xme:3X42ZYvEgKFXGNttA0kthbKP0HLq0YI2X_Hj9IO3rnRWR05AcK2f_hmbe7Xk4pECK
    UIWY5T0CA5vr3FM3nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:3X42ZWDp7CUTlUyBhid-28tQffehzvNNNvbBz8kQ2uCuoFOyovsmgw>
    <xmx:3X42ZQcK76hDhVVMBr3tH9vKd0PzjWN6deGqeG4iQ0StSHA-h6qjSA>
    <xmx:3X42ZVNTgT22xJcQiBBH_8M8IxNt2AOYjo-XZR2bJW2uGJGy0lLQtQ>
    <xmx:3342ZQGdEQ1YnY6VFN2tafTbr289GUD9MriSoShSnfxIvV8srUdX-g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1EB20B60089; Mon, 23 Oct 2023 10:10:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <50eafe40-9c50-48e2-8d48-6a113c8fd87d@app.fastmail.com>
In-Reply-To: <87v8axzc46.fsf@kernel.org>
References: <20231023131953.2876682-1-arnd@kernel.org>
 <87v8axzc46.fsf@kernel.org>
Date:   Mon, 23 Oct 2023 16:10:16 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Kalle Valo" <kvalo@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Geoff Levand" <geoff@infradead.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Jeff Johnson" <quic_jjohnson@quicinc.com>,
        "Johannes Berg" <johannes@sipsolutions.net>,
        "Larry Finger" <Larry.Finger@lwfinger.net>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        "Pavel Machek" <pavel@ucw.cz>, "Stanislaw Gruszka" <stf_xl@wp.pl>,
        "Gregory Greenman" <gregory.greenman@intel.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 00/10] Remove obsolete and orphaned wifi drivers
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Oct 23, 2023, at 15:45, Kalle Valo wrote:
> Arnd Bergmann <arnd@kernel.org> writes:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> As discussed previously, a lot of the older wifi drivers are likely
>> entirely unused, Though we can't know for sure.
>>
>> As suggested by both Greg and Jakub, let's remove the ones that look
>> are most likely to have no users left and also get in the way of the
>> wext cleanup. If anyone is still using any of these, we can revert the
>> driver removal individually.
>>
>> I would suggest merging these for net-next after 6.7-rc1 is out
>
> Why net-next? I want to take these to wireless-next to avoid any
> conflicts with other wireless patches.

My mistake, I actually rebased them on top of wireless-next before
sending out the patches, I just forgot update the text I had
already written a week earlier.

> We could take these to wireless-next after we submit the last new
> features (-next) pull request to v6.7, so most likely already next week.
> So if anyone has any problems with these speak up now.

Sounds good to me, thanks!

    Arnd
