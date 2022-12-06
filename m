Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F1F6445B0
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 15:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbiLFObn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Dec 2022 09:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiLFObl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Dec 2022 09:31:41 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0611EC6C
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 06:31:40 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so14931321pjd.5
        for <linux-wireless@vger.kernel.org>; Tue, 06 Dec 2022 06:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NgRHXVnEISkXMqWfVgd9bPaNDbTrsT8BuxpGskPtjc=;
        b=g7lBWEAJmE0JjBe6hm+lSm7BghYfVMeyFQfSvq9vq1u2jz0GQXRSziPzQLER19i+IU
         1AO/Qa6fpSlg0KCChA80ohn57gXhGy31XBfW2AfxDH11lOaJD/nYQAzDa6yx14nm6DA4
         PGQqfx/jZHR3RFFJbc6Vxn+gNPZ3jfOj7K9WIfn5Jnh6Q1zvpnrqCBdwviDs12NRL5zN
         4h9Dfp9Io/8xw4RBgHyN4ZOyAm4Lr04/JQjwgqL0NX1M9eVNnVaAgEFBBdxfIZA49s0P
         CT3fVi676G6cfrm3pr1wqtcCsp3raL9wTVZ56bqheY0qE646XRsugCfApZaxeYNdPX1p
         j8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7NgRHXVnEISkXMqWfVgd9bPaNDbTrsT8BuxpGskPtjc=;
        b=IuhMQyibsHmeeiKP5fVzdkf/lKh7st2XPDFwmTOvR71IbaJVQJq3ej4xgEihnWOzUv
         XpMeO7J/O2JBfmxKJB/N+xB5acSrYMAnknz3gwlbSTYhGTRgtBJmS7ioxdeGDUmKlyEW
         GLXs5OVf/OpYKT6SPfaqyBp072kS9B/Ov8KZloganbdQD+pUljrEjVa/p96U+tOxa9Gg
         ssMr3TDGNpCNjNJr35SvdPKtgtEJ1RtgpIIWGPbfg3yEdqdnVUljoqiCCeFdn4Z3ALJY
         1swiSnXJJdJ2s3ez6H8ferRPdZnWveAc6NA7YtxFsDjG5YD8ZVN9K0EBDXAldmblN7LY
         KLlQ==
X-Gm-Message-State: ANoB5pndQyEPc7ktfhh60ghB/40fW6uHxDNsG6X4nPk0zzNMv2vt5wqX
        Avf59sGfOGZI8ElR1uQEsANkkYO494PUc2Ooctg=
X-Google-Smtp-Source: AA0mqf6BRhWXBHfzTDbS9mopIbxoUO8hPLYvU42aOT2o+y3L/vkFfjqc5Y53Hu5wRK7hq3XFSUuhIxHGA1vXDA9+oAo=
X-Received: by 2002:a17:902:e0cd:b0:189:b0a3:cf49 with SMTP id
 e13-20020a170902e0cd00b00189b0a3cf49mr27204334pla.77.1670337100050; Tue, 06
 Dec 2022 06:31:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7300:b90f:b0:89:8a1b:3aa2 with HTTP; Tue, 6 Dec 2022
 06:31:39 -0800 (PST)
Reply-To: halabighina00@gmail.com
From:   Ghina Halabi <hidayatoumoussa11@gmail.com>
Date:   Tue, 6 Dec 2022 14:31:39 +0000
Message-ID: <CABCvUkj0DNmnsxyag09okdchNGy4ZXB0sJ28eJNwKeEpqJTFAQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
Hello good day,I am happy to be together with you, My name is Ghina
Halabi, I am a military nurse working with  Israeli defense force.
Please don't let my profession, race or nationality enter your mind,
there is something very important which I would like us to discuss.Can
we talk about friendship and partnership? please if you really want to
have a good and prosperous communication with me please kindly respond
to me positively.
