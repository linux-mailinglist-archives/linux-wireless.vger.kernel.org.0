Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706AB4F8F02
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Apr 2022 09:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiDHGsX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Apr 2022 02:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiDHGpz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Apr 2022 02:45:55 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1D22F429E
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 23:42:37 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id kr12-20020a17090b490c00b001cb3ee2e4c1so987295pjb.5
        for <linux-wireless@vger.kernel.org>; Thu, 07 Apr 2022 23:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ry/pptsNXcfgvM2e4w+e+zihZ3PckqdRqO56Galbnsg=;
        b=gj9fHsMV8bvOx+u4oTiZVJFEAjn2dAWvu0wdtdrp9RhQoggXIDfW1kcCJqB1/qUTAw
         6EOxl4qupy/H8AS+akRyPKhMVyidrK5CTDNfrQYRwdlurihHr2B+t9ou5t2n294hj8h9
         eDRqI13thFbwHoJHVkDESshyB0eUiz0K4UPTXh/Rs1MNjJB4/BCJptglyb/r9VE12M9h
         LkOamvgPrggotzcaxDxcqP3okuPaqYzS0wpZ+jKGS/LqTE+PopQlr+J87VBDKgikV4TE
         fi9aVpfPM6uawhCMHWBd/mLkWK4SFKfLvyjt5KNYbik0dUrgYXIkTw2Ah3NOfRsjkMIH
         6ssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ry/pptsNXcfgvM2e4w+e+zihZ3PckqdRqO56Galbnsg=;
        b=spNaWktw8RXQIb5BL2XyT/SujG2XuiX0HBveJ7mhwCK62k2tsW34duUSjQspHhdmWm
         ApkKT32GiJlgC3AaVTUu7nnGEMYpa95UDN0Q5R85U8yxMbr4nHNrFiFQRiEDXxUBLVa6
         am5L7QJAj0eukoow4Z/wrA/UK50l2I0E9Oy24eBGAoeRudMgf7Lblr4wVzFN91p4UZR0
         Y61m0bA/qIh0zjb5XvE7H5rpsZjkCw+2besd4URt1jvbYCsHmH9ZEIBYZ1uEmGgr+T0w
         v+5NuV95kDcRsgCKT5vlERDVRJ/7pE3k941FFgghVpaY6FdzTmw2aHE6yFBpNOV82U2z
         oWmw==
X-Gm-Message-State: AOAM533AC7FxnJYl2F8NcYev33qPMlg057f6z5YIQaAL6wutCWAY0IG2
        m4mSaVDQckLvqXK+Z3qD8PkPa0TnujGFWTIDTPt05w==
X-Google-Smtp-Source: ABdhPJy4g38Q/4igl0yQl4XqWpbhfoxp4xqXbs6Lx5BvjSQukPMPTlRriFDBJxnzPMbw69KxlsOu1wyLwUJpw33ONHI=
X-Received: by 2002:a17:903:200b:b0:157:1e6:931d with SMTP id
 s11-20020a170903200b00b0015701e6931dmr7688334pla.6.1649400156907; Thu, 07 Apr
 2022 23:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220408000113.129906-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220408000113.129906-1-yang.lee@linux.alibaba.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Fri, 8 Apr 2022 08:42:00 +0200
Message-ID: <CAMZdPi9kA0iLB64B6pCwt+2tUL2Lv9nYbU_N-0J6tSORSfq9_A@mail.gmail.com>
Subject: Re: [PATCH -next 1/2] wcn36xx: clean up some inconsistent indenting
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     kvalo@kernel.org, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, toke@toke.dk, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 8 Apr 2022 at 02:01, Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Eliminate the follow smatch warning:
> drivers/net/wireless/ath/wcn36xx/smd.c:3151
> wcn36xx_smd_gtk_offload_get_info_rsp() warn: inconsistent indenting
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Loic Poulain <loic.poulain@linaro.org>
