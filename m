Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717A867FF7C
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Jan 2023 15:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjA2OUf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Jan 2023 09:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjA2OUe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Jan 2023 09:20:34 -0500
X-Greylist: delayed 5882 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 29 Jan 2023 06:20:30 PST
Received: from pro152-32.mxout.rediffmailpro.com (pro152-32.mxout.rediffmailpro.com [119.252.152.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939B41A949
        for <linux-wireless@vger.kernel.org>; Sun, 29 Jan 2023 06:20:30 -0800 (PST)
Received: from pro-237-223.rediffmailpro.com (unknown [10.50.252.5])
        by pro152-32.mxout.rediffmailpro.com (Postfix) with ESMTP id 470171E3983
        for <linux-wireless@vger.kernel.org>; Sun, 29 Jan 2023 18:12:25 +0530 (IST)
X-REDIFF-Delivered-Remotely-To: linux-wireless@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rediffmailpro.com;
        s=epro; t=1674996144;
        bh=uQ0T6f7lRwLn26U6HZ825MDJrEyY1KR9wF5Whiksay4=;
        h=MIME-Version:From:Date:Message-ID:Subject:To;
        b=CYigt0jhb6iGAwK50kgyDVnT82yVkRW2bUakEzYEx0FNx+AUIGQGt+G9A+41FXG+U
         bC3oLA3UiEzkhtvGnB1aWPof6cyu1Jh9c1XYiOJ6otwDjBZbpyp0FZq7A3DkmaOOW3
         Ih4Oby6/uhFSHgVFB+qQrQfNygHQi3Puv+CogFvg=
Received: (qmail 21299 invoked from network); 29 Jan 2023 12:42:24 -0000
x-m-msg: 2fba2de75e7b680624dc19b1753d2818; a6da7d6asas6dasd77; 5dad65ad5sd;
X-OUT-VDRT-SpamState: 1\SPAM
X-OUT-VDRT-SpamScore: 300
X-OUT-VDRT-SpamCause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeftddggeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedttdenucdnodfutggrmhihqdfoohhnvgihqdgvnhculdeftddtmdenucfjughrpefkffggfghrhffutgfgsehtjeertddtfeejnecuhfhrohhmpedfldgurhdmuehorhihshhovhihtghhucfuvghrhhhihicuvfhulhhusgdfuceothhrtheisehnihhthhihrghmohhtohhrshdrtghomheqnecuggftrfgrthhtvghrnhepjedtgfevvdffheeliefhueeghfekffekteeigfehieejueeikeetveevvdelgeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuth
X-Dedup-Identifier: 1674996144_21273_16830_pro-237-223
Received: from unknown (HELO ?192.168.0.110?) (trt6@nithyamotors.com@102.69.220.39)
  by mailserver with SMTP; 29 Jan 2023 12:42:23 -0000
Message-ID: <9ee078ab-a6f4-efa4-cd2a-f66fc7469af4@nithyamotors.com>
Date:   Sun, 29 Jan 2023 12:40:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: dr_serhiytulub@zohomail.com
Content-Language: en-US
From:   "(dr)Borysovych Serhiy Tulub" <trt6@nithyamotors.com>
Subject: REF
To:     undisclosed-recipients:;
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: Yes, score=6.7 required=5.0 tests=ADVANCE_FEE_4_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [119.252.152.32 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.6 ADVANCE_FEE_4_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


-- 
FROM: Dr. Serhiy Tulub
SATURDAY 28TH JANUARY, 2023

  

Good Day,

I FOUND YOU TRUSTWORTHY OF THIS TRANSACTION

  

Please accept my apologies if this request does not meet your personal ethics as it is not intended to cause you any embarrassment in whatever form. I got your contact from internet directory and decided to contact you for this transaction that is based on trust and your outstanding, I have an interesting business proposal for you that will be of immense benefit to both of us. The need to contact you arose due to the invasion of Ukraine by Russian troops Please grant me the benefit of doubt and hear me out.

I am contacting you to seek your partnership in a pending business project,which I have here in my hand and ready to be executed without hitches from Ukraine to your country,I have all the modalities fashioned out to give this business an excellent outcome.

I am confident that you will give your consideration to this proposal and respond positively within a short period of time. As soon as you give your positive response to this proposal, I will not hesitate in sending you the detailed information of this great investment partnership opportunity.

Regards.

I await your quick reply for more details.

Kind Regards

Note: if you found this email in your junk/spam, it's because of your internet isp server.

