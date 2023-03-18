Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739816BF8B5
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Mar 2023 08:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCRH6G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Mar 2023 03:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjCRH6F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Mar 2023 03:58:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDAF12CE2
        for <linux-wireless@vger.kernel.org>; Sat, 18 Mar 2023 00:58:02 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x13so28635873edd.1
        for <linux-wireless@vger.kernel.org>; Sat, 18 Mar 2023 00:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679126280;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crBvFPTTmOot3lcyYt4C5FmdGIzcS6MFUn4GTbWgHyc=;
        b=mg+WqLsW+K9z7O5xtyfNpU0L08bNSmyBtmL3srF5qeO6DAw6cWuqYmNqqAGAbDuC8p
         y0am5atSSz9ZuKxOTy37GMypaB8shbzx7fQML0L2R99BrTUkImqxS/n9JaobGap4QnTA
         zbKsgpaCxez9EMd4qXZe50dkBIrHNkdLzAS+RFdj1vmwUgEq1KK8cc5FLYnOSfBpYu3y
         8aLUf9+QXKby8Mb1fAmRyiwTwxgs4TxGIC9COW6+xF8dMkBriHgG+8UJu3T4Taq0AMF7
         RhQUGbXLJeTmjHiXEJoMzeV4l2ix4XvSUNHASFiLp197H4adS51nLbqT7UNV2ubmesIH
         5o6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679126280;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=crBvFPTTmOot3lcyYt4C5FmdGIzcS6MFUn4GTbWgHyc=;
        b=H9nxeXXwhorjdWZv48HP+u/CBOyeX9uOHf0v3r7kM+plYj2gXQOdpMlbOGXx4m14AB
         /kwSs0N7yzI5cwUUcvpq5Ob6IO/LIKsOG/ExS8+ZId7s6obbzGbvaywibtnEMAYuWOH0
         7+05JGgPmx0SX6wymWEcDCXe2c9Gq1nq85seDCG3Sa7pnHJgoheRJHaVuUintwkCDGKb
         K4cipObhTYVV+2gEIlqo1VJOsgcCwD6EZmYshXJQ6DaDqFCtVe/46xGpUO45SxQTUxGL
         L5Ov1ugS50ZTyGw6PLfFBgHIyEba5jBQ6glbPpH80be+Cfc0bla0pBKGFRkLr55Rdq7q
         M9mQ==
X-Gm-Message-State: AO0yUKUtZzFk/0yTt3BbihknXbAdH5cocCo1/I9jVPxuZrCW3Dgp9CBf
        GeEq7B9GcEOkS7ZFlsjtF1m/hvjyZJwOeim7wQM=
X-Google-Smtp-Source: AK7set+dGBMDCzcMH7lbYTby134LfKsTEaFw/oo3VTcmAus4S2/5eFvvPbCyArhSDIJcyutRoJqeyGexbDsrABurp1s=
X-Received: by 2002:a17:907:11cb:b0:932:fab:8a56 with SMTP id
 va11-20020a17090711cb00b009320fab8a56mr999086ejb.4.1679126280482; Sat, 18 Mar
 2023 00:58:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7412:d30e:b0:c3:1ff0:7d21 with HTTP; Sat, 18 Mar 2023
 00:57:59 -0700 (PDT)
Reply-To: enocvendor6777@gmail.com
From:   " Emirates National Oil Company (ENOC)" <jakubmarcin424@gmail.com>
Date:   Sat, 18 Mar 2023 00:57:59 -0700
Message-ID: <CABML6O5NtLOytuAuKujWD2Xh+v6AzfBz2zNgStvEycs_5vYg0g@mail.gmail.com>
Subject: Emirates National Oil Company (ENOC)
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jakubmarcin424[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jakubmarcin424[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [enocvendor6777[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We are inviting your esteemed company for vendor registration and
intending partners for Emirates National Oil Company (ENOC)
2023/2024 projects.
These projects are open for all companies around the world, if you
have intention to participate in the process,
please confirm your interest by contacting us through our official
email address  project-ae@enocvendor-ea.com
We appreciate your interest in this invitation, and look forward to
your early response.
MR. Nasir Khalid
Senior Project Manager
