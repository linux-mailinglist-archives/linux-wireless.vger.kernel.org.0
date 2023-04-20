Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863296E9948
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 18:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjDTQMf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 12:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjDTQMe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 12:12:34 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C312D71
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 09:12:28 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f0a0c4e505so5539245e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 09:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682007147; x=1684599147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YGhMHr7d+eeHpm5iyUfg/2TsJmSoi2yaLl9i5TfcZro=;
        b=gh7u6NxTa7XO8GBj28ux+Ab4xUadm9u89Ip5+mh3Bcreom72LpjmJ50V/LEpPKWS30
         zNieOLIoQ4PpY6drGyVI3iZXZb0VjziZVt6G2xAizJ+VK8wV8xFlVG5CqFtBaoHWTNYD
         PWiCSVJL46kuq6f6nXZWMfVV2jAh0FgnOjBq1YRT0IwYZUm98HqZixE8hBY//ah6rl8W
         3PNqkZf2TBznQNNpAciqhPaKmcXpp1r16Ice7qzXnu3sgmNOFn9YwsmTRtrxsfaO3+8K
         m88YfGAs4GOI2wPhFrYnADg/k64v0iML3LxXJRmASWUcixjfiU/6fHYlUTXbYcB5xQgR
         GlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682007147; x=1684599147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGhMHr7d+eeHpm5iyUfg/2TsJmSoi2yaLl9i5TfcZro=;
        b=O8Yr5Yrwx2UscJtrCkbFAwYnXtFe5wJj0TTdTUyRJJ9X7HoD9bqeNZ0br7jcVAz4wW
         D82ikxEpEIr6fcXphouZq/3mv9+jRYS8gY1eIccR8IlokmNMqdb8Frezc3DgynXj90gJ
         4Dj8mUCdLHuIkhmf0Rgl/XtXUhXYh8mOLMWOTo4sgCTPCfiisq7hM0RpxKb/v92/umId
         453/qH1tcinuwgWi8akIYZGmT1WaKEezB8GZLKQBRBGTDAxB1JShw4oV/aKlut2Ua4zG
         Ge/8OSX1vQnQ4yq7zx3CmrCo0sfeY6nO0BqlPi5ZaFSGb2GXuLToO/UXbhTo/vxZeLLu
         MqRw==
X-Gm-Message-State: AAQBX9eq7wE0gS/RXo8ti+XTZAmFKib3mMHB15bPcXrO+QKHLFkGdRWZ
        jJkiHVAFVXeclL4uE46yK6iicdC7OfzAD2xHmYg=
X-Google-Smtp-Source: AKy350a4WNJKvCpUrsY0YD+xIHaWbTYvXUwUXA8NS5W9FcXXJB/S0rLPdmJi4e+N1y249yb0w9hkyU1gk9LMIr1MhVY=
X-Received: by 2002:a5d:5687:0:b0:2f7:363e:7f5 with SMTP id
 f7-20020a5d5687000000b002f7363e07f5mr1839064wrv.24.1682007146956; Thu, 20 Apr
 2023 09:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <CALbLcfAXrHp4vsVGqU0nBdB_gFmKTKx0GcdrFJA7R_kodAy0Ew@mail.gmail.com>
 <bfe732f4-60dd-4d78-1259-5f9f6c11adbc@gmail.com> <CALbLcfB7cMctHC-Fv93z1WVCZkQ76uW2F_=P6rCW7ZSPXvmapw@mail.gmail.com>
 <2857f998-1b1a-e3c2-20fe-d03dadcf8f23@gmail.com> <CALbLcfCsyGzhvrqjSz37+7cLvc3rc4Y_kgspZV=kiPNs4TBE4w@mail.gmail.com>
 <CALbLcfBnF6njFMSfQk2TuOiZ3C3kHwqs4-c-MQGb72azzQ5sJA@mail.gmail.com>
 <38172c8e-d107-d96e-7292-09d0e3b061dd@gmail.com> <CALbLcfCHLU+zoFdTnTrJs22UUYwr2rETp5hqbv=NL352Qz-XgA@mail.gmail.com>
 <CALbLcfDZJmOyn-Gf24+9X-eHh3-3PY4_nP5soG3gHf_Vn85=EA@mail.gmail.com>
 <CALbLcfAiVgGi9iocEG4OfgET2XLDRq0dthbxDMP0vP3R6BBp_A@mail.gmail.com> <3ceecfc1-ab04-7d54-51bd-457a4708c0ac@gmail.com>
In-Reply-To: <3ceecfc1-ab04-7d54-51bd-457a4708c0ac@gmail.com>
From:   Artem Makhutov <artem.makhutov@gmail.com>
Date:   Thu, 20 Apr 2023 18:12:16 +0200
Message-ID: <CALbLcfCpb8xbN+w2VvCZ6Gdr+L_ECH0UQsWZrpO1Hcpoef66UQ@mail.gmail.com>
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

Am Do., 20. Apr. 2023 um 17:33 Uhr schrieb Bitterblue Smith
<rtl8821cerfe2@gmail.com>:
>
> On 20/04/2023 14:40, Artem Makhutov wrote:
> > Hi,
> >
> > I think that I have found the problem: It happens when rx_desc->rxht
> > == 1 - then the urb is 4 bytes shorter...
> >
>
> That's very interesting. So it has a problem with MCS rates
>
> According to Johannes Berg, the 8 bytes at the end of the working ping
> are the MIC, which mac80211 will strip. Of course mac80211 doesn't know
> that rtl8xxxu sometimes receives 4 bytes fewer.

The strange thing is that this issue does not appear with another
Logilink WL0151 connected to my home network... Here the MCS rates
work fine and I am always getting the full 8 bytes.

> What kind of encryption does the network have? Is it possible to try
> without any encryption?

It uses WPA1 + WPA2 right now. Before that we had WPA2 only and it was
exactly the same.
I also did a test without encryption before. As far as I remember I
was able to send larger packets, but the issue was still there.
I will redo the test without encryption to double check it.

> Another thing to try is software crypto, using this tested patch and
> the module parameter debug=0x8000:

Just tried it out. There was no change at all.

Any ideas?
