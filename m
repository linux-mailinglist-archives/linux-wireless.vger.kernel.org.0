Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D9C4B366E
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Feb 2022 17:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbiBLQa6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Feb 2022 11:30:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiBLQa5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Feb 2022 11:30:57 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05149197
        for <linux-wireless@vger.kernel.org>; Sat, 12 Feb 2022 08:30:53 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E17715C0102;
        Sat, 12 Feb 2022 11:24:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 12 Feb 2022 11:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=NsKDjV7yozdIGo
        WYo6g6G5GVC/MAQKOf51OAj0cQcmI=; b=Visc1SxAlBGB4f3os2QUzaCgJ70doq
        yUWw4+myr59UX1/zPAzgZmPwuM7ccBBbP6x+ZjBoFz+cC0LAb3Aw0FDQ6d2fpzhH
        DrU1/qdoDww1+1pKG2R9rjsfVSEAD4gqZNEEjr098CBASq2heU4Y8jH0PheeIFck
        xdqAO3FGkce+vb5FbSLB/wd4xZMSNMzqULtTfI5Z/IO5dnA3u/SrlNgYC7mWng3i
        gfeNbN/RZc+wwUNL9yxpVIj4rUGOD0tv8RloEMWqvLiut4Fkprly0as1vupSuz3M
        c0JvOLGvIYIdH/oWJH98ix4EmB30KmUPQ5iS+CtOWMlgqXNfPh7zP3YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=NsKDjV7yozdIGoWYo6g6G5GVC/MAQKOf51OAj0cQc
        mI=; b=gMjAflY6L/xENzj3fAxhcDweV8V8X8erLI61x62h8UkcQ1t7Meyt+80qq
        PWe+Ip/ABLJDgf5H+wXZ3MgkUvY+J2qF4agoRO4asK2do/84ao4MPJ5lOMI07d3E
        Ec5e4Y3dm/mxCVzJ5cOmu2V4IxwQ3bXQcqxk/ooRO9RjdVPIdjlZF9pjlHSUuuuL
        P/Uapo4ok1VOfwhXcyHMdqXxXxrm8CZYP5fMPGq5lGuB0MTt6ByA+g08HSJxnZZH
        lWoCwEEJN1el1BZrPuDPMiJH21GkMWGV3AM8lsock6CXdD/9w2Pr5VkV8z6vXXin
        2LLa6Ta7VyXZmAVPxytyTj7Ifrdug==
X-ME-Sender: <xms:Qd8HYsXt031glO5oOx0DAS2wyhUAOT8gfGwbD_f_c1U5Qv8m6KZWNQ>
    <xme:Qd8HYglXbUq5im3MLTo_tn1lBfAP4_AyQHQD_uoqAZncA1MuSHTGiCTLt1BCNz3ht
    nAjU1FNWmEYPRLsd3M>
X-ME-Received: <xmr:Qd8HYgZ9bO58zQRxFu9Ksq-D_sLK6BQD0owus8CqbL1wFNZTWjQ6917pSt9wQPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieehgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepheffgeduuddttdeffeejheejteeugffgffeujefgudeutedtueef
    kefhkefhhfegnecuffhomhgrihhnpehmihhithdrghhovhdrtghnnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:Qd8HYrUL8LalJzS1M2gwsB5HiaHU77peHaIE6N8Ir6OdUiilaLc0lA>
    <xmx:Qd8HYmle2Yvtd8S89586pOjWjh2FcNi5P5QUdmMr8B_T0oRHHyr_cg>
    <xmx:Qd8HYgclEm7JYcXYiSsUzIvp6MLNpAwvGvEiqz9_TlWHAurqpi2KEA>
    <xmx:Qd8HYqv4tuMYQQeKYicIjDT1B3v3_SmelY3U8F2hhdYC1ZWL43xngA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Feb 2022 11:24:33 -0500 (EST)
Message-ID: <52607f0a-05ad-f4d2-6fb4-117f447f06cc@flygoat.com>
Date:   Sat, 12 Feb 2022 16:24:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for China (CN)
To:     Seth Forshee <sforshee@kernel.org>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
References: <9a460b85-4e1b-40b2-8691-3f999331c76b@www.fastmail.com>
 <YgfWuV8E+xHZGeqh@ubuntu-x1>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <YgfWuV8E+xHZGeqh@ubuntu-x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



在 2022/2/12 15:48, Seth Forshee 写道:
> On Fri, Feb 04, 2022 at 03:19:29PM +0000, Jiaxun Yang wrote:
>> China had updated regulations on ISM frequencies by
>> "工信部无〔2021〕129号".
>>
>> The new regulation effectives from Jan 1 2022.
>>
>> Update regdb accroading to it's attachment "2400MHz、5100MHz
>> 和 5800MHz 频段无线电发射设备射频技术要求".
>>
>> Announcement: https://wap.miit.gov.cn/zwgk/zcwj/wjfb/tz/art/2021/art_e4ae71252eab42928daf0ea620976e4e.html
>> Attachment: https://wap.miit.gov.cn/cms_files/filemanager/1226211233/attach/20219/d125301b13454551b698ff5afa49ca28.pdf
>>
>> Those documents are only available in Chinese.
>>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Thanks for the patch. I'm looking at a machine translation of the
> document, and based on that I think one change needs to be made, see
> below. If something was mistranslated or if I misunderstood, please let
> me know.
Thanks for pointing.

I asked a RF expert and he adviced you're right :-)

v2 is on the way.

Thanks.

- Jiaxun
