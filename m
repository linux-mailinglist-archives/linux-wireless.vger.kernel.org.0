Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E501FFE7B
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2020 01:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgFRXKf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jun 2020 19:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbgFRXKd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jun 2020 19:10:33 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87675C06174E;
        Thu, 18 Jun 2020 16:10:30 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id t74so4481030lff.2;
        Thu, 18 Jun 2020 16:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhny5BIdzMCArxR5VVXdJjK2vn4kS8RKmRFpsfCevPo=;
        b=bm5i5THmxV5QUrZXYzYo6o5ytzJhgUz2H49bve/mjYyKH76R9UA1HnIjSTMyoyIsEy
         rQxwk78x/zmFthZ8e3EDTouF05bgbSpKjEAXhHS4+T3QhLP8rl3Gp8ijZA9pQXzNsLRi
         7zG8WJkOHmKWKbIhdGuTfdTUCk5p1tzvF9DqkqCq3cMJEsnhlHejESGAKix4klGgMLPl
         20v6oxpUPVkem9Nmj7zoQZM7b/SHEKYRx1N2xfBhHB7H0iQR24Xrc3FTEC91DFGj0rWs
         Q3X/ZFhnEq2LOmhgsUhTq+NeJTmX8ziIQoG4sdodcp4Nh5SjdCB11I+DjHJxwiV83mNW
         eHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhny5BIdzMCArxR5VVXdJjK2vn4kS8RKmRFpsfCevPo=;
        b=RUyvarIXE4sjufpmrVZsoS+jyUtZ8vK1/UGuE/QD6dQM08Qwqov1rHX4yG0Fpajg8M
         Q9bZHGvFMoD5iOn02z0lnTkHnNPYzPEaeDnGGppkErHdp7tw2jHXscOgFbmCsewEFk77
         uabdmV0ClRAEApvzCEyo27GSKfwJiKSu+aCSNOB6QmXnAfMgzuoSu9V6HRoeeAdest/I
         qcwbWqru4cYvMfXbmhJfJ1KwAdWnhFZBdkF//zLIYzL0p+6jT0xHomzU6zTBqfqvxyw8
         WJwRwwqaAELligxEPagJJp+D3Rfc9KLUNCQfiZyQarAk7t0dQY8DRELALO+x7KY4G8kO
         crRQ==
X-Gm-Message-State: AOAM5332bd+i5O0uUHO8e8L22PXKfuwih1UL3j/FAx9PuICN2j86eZDb
        lbCI3XknuBF5rM+C0Lt+zF3RBDJZ1jxGNO0LT+3oblW7
X-Google-Smtp-Source: ABdhPJxDnjpMRhq/eJg4kRFm09A/NnAr44oJEByVLHxxQunIkaqHoi5JHmFlbFSMGdMrejPcfBgRzLLwUkRCozq0dHA=
X-Received: by 2002:a05:6512:3049:: with SMTP id b9mr320804lfb.44.1592521828993;
 Thu, 18 Jun 2020 16:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <1592458104-2961-1-git-send-email-akolli@codeaurora.org> <1592458104-2961-3-git-send-email-akolli@codeaurora.org>
In-Reply-To: <1592458104-2961-3-git-send-email-akolli@codeaurora.org>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Fri, 19 Jun 2020 09:10:17 +1000
Message-ID: <CAGRGNgV74fCD1gb=rXEe1BMN5+5stYeX3W6eKc4-do76TBmFqA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ath11k: copy ce service configs to hw_params
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Anilkumar,

On Thu, Jun 18, 2020 at 3:31 PM Anilkumar Kolli <akolli@codeaurora.org> wrote:
>
> No functional changes, added target ce service configurations
> to hw_params.
>
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> ---
> V3:
>  - added ce svc configs in hw_params
>
>  drivers/net/wireless/ath/ath11k/ahb.c  | 20 +++++++++++++++-----
>  drivers/net/wireless/ath/ath11k/core.c |  8 +-------
>  drivers/net/wireless/ath/ath11k/core.h |  1 +
>  drivers/net/wireless/ath/ath11k/hw.h   |  2 ++
>  4 files changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
> index 7e9bfeaaf4d2..aa74d27e5871 100644
> --- a/drivers/net/wireless/ath/ath11k/ahb.c
> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
> @@ -152,7 +152,7 @@ static const struct ce_pipe_config target_ce_config_wlan[] = {
>   * This table is derived from the CE_PCI TABLE, above.
>   * It is passed to the Target at startup for use by firmware.
>   */
> -static const struct service_to_pipe target_service_to_ce_map_wlan[] = {
> +static const struct service_to_pipe target_service_to_ce_map_wlan_ipq8074[] = {
>         {
>                 .service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VO),
>                 .pipedir = __cpu_to_le32(PIPEDIR_OUT),  /* out = UL = host -> target */
> @@ -644,8 +644,8 @@ static void ath11k_ahb_init_qmi_ce_config(struct ath11k_base *ab)
>
>         cfg->tgt_ce_len = ARRAY_SIZE(target_ce_config_wlan) - 1;
>         cfg->tgt_ce = target_ce_config_wlan;
> -       cfg->svc_to_ce_map_len = ARRAY_SIZE(target_service_to_ce_map_wlan);
> -       cfg->svc_to_ce_map = target_service_to_ce_map_wlan;
> +       cfg->svc_to_ce_map_len = ab->hw_params.svc_to_ce_map_len;
> +       cfg->svc_to_ce_map = ab->hw_params.svc_to_ce_map;
>  }
>
>  static void ath11k_ahb_free_ext_irq(struct ath11k_base *ab)
> @@ -853,8 +853,8 @@ static int ath11k_ahb_map_service_to_pipe(struct ath11k_base *ab, u16 service_id
>         bool ul_set = false, dl_set = false;
>         int i;
>
> -       for (i = 0; i < ARRAY_SIZE(target_service_to_ce_map_wlan); i++) {
> -               entry = &target_service_to_ce_map_wlan[i];
> +       for (i = 0; i < ab->hw_params.svc_to_ce_map_len; i++) {
> +               entry = &ab->hw_params.svc_to_ce_map[i];
>
>                 if (__le32_to_cpu(entry->service_id) != service_id)
>                         continue;
> @@ -950,6 +950,16 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
>                 goto err_hal_srng_deinit;
>         }
>
> +       ret = ath11k_init_hw_params(ab);
> +       if (ret) {
> +               ath11k_err(ab, "failed to get hw params %d\n", ret);
> +               return ret;
> +       }
> +
> +       ab->hw_params.svc_to_ce_map_len =
> +                       ARRAY_SIZE(target_service_to_ce_map_wlan_ipq8074);
> +       ab->hw_params.svc_to_ce_map = target_service_to_ce_map_wlan_ipq8074;

I think you misunderstood my point about this, the point wasn't to
copy the svc map to hw_params, but define it in hw_params:

+       {
+               .hw_rev = ATH11K_HW_IPQ6018,
+               .name = "ipq6018 hw1.0",
+               .fw = {
+                       .dir = "IPQ6018/hw1.0",
+                       .board_size = 256 * 1024,
+                       .cal_size = 256 * 1024,
+               },
+               .max_radios = 2,
+               .bdf_addr = 0x4ABC0000,
+               .hw_ops = &ipq6018_ops,
+               .svc_to_ce_map_len =
ARRAY_SIZE(target_service_to_ce_map_wlan_ipq6018,
+               .svc_to_ce_map = target_service_to_ce_map_wlan_ipq6018,
+       },

That completely eliminates special case code based on the hardware ID
in the driver.

Thanks,

--
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
