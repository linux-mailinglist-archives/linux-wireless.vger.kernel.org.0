Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91214C43AE
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Feb 2022 12:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240139AbiBYLcN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Feb 2022 06:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240140AbiBYLcM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Feb 2022 06:32:12 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A10811C2A
        for <linux-wireless@vger.kernel.org>; Fri, 25 Feb 2022 03:31:37 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id j15so8848983lfe.11
        for <linux-wireless@vger.kernel.org>; Fri, 25 Feb 2022 03:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=3j2oDd/zfZomS5E3AhwrR7MMITFY3P2eqdhQ23SIUWU=;
        b=drfsU/DwtaTkj5nWS+PwR5JvP+cD73/ncc/y+e57nVDCsdm2xS2rxvTMV84ABf/lCl
         9JVFBvgkRkqUdEI41Ez0EO4uRiBd62VndwBHG8r7Dxm3ZtJTzAQnLw0peOVzpouTvI39
         oKMXF0orDROBtDpu0EV8d5RJywjxd9sfOz4lsh9wxxIHZP+pHVYvyfV75PNAxXep9Z5N
         JlHOuVTbeOctsbaBcZ4/ERspz+qVOCyJt/32N/Od3XDUJ+Kp/82LSd1pjEGhZftcZypv
         WY9s9lSjDJuY6RULcx5wbkVxQ8/SSISDJIPGQyiX2yG0p5W2BoYZtHld/xUdZi9XsUlc
         4WXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=3j2oDd/zfZomS5E3AhwrR7MMITFY3P2eqdhQ23SIUWU=;
        b=daFfa7jjXkYNcie5/XlJ7NHraKQKzbp99BSjdC9Yq5jUEWBbzEQBQr6YrH59evkwT5
         PYAtP1FgphAZAgxXVaDFyqSLprE7OH3/ld8wp4UpwoRcsz70SGWx+G6ccmqJR/EU6Nd/
         RduQjqgS6aejhljy/afi8InoqnqcG1/8MQLZJ1A55W0HhcfmNwN9788ak+KfI8yMt3yX
         hphLYUW1sNlcmwSBva4Rl9qruW8PSKKulxtWUH8PqOMJAIHf3VSo3jYD/hAnM1oI6OKf
         lTnUvywrOOZpcM9emdNZ5+2kCc84E5ivvPMTCt0aTfqgpoKXw7KFjegsIduwV03blPhJ
         4YZA==
X-Gm-Message-State: AOAM530VMmcdLCXZYwzlhlWyvvA1JzXAZHd3sXps76LDqfEtr2gsJYOs
        uXuPDPAggBOnd1DoSB0HpLebFStlSyQaYt4GDN8=
X-Google-Smtp-Source: ABdhPJxGyCcjWsKY/fuRocJ1M185fY1JT1blFIwXbLRZ9YXMtFbhi1HKI77P5o1EtxvU5q/h+5RTvILJB9z+dMrlL6Y=
X-Received: by 2002:a05:6512:33d6:b0:43b:8dc3:130f with SMTP id
 d22-20020a05651233d600b0043b8dc3130fmr4811885lfg.47.1645788694988; Fri, 25
 Feb 2022 03:31:34 -0800 (PST)
MIME-Version: 1.0
Sender: goodsnownow380@gmail.com
Received: by 2002:aa6:c42d:0:b0:19d:c5c:a67a with HTTP; Fri, 25 Feb 2022
 03:31:34 -0800 (PST)
From:   "Mrs Yu. Ging Yunnan" <yunnanmrsyuging@gmail.com>
Date:   Fri, 25 Feb 2022 11:31:34 +0000
X-Google-Sender-Auth: e-7_37X2GJL-rbusmSqG8QUuocg
Message-ID: <CAGPyEkgsnbj-RXkMOFxhTjX7nf_nUMbxPwCuz45NspUZG3Dv8A@mail.gmail.com>
Subject: hello dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

hello dear
I am Mrs Yu. Ging Yunnan, and i have Covid-19 and the doctor said I
will not survive it because all vaccines has been given to me but to
no avian, am a China  woman but I base here in France because am
married here and I have no child for my late husband and now am a
widow. My reason of communicating you is that i have $9.2million USD
which was deposited in BNP Paribas Bank here in France by my late
husband which am the next of kin to and I want you to stand as the
beneficiary for the claim now that am about to end my race according
to my doctor. I will want you to use the fund to build an orphanage
home in my name there in your country, please kindly reply to this
message urgently if willing to handle this project. God bless you and
i wait your swift response asap.
Yours fairly friend,
Mrs Yu. Ging Yunnan.
