Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54E24F5F76
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 15:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbiDFNSu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 09:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiDFNRP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 09:17:15 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6449407E18
        for <linux-wireless@vger.kernel.org>; Tue,  5 Apr 2022 21:42:17 -0700 (PDT)
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 112153F85E
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 04:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1649220135;
        bh=Mt/wIr8VCHfxx+fAT86RPcS+1hpBF4cXlsZS+mb9xdE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=iUxOvNG6YajEHp0kF2JdMv/52tmbHq5DRlxwkH+QUcg186VpeTNqgoccW2JMMf2ji
         aP7tWesAOlh6pHj1OzkqU7c6smWgkFYBL7yBhaKMOSyJ14hbkhkW12sawK/pUvi7Yw
         lYgPqOYRWOwXz4ljmXdLj6ArCxWZ+cqnnqwBt/fjlN0sxSYvZMWiMVFqWPTN5xzDbP
         aWgYrLG1F/g7Uqala43Zwlised96gzeiFSPeobgq2uL7nOv3AR4ZI9/yfPLqI0XTel
         2IEpUtCd0CgjJ8eAp9bMLrQGmTyWbhivmr0TKSE1NZURD8wsmC2jbxiHGecGzS/Zi/
         WMzYmJUcOYaJg==
Received: by mail-ot1-f70.google.com with SMTP id n7-20020a9d4d07000000b005b2389a99cfso755462otf.17
        for <linux-wireless@vger.kernel.org>; Tue, 05 Apr 2022 21:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mt/wIr8VCHfxx+fAT86RPcS+1hpBF4cXlsZS+mb9xdE=;
        b=Wlq5rPNXMC/fgTGpdiYA2X/uA0SFgqPwdtKAp7c2epzHA18fg4/LopHw0g/Xef2XnI
         q6dAVUYR7l8wrn5ig3p8qrghMFxpaEZoAU5EGUVwHAC0yrgYyCGkLJnf3VpHb1j+Q9Qu
         e79RtWED30JnZUb6c1rXv6+h9GR8T79xzorFFYUnpYonblzxMo9eNEZ/ghS4r9022IBP
         Tmb1aP6/cZUeHs8ry+cQjvm0gmI0ONaGzbBt86Z5XlvqwdIDzrEHGquD2pBoRhVlPeIk
         BaZ5UBnRjtOkOXzeHOIvf9pjnUzDl+OHakAACXECj+F+YTlFg5+A8IFtFrgdEl6uTpgL
         f74Q==
X-Gm-Message-State: AOAM5322Sx0so6eBC2+a0DhByQ7aTGnt9JOxg/vnqdyFiZD8KWnCrjEp
        lzvApdqrWeAQ3gBX671tO21WqgsOc+c5DwTgAFVcmZELakdVQBk4qp6DwAM2pkYwNtsihWIYK55
        wCEkR/87un+jIhZeqqx4O3AMI0fshRYitfwGNsV3e5uLwb7CskJhM/soDGQrR
X-Received: by 2002:a05:6830:2456:b0:5ce:7f4:c702 with SMTP id x22-20020a056830245600b005ce07f4c702mr2472249otr.269.1649220130605;
        Tue, 05 Apr 2022 21:42:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHon0m0wisgENa7vRcxIQKSklrsxRLeAHmcisDb0KZ+faoRnPeYjrTDc6wEXCRXA5PMWMjLRWCaPLy2KtTmTE=
X-Received: by 2002:a05:6830:2456:b0:5ce:7f4:c702 with SMTP id
 x22-20020a056830245600b005ce07f4c702mr2472245otr.269.1649220130353; Tue, 05
 Apr 2022 21:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220325035735.4745-1-chris.chiu@canonical.com>
In-Reply-To: <20220325035735.4745-1-chris.chiu@canonical.com>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Wed, 6 Apr 2022 12:41:58 +0800
Message-ID: <CABTNMG2z33a6FgsBPbj=cFN9umVdhF8nXwsnVkkF--PYbeGS7Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] rtl8xxxu: Fill up more TX information
To:     kvalo@kernel.org, Jes.Sorensen@gmail.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     code@reto-schneider.ch, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Mar 25, 2022 at 11:57 AM Chris Chiu <chris.chiu@canonical.com> wrote:
>
> The antenna information is missing in rtl8xxxu and txrate is NULL
> in 8188cu and 8192cu. Fill up the missing information for iw
> commands.
>
> Chris Chiu (2):
>   rtl8xxxu: feed antenna information for cfg80211
>   rtl8xxxu: fill up txrate info for gen1 chips
>
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 104 +++++++++++++-----
>  1 file changed, 75 insertions(+), 29 deletions(-)
>
> --
> 2.25.1
>

Gentle ping. Any comment or suggestion is appreciated. Thanks
