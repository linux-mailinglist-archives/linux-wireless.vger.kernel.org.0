Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA8C2BA459
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Nov 2020 09:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgKTIJx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Nov 2020 03:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgKTIJw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Nov 2020 03:09:52 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD13C0613CF
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 00:09:52 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id cq7so8585054edb.4
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 00:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KUpgLXXRaJ8k8USLYA9QlAzBHTvl+GDp3TK1eHdH2gc=;
        b=gV7jKrAgdpPdx7ECB9V5HqgWZBSSNQ20SVZdqFPL4dQxBS4kxnMLfyjrlp4G4yJbqZ
         Q6nNOqYAj2/EdS38/bl5YQh7o0W2PZsE4j6Jm2NVzYL4B0tJzZSIcYT3j7h333GRAUag
         z4afklZE/Qbn51ycPK2kr0hasPrW49TqgiU6dYi3SMIZrCXzMVR6yk3dV4pAxmXY2LC9
         ItfmIbM0ujOj8Cd7nOUHVh82i55VxWkoT5zcg9S5b+IshdCdMsVJI2QpvlnAOuwBKP8S
         lDlHqc00IAt0QMKVA746Aqal9tJqSM7CLbbwYz4TF+H4Q02lD/AkI1G6gHy0iSQQ3jDj
         JNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KUpgLXXRaJ8k8USLYA9QlAzBHTvl+GDp3TK1eHdH2gc=;
        b=BOLsVApfMBTmFd5oBsUFnqbHrBpzyY2+4LW7WuMtkikxkeWUVnjhd/DSXOvoTy0nL6
         J+NfnHdzv030iGg0CEssyq47QiqlUrzSYtKFANd6OLjNOue8yxEhIPyupP2KCOU0Y1Hz
         6jB/kDwUUzsinmIC3SAeg5qrHiJOmBE0+eaU9pboC0wfHQa1y4E17l59xv263X75h9VN
         +ei8jJ7eShDrGY2GsUgaiJzVBqEgoCFa5Bc2oIxfe/FB+/9CEkmWn4hs0qLoMmthT0S+
         6Kv4Eak2tZTO6JrQ3cjJaROPj+McB86AHhWSJX0sG8PGxKm4Ywl3WxIihXZtjg4BlrvM
         4yMA==
X-Gm-Message-State: AOAM531heU/IWojcRuytv8nAKnF0M3liCWcLSilm3OSc2uNZEzAUeab/
        sXmiPuPACSJp+qz+A9zULz9yM5YP4H3Msg8q20zZdQ==
X-Google-Smtp-Source: ABdhPJwHV0W66DpiFTNhgi08eVjccwpmsuFIl8fw9QmjILu5kOaHSjPaK19Oiirxuu4YbiALtK5a9bTXi8dTtP9nIRI=
X-Received: by 2002:a05:6402:2373:: with SMTP id a19mr5736578eda.212.1605859791240;
 Fri, 20 Nov 2020 00:09:51 -0800 (PST)
MIME-Version: 1.0
References: <20201120021403.2646574-1-bryan.odonoghue@linaro.org> <20201120021403.2646574-2-bryan.odonoghue@linaro.org>
In-Reply-To: <20201120021403.2646574-2-bryan.odonoghue@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Fri, 20 Nov 2020 09:15:53 +0100
Message-ID: <CAMZdPi-HeeLauPSLrWnt4ricaP=d55LY960gYpS0FXVi=zsAVw@mail.gmail.com>
Subject: Re: [PATCH] wcn36xx: Send NULL data packet when exiting BMPS
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Benjamin Li <benl@squareup.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 20 Nov 2020 at 03:13, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> This commit updates the BMPS exit path to be consistent with downstream in
> terms of exiting BMPS mode. Downstream sets the flag to send a NULL data
> frame to the host on exiting BMPS.
>
> This will tell the AP to send any queued frames to the STA immediately.
> Verified the relevant bit toggle in wireshark.
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/net/wireless/ath/wcn36xx/smd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
> index 8ff1eda8f942..acf533fae46a 100644
> --- a/drivers/net/wireless/ath/wcn36xx/smd.c
> +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
> @@ -2176,6 +2176,7 @@ int wcn36xx_smd_exit_bmps(struct wcn36xx *wcn, struct ieee80211_vif *vif)
>         INIT_HAL_MSG(msg_body, WCN36XX_HAL_EXIT_BMPS_REQ);
>
>         msg_body.bss_index = vif_priv->bss_index;
> +       msg_body.send_data_null = 1;

I'm quite sure I've seen null data packet wakeup (PS=0) when sniffing
wcn3620, but maybe it was submitted by mac80211, have you then checked
you do not end with double null packets with that patch (one from
firmware and one from mac layer)?


>
>         PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
>
> --
> 2.28.0
>
