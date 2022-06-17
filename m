Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C551554F162
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jun 2022 09:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380268AbiFQHHb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jun 2022 03:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiFQHHa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jun 2022 03:07:30 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779516006C
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jun 2022 00:07:29 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y19so7025926ejq.6
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jun 2022 00:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=86I7shfTDSks9M7qk6fbp79Ueo4IhYjFHl3++T71OJc=;
        b=T1LmvwWM0sC5kioMr5NDh3cjIQPMU4kfWSQ667O9Ct19Cxqdi4k3u/jJ+iDwDxsUKu
         0nsTR9jtwCgos0MHIDiCg5sKd5Vx9HnTlhjmUjJkJeCWGd+H0nwUNlfAH8Er78z7dUE7
         8ko7X6jvghI7Lb4ArjlDxi1cS/8kj5GPswL3RF5IXG0NLu6bV4XafYnkY6s8Zn1gMGQP
         q+QDMnlGQfV71diLeyMl8E2qHgPO6NkcuIfBappADD0HpedFTQXqXcCqBlx8LaxkY5Vs
         C3hmlnUFy1rIvgtSvS6+6bsEY6Nfdaj6D5pN1l5FlH+FBikdDj9ODkTwaZDJCNcP309t
         gj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=86I7shfTDSks9M7qk6fbp79Ueo4IhYjFHl3++T71OJc=;
        b=m2DO+trN1bfDfG8iTE54Ty6zHCbj7YAtKVTTaTfsF6CotJSbxz++wQi+xGp7wnrcYy
         aDqd2VoykHWVjtwLg0DilMx/1oahb5ivS2ESiXA6D5dHdw1BUHPNMr8ZdRGeTp4A31v+
         tp5W4BhXIY8XYVQLf0gFPMIVEw8/nMEXrsPikJcYri6JYjNbdJ2F3n/QwjD9fkIl5EMn
         mfAwPh+Jh5UBZyj3JPyYojK+0Pnwz3NzAuP3FLVo7PdwEWe1vEThHKGEbJmKXF3RhZRg
         sceYTcMwptNO5UfxbNK9/G+hoFtS+/fr8p+s8BPw7/7Hmt2WgJGyrgNQHFfZ+CopiKEb
         kfaA==
X-Gm-Message-State: AJIora9mpDdWOgzUNjXMegq2+avyp6717InoWlh/ktHCxfVnNDmgP/Zy
        UisuFqyfpMf/zWqIkPIq06t/vC7fhLf6HH3F1Rc=
X-Google-Smtp-Source: AGRyM1tt4DyVNzrmbQ7MrY81bji9YhoTH0kkpdHpJINfK+psMeREzbYAAgKTJ7Wdh83QzReMNZz2VRBhRXEDYlg3iUQ=
X-Received: by 2002:a17:907:8b06:b0:711:e7f6:1728 with SMTP id
 sz6-20020a1709078b0600b00711e7f61728mr7804765ejc.32.1655449647747; Fri, 17
 Jun 2022 00:07:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:370e:0:0:0:0:0 with HTTP; Fri, 17 Jun 2022 00:07:27
 -0700 (PDT)
Reply-To: sgtkaylla202@gmail.com
From:   Kayla Manthey <malikwahabou@gmail.com>
Date:   Fri, 17 Jun 2022 07:07:27 +0000
Message-ID: <CAKGxY3_G+g2SMOyWgBQmBO5jdZb+_0-nV2CJ1WJiRBk8c0a-3Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
Hi dear, please, I want to know if you got my previous message, thanks
