Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4126B1F34A6
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 09:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgFIHKU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 03:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgFIHKT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 03:10:19 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B7BC05BD43
        for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2020 00:10:19 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c17so23639075lji.11
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2020 00:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A9Ho8otvYf7kSdEyzjj0hnww9Z78Ls6o++NXdJ56e/M=;
        b=TT1dKXxu7EqWLsruajQ2DHtxOZbUV/4VwvHFmSL2TrQXWIL6/kUWCmJtBo6iAgAtvS
         gafhmLw6opUNv7niA3MlbuqpzKIe5THLr6gYBwOoy72g47kBLLKuNJkiNzgSm3r+KsxK
         fUSO86qnPRgvdsYEYCcsURK2YVcxnm6/oZ6DOF6GLF8fBeLCVqhlHZIcvEu8xneOhT/3
         y11LOZN/4CkJXnKKo7N10Od/iq32yBH8lWMErAAigs6CLM+OR8kP55ksK/90KqasN4dM
         ZpT3L0kjH4dKMo/RxueDRvyiCa5QkjT1eY+CMVKimsEaG8OOtrUS1mX1Agg4o2Diva8h
         fJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9Ho8otvYf7kSdEyzjj0hnww9Z78Ls6o++NXdJ56e/M=;
        b=cp3+8YLoiogWvVJZnwZ9YTO//zqv3sT1ELQi7NgtJYXtT/MPKOev8NsaMgY/OKFan5
         grYVPvxKPxugVfTGX8YK7EE5+DhqoI19NKR8C3VLIJKpAt9CjZzTiU2WyCu8EpHbYLE0
         3MD6xgUXsyxGBuERNY5YxwDbeP2K3JmQeNf/lRf+/kqbiYoyRzWvhDPCnSjDH+WWNPpI
         P4jSwjSBzjB5rHMTe5giDD0+qZVWd0/2YGVGCspl7SATbSF1oxS3ie9gr9TwdYaR3RWs
         CPx+vnOvDJRRWDLC4TJHWI5IhnItNFjdVummq1spLFY5jMPu4o1zVdyqPYb1SwkqLIx4
         85xw==
X-Gm-Message-State: AOAM531QzvUUkz75rYIgh6o1ASJAKjYm75TK4oaQJ3S96Lph6QgLokI5
        U+LenscsOg0JqNxxpo5dM0QOyYGNULg8aaGX7VxB8g==
X-Google-Smtp-Source: ABdhPJzQCf9tPCArAnj75yAefkcWYrJVyl/BHhjbRmGeZefAqUJnW8VnpoUxcnP5oHeYQFS5d5UyzJeQ4PnU+cj9h+E=
X-Received: by 2002:a2e:908f:: with SMTP id l15mr8212442ljg.307.1591686617869;
 Tue, 09 Jun 2020 00:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <1591678993-11016-1-git-send-email-akolli@codeaurora.org> <1591678993-11016-8-git-send-email-akolli@codeaurora.org>
In-Reply-To: <1591678993-11016-8-git-send-email-akolli@codeaurora.org>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Tue, 9 Jun 2020 17:10:06 +1000
Message-ID: <CAGRGNgWO_KwfQcfh=DSB5NdM2696ZzVU7ZuQN_x_+op1c5ySEw@mail.gmail.com>
Subject: Re: [PATCH 7/8] ath11k: add ce services for IPQ6018
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Anilkumar,

On Tue, Jun 9, 2020 at 3:07 PM Anilkumar Kolli <akolli@codeaurora.org> wrote:
>
> IPQ6018 does not support mac2, add a new ce service map.
>
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/ahb.c | 122 ++++++++++++++++++++++++++++++++--
>  1 file changed, 117 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
> index b080ad8fab0a..25764f719db0 100644
> --- a/drivers/net/wireless/ath/ath11k/ahb.c
> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
> @@ -647,8 +749,15 @@ static void ath11k_ahb_init_qmi_ce_config(struct ath11k_base *ab)
>
>         cfg->tgt_ce_len = ARRAY_SIZE(target_ce_config_wlan) - 1;
>         cfg->tgt_ce = target_ce_config_wlan;
> -       cfg->svc_to_ce_map_len = ARRAY_SIZE(target_service_to_ce_map_wlan);
> -       cfg->svc_to_ce_map = target_service_to_ce_map_wlan;
> +       if (ab->hw_params.dev_id == ATH11K_HW_IPQ6018) {
> +               cfg->svc_to_ce_map_len =
> +                       ARRAY_SIZE(target_service_to_ce_map_wlan_ipq6018);
> +               cfg->svc_to_ce_map = target_service_to_ce_map_wlan_ipq6018;
> +       } else {
> +               cfg->svc_to_ce_map_len =
> +                       ARRAY_SIZE(target_service_to_ce_map_wlan_ipq8074);
> +               cfg->svc_to_ce_map = target_service_to_ce_map_wlan_ipq8074;
> +       }

You could just have a pointer to this array in the "hw_params"
structure which would reduce this to something like:

cfg->svc_to_ce_map_len = ARRAY_SIZE(ab->hw_params.service_to_ce_map);
cfg->svc_to_ce_map = ab->hw_params.service_to_ce_map;

and make adding future hardware easier.

>  }
>
>  static void ath11k_ahb_free_ext_irq(struct ath11k_base *ab)
> @@ -856,8 +965,11 @@ static int ath11k_ahb_map_service_to_pipe(struct ath11k_base *ab, u16 service_id
>         bool ul_set = false, dl_set = false;
>         int i;
>
> -       for (i = 0; i < ARRAY_SIZE(target_service_to_ce_map_wlan); i++) {
> -               entry = &target_service_to_ce_map_wlan[i];
> +       for (i = 0; i < ab->qmi.ce_cfg.svc_to_ce_map_len; i++) {

Is this the same "svc_to_ce_map_len" as in the hunk above?

If so the code below could just be:

entry = &ab->qmi.ce_cfg.svc_to_ce_map[i];

> +               if (ab->hw_params.dev_id == ATH11K_HW_IPQ6018)
> +                       entry = &target_service_to_ce_map_wlan_ipq6018[i];
> +               else
> +                       entry = &target_service_to_ce_map_wlan_ipq8074[i];
>
>                 if (__le32_to_cpu(entry->service_id) != service_id)
>                         continue;
> --
> 2.7.4
>

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
