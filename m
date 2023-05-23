Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EFC70E376
	for <lists+linux-wireless@lfdr.de>; Tue, 23 May 2023 19:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbjEWRg4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 May 2023 13:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237970AbjEWRgt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 May 2023 13:36:49 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933FBC5
        for <linux-wireless@vger.kernel.org>; Tue, 23 May 2023 10:36:47 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-39831cb47fbso32314b6e.1
        for <linux-wireless@vger.kernel.org>; Tue, 23 May 2023 10:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684863407; x=1687455407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=S1Kh/s2/gLaYUAM8MUKoA24L/mBMKNhW7a14cWcs8RA=;
        b=dv4+C2kGMDPHoAHqSNQgLKQXBIcDV5ehghJuYpzyur94jIgyabbClFKgZvmTGEfr0M
         m/SsW+DFL3XgildU8OLwaOH7wxsa2gsIdDSmGFtZ5qRf9oYrwyyZvwj0ZmZB3ExevHwN
         sWLWXPic9vP4FY0N2M4nbWByAJZfAlSlhI80SsJee14axAdzXKMHVvSHWD1VmsvZ3rNa
         QN6cbynimNfMxANY/MliioBiYGfrX/yJVXFRyqHHxe4O+WHAPszKNLDA1o5qt/8Dw1IB
         y05RmVgqx6tlrT115cxOYmC6yEKd1IizcljxW+2bRag1y/KHcStT+BpHfaRq4T7oSpZe
         VHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684863407; x=1687455407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1Kh/s2/gLaYUAM8MUKoA24L/mBMKNhW7a14cWcs8RA=;
        b=QqbD69iDKG52srN+zP5oVPmu46fMyfyD3kvBomYI519KXkgZmOzdEQMJEKDmYeVtfG
         Nkt2pXQtDc6E5LjRF5xRW0p593W0sdDLtrgPYE0ZMd2hZLceoGioVPH6LTINGQOwP5Sm
         r2lOSgZJOXb4R0tD3U4Ci5FLX6CIU6Jn1HcdsUQ6Ppin7poPsWPdyw5FN8XCstu/UaA0
         FR8OHoHEeHfScobm8HEymVzsK+KAsd+vDbhv0Fo6efZJpBfi2HRcFSfxvn2gXnouV+TL
         QvzqwggEE1GEsEjQ9EYZ5FtPsYzXQU8mNRw0JDwfXP5ekPxRSALXRETA+VYyKAbBHVgH
         e/Fg==
X-Gm-Message-State: AC+VfDwhD0aC5bcunqeUvCde9CyV41SVQjvvc0aCe+gdPujfV39qzCI4
        sbULfk1xW09jtat6RHG2AE4=
X-Google-Smtp-Source: ACHHUZ5HYGiJtWmKot5Yadx4LGxQqbq+QwGLAT/w3sfto62FFe0KQKHMfzgB+GGwwmEtCyqDeGDtEQ==
X-Received: by 2002:a05:6808:910:b0:398:19d2:2882 with SMTP id w16-20020a056808091000b0039819d22882mr2803155oih.24.1684863406803;
        Tue, 23 May 2023 10:36:46 -0700 (PDT)
Received: from [192.168.0.159] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id u21-20020a056808001500b003923ef75a3dsm914247oic.4.2023.05.23.10.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 10:36:46 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <79f87067-ae50-b579-d57a-74103c6038b9@lwfinger.net>
Date:   Tue, 23 May 2023 12:36:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Realtek RTL8832CU compatibility
Content-Language: en-US
To:     Fabrizio del Tin <devotedmystic@gmail.com>
Cc:     linux-wireless@vger.kernel.org, James <bjlockie@lockie.ca>
References: <CAMzNfvPpi9GiFHf0UcBpS8oozg6o_s3wwzOAPJ0FzGy7LaC4pw@mail.gmail.com>
 <777df364-6a1c-4427-ab68-46a9a71fc629@lockie.ca>
 <6f014d1e-7d50-5688-1ffc-88e00c77a61f@lwfinger.net>
 <33FF0DFF-0FBF-4344-95BA-55C2FE740B49@gmail.com>
 <0621f2d1-5316-0a0d-62b5-ba4aa3702fa5@lwfinger.net>
 <CAMzNfvNXqKyvy-88y79WnJ6BumAyGLQEkAcUk-9k3JeDLKeCkw@mail.gmail.com>
 <CAMzNfvMAgpHV=7HXydrtGJCLG+Mjny4NU6pFP1YjdrPt+Mcc-g@mail.gmail.com>
 <CAMzNfvPtmGyXDV9m-whhptH5n3xJL1-ZPNed3yrkXG-DSF==+w@mail.gmail.com>
 <7058acc1-b7e8-b7b5-0c8c-e83907f1b327@lwfinger.net>
 <CAMzNfvNMqSOUhCRijbqavubiMqaq3aL=4+VXe83ZOiML8sTbNQ@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CAMzNfvNMqSOUhCRijbqavubiMqaq3aL=4+VXe83ZOiML8sTbNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/23/23 12:19, Fabrizio del Tin wrote:
> I confirm it works. Kudos!!!
> 
> I also don't have a 6Ghz router, so I cannot test that at the moment.
> Maybe I get one next month. I wonder if there is a command to see the
> supported frequencies of the card.

Good to hear. The command 'iw list' will show the channels negotiated between 
the AP and the NIC.

To make any discussions available to other users of this driver, please open new 
issues at lwfinger/rtw8852cu on GitHub.com.

Larry


