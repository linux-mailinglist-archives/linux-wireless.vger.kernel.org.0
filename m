Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02226C63CB
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Mar 2023 10:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjCWJiP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Mar 2023 05:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjCWJhf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Mar 2023 05:37:35 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EAC39287
        for <linux-wireless@vger.kernel.org>; Thu, 23 Mar 2023 02:35:14 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id b18so4980113ybp.1
        for <linux-wireless@vger.kernel.org>; Thu, 23 Mar 2023 02:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679564112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JF+vGQVgdI6sx9plJs4AJswLA4WXZNTBD08CbZnYmOw=;
        b=qgnBDQsImBRsBRzL04y/XruUAp85l8H3/quagH2UU3puPCBRsAsmXcd0fQqkGckt22
         3VLNedY8PKZr5ZwPq1czPzZAkvbryUhYFIe0hSApclFTrouW4GcL7UR1EUL6+juQphEt
         uHYHwGObMae+CTi4Q5Rj0hbbE4nGkI4o8qpg7GdTOkBwLf1x8nkqJJPdyYBRX7Gm0adu
         Wt2WlQ5ByWszvYzJsYf/Gwe3uwr7LDZlJPViam/w9AYmGiGpmGE7WFRszWLdCSA6j8nI
         klqDqSxihNxQSyXykhMvL26Ym84VBmx7T3oeSM8bqxRlXHQNGqNKY6My2yKDO8cP2/m3
         GqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679564112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JF+vGQVgdI6sx9plJs4AJswLA4WXZNTBD08CbZnYmOw=;
        b=K2b+2/HLBZWx5haMMC5gq2ygSs5nVasHRZXQjT1H6f0HkUz+zxGAMt5h03XwFpCefW
         eHN8+BJciH2fTJyzqH4oz8mMNYwnFlMCiv3XhottMnMqj80GOWW1+bQ46AuqD97ce/FV
         I4E4fxjWug1Sc9DDy1SPMJFk750YeOBMDbjGkuPvbBj4EDpBItfJ6FlkF7h3iEGwbWvK
         5PjKMxcT6ktZK3ywg0SUy5HF8hc5XHeaRfzWVH6bZD4X+ZaZz9tm/spE8xJ5li35JTA/
         ue5ysnN3RzMhYDu8PYgQBgibxHFQxfsQkNMS+ciGQ+r37f1CryO0FVtU2IDI0II7eUGX
         +OeA==
X-Gm-Message-State: AAQBX9cy04ntyjRe9Lhqb3ThsSAV0IZS8EXNT12C7o4Os2QzX4r+e9/M
        0wpIdr2+jHTOX0KNKp9Go1zx4EFUUXvk+407hIQU4w==
X-Google-Smtp-Source: AKy350bNDlq8omL6C5VYBvrDpmMp+ZJqXKk9D1arTEZ5Jo48ki+2fH+W9YnpT+A9TVctPNAUkGxRMWzPGLfKS2MSHg0=
X-Received: by 2002:a05:6902:a8e:b0:b6d:1483:bc0f with SMTP id
 cd14-20020a0569020a8e00b00b6d1483bc0fmr1379565ybb.9.1679564112387; Thu, 23
 Mar 2023 02:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <878rgzuw37.fsf@kernel.org> <f08d7310-8c33-ab0b-c9f1-317f737ba37c@linaro.org>
 <87v8ite3g4.fsf@kernel.org>
In-Reply-To: <87v8ite3g4.fsf@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 23 Mar 2023 11:35:01 +0200
Message-ID: <CAA8EJppge=2Zf1CZPY4sUNkC2VzhDQ8ah8f3x6LGAky=PdFQrw@mail.gmail.com>
Subject: Re: [PULL linux-firmware] ath10k & ath11k firmware 20230215
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-firmware@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 22 Mar 2023 at 07:54, Kalle Valo <kvalo@kernel.org> wrote:
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
>
> >>   ath11k/IPQ5018/hw1.0/Notice.txt          | 4094 ++++++++++++++++++++++++++++++
> >>   ath11k/IPQ5018/hw1.0/board-2.bin         |  Bin 0 -> 524564 bytes
> >>   ath11k/IPQ5018/hw1.0/m3_fw.b00           |  Bin 0 -> 148 bytes
> >>   ath11k/IPQ5018/hw1.0/m3_fw.b01           |  Bin 0 -> 136 bytes
> >>   ath11k/IPQ5018/hw1.0/m3_fw.b02           |  Bin 0 -> 262144 bytes
> >>   ath11k/IPQ5018/hw1.0/m3_fw.flist         |    3 +
> >>   ath11k/IPQ5018/hw1.0/m3_fw.mdt           |  Bin 0 -> 284 bytes
> >>   ath11k/IPQ5018/hw1.0/q6_fw.b00           |  Bin 0 -> 532 bytes
> >>   ath11k/IPQ5018/hw1.0/q6_fw.b01           |  Bin 0 -> 520 bytes
> >>   ath11k/IPQ5018/hw1.0/q6_fw.b02           |  Bin 0 -> 7552 bytes
> >>   ath11k/IPQ5018/hw1.0/q6_fw.b03           |  Bin 0 -> 545008 bytes
> >>   ath11k/IPQ5018/hw1.0/q6_fw.b04           |  Bin 0 -> 86788 bytes
> >>   ath11k/IPQ5018/hw1.0/q6_fw.b05           |  Bin 0 -> 17776 bytes
> >>   ath11k/IPQ5018/hw1.0/q6_fw.b07           |  Bin 0 -> 1488 bytes
> >>   ath11k/IPQ5018/hw1.0/q6_fw.b08           |  Bin 0 -> 4096 bytes
> >>   ath11k/IPQ5018/hw1.0/q6_fw.b09           |  Bin 0 -> 2330624 bytes
> >>   ath11k/IPQ5018/hw1.0/q6_fw.b10           |  Bin 0 -> 269028 bytes
> >>   ath11k/IPQ5018/hw1.0/q6_fw.b11           |  Bin 0 -> 99436 bytes
> >>   ath11k/IPQ5018/hw1.0/q6_fw.b13           |  Bin 0 -> 7024 bytes
> >>   ath11k/IPQ5018/hw1.0/q6_fw.b14           |  Bin 0 -> 1668 bytes
> >>   ath11k/IPQ5018/hw1.0/q6_fw.flist         |   13 +
> >>   ath11k/IPQ5018/hw1.0/q6_fw.mdt           |  Bin 0 -> 1052 bytes
> >
> > For the past several years, the Qualcomm community has been shifting
> > from the pack of .mdt+.bNN files to a single .mbn file as a main
> > firmware file format. It reduces the back-and-forth between the kernel
> > and userspace and also simplifies handling of these files.
> >
> > In-kernel mdt loader provides backwards compatibility, detecting the
> > file type and using .mbn instead of .mdt one, retaining the name (or
> > using symlink).
> >
> > Do you have any plans to also shift from .mdt to .mbn?
>
> I have not heard any such plans but I'll ask around. Would you mind
> filing this to bugzilla as a feature request?

Done, https://bugzilla.kernel.org/show_bug.cgi?id=217235

> https://wireless.wiki.kernel.org/en/users/drivers/ath11k/bugreport
>
> That way it's easier for me to track it.


-- 
With best wishes
Dmitry
