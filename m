Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5A335F1EE
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Apr 2021 13:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbhDNLKb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Apr 2021 07:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbhDNLKa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Apr 2021 07:10:30 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6112EC061574;
        Wed, 14 Apr 2021 04:10:09 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e186so20250781iof.7;
        Wed, 14 Apr 2021 04:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FASEUqYIZBb6hS7B3SBXB89XThdZrbyVFurlFc1J03g=;
        b=Mx/DPTZX+OvWlWEWLYvPDZWCJZsWeZR+F7x8MzZKksI1jZlptdeLmRRTuzXgXukE4p
         lLrIDsSljV68AGjc/Q9WmYA4+alUPY9CEfuk/jhbpd+xKfCBTt1+XNLhcS/xpmFoRJ/F
         wuSAsgaXv7XLRUIiE0oQkfiX0ty9ezIDyURe7W+0oe+OXx5V2oecHTOc7Xmu2W27pvLa
         scbcWoQBr1BDxxKNo/YGmYpPgHbZL5LqOmUyZ+pAKVyu+hxoahNnPWMcCr6XUfL4ZpZE
         JEfhS95e0gPpdqrB8O8iNh8aHbv4e4HBSM+SHSjtXLarYYMMYtK/7DC2Z6JYK5dQ/YwS
         H9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FASEUqYIZBb6hS7B3SBXB89XThdZrbyVFurlFc1J03g=;
        b=J1VVnJxui+bwtPGBK6SbRyreoUzsMLbqrqpaMxQ89uzoGCI0txkNb5Yif7bk902Pty
         KJl7tl3aByqnkE/mH39chwfEWaUKj/C6xzC1gxc25cMcwFL7/PctUgPZqw0GHGH/6S8J
         Ey99aUwBEayPE/kPfP8Avpxkiy2pIbEk190xOzlbkWqV4uWBX+Co7DgrBq5bJOjjdQnf
         weOTj/VqxZ9b/Ju9hJmwJ+MhWsxW+1zuvY8P+HNBfaw1ChFpRt6vQDFM2O1JoxoVOXY7
         gneyk947TyZj/XKDZwwQgmJNog6w+6sIPMYdGHpjVlvFDPRnRNf1bEcKEUn6Y7OrzQk6
         rXwg==
X-Gm-Message-State: AOAM533mk08v/vyneURcDn2+y7d2C3aOmTBUiRHUNZBBa0Uk3oUA+TO1
        La5am5uxuHj3As1IMGfJkTe6YicGO3GwREvSM/8=
X-Google-Smtp-Source: ABdhPJzQ1Bw4nnuaR951fNbcSkJI74gkp+vB6tWFrd7JR/wEdTF17GSulZw7ykDJcPIGqoHdaU0r7zkxRv3fpjCvmQo=
X-Received: by 2002:a05:6602:179e:: with SMTP id y30mr17120190iox.130.1618398608907;
 Wed, 14 Apr 2021 04:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <YHaoA1i+8uT4ir4h@mwanda>
In-Reply-To: <YHaoA1i+8uT4ir4h@mwanda>
From:   Stanislav Yakovlev <stas.yakovlev@gmail.com>
Date:   Wed, 14 Apr 2021 15:09:59 +0400
Message-ID: <CA++WF2M_XOPhUpARSi8+-JfcmF2rfY8jM5+j7vTuA5YFsYbqiw@mail.gmail.com>
Subject: Re: [PATCH v2] ipw2x00: potential buffer overflow in libipw_wx_set_encodeext()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        James Ketrenos <jketreno@linux.intel.com>,
        Jeff Garzik <jgarzik@pobox.com>,
        wireless <linux-wireless@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 14 Apr 2021 at 12:30, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The "ext->key_len" is a u16 that comes from the user.  If it's over
> SCM_KEY_LEN (32) that could lead to memory corruption.
>
> Fixes: e0d369d1d969 ("[PATCH] ieee82011: Added WE-18 support to default wireless extension handler")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: use clamp_val() instead of min_t()
>
>  drivers/net/wireless/intel/ipw2x00/libipw_wx.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>

Cc: stable@vger.kernel.org
Acked-by: Stanislav Yakovlev <stas.yakovlev@gmail.com>

Stanislav.
