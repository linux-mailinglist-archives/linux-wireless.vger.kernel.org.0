Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AA32E1059
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Dec 2020 23:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgLVWiA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Dec 2020 17:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbgLVWiA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Dec 2020 17:38:00 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A79C061793
        for <linux-wireless@vger.kernel.org>; Tue, 22 Dec 2020 14:37:19 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id o6so13387315iob.10
        for <linux-wireless@vger.kernel.org>; Tue, 22 Dec 2020 14:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=djZGsbrkmGA94jAXMOhutdjZdetBTqkQXt4zsACd0OM=;
        b=Z8Ugi74CxfCPMN3s/HZNn1ukTSQh20jHPmxZYidK/tLBsgUU85LmLkEK9m8Tiva5Du
         9cVovmwScoIvz0x072sABbgGW852qliKBHsMYTnzCy4u5UtU/fx0an7c/QOq8EHgQZth
         S7BTWvhvN8nhQkA6W/noUD1I18PhFFoisCdFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=djZGsbrkmGA94jAXMOhutdjZdetBTqkQXt4zsACd0OM=;
        b=CekdgX+1fWZGs0hvvGkP0qrU80rH38MXKWfrDR1L35unf3CxK1fVgljbPxb6hMllkT
         5FVMLigIOW4Jk6rPpnSj+G0LsjsdPcknJnPYEWrRRZLMnfXl2e57147F4Bq44j2p+M2l
         OsjQEFCuR71KxI9rHxsMxuhBmArNoh50kyL/8fSURKkPxf+jikTVDhot9DTySaMZ/kTL
         p4xCx0Zx4ByhNoH5t8VXwC8ozDD3kXP1hoacgfpwlObyBmFjBHL2YGeOj4i+b5aKjbgi
         WLs9nY85ifmdts2yyS+DhyOEtD9QLYUa2GzQio/BKJEfqMp/EEsEcOji9XLLJfYQGoPm
         rfSQ==
X-Gm-Message-State: AOAM533YWMMdd6KDoy2kfd6fYszCSYSIEZQB7cxgUwCge5vNWSEwlU1w
        NuFYFyT3DwpuhPhtiqj/scJ2+Z0Gf4X96dN7Oj0kKA==
X-Google-Smtp-Source: ABdhPJzjPE3ifZKjaoRV9kaxRig0JeWpFArkXbVay9Rq/k+MZUU5lRDgK84v6MDTfAop8WyZlSSNI01+2WrWzmEqp2k=
X-Received: by 2002:a02:a304:: with SMTP id q4mr20446611jai.97.1608676639053;
 Tue, 22 Dec 2020 14:37:19 -0800 (PST)
MIME-Version: 1.0
References: <20201215172435.5388-1-youghand@codeaurora.org>
In-Reply-To: <20201215172435.5388-1-youghand@codeaurora.org>
From:   Abhishek Kumar <kuabhs@chromium.org>
Date:   Tue, 22 Dec 2020 14:36:58 -0800
Message-ID: <CACTWRwsM_RJnssBpxDpRSbex4_1T9QDv3+ZT7eLnYsgOgtGFQw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ath10k: Set wiphy flag to trigger sta disconnect on
 hardware restart
To:     Youghandhar Chintala <youghand@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Rakesh Pillai <pillair@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Dec 15, 2020 at 9:24 AM Youghandhar Chintala
<youghand@codeaurora.org> wrote:
>
> From: Rakesh Pillai <pillair@codeaurora.org>
>
> Currently after the hardware restart triggered from the driver,
> the station interface connection remains intact, since a disconnect
> trigger is not sent to userspace. This can lead to a problem in
> hardwares where the wifi mac sequence is added by the firmware.
>
> After the firmware restart, during subsytem recovery, the firmware
> restarts its wifi mac sequence number. Hence AP to which our device
> is connected will receive frames with a  wifi mac sequence number jump
> to the past, thereby resulting in the AP dropping all these frames,
> until the frame arrives with a wifi mac sequence number which AP was
> expecting.
>
> To avoid such frame drops, its better to trigger a station disconnect
> upon the  hardware restart. Indicate this support via a WIPHY flag
> to mac80211, if the hardware params flag mentions the support to
> add wifi mac sequence numbers for TX frames in the firmware.
>
> All the other hardwares, except WCN3990, are not affected by this
> change, since the hardware params flag is not set for any hardware
> except for WCN3990
>
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00110-QCARMSWP-1
> Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00048
>
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> Signed-off-by: Youghandhar Chintala <youghand@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath10k/core.c | 15 +++++++++++++++
>  drivers/net/wireless/ath/ath10k/hw.h   |  3 +++
>  drivers/net/wireless/ath/ath10k/mac.c  |  3 +++
>  3 files changed, 21 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
> index 796107b..4155f94 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -90,6 +90,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
>                 .hw_filter_reset_required = true,
>                 .fw_diag_ce_download = false,
>                 .tx_stats_over_pktlog = true,
> +               .tx_mac_seq_by_fw = false,
Probably orthogonal to this patch, there is a static array maintained
for different hardware configs and the structure members like
"tx_mac_seq_by_fw" are initialized. This does not seem to be scalable
and probably these parameters can be auto populated based on FW
capabilities and so we don't have to maintain the static array.
Thoughts?

-Abhishek
