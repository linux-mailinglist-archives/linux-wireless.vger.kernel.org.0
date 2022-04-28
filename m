Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCAD513DA9
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Apr 2022 23:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352354AbiD1Vfq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Apr 2022 17:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351487AbiD1Vfq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Apr 2022 17:35:46 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC987BF53A
        for <linux-wireless@vger.kernel.org>; Thu, 28 Apr 2022 14:32:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p189so3638084wmp.3
        for <linux-wireless@vger.kernel.org>; Thu, 28 Apr 2022 14:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=UIbSwXETQo8py8NKWWoOzTbdb19k4UaVxjqlebXhaiE=;
        b=f8NOljRde+qFibxgru9tmIkEQW54Z+Hbpyckcy4ShcjDb+p4J7OqskaSR4BE/ojOl1
         OqTgAVqf7cQ6ZYENt/11bnWlPjIDYQEwIyQHAElAHwJ5VC2oAX9WwYP6R8VgLgaSKY4J
         VivRfm6O5B0w4eJ31UcsNA1+mOTzHgBZv/YFzJUpTTUU61/lJw0ItCN37WLLWr5ocq8T
         CO5gf4gmSYF4EOSs/ibhCbFsJzK0/aC8GE7SlGsxhCK3a8gQ5A2JC4BePRRxKsekSmx6
         erBYtrzhoNrJXdkW+m9G4gRR0sOUB24OjVw9/6of3+ee3+vVxdnqglc0zptC7h/MXNgb
         N9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=UIbSwXETQo8py8NKWWoOzTbdb19k4UaVxjqlebXhaiE=;
        b=G8DLOtRcMbO+2fKw+6CMyKC6WdwAl633u1fNmhd6vJm+NLX05sd+G479hDFlOne2Hk
         wqar51toFkZtI0hTm3zUo0ZkSIdayOhNaE5nsmtDrBFNVcNbEBluF2jisBcqxJfc9Rk0
         s0TGR4mhci1O0CqXp2NEWADhZOnQp/QLtMJcPTlPCrSx5vP4lIEZHgXAZFxQRYOoboVs
         faQ2BEkMkh5B0ASXilCbRAagJTox9ksGu5er3eoCouPvp4aWE68ZxdA8trgFZojZjwgJ
         SvQHsFuU0CD+mmNq942gyajbHBAFcu7KNRjDvcZAz6a/b/M+lid2ZnFYX+eh9U0t80VL
         3uhQ==
X-Gm-Message-State: AOAM530W54Kdc8ZGClVaV3sNHMLXLjmvKyBxsVY9Vq4U+j8AZm6cmyyZ
        SiiOW1c8JWMrYNlmD9dMEJeLdge5+yNewjnqMA4=
X-Google-Smtp-Source: ABdhPJz7QXY5RD98djsZi9Ojy+YqpiHN9eK9guGj27v4EqkvHutu7zrJ9d02rBUa//MwzwknkG7nIgBxphCiI6UcA44=
X-Received: by 2002:a05:600c:c9:b0:392:af6f:734a with SMTP id
 u9-20020a05600c00c900b00392af6f734amr163049wmm.61.1651181549419; Thu, 28 Apr
 2022 14:32:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:f2c4:0:0:0:0:0 with HTTP; Thu, 28 Apr 2022 14:32:28
 -0700 (PDT)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <sylviajones046@gmail.com>
Date:   Thu, 28 Apr 2022 14:32:28 -0700
Message-ID: <CAGH1ixsVYukr9f65PWnC2KRw_3ctk5ndM=808MwZSfvY=gcw=Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
Hello, did you receive my message i sent to you ?
