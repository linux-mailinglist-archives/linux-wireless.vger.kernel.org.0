Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54872D36BE
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 00:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbgLHXLc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 18:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbgLHXLb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 18:11:31 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9BEC0613CF
        for <linux-wireless@vger.kernel.org>; Tue,  8 Dec 2020 15:10:51 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id h18so367301otq.12
        for <linux-wireless@vger.kernel.org>; Tue, 08 Dec 2020 15:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jHz309rbDlsSLjV/TxkCT8sBuAeA8cl3QJTN2mWx3uk=;
        b=IYS4Uw+1WmV25KVrrQJIKGIkZxO8VIJKlsI5XuuDHYtitJaLoQpWY+WbkRavl4/0LB
         QsyPm7w+elo9PB+OyzXq4o91tFD5ebnYwdRALclGHBh+M4Vba6LYOPPowgXEtIg8Hyhm
         q6DH1DI01mKHq+rf2rXy9/A6ho7xdTDLqzcL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jHz309rbDlsSLjV/TxkCT8sBuAeA8cl3QJTN2mWx3uk=;
        b=dR70LxqISzHMzB8uK7Hm7EzGKzGuf98K3W3uOoxIMqpnide+gKR7SHYUHre9jH7tE5
         C6D2p8ZlIlif8UK7UMLB3iUjN8V0BJDJQzXxzjgiZ2rUS0nhocqhqikuQalmFey3Ty4j
         vywM/10hD8DPn0FTKANpwjIqHSFmKc2wijApvJ9s257Vb4Clvh1VKeZbH7T3fSY8ampr
         Dpq5G4d8FO3WdjB//beF8yTzDx7SJYtlB6iRjOZYS9++Ftyr+GECl5ewrkPPmAr62T3R
         LUy7p5U4x/gBdX71oVoGLJawkjtUYPJOOuDpQGPmmj5gqPgHOK48iLLEP9CVRFf5j+e5
         nbFQ==
X-Gm-Message-State: AOAM533n6uRHWsNlE1Dq0Ti7U5PmQdQbIXhr+qfRSuKjoTsTlmoeqXan
        FrmXhmpfePFFLhAqlqg7xgtstwlQ04i2tw==
X-Google-Smtp-Source: ABdhPJzTUMs2U0t17tu1w51YjY/zdhCPzftgDg/wu5IFYLuBhiMV1fP/F06A9wa55Se4yLFuR0eX2g==
X-Received: by 2002:a9d:745a:: with SMTP id p26mr383363otk.206.1607469050546;
        Tue, 08 Dec 2020 15:10:50 -0800 (PST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id y84sm59537oig.36.2020.12.08.15.10.49
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 15:10:49 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id a109so434915otc.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Dec 2020 15:10:49 -0800 (PST)
X-Received: by 2002:a9d:744a:: with SMTP id p10mr340189otk.203.1607469048659;
 Tue, 08 Dec 2020 15:10:48 -0800 (PST)
MIME-Version: 1.0
References: <20200731024607.5817-1-yhchuang@realtek.com> <20200731024607.5817-3-yhchuang@realtek.com>
In-Reply-To: <20200731024607.5817-3-yhchuang@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 8 Dec 2020 15:10:36 -0800
X-Gmail-Original-Message-ID: <CA+ASDXMXfTBdK2G_QbrUOz2GpR27TcSxd-RHVdpyKu7k_d-qGQ@mail.gmail.com>
Message-ID: <CA+ASDXMXfTBdK2G_QbrUOz2GpR27TcSxd-RHVdpyKu7k_d-qGQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] rtw88: add adaptivity support for EU/JP regulatory
To:     Kalle Valo <kvalo@codeaurora.org>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Andy Huang <tehuang@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ Tony's new address

On Thu, Jul 30, 2020 at 7:46 PM <yhchuang@realtek.com> wrote:
>
> From: Tzu-En Huang <tehuang@realtek.com>
>
> From MIC Ordinance Regulating Radio Equipment article 49.20,
> ETSI EN-300-328 and EN-301-893, the device should be able to
> dynamically pause TX activity when energy detected on the air.
>
> To achieve this, add Energy Detected CCA (EDCCA) support to
> detect the energy in the channel. Driver will set corresponding
> thresholds to the device, if the energy detected exceeds the
> threshold, the TX activity will be halted immediately.
>
> As this could lead to performance downgrade when the environment
> is noisy, add a debugfs to disable this for debugging usage.
>
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

I see that this patch series is still marked Deferred:
https://patchwork.kernel.org/project/linux-wireless/patch/20200731024607.5817-2-yhchuang@realtek.com/
https://patchwork.kernel.org/project/linux-wireless/patch/20200731024607.5817-3-yhchuang@realtek.com/

and I'm still rebasing these patches in my tree. I realize the docs
say "the maintainer will revisit the patch in a later time":
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#checking_state_of_patches_from_patchwork
but I figured 4-5 months might be long enough to wait ;)

Was there something controversial about this patch set that makes it
difficult? Or should it get moved back to New? Or do Realtek folks
need to rebase/resubmit/

Thanks,
Brian
