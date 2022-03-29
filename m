Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BBF4EB5E3
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Mar 2022 00:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbiC2WbG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Mar 2022 18:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbiC2WbD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Mar 2022 18:31:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E16340E9
        for <linux-wireless@vger.kernel.org>; Tue, 29 Mar 2022 15:29:19 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m30so26810444wrb.1
        for <linux-wireless@vger.kernel.org>; Tue, 29 Mar 2022 15:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=KUrvgG8Hj4Oi4ofJnOcrlqCgL0ZdNDAP3sS90sQascYxaAAZTQyQgS1ngSbJaMET/B
         sdYj53lRNjMbBjHl8niUK9LDMidlgj9+soINNKRmiOmfTjbm8cUSj/bTpxlZ/pCjay2o
         by6YlnUh2iUEpk9dg2R8EHHXJPhx89svOhwGABM23sYZ7ldbO8SBYydNspaGlhEzqbYq
         Vv8jAA6VeS6H+NTznzDsRz87a8iRyEdEKZO+zFVyH06rMhRPUzED8AKe8VI26xktvrGY
         VOURA1mBEo2d8Pq0u18k+nBA75ZltzxqPs/Xd7Jx+OQlw208yJPbJGwdtLlSlqLlNZB+
         j/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=dsNk3iPVbbsXTAFrs3JKXnQcljeT+qvU7PYUk1saKAnDoBWtStXRtBFyhAQRC2xa58
         X7u2KNR6RHDk9AqWq3bFbsyQGzkj+QidtJXH+etukQFw2k16ZVne2ydygQvLjd/3uUaC
         RNJcsQBQWVAA+JZdF7EHjMUHXpuwkZC7C/l/fnqMShifBCAuqBxm7BxQCLcOxBxS9Ups
         tGrqiJvp9jcMcHDd7E63rwq8Uu4mH/z2eLlqth5NPzcHgDGgPkREi4Y9FZi6K72L+7MP
         pQGfgpIb01JzrHEBl4zeK6QjVYCzlhWXvms+FntBL9ppaG5ceDhOe6hsDtu6Q3ElBcQY
         9wPg==
X-Gm-Message-State: AOAM532y11k1pOOZpOuMtIQXxym3WxafZ/covbiyhJ/TbB+yS+7/GVy7
        CzmXGJTY7qUzJ+bUx97M+aA=
X-Google-Smtp-Source: ABdhPJyMC8U+My0DAQPNLjU0UMI/o27Syg3QpoUXKunFqLNAsAWtIsouAh0hLUqzieLfYd/T76xWFQ==
X-Received: by 2002:a5d:6d86:0:b0:204:111f:17df with SMTP id l6-20020a5d6d86000000b00204111f17dfmr34147910wrs.498.1648592957933;
        Tue, 29 Mar 2022 15:29:17 -0700 (PDT)
Received: from [172.20.10.4] ([102.91.4.187])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d48d0000000b00205cf199abcsm2851970wrs.46.2022.03.29.15.29.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2022 15:29:16 -0700 (PDT)
Message-ID: <6243883c.1c69fb81.a7286.bcbe@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Gefeliciteerd, er is geld aan je gedoneerd
To:     Recipients <adeboyejofolashade55@gmail.com>
From:   adeboyejofolashade55@gmail.com
Date:   Tue, 29 Mar 2022 23:29:09 +0100
Reply-To: mike.weirsky.foundation003@gmail.com
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_US_DOLLARS_3 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Beste begunstigde,

 Je hebt een liefdadigheidsdonatie van ($ 10.000.000,00) van Mr. Mike Weirs=
ky, een winnaar van een powerball-jackpotloterij van $ 273 miljoen.  Ik don=
eer aan 5 willekeurige personen als je deze e-mail ontvangt, dan is je e-ma=
il geselecteerd na een spin-ball. Ik heb vrijwillig besloten om het bedrag =
van $ 10 miljoen USD aan jou te doneren als een van de geselecteerde 5, om =
mijn winst te verifi=EBren
 =

  Vriendelijk antwoord op: mike.weirsky.foundation003@gmail.com
 Voor uw claim.
