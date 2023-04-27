Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1506F0DD0
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 23:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245140AbjD0Vry (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 17:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0Vrw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 17:47:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003542D5B
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 14:47:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2fa47de5b04so8741903f8f.1
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 14:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682632070; x=1685224070;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JHFpiWV/4zmijgpBUi1Je9lWjHCbSkwSmirAiM2LkpU=;
        b=Br5r6S+cxvZ7EbXL1iCXkWJbwdKpoJnLKaQSjPu1HoIaJ+/IBNuL9BQlJw/wwSav4x
         XyPb18NIUuYgV6YHmdnXSyBk3DQLe5q6CnE2WVkIDmtlVnh3pp7dlO7fOouafaXUfNeo
         tVLrnh73zi5avTW+GqJkEMCWNzglUPZAqR3q834r+SRNAFs2Ek/zcsH2LdvdO7u3JneF
         PwIyBxCQ/61llMZTHJF16WCTt/UApuWom7Am/pPzSxogi+TWjAVrw0mcOSm0iRvwJ6py
         gY82OjvFQz+beEZjL+DbrJU1+ksFopQqf1ioNAgZKxEo6WksOS7Mrdth6/Hx2+tBl1os
         /elQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682632070; x=1685224070;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JHFpiWV/4zmijgpBUi1Je9lWjHCbSkwSmirAiM2LkpU=;
        b=DJy1c2uoXV8tkhEe64hSc7+f8e3+ccVJtOzRGTg217b8c9Ozvksp0Gkdt46tl4aeZC
         BP0odj2usGi51URP4psem/ikhryDVjCOh1YUPM9dgb1YHTh2egs17/Zpm9CmsE+X05F7
         Ip1C65ABf81OJPMd6VbhGuvi33JfsNtoSJ9XrGafOc9RiTw3373GSBe+6ho9uNwHzDWh
         1NqazRM9722v1RQIeIpQDS0UbqGWdoKUlWJOg7Mjea9lN4R95CpzMszsbdqlMalkWHKM
         mVvtdSoMWAwzbitM1voyxor3XCdkMyvfcNmcFWsU35jQbOAZIiE7hzMePazqNzv13Tt7
         f+iw==
X-Gm-Message-State: AC+VfDyxV+ujbtlqbJhWkIEMVNVTS3F9GeCS4eW3lUHvQrsmuEM0h3Pm
        Z82hU4wNe8lr2JrrIoTzpcbtoElX/5LwhdwKKafW9Rq+ir7G2w==
X-Google-Smtp-Source: ACHHUZ7C/AhPO5dEyhH3utm4tNiDomV1HdHun9hZrvnIxwnIldo9Q3YzfWerLfet2180uq+no2GbTK232Yd+2wVsG2c=
X-Received: by 2002:adf:ec09:0:b0:2ff:f37:9d0e with SMTP id
 x9-20020adfec09000000b002ff0f379d0emr2121329wrn.61.1682632070331; Thu, 27 Apr
 2023 14:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <CALbLcfAXrHp4vsVGqU0nBdB_gFmKTKx0GcdrFJA7R_kodAy0Ew@mail.gmail.com>
 <bfe732f4-60dd-4d78-1259-5f9f6c11adbc@gmail.com> <CALbLcfB7cMctHC-Fv93z1WVCZkQ76uW2F_=P6rCW7ZSPXvmapw@mail.gmail.com>
 <2857f998-1b1a-e3c2-20fe-d03dadcf8f23@gmail.com> <CALbLcfCsyGzhvrqjSz37+7cLvc3rc4Y_kgspZV=kiPNs4TBE4w@mail.gmail.com>
 <CALbLcfBnF6njFMSfQk2TuOiZ3C3kHwqs4-c-MQGb72azzQ5sJA@mail.gmail.com>
 <38172c8e-d107-d96e-7292-09d0e3b061dd@gmail.com> <CALbLcfCHLU+zoFdTnTrJs22UUYwr2rETp5hqbv=NL352Qz-XgA@mail.gmail.com>
 <CALbLcfDZJmOyn-Gf24+9X-eHh3-3PY4_nP5soG3gHf_Vn85=EA@mail.gmail.com>
 <CALbLcfAiVgGi9iocEG4OfgET2XLDRq0dthbxDMP0vP3R6BBp_A@mail.gmail.com>
 <3ceecfc1-ab04-7d54-51bd-457a4708c0ac@gmail.com> <CALbLcfCpb8xbN+w2VvCZ6Gdr+L_ECH0UQsWZrpO1Hcpoef66UQ@mail.gmail.com>
 <8eaeb64e-3f7f-6752-4476-c0f0c88a008b@gmail.com> <CALbLcfD7AmMG72-Qxafc9533OQVBCL=RLDycjUCV2MJ0DRN6nw@mail.gmail.com>
 <2a679614-c964-dc3f-c987-6c7ee03923a0@gmail.com> <CALbLcfBGg8FTBZx-_8v6u5iLsAssr+=QgQYc+Q2bUbmEwJPRYQ@mail.gmail.com>
 <0ce23546-7bf6-ef96-9417-c62adaa77cb6@gmail.com> <CALbLcfCYO2Uk91Mq6FW1UCx4j8RiK1Hpy-1VU6wb9tipBi74Fw@mail.gmail.com>
In-Reply-To: <CALbLcfCYO2Uk91Mq6FW1UCx4j8RiK1Hpy-1VU6wb9tipBi74Fw@mail.gmail.com>
From:   Artem Makhutov <artem.makhutov@gmail.com>
Date:   Thu, 27 Apr 2023 23:47:40 +0200
Message-ID: <CALbLcfA9Ak59sZ_OvoTUaMBO7vVuDLPM+Zvr4WkJyWkPyqNotA@mail.gmail.com>
Subject: Re: RTL8188EU (LogiLink WL0151A) - Malformed packets
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

did some more tests and it looks like that

if (priv->rtl_chip == RTL8188E)
                val32 &= ~RCR_APPEND_PHYSTAT;

Did the job for me... I will do some more tests later.
