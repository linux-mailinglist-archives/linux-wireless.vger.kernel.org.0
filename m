Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D6C39F0E7
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jun 2021 10:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhFHI3j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Jun 2021 04:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFHI3i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Jun 2021 04:29:38 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C054EC061787
        for <linux-wireless@vger.kernel.org>; Tue,  8 Jun 2021 01:27:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d5-20020a17090ab305b02901675357c371so13274608pjr.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jun 2021 01:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kru1jVKIZDBbX/gbXId8v7rU5ZsvCdv1CDcksUANLSM=;
        b=PCY7GfBYObdBW6XaxdECThXX+WKhR0WID57PrjrWtuc52OtUQzDC1l6FFxmF5/dMVw
         G+QM5sEHfZmNy/aEaLf6Acw0vzeeoMSHkt3bqAJnjjo4RfSqrk0okxmOs/mn2uA8zpGp
         fSgXCMbgNwV5H7JNsjXoGUmrr0GrxfI/hi6JfLrG2YhIEJk5AgVbmh6z5R/aj1cw6/p+
         +4G9qZPpXLdjYsPSlnNZbAp6Hj42wgyVnSZOq1/SElmgJBL4Z2W3NmaBks7ULIfhNrui
         DhXwZuoCSY9xiEpGPuin1DAtSnENmnMHhinlG4gKCT2Px0sylPVun+ttRHxAYFtvNxz/
         /iUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kru1jVKIZDBbX/gbXId8v7rU5ZsvCdv1CDcksUANLSM=;
        b=J4v9nfPQF8y262E1MGbDbUi4YCAUfXZL5D4vj4GDc4+v41dZebmIz3ipMswlyeEwQj
         jOqA7Rc3aTxWVV+EmB/3yHa2cmsWdGFitWeFQyI1ts+0D9zqpqfrTZRhZ9zPT78BkhG0
         8uXmt+zTy9wTNSQQBLnl0WHrBL3kViByqS20/MhKDuLWJa3+vldg0iRZdS1/qxa6/R3m
         Ca5SOGoTfIBO/yi8/uV6OM4xvDrBLXW6jPw6lZfNCYm+Ktaqs2C8TDZhYirhSM1sfvA3
         TCwlGOZcBtyDH8EC5kkE6luEjw6UM8jatq73iJfoZRHwqxy6zyNgFBM234bpFCQMdHXA
         HPpA==
X-Gm-Message-State: AOAM532bWJpz9DIXq8m8yrszThg6OYH4K4pW8axb3bpvSj+pPY0BUFJE
        zk8Qke5VPxHfyIoeQwbQpAmVJat3oPtPapgq+OFtyA==
X-Google-Smtp-Source: ABdhPJzbAX1nUH+3GGcXlPZ9uD9JPAK6Bo2dLzJrat++g2PixCKqruoRtTKM8RrwvOduXp07jnUJUOlJHmx5O/L29mA=
X-Received: by 2002:a17:902:8e86:b029:10f:44bb:2c42 with SMTP id
 bg6-20020a1709028e86b029010f44bb2c42mr20670116plb.67.1623140848266; Tue, 08
 Jun 2021 01:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210608040241.10658-1-ryazanov.s.a@gmail.com> <20210608040241.10658-5-ryazanov.s.a@gmail.com>
In-Reply-To: <20210608040241.10658-5-ryazanov.s.a@gmail.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 8 Jun 2021 10:36:39 +0200
Message-ID: <CAMZdPi9myKaDmanHv-FGrdwv0taDU3Q-8=n5zL0QHA12go=9Kw@mail.gmail.com>
Subject: Re: [PATCH 04/10] net: wwan: core: init port type string array using
 enum values
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 8 Jun 2021 at 06:02, Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
>
> This array is indexed by port type. Make it self-descriptive by using
> the port type enum values as indices in the array initializer.
>
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
