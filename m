Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2D54A9198
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 01:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356218AbiBDA1P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 19:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356217AbiBDA1K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 19:27:10 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0F0C06173B
        for <linux-wireless@vger.kernel.org>; Thu,  3 Feb 2022 16:27:10 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id s18so5425806ioa.12
        for <linux-wireless@vger.kernel.org>; Thu, 03 Feb 2022 16:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZHLlp8umDVFs9Tye8ZudPORlyWBAZ0TceN0aLVUR5o0=;
        b=Ro0400dsEnmE9sFvCXr04FI1Suxxe+GviQVvHHvua9HenOqS29iCeTQK2BO/GvkJV0
         NYK0hioNaHxQozDh+vrUiMQnovxtyh8zG8zfNWOSNa2cmO1wF+2aGkFC7OBLlAZuFS7d
         QzLTY101Owp2M+rUMLjHgr3B7GQP1HdZD/b4DuawIiJaUZhmJhlPfFC3zcVo/rtaEr7J
         Kup/QqUiv7C0/FFyzYkBpMiRD8M4yRWm4jkA18aago6Veq3AYkzqsAUX8RzrWm8IB5Uq
         J5rxKu7NwIgAhVivDJm/xM8NuSWJzjXsHsx929HIZus7bzHpyYJ+515C+KRvvQh198S9
         ZVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZHLlp8umDVFs9Tye8ZudPORlyWBAZ0TceN0aLVUR5o0=;
        b=PqqtKvfrq+deL2ALHIM//j3PZOxY9h2G0BHUASNPv2e213CoOpTC94/zQH22EAQkXW
         zav8J5xUMfX4MdthbkBpCp/vnPRoXBimWk4sSC8arhcazaJcCTPwLOvALQJMURWchw6e
         cSIVGS73yGTxPy9X3PDz7fZeDNw9bqAeZuD4A/rgoZp3+c2jsL7hKi+Cphd1rHw8NQFj
         YjD07SH+VyQ00U8xHkUMakiobyFRVy3CTnvCNaIZ/fji22hnYXohkjTHQJPyMxUhgrZh
         wRLr1zEkSG0EXnBQsWnnCNXsoKjsCnafEbF/n7iJtxwoUz3nZJ0zhPHIEOe4k/X3ED/S
         Z1Dw==
X-Gm-Message-State: AOAM531P9td8t2K7bmHkXqjCDlo+SpPKocnM7pV4rPD15uLBPklUeyGe
        pfiZrzVq3a5xoEimAP9wM1OJuuX4yrRVKeThwIfAb3MBRa82JdNMHZg=
X-Google-Smtp-Source: ABdhPJzkeVpmnHh01+sMw4I7bRAwMdEmLxLXizA1qhnR5P1LQJu7e/QGIVCLOswhuk9zyyLWgWLSCVRdlnOv6PYHo4A=
X-Received: by 2002:a05:6638:371e:: with SMTP id k30mr227509jav.64.1643934429378;
 Thu, 03 Feb 2022 16:27:09 -0800 (PST)
MIME-Version: 1.0
From:   Slade Watkins <slade@sladewatkins.com>
Date:   Thu, 3 Feb 2022 19:26:58 -0500
Message-ID: <CA+pv=HNuxZXTxu2S5vcz=zF81wWxykQe2im6oKgKiaDPujVjiw@mail.gmail.com>
Subject: rtw89 driver
To:     Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Larry Finger <larry.finger@lwfinger.net>,
        Slade Watkins <slade@sladewatkins.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi there,
Quick question for wireless folks: would backporting the rtw89
driver[1] (Realtek 8852AE) to kernels older than 5.16.y be possible at
some point down the road? I ask this as, when testing a stable build
of 5.15.y a bit ago, I had an issue where the driver wasn't present
and the system I was testing it on wasn't happy and started kicking
errors. (It's fairly new, so I did kind of expect that.) I was,
however, able to solve this by manually building and installing the
drivers so it wasn't that big of a deal.

[1] https://github.com/lwfinger/rtw89

Thanks,
Slade
