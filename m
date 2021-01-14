Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2EA2F69AB
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 19:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbhANSfN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 13:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbhANSfM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 13:35:12 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BFBC061575
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jan 2021 10:34:32 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id w124so6919000oia.6
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jan 2021 10:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZh/mWJSzO+TetDOcszyEvmZmAyAbAOQdCJcm1GsPiU=;
        b=AesTqJo1ng30NLzIT/3qy8fktkiK/XYb7DNqu8866RQ7bZl7Tr/Dhzb8N7A5lPp+8A
         l4kg16Q0q/j+T0XcTdqz1MYonF2SbruApQfhG8vKGCejUPCoMSYOOL8a3Ox1CBe4CKci
         1R3i3JUAPIoEwhyQfAx62YToF3pnHcmyuiYA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZh/mWJSzO+TetDOcszyEvmZmAyAbAOQdCJcm1GsPiU=;
        b=MlRSqSTQmaxUySiF9K+Lijmd0rYT+PZ4ciHY8PAeDu8WvZ7aHu6A6ahzYSQDeDinV/
         PL/mqIR2qjlCZe5k8RyHeIGR/31BGma+nimwyPwFBuB6S1XYrqdLXPruefXpQPH7LIau
         jjdEb8lg7a7f689zWylPZ3E3vjXe3dDxVYVWiyVHycqYtcg5E5rVnfZ8ekLLgtsGoG57
         GC0Wyi/ZCQlSrPr8OT6QVf9LR3YQkUKIWJUgTb/l4bbux/0DscJ+DE8GbQLwpNsvOxck
         07WXoQkJBdaRvAUDvKDVzUKfpSOwrMrfx4LqcKXO13V0CKu13WCwwgAIEKXgEpaCxCy2
         Esrg==
X-Gm-Message-State: AOAM533e/IsLoaPFmW6Wiwu0gJXIgDWLcPfr8C8maBKr647mfzT5huHj
        6LuzSs76SB5njg7beMyfVPO0HzfFXjbw3g==
X-Google-Smtp-Source: ABdhPJwB3aGM0L5fD2Uf1PFHlI1sXDykaj9Jgyl09ixkQ4y244XqHF1XbehPdxGXJ8C0r0wRdMw82w==
X-Received: by 2002:a05:6808:2cb:: with SMTP id a11mr3418277oid.93.1610649271393;
        Thu, 14 Jan 2021 10:34:31 -0800 (PST)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id z3sm1207800ota.80.2021.01.14.10.34.30
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 10:34:30 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id l207so6940212oib.4
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jan 2021 10:34:30 -0800 (PST)
X-Received: by 2002:aca:d696:: with SMTP id n144mr3260842oig.77.1610649269609;
 Thu, 14 Jan 2021 10:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20210114010950.3316-1-pkshih@realtek.com> <20210114010950.3316-5-pkshih@realtek.com>
In-Reply-To: <20210114010950.3316-5-pkshih@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 14 Jan 2021 10:34:18 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPy784XGyqV-EM2KF_=K58CG6fLdhieZSoxvpbfQC5rvg@mail.gmail.com>
Message-ID: <CA+ASDXPy784XGyqV-EM2KF_=K58CG6fLdhieZSoxvpbfQC5rvg@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 4/8] rtw88: replace tx tasklet with tx work
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        phhuang@realtek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jan 13, 2021 at 5:45 PM Ping-Ke Shih <pkshih@realtek.com> wrote:
>
> From: Po-Hao Huang <phhuang@realtek.com>
>
> Move tx tasklet to thread, by this we can reduce time spent on
> waiting for schedule and have better efficiency.
>
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

I'll note here for completeness: I suggested considering a workqueue
on v2 (I hadn't yet received v3), and Realtek was planning on
considering that.

Brian
