Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A916866574C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jan 2023 10:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbjAKJVt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Jan 2023 04:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238303AbjAKJV2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Jan 2023 04:21:28 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C1F60C1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jan 2023 01:21:25 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o13so11759306pjg.2
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jan 2023 01:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BDAYJ0rba9Lt9b0XJjJxh+A0UhRZ127T1rCwiGZHjnc=;
        b=x2XQxLUwZR2yYsRMaInf7HWF92ZLD+A8Ta/XpfOy9ltRTG81C6B4t3CzTcmvP7jz3/
         lWh6f2dtGJ219/jUuv2iH7m/U4NGBjFHzp4071AJBOgyXRI1ViS2OKfAS8IL4VqJH41J
         Sy8z6MGyzL59k+PLtxV0hmjP4lkCDie1EJO1VFeVSeJqtTm1ierzThCCy4zhfPI1bJJq
         WFxrtIqvv7HqOo8fSEqABusv8jmYDrsdBNamTK0v9HWaNAQhTdj17J1A/NH1zrh3/0Vf
         IZODWNH23nkOj9DJvhqo5rr6LJGyKBZnO2cbdGaE+ivTzuOeqxf0C3NlLLut3Tsm9Dtq
         uu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDAYJ0rba9Lt9b0XJjJxh+A0UhRZ127T1rCwiGZHjnc=;
        b=4tnGTuF+RgtwFcI4yCrzpL0hnvDTwDHLmRbRNIuE/VkKpDX75/wrbeM1/BbtgeGKq2
         lILiEkMl8tjwAkfTcwKazaBxjbwoGOZ2GUCUMUX4o0If3/N9ID6bhzkbkyZmTwRyw2O3
         oE/Fw1xikmPI9Hdm8Ab8pZEqkrNzGEA3akl1cU/QwjQWKarcY2lRyACnPu3jYjOVI0zq
         NXwOnnPVHYe1wY634gi+YCt3xc5+cWzNjNQas072dYxKMPHAofuG2RB9wt0BDPRQCOvy
         73yXS5Ae8d6oIKlVrPihdQDmMaZH5VivypTX8GzPQ9JSAb1SgY2F+g1d4IC3fkjj/lS/
         Q8gg==
X-Gm-Message-State: AFqh2kpvSaooKi3XyAmtBGWowRhrdoo+vaNGuk6kN2tSmS4uYm7ZnB9E
        6syyp8DqUxDDRewozKj2T6dYcqdutTNxs28h+fmhGg==
X-Google-Smtp-Source: AMrXdXs1BfLQg12NC/c7gfJ2HOmIPIiSva1z4dPZByoL2IWMaM3TOIFUfRduiYyr0b0soYPNL3Jt1Ey8jdQq4xjQLaw=
X-Received: by 2002:a17:90b:48cf:b0:226:164f:522e with SMTP id
 li15-20020a17090b48cf00b00226164f522emr3628516pjb.22.1673428885353; Wed, 11
 Jan 2023 01:21:25 -0800 (PST)
MIME-Version: 1.0
References: <20221105194943.826847-1-robimarko@gmail.com> <20221105194943.826847-2-robimarko@gmail.com>
 <20221107174727.GA7535@thinkpad> <87cz9xcqbd.fsf@kernel.org>
 <877czn8c2n.fsf@kernel.org> <CA+HBbNFCFtJwzN=6SCsWnDmAjPkmxE4guH1RrLc+-HByLcVVXA@mail.gmail.com>
 <87k02jzgkz.fsf@kernel.org>
In-Reply-To: <87k02jzgkz.fsf@kernel.org>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Wed, 11 Jan 2023 10:21:14 +0100
Message-ID: <CA+HBbNHi0zTeV0DRmwLjZu+XzUQEZQNnSpBMeQeUPiBu3v-2BQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] wifi: ath11k: use unique QRTR instance ID
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Robert Marko <robimarko@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        gregkh@linuxfoundation.org, elder@linaro.org,
        hemantk@codeaurora.org, quic_jhugo@quicinc.com,
        quic_qianyu@quicinc.com, bbhatt@codeaurora.org,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, ansuelsmth@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Really sorry, I just didn't manage to get this finalised due to other
> stuff and now I'm leaving for a two week vacation :(

Any news regarding this, I have a PR for ipq807x support in OpenWrt
and the current workaround for supporting AHB + PCI or multiple PCI
cards is breaking cards like QCA6390 which are obviously really
popular.

Regards,
Robert
-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
