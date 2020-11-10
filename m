Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A5D2AE1F9
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 22:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbgKJVml (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 16:42:41 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55331 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731992AbgKJVlF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 16:41:05 -0500
Received: from mail-oi1-f200.google.com ([209.85.167.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1kcbNv-0003PD-KX
        for linux-wireless@vger.kernel.org; Tue, 10 Nov 2020 21:41:03 +0000
Received: by mail-oi1-f200.google.com with SMTP id u24so43481oiv.0
        for <linux-wireless@vger.kernel.org>; Tue, 10 Nov 2020 13:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gi2qCG7vZVjA2NVWHQOHYg/qHFwRYcU2uHFUPGZGuBU=;
        b=DEWhfqIoMw+iXX1gx/mz7vtQXrCVJbESG+IWcc5pjmvMAndWhZolle14Ld4cbAjt/q
         EnIuSxs+O/P43H6ZyOXgk8wXKdt50yo9+5PtFs4xEuI1zzoIjbVi9UhffkD+Uz2NPXLf
         6z/+62zZiuTgPXcwv4wJ5kWHa90cQWhThEuceyuFCl9/k01ilX4Xq4bh82S6dft8cxg3
         j5z1zZEaSTUHBRpBowGlsnXQh8TdukTPTQ3kFVH/ctcYJs6UsesLG428HGgylgJD3o3S
         zvKL9Vb5+d3b62B6ENK0UCf0iBn51mCSnlzL0SoIugi/FzkYp6xvWd4tgybjrIhDAlKH
         ZWtw==
X-Gm-Message-State: AOAM5319yOULKAsLj3vr+6wQtn1/QnaQ1iy8b7T6Yr7zl3+HH3z1Rt96
        rNaS8xhZsNByBmjHyl36EQFK2TromYbUolzy79mJuycPa4zLdPw17h8vXUz4GzuAct7i2WPzY2A
        jxrLtKfuionm+0EZrP8GxmsNE05BZ+UPu8TPXgqkZKNGF
X-Received: by 2002:aca:cc01:: with SMTP id c1mr70584oig.147.1605044462595;
        Tue, 10 Nov 2020 13:41:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzilmdcWJIVPAjZxUAcnW89AOUZoduSV9BDAKrqJqrAsohh/nteHAoaXv/YS9TqSZ2kVHZ5Eg==
X-Received: by 2002:aca:cc01:: with SMTP id c1mr70573oig.147.1605044462378;
        Tue, 10 Nov 2020 13:41:02 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:59ea:bfb1:548d:1c70])
        by smtp.gmail.com with ESMTPSA id s20sm47903oof.39.2020.11.10.13.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:41:01 -0800 (PST)
Date:   Tue, 10 Nov 2020 15:41:00 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Abdul Rauf <abdulraufmujahid@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Pakistan
 (PK) on 5GHz
Message-ID: <20201110214100.GN6125@ubuntu-x1>
References: <20201020181731.GA18865@leagueoflegends>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020181731.GA18865@leagueoflegends>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 20, 2020 at 11:17:31PM +0500, Abdul Rauf wrote:
> Update range to 5.725 - 5.875 Ghz
> as mentioned at https://fab.gov.pk/type-approval/
> 
> Signed-off-by: Abdul Rauf <abdulraufmujahid@gmail.com>

Applied, thanks!

> ---
>  db.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/db.txt b/db.txt
> index ac32483..ce8449c 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1243,8 +1243,10 @@ country PH: DFS-FCC
>  	(5735 - 5835 @ 80), (30)
>  
>  country PK: DFS-JP
> +	# https://fab.gov.pk/type-approval/
> +	# https://pta.gov.pk/media/Pakistan_Table_of_Frequency_Allocations.pdf
>  	(2402 - 2482 @ 40), (20)
> -	(5735 - 5835 @ 80), (30)
> +	(5725 - 5875 @ 80), (30)
>  
>  # PL as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
>  # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
> -- 
> 2.25.1
> 
