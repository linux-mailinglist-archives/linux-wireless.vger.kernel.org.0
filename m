Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141065EC4D0
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 15:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiI0Noq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Sep 2022 09:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiI0Non (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Sep 2022 09:44:43 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCC04A103
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 06:44:42 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id i3so6020939qkl.3
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 06:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=oxo7cHKcifyhAmJbZ4Y+PabLYourh+9AJXd5kPcGpr4eMnMN6Bx9c25/uXRgrvs5EC
         K0QmlSa9Tz956xKGdTLesHLLXY8oeFYEaIrotDQnjd9+HyQhIuiVUH54fJGhiWElf7gm
         2ulSBP9DS5qbfK0jZi6IpMN2NDi/dDANJgsWNcKN50UstHw1FsGL24eLRNHxsKYdNlFv
         vy6n9nk+g0RsBlOrJHEu+PLg4Hcq1E+ZH5AXajFcyVFCPjhuxcC1mDewmaZim2Aiuqyu
         ebvtGYXoyjmeMyJm8aX3IKhZDzI2Mp6boytLxoPF1kixEkmgjHCRj4yzWTPaPb7rkAAO
         Sq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=UIml55Bh+lVed7nqPdd6nat3eHrgEQGjVKoay7nCOvSfJSiE4YIcV62Hb/JpAJJrYB
         7Tb5TUUBkN7T1keNXkdEefFFQXw7yMRfjplG+f/uMwTUjX6jYbBgx8vLA116La6jbhWZ
         DpgVYJ/H/FIaImlFwy5yNqUxyYjoV3G/3Dj7EFlHal2kfpuCDPmpk6C2bAxXe+lNGT9/
         ZknbfPCP3X9CNv4QAiCopv+IR/70KeSycTJ+QC+T9n3FF1fX0sfH4GvMuPWDFzvTdvgW
         ex76ABl7QY4Dxfvy+dkhvVaMG2dPCOg08SowenvL3S9WkIyEIjUlRa/GgKVUJBuwR7OB
         ENCA==
X-Gm-Message-State: ACrzQf0ZPoPegeZzKyfWzG2c+cTjlzazuw7lde4nA3SPqOXoy6ww+KT+
        /CoJ06VtyYfvBj3hffoMu1K5nqaWn6/osNzmgaM=
X-Google-Smtp-Source: AMsMyM7KXiGgPm2R/U9BM/atMjXuiKBJet4S0Cszz8YR13+NeqJOQrqLXJpDWrEQoP67Ngu+NQCqmz9YjwOQDyAJvYk=
X-Received: by 2002:a05:620a:2805:b0:6bc:5d4a:9618 with SMTP id
 f5-20020a05620a280500b006bc5d4a9618mr18454119qkp.116.1664286281523; Tue, 27
 Sep 2022 06:44:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:622a:38e:0:0:0:0 with HTTP; Tue, 27 Sep 2022 06:44:41
 -0700 (PDT)
Reply-To: kl145177@gmail.com
From:   Ken Lawson <davidwolfgang046@gmail.com>
Date:   Tue, 27 Sep 2022 13:44:41 +0000
Message-ID: <CAFGUgZvrHszEn8K+gzKYKZeTwLSGKp3e+2cD_fSN7paxpBPpOA@mail.gmail.com>
Subject: =?UTF-8?Q?Modtog_du_den_e=2Dmail=2C_jeg_sendte_til_dig_i_g=C3=A5r_morg?=
        =?UTF-8?Q?es?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:733 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4968]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [kl145177[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [davidwolfgang046[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [davidwolfgang046[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


