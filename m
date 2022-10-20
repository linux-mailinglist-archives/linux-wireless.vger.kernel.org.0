Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D93605B87
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Oct 2022 11:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJTJv5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Oct 2022 05:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiJTJvz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Oct 2022 05:51:55 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9CE12B366
        for <linux-wireless@vger.kernel.org>; Thu, 20 Oct 2022 02:51:53 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id d18-20020a05683025d200b00661c6f1b6a4so11079668otu.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Oct 2022 02:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dbpyx+08KYdYeE8bMSeJWR+hSg6Oxt5p1wv31GmIIqo=;
        b=N4mJtkFjhfPnq+G5qYUDpzmozEOm8Yrr9P/QOkTAFHlFmG9uNCVnGmiu4xyizFpUvf
         CnoIDxbE/Ez5XgL3fQxCoXNTGVoAOKyw7moO01AMjNNU19N6lJ7wKtZVDS2zzO6+urlx
         Jhv0V8ek9I6Es+i89S8UtQj9b7r8h2Pk1FSgGpbgE7zoOzDwNzhcUanq7J2o1r06OFV2
         XtoDlLY3agDCykbxNOvWeGQSRN8UtHap0ISmse8KEEej4iaGNXu3ArTsrWMsx6iswLuJ
         1KV910H5ls0rU4HNHFpulRddYpnKBZ3jugn3sM47h42yJIC1dWi/tyCLOCTT/i+7OGWa
         DIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dbpyx+08KYdYeE8bMSeJWR+hSg6Oxt5p1wv31GmIIqo=;
        b=LfNkVTLCTIRxn83PDODXg7OMAkK4qMqo9tWbtqqrzvnr6tJzgc3ZnfTMzexir1AyfN
         wuynp7ohIaFWGkbEDrJ8V14yDwqfRrF4v/Jo2gLmO74lgQ6wF2HXxKc0fpgQt5/sLBmp
         ek+wzDRhOeUQK5CqNV5UzAGE+sn2YT6TfwCClfdoDu0Ix2AGZKz+MhUFdb/YU3jw3XNo
         4s+iplWP/5NK0M8tVp4NvSP4RChkAkE95N42WEe3+cLophx5Ca0BaJ1W3noR76k8bCaH
         qcwg0Np1DHkgWRigSiokIpESQZgyht1b6UaBsryQ6J3q2E2DePpxTl2cj+qdeEg8v915
         AOpQ==
X-Gm-Message-State: ACrzQf2zI29zdlnXb+sNYgbr+KXQTictKfV14X/Tur8TFvD6ge8P/mw5
        I4hmcBe3SsojoYpU/gPEEJyb1gM2yzIMjcpTlvA=
X-Google-Smtp-Source: AMsMyM6eJu2yc9xxGYANojjQ1f1PuvSNc/ka8EMyXvU1H+GzC5WBjKrdrkb+U7OyzMEsFcD+QyGdU7lXJ1E7GwYigtM=
X-Received: by 2002:a05:6830:2789:b0:661:9c8d:9d1a with SMTP id
 x9-20020a056830278900b006619c8d9d1amr6729066otu.249.1666259512042; Thu, 20
 Oct 2022 02:51:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:c07:b0:cb:a6e1:efb7 with HTTP; Thu, 20 Oct 2022
 02:51:51 -0700 (PDT)
Reply-To: nikkifenton770@gmail.com
From:   Nikki Fenton <jjdriif@gmail.com>
Date:   Thu, 20 Oct 2022 11:51:51 +0200
Message-ID: <CAGfKr0Y1ARnLGFFgfN2T58fo_5tdjgMXnhP0owb-RNasOsTZ7A@mail.gmail.com>
Subject: Kindly Reply Back urgently
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:341 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jjdriif[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [nikkifenton770[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Good Day To You,
I hope my message meets you well. I'm contacting you regarding a
proposal that has something in common with you, kindly reply back on
my private email: nikkifenton770@gmail.com for more details for your
perusal,

Regard
Nikki Fenton
nikkifenton770@gmail.com
