Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094065849CB
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Jul 2022 04:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiG2Ccd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jul 2022 22:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiG2Ccc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jul 2022 22:32:32 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EE17AC13
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 19:32:30 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id v22so1653490vkc.6
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 19:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc;
        bh=+D1zF2DCKf5WB+zgoPewh33B5r7wz0pan/6d9WW6hok=;
        b=Fm0ShrdIsrBUriJRwckvrscm21bcMQ2hft2jZxhYYVnluqU14oEMxx5Q32rqA5nHON
         ge7kkHbXf4ycYanpxO/eYpkuXpFmqfjhhHgzGpc6UM4DvAhcNP2Um9YHSL8hIt/S3Yma
         Pc7aAeDZly/dYE2gJ2gQRLSLCZF+UgCFKWqHUUER/GpWiHieskrwlZOhDJ2vv8EjnITM
         gRM8bnUc7xxKaAlfk+5q0fZZqrZ3ONmxY+7YGyddkIPIljCc7T6p72ZHEMo8VUTkBu/5
         GIqqd7R7ww+IqXdp2iBCe8PGY1bTvn2vo13F9I36aCrRbTFSQjweDW18/ziUcHXzBBO4
         barA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=+D1zF2DCKf5WB+zgoPewh33B5r7wz0pan/6d9WW6hok=;
        b=4Hi4TwafY/kIytTphW3kqQIFB/cKu7ZQ7Q53rMpNOVX/GWEgaX1vEvxh04HTTXXJid
         2tBm0qhjnrnMZ8tKVIDp/SOYjURPFK9+Wy0Pz05SCA0oY+kqU0cPnJ20vi6GtSbb+JVw
         ygxQaH+GoiKJd78yzanTVmeMDTFxNXjed+q+IXlfubQuRtQdxy3ICjsJBNck8g0c7cbV
         FSFPCEDB2hqeFxCrri/rQC8MSzqbUJbrw+/NxA26w5Q4lMwWdJCiw9E593i9kCgWct3S
         5w2nzui0AbOjAdffoB3Ppa9dFzzDymUnpMRxd8FvXTdpZzRNZhPqO07n4dOBHWFWSihe
         V3MQ==
X-Gm-Message-State: AJIora+3DBtpDKvkuY6zG1RhgvOJh69Js2DR0BXrxqeRG8/AVDkTbgtU
        1Hx+2kPNGO77K20z7+D5rpbUInfA1I5byd7K8oE=
X-Google-Smtp-Source: AGRyM1uVuOxtqXCcJHdFNTL7J8JWVFeTI0EJ9PpAYDRKrh1A4xhrUQr5c4iAQX9fIxIl6Fbm4hdRrwhvmSx09Ci9FuY=
X-Received: by 2002:ac5:c916:0:b0:376:f130:808f with SMTP id
 t22-20020ac5c916000000b00376f130808fmr482675vkl.19.1659061949751; Thu, 28 Jul
 2022 19:32:29 -0700 (PDT)
MIME-Version: 1.0
Reply-To: edmondpamela60@gmail.com
Sender: phillipcannon202@gmail.com
Received: by 2002:a05:6102:3137:0:0:0:0 with HTTP; Thu, 28 Jul 2022 19:32:29
 -0700 (PDT)
From:   Pamela Edmond <edmondpamela60@gmail.com>
Date:   Fri, 29 Jul 2022 02:32:29 +0000
X-Google-Sender-Auth: Cz3O2f5ibF9eShpRLPRwIaG6SR4
Message-ID: <CANLyv5hzW684Q0BecHTrMvemqN+LQPxp8u8LnSKAsiTqVNny-g@mail.gmail.com>
Subject: It concern Ukraine and Russian issue
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Good afternoon!

Recently I have forwarded you a necessary documentation.

Have you already seen it?
