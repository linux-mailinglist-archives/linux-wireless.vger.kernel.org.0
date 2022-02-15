Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FF94B6DCB
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Feb 2022 14:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbiBONlM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Feb 2022 08:41:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiBONlM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Feb 2022 08:41:12 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CED6E8F6
        for <linux-wireless@vger.kernel.org>; Tue, 15 Feb 2022 05:41:02 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id ay7so20727527oib.8
        for <linux-wireless@vger.kernel.org>; Tue, 15 Feb 2022 05:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=5g4e3FoDZ04w3yN9r9/DrAhXMgzBOA3m1TJsZRCqpfs=;
        b=iwKWjwBv8UenF/T4JA+RKc+eHrfU+G65tx/isWRmIK1+OkRGf0xrLlW8LNgkeIoYgM
         1yg8NyPboJUda08AioEj5OgGSUvDL7Ahi3v4BDkLsKGlCyQHmk1qkLfdSXSIX4qZTV+T
         aUli6KIoce8WkyXnXhbyIcvdxuF57RYpOdLKA1p50Gfh8glVKOKV+qTmXsvp2F6MvxCZ
         06cfYud4PkxQNkJ0I+6PqaRTi1fh8erwAYSP3rW6fyPP92lwQvi2nVwTxJFTPFKA3Lpr
         hmzpA1zOWNJZn0GGnsiztq1vVlyMyW7xciFpjYlyHlN55E9z/d7lkqZ72KF/ScJbDMX8
         s/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=5g4e3FoDZ04w3yN9r9/DrAhXMgzBOA3m1TJsZRCqpfs=;
        b=NI95eEO7lO9Jpmawg9Xc+9iu3/SD/9gkcZD01bvkLgyHK9hJYYzJiboXW89Iu4fkrQ
         bTB8WZH1d9LvSzRoIwuQXXQdzZjMftbw6T5JnidGsLZ8Fw33iV93YYbD7TEvZSif3HHj
         +aUXJJf4JvGr5XQTQ3k2MKd0m9RlSpZCXdiJ5RzJDIcNqM6olraMNqkFgotWPkak+4Rd
         4fjD0miIirarCutDBPIfLWzPBNW2m1F8p3b5KrcyA2bdOnBGPdm1JBZqVMzMaK+Lp0xP
         JliCyX1jmAnCdsyK5jMWdLXLFSbDJam2nIcO2/f3qcXjjqSKPTKCUqMW6q/GRZeXX4sQ
         3WPA==
X-Gm-Message-State: AOAM530mA0y/bcaLa0Nv1ZeH6lX+yYaeuwLxmDfntcIrAYeZFNb975Zq
        f4897DA2uNBsiDTIEMNJnT8NdwXkoDjeDj9dZfw=
X-Google-Smtp-Source: ABdhPJyWRUchNnETanlceUFVSM+//3CoNYVUQV5e3K2b35V74eO5WfWCdu96Wx315BSvRwGVYKw6Suc13S/h6bYLXSA=
X-Received: by 2002:a05:6808:238f:b0:2ce:df34:1812 with SMTP id
 bp15-20020a056808238f00b002cedf341812mr1570727oib.147.1644932461841; Tue, 15
 Feb 2022 05:41:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6838:588b:0:0:0:0 with HTTP; Tue, 15 Feb 2022 05:41:01
 -0800 (PST)
Reply-To: michellegoodman035@gmail.com
From:   Shayma <shaymamarwan07@gmail.com>
Date:   Tue, 15 Feb 2022 13:41:01 +0000
Message-ID: <CAAgEbkmeqteQNdTczE_=srqm5raRDbsL0XoyinNdJLQk6zHdPQ@mail.gmail.com>
Subject: Halllo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:22c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michellegoodman035[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [shaymamarwan07[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [shaymamarwan07[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hallo, ich hoffe du hast meine Nachricht erhalten.
Ich brauche schnelle Antworten

Danke.
Michelle
