Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A2E30B8B7
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Feb 2021 08:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhBBHgW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Feb 2021 02:36:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39174 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhBBHgT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Feb 2021 02:36:19 -0500
Received: from mail-lj1-f197.google.com ([209.85.208.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1l6qDp-0007js-PW
        for linux-wireless@vger.kernel.org; Tue, 02 Feb 2021 07:35:37 +0000
Received: by mail-lj1-f197.google.com with SMTP id m16so10852427ljb.20
        for <linux-wireless@vger.kernel.org>; Mon, 01 Feb 2021 23:35:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=seJD1Jdpb4jEZkPZZfgRwYyzIX2lIdzvxkmqWrtsCAE=;
        b=gXoh37j/1ej6Qf9ssdHoQF2Ra0DFiTBD1S9PdkOcBsgnA/eom8AGcwHQ5SwyY2ECH4
         5dFWNRm12eX4J3mBLXrCvOOY5DP2dIDiLKs6dZCtOlNsNJA6cqM3820Xc639ZcqNA9Cr
         v2/TAGz4vG2tntaE4J63+ZuI6iXWbAsc3LbwYAG28as1ig0ODZjNUlLNhzn/pTRu+zsY
         qLxqlxHRi4LPT9e0sjshBQH7e2XvnPp51Ot5sw6ImpvUSvQ2FPEsZTRMBr147uJoO2tf
         maMEvUk5Y5eUKLruH4sJCMzKPg8Rs4nwEQtjJWVs8qKxnewUrQ27EBB6aIE8OKYEkdYw
         c1Tw==
X-Gm-Message-State: AOAM530SGaZLSmuv/aruE/AZPfK0bWtrmxFZE75buF4+sELoK9yGEY/X
        ukE2Wka7GvbAM3Lx1IfXYnnNY9YTqY0FH8EHSf/9vWizjETwN/JhHtUymlDA2oKNqlsEFBTUhGJ
        CYr6b1AJ156FCqQEBpar66hhfHXpy2fwvYrbNzWr0IcDQtw2xvGMRTv509nrs
X-Received: by 2002:a19:ca03:: with SMTP id a3mr9947180lfg.425.1612251337153;
        Mon, 01 Feb 2021 23:35:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhKTJzRcSTMQcIhemobEzsfevc3BYDBf9PqdMMO3pkEY4hANEFGiSjI2tqXJPXlKF38pLhk0DPdI8AfGwZAc0=
X-Received: by 2002:a19:ca03:: with SMTP id a3mr9947174lfg.425.1612251336857;
 Mon, 01 Feb 2021 23:35:36 -0800 (PST)
MIME-Version: 1.0
References: <20210202055012.8296-1-pkshih@realtek.com> <20210202055012.8296-4-pkshih@realtek.com>
In-Reply-To: <20210202055012.8296-4-pkshih@realtek.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 2 Feb 2021 15:35:25 +0800
Message-ID: <CAAd53p4od1-Ait8HxRS3_8zcv=0_-EJcbh=yxSW-ry8FxgTh0w@mail.gmail.com>
Subject: Re: [PATCH 3/3] rtw88: 8821c: support RFE type2 wifi NIC
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     tony0620emma@gmail.com, Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Feb 2, 2021 at 1:54 PM Ping-Ke Shih <pkshih@realtek.com> wrote:
>
> From: Guo-Feng Fan <vincent_fann@realtek.com>
>
> RFE type2 is a new NIC which has one RF antenna shares with BT.
> Update phy parameter to verstion V57 to allow initial procedure
> to load extra AGC table for sharing antenna NIC.
>
> Signed-off-by: Guo-Feng Fan <vincent_fann@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

For the series,
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
