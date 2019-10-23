Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C90B2E104E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2019 05:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbfJWDA7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 23:00:59 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:38327 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731951AbfJWDA6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 23:00:58 -0400
Received: by mail-qt1-f181.google.com with SMTP id o25so16785527qtr.5
        for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2019 20:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YARoJvbXa5IVPfrRqD+GG0sdSg3qTNRY0h+SNpOhsUg=;
        b=QhLgKj+eSWs/JcLKgkJWuGzw1JR2I52axOIgdf9UZfrlmlZpuqBMMSFtbv3fMIuYDl
         CJWC178bpDOYLgb9ysugxKGLGCgjCf3wh4zBu9SMcrFPD3e28mU1WiSL9UdOYRNUj3Lf
         OmZI3cKacQh1hkfjExqy9T6vIefTp++wygWpOJG+z4GC6OOr2V+pAdOIC0NuNAzdyjd2
         wKf+hpEFM8RWt3wG0K6Eak+N5G6p968e+o+bZlrLdTs6CdI1z9g1Hz3TqU9Vj7ydz74+
         2IqrWBrZJifQMgqPoNunKdS/npSy5n4xDQRXEEFs5S8hsxcAuMvYYybhHbMsaQZ5vGiw
         mtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YARoJvbXa5IVPfrRqD+GG0sdSg3qTNRY0h+SNpOhsUg=;
        b=r5/24tHW65sOdiqBIZfrUEK2IDAyIyVCzNqtzgXC+Tp4LnW/YK29C0OpIZN+VA5QtE
         ZPEdMT3vq6jPLfe99d2fBE5E6AMJone44vEAymDPZMgPucF9F/kCq+GqM8J8y7crhTWE
         0EqinTyF8LzYSdjvPO4JhV8TxZm+F/JLxBb4kTCav2EczYRngL/ko9Y2DnzHLNKoEivY
         Vz++yiiRuTnZ0gYNN1Cj1gI9CJkGopzJM5jDtRpe/W5qyfBxaI/7r3CtV6NXtmS/ZZid
         djGPhy6pbJsqqU9ST4IFBoThM+4W7VFS+uq0INRBKpjgrKplUDWPfphEarvV0xfwYbXk
         E+Zg==
X-Gm-Message-State: APjAAAUwEBLU1dDqgdsEsUI8a/CTOzlRIfidxB8dNKdCKfM99mIAlQxl
        p8bx+DPxNpQYJwG2sgvTPdzbuYppklmLiRw5BLCvJw==
X-Google-Smtp-Source: APXvYqz+KPHHgGWjazHY9+W6HWYZyqLUGPWFeSr1lyxrYj6Sb1uwVWcEo4DFaSadL5CjAjcZQVXj/4IcCxPqVRqMOFs=
X-Received: by 2002:ac8:23f0:: with SMTP id r45mr6932997qtr.208.1571799657584;
 Tue, 22 Oct 2019 20:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191022100420.25116-1-yhchuang@realtek.com> <20191022100420.25116-3-yhchuang@realtek.com>
 <CAB4CAwes6r17gCGF-WKB=i9cN8dz6evA_g9SGzNdmJXsNcmTxQ@mail.gmail.com> <F7CD281DE3E379468C6D07993EA72F84D19069EB@RTITMBSVM04.realtek.com.tw>
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D19069EB@RTITMBSVM04.realtek.com.tw>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 23 Oct 2019 11:00:46 +0800
Message-ID: <CAB4CAwekWUcJUSPYaRrmqp78ctUhfoGzLyrwoVjxMTMSOHGcSg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] rtw88: add power tracking support
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 23, 2019 at 10:23 AM Tony Chuang <yhchuang@realtek.com> wrote:
>
> >
> > I don't see any chance that delta_power_index[] will be < 0. Either from
> > rtw_phy_pwrtrack_get_pwridx() or swing_table.
> >
> > Maybe just use u8 instead of s8?
> >
>
> I think "return -delta_swing_table_idx_neg[delta];" should be stored
> with s8 ?
>

Sorry for missing that. I was somehow misled by the naming 'power_index'.

> Yan-Hsuan
