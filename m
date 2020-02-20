Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D16D216568D
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2020 06:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgBTFKh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Feb 2020 00:10:37 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:43945 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgBTFKh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Feb 2020 00:10:37 -0500
Received: by mail-vk1-f195.google.com with SMTP id m195so828195vkh.10
        for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2020 21:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvsJMPuJMhWdY3UrvCeVbfZ3qnixQuVFhEPUtGkCIb0=;
        b=Da4OZtqXMqH34dsg5MLmWZ5DQozYoooLnRFDmiTK3L/8IBJTAMI6BKMh1rmcrkfkW+
         NEH+7DM5Cm+9W9yD9ooJhVL8pXFot0R8OsyhY8Gjoo9oUzTjVE9bZLBV1ISysZYScMHl
         98D+rp4YX22/NeFN212HCSiihKy9lJuM90s39Ili6V/snbEC98uqu7GwMTQYcymVjKF3
         7CpEfLeLFY4GODCmb/oHpI2aQR5/p3yHc5Ifg/QGJrx02yTZv1xZs66YKlD9Gmodiy55
         XvF3b2e7/7rqOmp/fcdotGxmn5lyGiyKAsWKbiKAGR81FcUgX7UvCLazG7wLvENFxKfM
         Iznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvsJMPuJMhWdY3UrvCeVbfZ3qnixQuVFhEPUtGkCIb0=;
        b=CBCExpAcffIdaIdjkd8yqFhLJAZ02hS+aEo52SqaxLZT4Kw57TqscmHRoBB/P3xjav
         +V65xyho9eMn5jNeHwnDCljrGlAIFGPzR9bpZ+AQ/PtRfCQbZscs9wCLe7fcHu+MPv7K
         c1JbSqI+eMHQNZGaDkzQIiHVks819NmEaOh82EH9c5d+Qsg2OCxDQSDsDWsDTYH5RIls
         E6/2yIgMyygc3E018YbRTk/OeRLW7asZYtfpQM+iEspyyVzeVghCuxwmbLf7lH6LIfun
         KoWEeU7/mXri8eMDbyxpjpxUBzlROQ8hkSc9tFq8fh2W9qoRA5ABr1gG0sByB0b2XBxz
         ec1A==
X-Gm-Message-State: APjAAAVCvSiu0GdqcsD3zKDAzt1XvvFIOZfgnUEQLGug2PIWgpi809WQ
        jN7R+MXm9jmHhDJ2ZdMH6YzW8A7SM2WINJjqyOfebTbsFQc=
X-Google-Smtp-Source: APXvYqzPobRCq9DJi47Blgu4T8c46ciqAA0tTQG9z2eUTXA6ca0XvPtabGMq7X97na3gIcHb05wv3E5c/6ilmu4PC8Q=
X-Received: by 2002:a1f:b6d7:: with SMTP id g206mr13498964vkf.8.1582175436461;
 Wed, 19 Feb 2020 21:10:36 -0800 (PST)
MIME-Version: 1.0
References: <1582171405-27236-1-git-send-email-yiboz@codeaurora.org>
In-Reply-To: <1582171405-27236-1-git-send-email-yiboz@codeaurora.org>
From:   Justin Capella <justincapella@gmail.com>
Date:   Wed, 19 Feb 2020 21:10:26 -0800
Message-ID: <CAMrEMU9FvFm5eFP3YfAap238s+x0hz9kKUO6cEizeR_5KY4F2A@mail.gmail.com>
Subject: Re: [PATCH] ath10k: fix not registering airtime of 11a station with
 WMM disable
To:     Yibo Zhao <yiboz@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ieee80211_sta_register_airtime uses ieee80211_ac_from_tid(tid) which
already applies a mask, so should be returning IEEE80211_AC_BE = 2
already, there has been recent changes to some of this so maybe I'm
looking at the wrong decision but I don't think this change makes a
difference

On Wed, Feb 19, 2020 at 8:02 PM Yibo Zhao <yiboz@codeaurora.org> wrote:
>
> The tid of 11a station with WMM disable reported by FW is 0x10 in
> tx completion. The tid 16 is mapped to a NULL txq since buffer
> MMPDU capbility is not supported. Then 11a station's airtime will
> not be registered due to NULL txq check. As a results, airtime of
> 11a station keeps unchanged in debugfs system.
>
> Mask the tid along with IEEE80211_QOS_CTL_TID_MASK to make it in
> the valid range.
>
> Hardwares tested : QCA9984
> Firmwares tested : 10.4-3.10-00047
>
> Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath10k/htt_rx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
> index 38a5814..f883f2a 100644
> --- a/drivers/net/wireless/ath/ath10k/htt_rx.c
> +++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
> @@ -2744,7 +2744,8 @@ static void ath10k_htt_rx_tx_compl_ind(struct ath10k *ar,
>                         continue;
>                 }
>
> -               tid = FIELD_GET(HTT_TX_PPDU_DUR_INFO0_TID_MASK, info0);
> +               tid = FIELD_GET(HTT_TX_PPDU_DUR_INFO0_TID_MASK, info0) &
> +                                               IEEE80211_QOS_CTL_TID_MASK;
>                 tx_duration = __le32_to_cpu(ppdu_dur->tx_duration);
>
>                 ieee80211_sta_register_airtime(peer->sta, tid, tx_duration, 0);
> --
> 1.9.1
