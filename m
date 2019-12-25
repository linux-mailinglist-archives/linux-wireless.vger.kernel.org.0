Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A06F12A93E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Dec 2019 23:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLYWzf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Dec 2019 17:55:35 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35779 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfLYWzf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Dec 2019 17:55:35 -0500
Received: by mail-ot1-f66.google.com with SMTP id k16so25856683otb.2
        for <linux-wireless@vger.kernel.org>; Wed, 25 Dec 2019 14:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=80jAyJVeOXTuDUpErDnlHfp3L/JfNwepEBZzxURdIw4=;
        b=EM4EzMjCA7x6i1mOp1QgRJj2l/WUw15fnus3M+6rRaUAjahc22yyA3yJn0w35oSkWO
         zOXILFfQrhewpxeOSkn/51T+MqPCBoIMbhn6oPlxq01niSAqSK0uomj036cga4Oms7Jq
         nPOK3v8ZKfobFzZTlJXITg6In6J0Oq1AVw+mFQNhf75EBN9RHF8OGNXDa/46G1c+nvOH
         NLhOhFzCicmWz57HZJbqNqHNVbQv7QI1oizPWzkGpCF7EYjdwFH/XJNMxRXInhP01khf
         0/Np3rsW/cJTrvr0MibNOYuEmvK3RzUHulR+wx5/6e2O+7+G5uxOzjqhX1M9iajVgXSM
         gaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80jAyJVeOXTuDUpErDnlHfp3L/JfNwepEBZzxURdIw4=;
        b=X72L0sbNLHE6/ynmFcKJlHVIim0M9igUeLCleYWrBNv2HDH3D5NmMx+kp5giEXdftW
         +tiIDZsRqc5DGUGUSxOIYfIrmv7Kriy9VgsiHe74XQeU2K24yAt2Ff0uQEO6rSKYhbLp
         +Pra7ddfgZ2h7HLt0tPa0C/ecDE8CZ8+4cslyoe7l5Szr97m+PtX04I/QQhgLmbqFJ34
         aWUFX9o6AlxPJfT/AwPVrDjMNLX3oMgb16hhLPhuxwk+C+NPSvVZWpKZ/uacGN/zuCK1
         q5NbGBhhGiXbgL9YaY3cPU7P9TBHOP6G5IR0bLqTGcFcXr9MXywG8KRWSGuR6wpbW3gs
         +fDw==
X-Gm-Message-State: APjAAAVW9YRAfmr+BUJrGXiffY0IMkPz2UqKgmzml7ffmyFI7IgF3e71
        sETZI5WwHyVCoouv0jk81S3I6W1l6of/Kx1ZyKY=
X-Google-Smtp-Source: APXvYqxPk3MCnzXx4k2wZwiqWJ8ttbT6p9kAjJNFaHu8Q3TSgpMB4oURBrHk2s13I/DPioK1tvmFgMe7NAx6M+U5hdY=
X-Received: by 2002:a05:6830:1515:: with SMTP id k21mr32167294otp.177.1577314534400;
 Wed, 25 Dec 2019 14:55:34 -0800 (PST)
MIME-Version: 1.0
References: <20191225120002.11163-1-wgong@codeaurora.org> <20191225120002.11163-3-wgong@codeaurora.org>
In-Reply-To: <20191225120002.11163-3-wgong@codeaurora.org>
From:   Justin Capella <justincapella@gmail.com>
Date:   Wed, 25 Dec 2019 14:56:01 -0800
Message-ID: <CAMrEMU9ZVV-yotvH2Odn+sb1HiiL_tN_GASSeSnhAOzCUjLZ7Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ath10k: start recovery process when payload length
 exceeds max htc length for sdio
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Does the SDIO bus require addresses to be word aligned like the PCI
bus does? I'm thinking of how netdev alloc uses skb_push to ensure
that the payload is aligned.


>> if (ar->state == ATH10K_STATE_ON)

What about the other STATEs: RESTARTED/ING

The value you mentioned 57005, is 0xDEAD is that a special case?
Perhaps a result of fw crash? Maybe a lookahead gone wong? I see its
the WMI PEER ALIVE/DEAD indicator but I'm not sure why it would be
trailer of the other

On Wed, Dec 25, 2019 at 4:01 AM Wen Gong <wgong@codeaurora.org> wrote:
>
> When simulate random transfer fail for sdio write and read, it happened
> "payload length exceeds max htc length" and recovery later sometimes.
>
> Test steps:
> 1. Add config and update kernel:
> CONFIG_FAIL_MMC_REQUEST=y
> CONFIG_FAULT_INJECTION=y
> CONFIG_FAULT_INJECTION_DEBUG_FS=y
>
> 2. Run simulate fail:
> cd /sys/kernel/debug/mmc1/fail_mmc_request
> echo 10 > probability
> echo 10 > times # repeat until hitting issues
>
> 3. It happened payload length exceeds max htc length.
> [  199.935506] ath10k_sdio mmc1:0001:1: payload length 57005 exceeds max htc length: 4088
> ....
> [  264.990191] ath10k_sdio mmc1:0001:1: payload length 57005 exceeds max htc length: 4088
>
> 4. after some time, such as 60 seconds, it start recovery which triggered
> by wmi command timeout for periodic scan.
> [  269.229232] ieee80211 phy0: Hardware restart was requested
> [  269.734693] ath10k_sdio mmc1:0001:1: device successfully recovered
>
> The simulate fail of sdio is not a real sdio transter fail, it only
> set an error status in mmc_should_fail_request after the transfer end,
> actually the transfer is success, then sdio_io_rw_ext_helper will
> return error status and stop transfer the left data. For example,
> the really RX len is 286 bytes, then it will split to 2 blocks in
> sdio_io_rw_ext_helper, one is 256 bytes, left is 30 bytes, if the
> first 256 bytes get an error status by mmc_should_fail_request,then
> the left 30 bytes will not read in this RX operation. Then when the
> next RX arrive, the left 30 bytes will be considered as the header
> of the read, the top 4 bytes of the 30 bytes will be considered as
> lookaheads, but actually the 4 bytes is not the lookaheads, so the len
> from this lookaheads is not correct, it exceeds max htc length 4088
> sometimes. When happened exceeds, the buffer chain is not matched between
> firmware and ath10k, then it need to start recovery ASAP. Recently then
> recovery will be started by wmi command timeout, but it will be long time
> later, for example, it is 60+ seconds later from the periodic scan, if
> it does not have periodic scan, it will be longer.
>
> Start recovery when it happened "payload length exceeds max htc length"
> will be reasonable.
>
> This patch only effect sdio chips.
>
> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath10k/sdio.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
> index 7b894dcaad2e..78f431609493 100644
> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> @@ -557,6 +557,12 @@ static int ath10k_sdio_mbox_rx_alloc(struct ath10k *ar,
>                                     le16_to_cpu(htc_hdr->len),
>                                     ATH10K_HTC_MBOX_MAX_PAYLOAD_LENGTH);
>                         ret = -ENOMEM;
> +
> +                       if (ar->state == ATH10K_STATE_ON) {
> +                               queue_work(ar->workqueue, &ar->restart_work);
> +                               ath10k_warn(ar, "exceeds length, start recovery\n");
> +                       }
> +
>                         goto err;
>                 }
>
> --
> 2.23.0
