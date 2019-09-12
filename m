Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9F9B0924
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2019 09:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfILHFy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Sep 2019 03:05:54 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46867 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfILHFy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Sep 2019 03:05:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id v11so28355119qto.13
        for <linux-wireless@vger.kernel.org>; Thu, 12 Sep 2019 00:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XdVS0GTBmq8aqv8u5teNHgP6ys6TMpE3OOp/NhVioGo=;
        b=PnTDAd5IxPnvcZb3zx2U56IlBNF0lC0EtVpc9FDb812AGSWOub+stuFd3KacxuIKfD
         BPCRrdftemjf1kMH6oo14SKtfbbaWcLglIw22U3xt2b+d3ifmmG+O2v4Qwel26G+9oO9
         j2n7sxmF9rRgbOZlcPBaz5rowdxEz6CAEtzWmHsmRxLiHlrIXp4oIBWxCNQ//h4l+YBY
         +c0LYNh3D3i7eMZB8E7Wis3bIlsRuTLGnMu2EHJVwME9pO2YaaB6JTFCTgjCCMB8UsJY
         nplJu4SVrUCe3ckGdigSNMVw6Kw7ePBkmw9my6clRwEoksWJGJ3Z0Rza5gcsgM64e1IC
         SFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XdVS0GTBmq8aqv8u5teNHgP6ys6TMpE3OOp/NhVioGo=;
        b=mTZfx7p1ovzs9Ocvmffou47ooPFwKrjnVPAV5WrxwMu0/APl6cqIsDzcHdkthcCY2x
         5GleV/x+K7k5vSALRb6HOq8WjJp5lmihRQQlFI6ADOIppMlAsvZKtNgUEQxTtLbqlggw
         6w69XuOpJUQoSsNLBjFG9X+VqPaqA7FzLAbGVBK8M0gEqSvOcqEyF++RyRASYjHskWWF
         EfrbI8XMf7ps15vCj22q9Mqj9+aQh7zo7nJIUBkjKK0SXN3XLqPYDx5Bc0Q7/xnjhmNb
         Fc97/lkFSXKi/EDIMr82YikUXBbiLJuiBPKAVN4UAbQ+WlN9IalTICJdNy3Y60+kTgn7
         8oHg==
X-Gm-Message-State: APjAAAV6+qYTsegZ6t5Ffwjx1e5sc27goawD3QdcdAJPrfcQwQv+Oso7
        ZFuJ/IZ6bZfFEcJGlkSsK2L15g6ZNZz9XuqBT9kcZw==
X-Google-Smtp-Source: APXvYqwYYZajUfLdoQzqn71l4lABvnhxBsMcR5omR5HJM4ijPZBH4wh6DUY+3vdFyP8bFoi86FOVl6+PNn8YPcewr1E=
X-Received: by 2002:ac8:6bc8:: with SMTP id b8mr6344934qtt.95.1568271952131;
 Thu, 12 Sep 2019 00:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <1568270355-29727-1-git-send-email-yhchuang@realtek.com> <1568270355-29727-2-git-send-email-yhchuang@realtek.com>
In-Reply-To: <1568270355-29727-2-git-send-email-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 12 Sep 2019 15:05:41 +0800
Message-ID: <CAB4CAwdP+qfUXzhz4Foe2uUb1jaSd9FBtndzKZoM07BU9F=ssg@mail.gmail.com>
Subject: Re: [PATCH 1/2] rtw88: fix wrong rx power calculation
To:     yhchuang@realtek.com
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        briannorris@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Sep 12, 2019 at 2:39 PM <yhchuang@realtek.com> wrote:
>
> From: Tsang-Shian Lin <thlin@realtek.com>
>
> Fix the wrong RF path for CCK rx power calculation.
>
> Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
> Signed-off-by: Tsang-Shian Lin <thlin@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
Reviewed-by: Chris Chiu <chiu@endlessm.com>
> ---
>  drivers/net/wireless/realtek/rtw88/rtw8822c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
