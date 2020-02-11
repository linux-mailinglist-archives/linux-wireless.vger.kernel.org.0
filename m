Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEA8158D46
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 12:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgBKLMc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 06:12:32 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39716 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgBKLMc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 06:12:32 -0500
Received: by mail-ed1-f68.google.com with SMTP id m13so4158990edb.6
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2020 03:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oi9QRDBH00+kWcgt2F0eb3CE6ju+ATrMcPPQCmiPk4Q=;
        b=mrPbinoNSX+FEnNRG05FxKFpDp7BEz2+lgsILrww0zOfaWTH4Jwhd/hcdF9+fl63DI
         6CZoDr3UCBAsX5lp3ihzoRABtrumO6t7C+75LXdBgWAIhTNezZxEjauTanrf+k6qCokx
         jTDCdqXKJDg531xoAs72cf2YTVbFw2Kb4nWKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oi9QRDBH00+kWcgt2F0eb3CE6ju+ATrMcPPQCmiPk4Q=;
        b=JOxjF3VpZASCAfwus2bNWBBjNvxkt5RtOwPco4pDpHV1vsa/X4Juo0mQYA4N0cP+a4
         1tagk1PXCDqTjN6x2DsDqShmqKbCszGQqHTTc6SVIA+gGJZhMgwR6Za5I7RY4IXkPGIo
         8ta4y0GPA9KDa793/Hfc3vaXQXuyAGcdiuaRrKs9fmr5tjJLsta6dge2TdyRwdSW6SQ3
         9bch6ciN+lbnWMqtMBoSTJgYxAJG8rlGr3+t3/eiQS1b/VAzbXmYInY2DcbPAdVL31CB
         0fwnbGcjUZKC7xifIB7sHttuAbkp/urfS5cJ+NOS4slfgtETT0VKxCtFVFveurN/Bqot
         w+hA==
X-Gm-Message-State: APjAAAUKo37sTrtRZa8pPAQswcdJj21kGz+cqra9WqiUyiaToD4DiVtc
        cWInrFFO43xSJNATz8IyDY8hPILZ7zZIPHmAkr+JhwX2hhpOQA==
X-Google-Smtp-Source: APXvYqwV2YnBsHjXKGaL5ZiPagi8kT5P2XRDWDl0DhDuPixgjLC/pwUamycu3j49KFyx95UE+Dhy0JKyVYOWBnofnGI=
X-Received: by 2002:a05:6402:125a:: with SMTP id l26mr5217374edw.315.1581419549173;
 Tue, 11 Feb 2020 03:12:29 -0800 (PST)
MIME-Version: 1.0
References: <20191128103030.6429-1-wgong@codeaurora.org> <0101016eb1903db0-ef7063b4-0f42-4a01-8886-327541e6c1a4-000000@us-west-2.amazonses.com>
 <76bce8e3-e05b-ace6-3edd-54f522be3fe6@chromium.org> <25fd4f59b39c56b2fee208713c7cbc57@codeaurora.org>
In-Reply-To: <25fd4f59b39c56b2fee208713c7cbc57@codeaurora.org>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Tue, 11 Feb 2020 19:11:53 +0800
Message-ID: <CANdKZ0eWJtSuOdZp6Djne21maoBtmSsEm9Rmq9HbLfriY1goWw@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] ath10k: disable TX complete indication of htt for sdio
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Feb 11, 2020 at 5:46 PM Wen Gong <wgong@codeaurora.org> wrote:
>
> On 2020-02-11 15:03, Pi-Hsun Shih wrote:
> > Hi,
> >
> > On 11/28/19 6:30 PM, Wen Gong wrote:
> >> ...
> >> diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c
> >> b/drivers/net/wireless/ath/ath10k/htt_tx.c
> >> index a182c0944cc7..c6c4b2a4d20f 100644
> >> --- a/drivers/net/wireless/ath/ath10k/htt_tx.c
> >> +++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
> >> @@ -543,7 +543,35 @@ void ath10k_htt_tx_free(struct ath10k_htt *htt)
> >>     void ath10k_htt_htc_tx_complete(struct ath10k *ar, struct sk_buff
> >> *skb)
> >>   {
> >> +    struct ath10k_htt *htt = &ar->htt;
> >> +    struct htt_tx_done tx_done = {0};
> >> +    struct htt_cmd_hdr *htt_hdr;
> >> +    struct htt_data_tx_desc *desc_hdr;
> >> +    u16 flags1;
> >> +
> >>      dev_kfree_skb_any(skb);
> >> +
> >> +    if (!htt->disable_tx_comp)
> >> +            return;
> >> +
> >> +    htt_hdr = (struct htt_cmd_hdr *)skb->data;
> >
> > skb is already freed on the above line (dev_kfree_skb_any) but is
> > still used here, should the dev_kfree_skb_any be moved to the end of
> > this function?
> >
> skb will not freed on the above line, please see this patch
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/drivers/net/wireless/ath/ath10k?h=ath-next&id=30382dd1cf3a141bfaa568ee183c1892090fa79a

IIUC the commit only makes the skb not freed in ieee80211_tx_status,
but it's still freed in ath10k_htt_htc_tx_complete (by
dev_kfree_skb_any)?

While booting with this patch (and the
30382dd1cf3a141bfaa568ee183c1892090fa79a commit) with kernel bootargs
"slub_debug=FZPUA", I got a kernel panic in ath10k module:

[   16.058676] Unable to handle kernel paging request at virtual
address 006b6b6b6b6b6b6b
[   16.066613] Mem abort info:
[   16.069419]   ESR = 0x96000004
[   16.072481]   Exception class = DABT (current EL), IL = 32 bits
[   16.078406]   SET = 0, FnV = 0
[   16.081476]   EA = 0, S1PTW = 0
[   16.084624] Data abort info:
[   16.087513]   ISV = 0, ISS = 0x00000004
[   16.091369]   CM = 0, WnR = 0
[   16.094354] [006b6b6b6b6b6b6b] address between user and kernel address ranges
[   16.101503] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[   16.107071] Modules linked in: ath10k_sdio ath10k_core ath mac80211
cfg80211 lzo_rle lzo_compress zram asix usbnet mii joydev
[   16.118380] Process kworker/u16:2 (pid: 142, stack limit =
0x00000000082e3c57)
[   16.125597] CPU: 7 PID: 142 Comm: kworker/u16:2 Not tainted 4.19.102 #48
[   16.132287] Hardware name: MediaTek krane sku176 board (DT)
[   16.137862] Workqueue: ath10k_sdio_wq ath10k_sdio_write_async_work
[ath10k_sdio]
[   16.145251] pstate: 60000005 (nZCv daif -PAN -UAO)
[   16.150051] pc : ath10k_htt_htc_tx_complete+0xe0/0x1a4 [ath10k_core]
[   16.156411] lr : ath10k_htt_htc_tx_complete+0xdc/0x1a4 [ath10k_core]
[   16.162755] sp : ffffff800888bc80
[   16.166061] x29: ffffff800888bc90 x28: ffffffd892b08c20
[   16.171363] x27: ffffffd892b173f8 x26: ffffffd892b08c20
[   16.176666] x25: ffffffd897337240 x24: ffffffd892b16b48
[   16.181968] x23: 6b6b6b6b6b6b6b6b x22: ffffff970d2a1000
[   16.187270] x21: ffffff970d2a0000 x20: ffffffd897337240
[   16.192572] x19: ffffffd892b01960 x18: 0000000000000000
[   16.197873] x17: 000000000000003c x16: ffffff970edefba0
[   16.203174] x15: 0000000000000006 x14: ffff001000000600
[   16.208475] x13: 00000000000064e6 x12: 0000000000000000
[   16.213777] x11: 0000000000000000 x10: 0000000000000000
[   16.219079] x9 : b307f4e257a4e000 x8 : b307f4e257a4e000
[   16.224391] x7 : 0000000000000000 x6 : ffffff970f970e9c
[   16.229712] x5 : 0000000000000027 x4 : 0000000000000000
[   16.235030] x3 : 000000000002ed25 x2 : ffffffd8bff94fd8
[   16.240341] x1 : ffffffd8bff8c0c8 x0 : 0000000000000034
[   16.245644] Call trace:
[   16.248109]  ath10k_htt_htc_tx_complete+0xe0/0x1a4 [ath10k_core]
[   16.254123]  ath10k_htc_notify_tx_completion+0xe4/0x118 [ath10k_core]
[   16.260559]  ath10k_sdio_write_async_work+0x158/0x1f4 [ath10k_sdio]
[   16.266823]  process_one_work+0x208/0x408
[   16.270825]  worker_thread+0x23c/0x3e4
[   16.274566]  kthread+0x120/0x130
[   16.277788]  ret_from_fork+0x10/0x18
[   16.281357] Code: 528046a3 aa1303e0 97ffc028 f9406a97 (394002e8)
[   16.287442] ---[ end trace 3bae4173512bf484 ]---
[   16.298803] Kernel panic - not syncing: Fatal exception
[   16.304033] SMP: stopping secondary CPUs
[   16.308072] Kernel Offset: 0x1706400000 from 0xffffff8008000000
[   16.313983] CPU features: 0x0,2188200c
[   16.317721] Memory Limit: none

So it seems that the skb is used-after-free in ath10k_htt_htc_tx_complete here.
