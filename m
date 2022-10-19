Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EB3605078
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Oct 2022 21:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJSTdI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Oct 2022 15:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJSTdH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Oct 2022 15:33:07 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4F217C57B
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 12:33:06 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id j21so11403072qkk.9
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 12:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJ2NTFSuwbgn1shPsMG7t3f98JKsP5lqwb6cWvxUrKw=;
        b=e3LAO5ot+HYIuwH0oRwF1V2m7tObsRqAmwWJKj2lV+5X7rJpebsfPCuW/9q+0LHvaG
         fo+htkvCP8vFQ/xzXPEpiAYcsQTpcJNyZ4D4yNlR0xqWgnIVvdVDA5oxZjUTDwz7Tk78
         FmPvPGChc5JmiBovjyfeDpm6jvUuWq5r5r/ncUmKE/kptrKnR19LQ7etW3sjLZa8tkw7
         GRO0MBwyV94L57OtHqaMqElvHabz6pJ/+pUA2XK69+8tvORro+jx64sAjJrqABf+sPmo
         AMS78x78tgqL6ypMK6yEbTwAwXOtPSk7JX511PaQrr+M4oUeubeP6hd2utb3+NND36Tx
         qtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJ2NTFSuwbgn1shPsMG7t3f98JKsP5lqwb6cWvxUrKw=;
        b=AasYSrqy//TnQBJABLQ8CDkOB3LJ96ntf46n8RRmq358exsimH67YPqvGxU9dp/jQW
         ixa7hC6uR1cwwrjwrRsHN0+I1cSCcVOu9EfHnjhGwENKdny6f5hvyM4vGQQP9wmfj4KM
         YW+aTGP8CTXrMkHWiuC1qHVGWmc8QrPOOxS2FAHNh3noZn2Cddcdvo18H1g45FMY8IGw
         LDr4DH59ljWdeyaILdm1Z0ZESbFO2WWuPEXmMiu8aljMYPeWcQKsT0mLnDxOA0rg9F+E
         6ZNa3rWKmuMt8dTjjKfVgkPh/3TBCW9Xor5HGv8acIUkByu6aDPdA53iGy8IVDAe4E2s
         SuUg==
X-Gm-Message-State: ACrzQf0ZfglmBpHS6wW6pfWvBiMl7w6hDAA8skcx4pUw5S7eIv2v9ira
        IB36gJ5WZU5m2JepDT8cQara0batoFCPpMWrLW4=
X-Google-Smtp-Source: AMsMyM76YvQyTs9c4i7CSg9irdFoy3BQcM2tm7UFaoxshsz/JrrHP89BBPvpUbgzwBe3AzU5Z4yAYWdTVqzsqPM/chI=
X-Received: by 2002:a37:c11:0:b0:6ee:b25a:2573 with SMTP id
 17-20020a370c11000000b006eeb25a2573mr6609942qkm.297.1666207985290; Wed, 19
 Oct 2022 12:33:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:620a:31a7:0:0:0:0 with HTTP; Wed, 19 Oct 2022 12:33:04
 -0700 (PDT)
Reply-To: mr.rwilson11@gmail.com
From:   Richard Wilson <wilson1247richard@gmail.com>
Date:   Wed, 19 Oct 2022 19:33:04 +0000
Message-ID: <CAPMufH7-iDUH96COV2SuEXjShBUHQdhL8CoFU_Zp564OA3TOnA@mail.gmail.com>
Subject: Deposit
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
Dear
I am contacting you to assist retrieve his huge deposit Mr. Alexander
left in the bank before its get confiscated by the bank. Get back to
me for more detail's
Barr's Richard Wilson
