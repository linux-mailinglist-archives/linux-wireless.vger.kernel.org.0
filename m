Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92E64EAD91
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Mar 2022 14:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbiC2Mtk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Mar 2022 08:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237324AbiC2Msm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Mar 2022 08:48:42 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E77262D4F
        for <linux-wireless@vger.kernel.org>; Tue, 29 Mar 2022 05:43:49 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id k21so30068340lfe.4
        for <linux-wireless@vger.kernel.org>; Tue, 29 Mar 2022 05:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=VSEH8Q3Lr+Mcr/0lsL1VFPftJp7ALZ21MKYEz4sry74=;
        b=NTbtfhXGLJZuqfIpqw2fsty7MoqTSC5+GeJXCCWn8ADDh5Qe8ZM6bZXN6VlL2kbXm7
         TIo3UkblHq6UvhYtqgoOYySJWsIE7A+srTZKWDmMN/bdQ3w2kbSIhSXPTuanl/gXF+3i
         /EojGPc3PfHUJ2qk7/G/qZVCT6CvNgx3ozM3or1Y6yThlZm9mSTcAwvmpxb2J+qZ10Qm
         v067pqgjO/zD3qdIS+HsqhM47VKBo4IeOrc3sooq0iD4osN5PAkCCVcaq8eT2paSX22X
         HLhzpZlvrWcuRKsJK1qqOWOPmBlaQS+IwK5/pjLKCiaEoMgqVGBn/hZ4BH3PCeidubrE
         UzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=VSEH8Q3Lr+Mcr/0lsL1VFPftJp7ALZ21MKYEz4sry74=;
        b=Vd80JivjO8AEUHmElT6TiYhyWBX3uU59X26aEm9HSg01SA5Styp7wzyRWjDXVGCNxr
         SdKMoV3dVK3o7avhEDAlHn3svt2XvPOSvoM4ES+6v4VHd1Y7TBzuNEwljq6MgLNkK1PP
         JSMGTKQAYvRAN0AET+4/8qxTAnxNNayb0atEKALu4y50JrlhicTKePvpPzbxnCit2SoZ
         wXtm2G1Tw2GeKn18fHOgwvP8TmEF5XANtUy+CgxmyWqmwm+2xM4sYnVaJLKfgGnj/XAE
         MRTngb0x/5xh9/33Ta6/4SX9XQfBSGdYirt/HCEAsLUTwoFHwBWVTm2jH/M5Mc3knYUH
         ZUPA==
X-Gm-Message-State: AOAM532VsThJl7bxykXeUsonOZS/oOG7/ukERrVgSlWv+wlsqgMDnO0h
        aThRHmZnJBftrp+vbnVDGJ3kVfC3jMbLz0+Ir0Q=
X-Google-Smtp-Source: ABdhPJyp6v5LBrjboaGiVuOqYycvFu1xtOmg70SHkmps46kcPjhScfjWyiFXHT/wXa11KzJrhQhbX2BXcWg9EY6+rxk=
X-Received: by 2002:a05:6512:230c:b0:44a:2282:8e38 with SMTP id
 o12-20020a056512230c00b0044a22828e38mr2555869lfu.315.1648557826683; Tue, 29
 Mar 2022 05:43:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:9cd:0:0:0:0 with HTTP; Tue, 29 Mar 2022 05:43:45
 -0700 (PDT)
Reply-To: christopherdaniel830@gmail.com
From:   Christopher Daniel <cd01100230@gmail.com>
Date:   Tue, 29 Mar 2022 12:43:45 +0000
Message-ID: <CADacUq-KxndfOowTReH_hUPwZkBzZaE+knLG6A7qyPEVcxuVNg@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:131 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4949]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [cd01100230[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [christopherdaniel830[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [cd01100230[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

.
I wish to invite you to participate in our Investment Funding Program,
get back to me for more details if interested please.

Regards.
Christopher Daniel.
