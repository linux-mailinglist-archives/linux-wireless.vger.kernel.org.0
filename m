Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33417F0EC0
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Nov 2023 10:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjKTJPr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 04:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjKTJPm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 04:15:42 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C991DA7
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 01:15:38 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-4af6a700087so1417911e0c.0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 01:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700471738; x=1701076538; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGUSPipm8cHx9uqpOKEqNlZRVI6FwrP0qizfWCjAeMo=;
        b=DJJ6rRfYhwAUyLaLEvQUL0WEzHxZ/SdBwDwxhWXlA1k665MMluGFFX6AjsbWxYzYEb
         Jf1PN3xWwu/E2IYfpqWPjXmg4VrRTxFYupLzjBck6quw8M7VcfIu0N9JQ1d45sN3EBtx
         Se+gAfRt0kPsIk7eeaGSOKxziytfC1kMJW4j6EN+GlB5eW0URq/TmiCcRZ9Gg7aSsx47
         ntTN183De5TiNp7VZJIoskpffXAGiEznMYckUCHeTYD9tLsDInXc1qLjNxkpSZ+VZDIA
         2S/Ooio/J4BZLNFbVZYGrjQwPg74u4buRKEgzIcoWl26Y5B41s9oWTSdRGWqHhoPREvO
         eaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700471738; x=1701076538;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGUSPipm8cHx9uqpOKEqNlZRVI6FwrP0qizfWCjAeMo=;
        b=MnvlkDOyLxi2a/XalBaLJ4s94LQru/nOsMTcvrOriE9tdY9ahSfMCOZ+3GFXxfPD0C
         3i1N6RWfRCOC0soMY2mrzJu+sHPPFHGZEu0MX2lMBLa/g+DMSxtHkj3Q9HiCKaTOjBoo
         K8sFR00XiKyM/cdenRTW/LcjAaolibQVlqAstI7z8JDFtXLYicUYYw83dYpUJvqwjt1+
         HE2doJg1R+DGISt6QNqs6SYNaI5L8UyXvgEiaxlh2zx6yr2J6OSgCQ2WfXB1/18kH3yP
         67xpDL2/9J5ryX5HmKb7rTT6Sx6v9kqOUwf3otAre6pdbaMsq1AuHW88eVOgx+yuVzB5
         8xsQ==
X-Gm-Message-State: AOJu0Yy5PA3MCFbrQPO+09xDmCaTaIF405i52wY73gFI2zFW18ka7cld
        INgX71ouBTNCtvehfT5q5wiAu19Gn5Gw/zW2WFI=
X-Google-Smtp-Source: AGHT+IFa5Zia3nlUuw4gB/6z6NwXGwrFctCxlDmv3Kju7CF46IFApKxHYzYLaxyAZGqjD6akasaslZHho0beZDFvaYM=
X-Received: by 2002:a1f:cac7:0:b0:49e:1eca:f84d with SMTP id
 a190-20020a1fcac7000000b0049e1ecaf84dmr4598800vkg.14.1700471737875; Mon, 20
 Nov 2023 01:15:37 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:55d4:0:b0:755:5671:293a with HTTP; Mon, 20 Nov 2023
 01:15:37 -0800 (PST)
Reply-To: andersonmorris490@gmail.com
From:   Morris Anderson <thompsonburton665@gmail.com>
Date:   Mon, 20 Nov 2023 09:15:37 +0000
Message-ID: <CAMz0d3HArRbG1BqQS2nJ1kyCifPZEQ0+-_TPnJT=emvkhPJgAQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
Do you see my message? I sent you an email but no response what happen.
