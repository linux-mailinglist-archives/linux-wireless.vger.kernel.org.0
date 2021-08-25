Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3922A3F7ED6
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 01:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhHYXC1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Aug 2021 19:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhHYXC1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Aug 2021 19:02:27 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366E5C061757
        for <linux-wireless@vger.kernel.org>; Wed, 25 Aug 2021 16:01:41 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t35so1630087oiw.9
        for <linux-wireless@vger.kernel.org>; Wed, 25 Aug 2021 16:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c7HZlWC8KJohv3wxpeiYZ8xLIfggzme+ADhSLyEO+Yg=;
        b=kzEpcmV5cjVZjLrrDSrvWkwENdpxVZywXviL2w13mDb8LhPUcHx18eBMtuuR/U7BqI
         ZBKvsv64+VAjwxU4viRTT4nf5zu4onbxB+qAxSJpNMlD1DJGNen7l30Cp1ht2ou31L9H
         VKHIM2jFvbsin05OfbFvHhuCQOxJ7R44MPwzLP1C6tQaQwwxGAlnCE7hi4FGjLz8u16+
         OC6z0MJYoQwJMM962U3yNW4tfxBcXfqbOgrBOn/dv8pSDftHpuji1V6yPx38fG5JbX89
         XmiOpYmlNVouCymyfVL4YxXrnc64+dqvTc5elJ/n5Hm7zJJjk9L4nkvyosV+9WmN9zRc
         I51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c7HZlWC8KJohv3wxpeiYZ8xLIfggzme+ADhSLyEO+Yg=;
        b=GaKXP7bFrOGnHxnGDJRAUL8YwXrZCBVA/LYoZRVebBBUUQ6/VGmk55K6CHBn/vRzb+
         CsCreIt7A5hR9FrD58XSUV7P6k7Tb5dguAqwkuMFZ+Y0BhaJloRTN3H0KakGNPmcZQ8S
         aoLc0apLZr+s0m5lHNmT1f39GY9xEak48s5EFzOUeCDhaLJzDHeO0ADQpH+RzkES05uN
         M6jVpXEkvZtccVp+qiZIu2mZxD8VVw+b2XIFdVc0Vq8S4gXzzlRoDNrC1bNzvsTxQETx
         joaqouEf3f8+VDetcWBLAPBAsCxNoWDnJfVvA3NRoXYCSaPZtnWEpkxhRTIMJ3RC1yma
         T10g==
X-Gm-Message-State: AOAM531d+wIKD10iYzSFkgr/2NaKt7mgEWZ8c1TreeKxBAsR8dSkgbNL
        cfZrTPha0G94zfCOBeuFBUJNIt2X5OQmV9yqujw=
X-Google-Smtp-Source: ABdhPJyfWdhuq7QS8eNXfpfLZpVi4hXUbiV4Dx7xPMWbM48ok62/D1CS1zZm7aUrNajAyCd9p7QK3U39GoarGOwR24M=
X-Received: by 2002:aca:3488:: with SMTP id b130mr8461960oia.17.1629932500628;
 Wed, 25 Aug 2021 16:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <1629884277-18759-1-git-send-email-ppranees@codeaurora.org> <1629884277-18759-12-git-send-email-ppranees@codeaurora.org>
In-Reply-To: <1629884277-18759-12-git-send-email-ppranees@codeaurora.org>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Thu, 26 Aug 2021 02:02:10 +0300
Message-ID: <CAHNKnsRi9CYH4vZfgpEUTJEHJfb-Av24dyE-_7pc7KMKy3S8VA@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] ath11k: add branch predictors in dp_tx path
To:     P Praneesh <ppranees@codeaurora.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, Sriram R <srirrama@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 25, 2021 at 12:39 PM P Praneesh <ppranees@codeaurora.org> wrote:
> Add branch prediction in dp_tx code path in
> tx and tx completion handlers.
>
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1 v2
>
> Co-developed-by: Sriram R <srirrama@codeaurora.org>
> Signed-off-by: Sriram R <srirrama@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: P Praneesh <ppranees@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/dp_tx.c | 45 +++++++++++++++++----------------
>  drivers/net/wireless/ath/ath11k/mac.c   |  2 +-
>  2 files changed, 24 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
> index 8bba523..ab9ccf0 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c

[skipped]

> @@ -432,12 +432,12 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
>
>         rcu_read_lock();
>
> -       if (!rcu_dereference(ab->pdevs_active[ar->pdev_idx])) {
> +       if (unlikely(!rcu_dereference(ab->pdevs_active[ar->pdev_idx]))) {
>                 dev_kfree_skb_any(msdu);
>                 goto exit;
>         }

This is another place where rcu_dereference() could be replaced by the
rcu_access_pointer() and the whole block could be moved above the
rcu_read_lock().

On the other hand this is an _unlikely_ path, so it looks like a
matter of taste which macro to use here.

-- 
Sergey
