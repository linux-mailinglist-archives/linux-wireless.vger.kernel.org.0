Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FB659ABF0
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Aug 2022 09:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244652AbiHTHKw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Aug 2022 03:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244217AbiHTHKv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Aug 2022 03:10:51 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90E6193EA
        for <linux-wireless@vger.kernel.org>; Sat, 20 Aug 2022 00:10:48 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so3468633wms.0
        for <linux-wireless@vger.kernel.org>; Sat, 20 Aug 2022 00:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc;
        bh=MUPE+WCKiaoxRAdnteR3TsIHrvUD8FAr/F1eBQt4pX0=;
        b=RmJ7b8MC+rqO0CIIgYxCkd7olw/2AXA19n3ITt/aA8+ozMl8iCKgk86hr8S4vZ8cY3
         yy9UIpw8VtTB1L05ruemmo+7XSZw6GMW0MctDzuKviod9dpMzRO5J58quO2ZpaYfcTzI
         dHu7xNL4QP01IAtdvz9zccnzXvNnOtGOw7No0cfsXp9RFu/rNObCdWzov6WouSbQXjSZ
         AdFIpC5naZwF1+PzJAwo+UvihDqI4FYpvntk0t9yuYBqWZrtgUYsWbndgerPg5NpcSEe
         RihFAY8DvdXNT+Z6iZ0zwJGgBKhPOK7/qGfcd6ibMdCnDnY1mVybT/BhhK5KjjEggZva
         zyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=MUPE+WCKiaoxRAdnteR3TsIHrvUD8FAr/F1eBQt4pX0=;
        b=oqH5bB3uxVHkXN6ntKDYGsxHWlHOhINofTAlRPBTZEcYvV5S2aBcYpxjs5Kr+dNmNA
         TKXvshys2HW16qpBXXumXBlb0tvrKNOl0aA8N/kkJW79uNrbZ6S0KeYyyzoSrc4WUDn7
         I1FE7GlL+L5KfU/sFOnVLqPA2IzWATrhBbwf+dcuDSyeaddjDjhf1PQJuhcHYqLmxyyS
         cXwMHhOgH8j2Y1TBlQoFdw0B+D4FFPdNJ6QQjZ1uDg1UWLf8S9QQHBv5oG1eVkBmb+42
         cmJkEKiRwhmylHJj7FSzVMgoExKlNF+Of8K3kHXVAWFxZd7g5MK2NchEvqdDa/wbl0V1
         tlWw==
X-Gm-Message-State: ACgBeo3niBK5KfjkIS/UaWnxPEln52r0OPPy522ffQi0fbL84BBn2mQO
        fWwqtMernK/RQ8f5hpAvcNufhCUTJ4HbjS/u3aM=
X-Google-Smtp-Source: AA6agR7Lo+hexuadG1nYCtDeicdLk1KVDAf5iVke+jZzHkasVnrNBgPu/ahecUwf1/3glneagKJgwlU/Vf6lJ5goIE8=
X-Received: by 2002:a7b:c046:0:b0:3a5:ff4e:5531 with SMTP id
 u6-20020a7bc046000000b003a5ff4e5531mr9757197wmc.104.1660979447295; Sat, 20
 Aug 2022 00:10:47 -0700 (PDT)
MIME-Version: 1.0
Reply-To: jerrydosso1@hotmail.com
Sender: udoeze160@gmail.com
Received: by 2002:a5d:5887:0:0:0:0:0 with HTTP; Sat, 20 Aug 2022 00:10:46
 -0700 (PDT)
From:   Jerry Dosso <jerrydosso55@gmail.com>
Date:   Sat, 20 Aug 2022 09:10:46 +0200
X-Google-Sender-Auth: dLCGyfvttlDsVZBGYwiFpaWy3xM
Message-ID: <CAG0PvUCnnpQoq6iSKz66taaY0ZmPR83zd8Ewvwa1unxrcEfZxw@mail.gmail.com>
Subject: Mr Jerry Dosso
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:32b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5062]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [udoeze160[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jerrydosso55[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jerrydosso1[at]hotmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
My Dear Friend,

Did you receive the message i sent to you?

Regards,

Mr Jerry Dosso
