Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D54418D39
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Sep 2021 02:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhI0AKN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Sep 2021 20:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbhI0AKN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Sep 2021 20:10:13 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6E5C061604
        for <linux-wireless@vger.kernel.org>; Sun, 26 Sep 2021 17:08:36 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id y186so4729690pgd.0
        for <linux-wireless@vger.kernel.org>; Sun, 26 Sep 2021 17:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZITki0Tlgr2SOixro8XnxB3qWg1irmvVm6UWMwcCgLY=;
        b=r9nqq+3OdoQV3e1vn4PowWpeKZ7ylD4rWLhHVnCkJP417FnWIxEDgJhoCgkID6ihv1
         usIsh1VFvVIRavVoe00+WMmx2tYWi/QD723QrCt9LZpR4/Mod7LMVfMWTClFddoljQEc
         TEhnjOHX7bXrQeCh69iNqjK8E9j+13McwJdENTftglreWqiJ2YFUsWOa3bAggPw6johS
         8oJK/UXUriiDjI7S10sQPHBxJpaM2ElHt7JCEH7/rLq5CFSlYuEmLcM7VQ56ZiuVf+sn
         GFi/rzGBA1wjn9ESFjsdGsQu4Vz1v5DYt3Etzr8joN6jFAozZG16N4846jZNapfsntGv
         jU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZITki0Tlgr2SOixro8XnxB3qWg1irmvVm6UWMwcCgLY=;
        b=Mb92AZZoELWmX0Vnxtu8OmKSZUplBG683ND1Vkmh3uXWlVmLPAR2S/gOleDGSsYfIR
         41N4ZkyzQth5wQQjJBw6L0pMZehQeRaqq9OV2A4OgVgYyanvyCKSLBqHZK+dv5pKBW2Z
         Yx4We6KotcMbAE01QgI6Fj49i5D7xyOdZI1wiKualwDV0UDHZxRAw+BoZwmJxh7YK0pY
         bdOnQmpdQMWngD9LM+VA8WDjqXSiC4v5jXT6tDiULNe0MuSIYPLf0yhGqyh1QlwOTX6g
         zzIttPFJ3jmPQ2cwZYNfeuYAv3WS4WWHOKYaXO8+OFfVQxCUgsA1QrA6d4lTkmDvCVEd
         8NOw==
X-Gm-Message-State: AOAM530h8+tJ9bqnFESfolF7xpaCoSDzt6480QN7hzpm5ldg47GRwzmv
        M34pqIOpZ7OBYyaY8WtSMU9hYw==
X-Google-Smtp-Source: ABdhPJz0KqJsswBZcZk1GMY1L+3Mp/JKNhbpIZ8FC0/9c8ADjX/fqNNkL2mOqao3KlX8y8cpTT39nw==
X-Received: by 2002:a05:6a00:4:b0:440:6476:bcb4 with SMTP id h4-20020a056a00000400b004406476bcb4mr20529491pfk.0.1632701315853;
        Sun, 26 Sep 2021 17:08:35 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id o14sm15485637pfh.84.2021.09.26.17.08.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Sep 2021 17:08:35 -0700 (PDT)
Date:   Mon, 27 Sep 2021 08:08:29 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Soeren Moch <smoch@web.de>
Cc:     Kalle Valo <kvalo@codeaurora.org>, stable@vger.kernel.org,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "brcmfmac: use ISO3166 country code and 0 rev as
 fallback"
Message-ID: <20210927000828.GE9901@dragon>
References: <20210926201905.211605-1-smoch@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210926201905.211605-1-smoch@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Sep 26, 2021 at 10:19:05PM +0200, Soeren Moch wrote:
> This reverts commit b0b524f079a23e440dd22b04e369368dde847533.
> 
> Commit b0b524f079a2 ("brcmfmac: use ISO3166 country code and 0 rev
> as fallback") changes country setup to directly use ISO3166 country
> codes if no more specific code is configured. This was done under
> the assumption that brcmfmac firmwares can handle such simple
> direct mapping from country codes to firmware ccode values.
> 
> Unfortunately this is not true for all chipset/firmware combinations.
> E.g. BCM4359/9 devices stop working as access point with this change,
> so revert the offending commit to avoid the regression.
> 
> Signed-off-by: Soeren Moch <smoch@web.de>
> Cc: stable@vger.kernel.org  # 5.14.x

Acked-by: Shawn Guo <shawn.guo@linaro.org>
