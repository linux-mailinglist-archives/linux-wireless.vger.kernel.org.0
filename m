Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49362519B3A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 11:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346957AbiEDJPj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 05:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346734AbiEDJPj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 05:15:39 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F29A186C2
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 02:12:03 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id e15so414103qtp.3
        for <linux-wireless@vger.kernel.org>; Wed, 04 May 2022 02:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=Y6Pu9ZHhPRPO2SQkHFNWPpdwK5Yz0pvbAlMUZfrXeVPhag9zLX2xDdfaQp3EqMqgSt
         3zsJTwY//WM3PPp3z4sloNJLgDsg8pvs4apH9tBRTcugFsNM+HXpbawSATfm04SjYIti
         VljE27+syQUz3SxZJz8tBI+kFjx28bMwG8p5WwzU1+T3VTB7xyAg6/d/e50wTPsPSLvX
         /oAO8Sox12Oz/xVRzW2y2Ne6pDssJ+rlOsq0jiO0d7Rc0XB004/mXd3GnS6vbbXEwLRw
         f/nKSmBhfr/k75aoIlDgmk+aSHNBMtEwsTdj0QwV+e6zp+b9QZOs5t5rWYa3D7uhW/ZK
         aqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=cbXhTj9DVjgPmaF+XrNNGNpQSID3GFklOjiUjxKd7s0M4pNv+fHe2djG//IE36Wa+4
         ML7H8TuSkonAgJPfmzbipgOJVLj2MBQGD1VjwsFREKWdLJtu3MFSPW3Qkfb4Yc72wk0V
         6jmIoecxs2swJg5VBWZDi7GRcvyO5VlR0R5q8ZgLZR2A68z8uzpMYm9mi68kcWY5OxNG
         T9ul1Fp2IvJOLCdEltBT8NFJ9PzjGcfAdNhe/XbzACdYXiTMxWoFWUKczGN7rOVlqMO7
         e3+nO12JP+Zo7g4TxdnF0wmt0j4/YDCfDGEmN0QHTlT/5kmB8hD3VUqZKKCFff2anOzG
         XN8w==
X-Gm-Message-State: AOAM530XueJhyaDRxWi/MEXDFkPUsTGldmVM5+RurLphyeTP5Z7KblLX
        C1mU3V5lDVlja0Y1L6iuuvGoFG7Z3AJCebv+6Q==
X-Google-Smtp-Source: ABdhPJxHXSFJmWV2hiT/J6c6oDD2UorFrH2PXZSE6h7gO7MEGnrBOrAsFE+qxYb/cGRjrBRjI0zrJzzwRERa+NNir6c=
X-Received: by 2002:a05:622a:650:b0:2e1:e5cb:e47d with SMTP id
 a16-20020a05622a065000b002e1e5cbe47dmr18452003qtb.223.1651655522264; Wed, 04
 May 2022 02:12:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:622a:110e:0:0:0:0 with HTTP; Wed, 4 May 2022 02:12:01
 -0700 (PDT)
Reply-To: jub47823@gmail.com
From:   Julian Bikarm <philippesbilibri@gmail.com>
Date:   Wed, 4 May 2022 09:12:01 +0000
Message-ID: <CA+j1esNfg0BXG=cOf69ST4aze5A05gdAfgPUjr+hSmvH6Ec+Xw@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4105]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:832 listed in]
        [list.dnswl.org]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jub47823[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [philippesbilibri[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
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

Dear ,


Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.

Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Julian
