Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07F761554B1
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 10:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgBGJaI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 04:30:08 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39711 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGJaI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 04:30:08 -0500
Received: by mail-ot1-f65.google.com with SMTP id 77so1549398oty.6
        for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2020 01:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DNMjC/wZol4T8GHtgcdMs3vqXM7ujVjH/kst1nQDTZc=;
        b=uT9YUtCbCxw/CboQR7Te48mRM92bMkdfILP3BBIyW9acDI3hmyWBAie/IekHQq7Er9
         z0H1TdKlN6OoGPiPiG1ktQn6+h34zsr9PzNAP4DpljfiKH8LaoKRf4wJalnRE8Kg41BC
         GBcyzjh/KkfMiq/G0Tk8+YDkNGsImK/9rwVmEVweX+ZvlRdJJC6VsapTtnSWzIBv2ukS
         L7S1PqEbjL+YB6pPb7Fbw9hxGTFoK+TBfZ+xHdCGpbmC7bfB4faAB1C7g0va3uDrQEdP
         S3Zu/XyfGL4SII9fMT3NNd5Pa76a2pk7z2vIlIzx4biTdODcThkJO58MfwBgiot8VOMr
         AHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DNMjC/wZol4T8GHtgcdMs3vqXM7ujVjH/kst1nQDTZc=;
        b=dyIweEmx2tUjJa9EV2cboV3OELwRBvTLQ6/lLmvvHB8C61FURUddurs9wHndroX4uJ
         ZKT/sJ+fp3mMgvj8jYYhKNSVNWxcYquooYFgNYLFTjAHZyaEHdCr5KJtQQJmBwXCD07x
         OoA2YWfJJqjTcttkQw+jzly8eFf7IPUX8GromYP/7mqjM3C35uyS8oq4lCCNdK2cYtna
         jbauud52LpfwebgAkOd0SrKvTBcYUtbUTlW/mICQYURJGVQKi6nIb/TWlqoMQ6tslULM
         9L5qMXn6ZMJbQKmJsJVB4tYK5izfgGIYrKaMs1Slt0RuldJrn//4txyEjK0/QtDPQFvI
         dABg==
X-Gm-Message-State: APjAAAUEo8mjCLHUkLQdHmBR61NlSAieWAN8MliXkYqQMg5WDo/RcaHi
        lPcessj8644SrvDN3jMlJoFM94nPK3IIboqzrDtBTQ==
X-Google-Smtp-Source: APXvYqw8aurwLdzrOhYuAGyBghBLWTIQpe9EzDMBbggFfXS0eGnefWsPamw20ISsSKsadrnDnJo8ytrMXKgDDDfMltE=
X-Received: by 2002:a05:6830:1218:: with SMTP id r24mr2049664otp.144.1581067807399;
 Fri, 07 Feb 2020 01:30:07 -0800 (PST)
MIME-Version: 1.0
References: <20200207084729.24882-1-yhchuang@realtek.com>
In-Reply-To: <20200207084729.24882-1-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Fri, 7 Feb 2020 17:29:56 +0800
Message-ID: <CAB4CAwe5ts58SXarzHQCO3NMCOu8EgKU5Hqh5ZMyiwU9HxfMZw@mail.gmail.com>
Subject: Re: [PATCH v3] rtw88: Fix incorrect beamformee role setting
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Feb 7, 2020 at 4:47 PM <yhchuang@realtek.com> wrote:
>
> From: Tzu-En Huang <tehuang@realtek.com>
>
> In associating and configuring beamformee, bfee->role is not
> correctly set before rtw_chip_ops::config_bfee().
> Fix it by setting it correctly.
>
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
Reviewed-by: Chris Chiu <chiu@endlessm.com>

>
> v1 -> v2
>   * cannot put bfee->role = RTW_BFEE_NONE after out_unlock
>     put it enclosed by else
>
> v2 -> v3
>   * remove unnecessary 'else' statement
>
> --
> 2.17.1
>
