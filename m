Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5095577ED
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jun 2022 12:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiFWKeQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jun 2022 06:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiFWKeN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jun 2022 06:34:13 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36BD4A3E6
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jun 2022 03:34:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id o9so18648655edt.12
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jun 2022 03:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TVEhdrfM0Dda/kMBADzBhaUVLTbI0IyZhtodQY5JGzA=;
        b=jXinmJEqz6Xd6Y1dy1veRZLP26diTct+sZ7yyorv2DSfoBO+rC1hIY89zB/dbxJQCx
         iaHjUGFc+1CMH1EbNvcMWjhUxVzABmKgz1TE+vW0xvnfy6V8Vppnz36Z+2OfAyYmRx7W
         Fb4gk0vffnEOpXfl/8JfGNXpqbzbzOR8Ysy/lomtzH9mym3FhWrUT3NiorZv3zqz3U8g
         1Ouy1fS9VxaXdPebId7cRRJSQQrPf/YVtTXeIMU/evVNa3HYjaaTGm1CldcOiFSZE8xL
         OrILBxg8yyojK/IJLk0TD49oLubcklfBuo8L1k9+kVPZcghkB1s08lKa1FnRgcBOujO1
         7Ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=TVEhdrfM0Dda/kMBADzBhaUVLTbI0IyZhtodQY5JGzA=;
        b=f2gmAA9F/z96efFwYrG4Ah1I2fiDCcRxJgiOwVIomdDlnL0YH6KzyBibPtYZ4M3KYR
         PukG/QMOGL/A5eVsnPx53+Qeb02v9+b/2cNZfqVzo39GGBeRRp379I6pqpZPx0Kwh15c
         7jpsRsjuY0Q2IjYnxSvsPAaxPxE1Mzvg+RmZjzCKYTzeG966h4JZyGExVg06gXiv6zYv
         +lDq+d5zVZ4O9DaJknXKSwOLfciamBkTRax7/bhuusN2c49ha4g5aTCa28KD2c5BEbRL
         oGKAoHC89DnJcQINIZI/MeJWQEVZNErz3F63vfxemC+aq9JRLlZ9rcNAHtz2VGmCt/FQ
         4SEw==
X-Gm-Message-State: AJIora8Xh4hwIebrQu/PTD9uiapR4CpLLX1gbBbiMKINT/QG6VCqCFbn
        9JKeTeXt83rygYYcGLnw/idQLf0mJfittk29j1g=
X-Google-Smtp-Source: AGRyM1tuCDpSoemLz9XP2XBY7Kwchlm7DbIp6SAN/E5Pe236VzEbOedzaokbSYEd6RR3jjXUiERnavfv+eiROu1qy4s=
X-Received: by 2002:a05:6402:238c:b0:435:8eb8:48dd with SMTP id
 j12-20020a056402238c00b004358eb848ddmr9773045eda.301.1655980451280; Thu, 23
 Jun 2022 03:34:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:c688:b0:1f:5e6d:a98d with HTTP; Thu, 23 Jun 2022
 03:34:10 -0700 (PDT)
Reply-To: sgtmanthey12@gmail.com
From:   Kayla manthey <donlammy56@gmail.com>
Date:   Thu, 23 Jun 2022 10:34:10 +0000
Message-ID: <CABehkZKh3r0E1zB52qDb-s2A5w7-0=uJc6t78SG0R13Ze-xrvw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

LS0gDQrQl9C00YDQsNCy0L4sINC80L7Qu9C40Lwg0LLQsNGBLCDQttC10LvQuNC8INC00LAg0LfQ
vdCw0Lwg0LTQsCDQu9C4INGB0YLQtSDQv9GA0LjQvNC40LvQuCDQvNC+0ZjQtSDQv9GA0LXRgtGF
0L7QtNC90LUg0L/QvtGA0YPQutC1Lg0K
