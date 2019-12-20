Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A879127AC4
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 13:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfLTML1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 07:11:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40635 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfLTML0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 07:11:26 -0500
Received: by mail-ot1-f68.google.com with SMTP id w21so3897074otj.7
        for <linux-wireless@vger.kernel.org>; Fri, 20 Dec 2019 04:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d92jvRVZ59eJITd4FbroiziaoGY788o8GRNA4jRIH3w=;
        b=lZs24/YWxsq1ODn7FE38BBoBr1v0QiBCWAzXCEigr833cfEMOGjw6/MVESURA9d4fZ
         +Jl4aJuLT+VbKZ9z93cCQDoj79qtwDpq0GMAAL+PYunFEPJwDwGwQqC28G3H38qtzWp2
         P5eBOGLByHK/Oo2CGXRMR/NzhugQhNiGl5HShXQzQD5mXR6/JuG7yBBpHi/9VAMqYs8d
         9OqH/akd7dcO3RwB8KvbAUpOBBVS3VwbEXAfjokUMlIfxEd5P/Pmb/JBIbsT46IeIv2F
         f4fTtfwnH9cMn5qLIn21vJkzlwABJyvSQ26uNIbD2VJTTf+sZT7XGOW1PGgpqhF1U/X9
         hzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d92jvRVZ59eJITd4FbroiziaoGY788o8GRNA4jRIH3w=;
        b=TMi53G9iRKDAzDclH+/+RvFDihiD6wK7V9PWZtzGkMR6FgRHGSC+fPnPdRlsYfDXOu
         zUdAM+wveuA3OUpYGp40aog3acolJ/U1fD6Qj8EeNB5/l+DQ20UtITtMQTJvrIclirj4
         uzBNkWkRRvW1/4h2lxp0sKe7b57+hxuhA/neblnlaYkHoybEoOF56pdGzcgD3okTJw7n
         kT7zHcj27XDwbMSgO2lrF0UqmvhcIg5mFw0Vlo+ptJITXra7nW5qX4xMAVKVmMNtQaAn
         t/zkrZIIQZsjkONr4lcrVmpTKXWrU5nNhMXDFxC10pmLBK/yFGUlWlmUufMztp/piqN+
         reKg==
X-Gm-Message-State: APjAAAXo7AfCb0+9XJ++nka2dQo+ZfTqZTi7wS8pABDtzLhW32acJPbh
        mSyjkeiYZwBj35SmS5XN+9fV8cAmjpR9ka2biqEY6JEAU6M=
X-Google-Smtp-Source: APXvYqwJmRR4xX6Ynlkzi/BhrAs7uJ5X/aPz+Ot8k3LApGRWcdw1N0nBZBB2p1HSva4mMhCWDQGzF9BD0c+nqiSbfns=
X-Received: by 2002:a05:6830:1515:: with SMTP id k21mr1135493otp.177.1576843885012;
 Fri, 20 Dec 2019 04:11:25 -0800 (PST)
MIME-Version: 1.0
References: <20191220063829.11873-1-wgong@codeaurora.org> <CAMrEMU9cfYqgC_MvAuhJh5-pjqb_+WamHEkHf-t2ZW=nOR-8+w@mail.gmail.com>
 <c962d9a7401c4a3bbad71b01190fdce9@codeaurora.org>
In-Reply-To: <c962d9a7401c4a3bbad71b01190fdce9@codeaurora.org>
From:   Justin Capella <justincapella@gmail.com>
Date:   Fri, 20 Dec 2019 04:11:12 -0800
Message-ID: <CAMrEMU94SDEP24XfFL-2R2KoK4NehwDY8p=MsNx1P7PBi111JQ@mail.gmail.com>
Subject: Re: [PATCH] ath10k: select the min len of RX skb for sdio
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the data is invalid I think it should be discarded and a warning
displayed, it is just as bad to pass too little data isn't it? Then
you potentially have uninitialized data? Or pointers to nonsense?
There is a good chance I am misunderstanding though, I just wanted to
make sure you had considered those cases and the word alignment if
that applies to this type of bus?

On Fri, Dec 20, 2019 at 12:57 AM <wgong@codeaurora.org> wrote:
>
> On 2019-12-20 15:35, Justin Capella wrote:
> > Does this mess up alignment or anything, feels wrong to just take the
> > smaller but I don't understand why it isn't the correct size, why is
> > it? Should a warning be printed?
> >
> When tested with the simulate sdio transfer fail test, it will trigger
> the len is not correct,
> the commit log have description for the reason of wrong size.
>
> > On Thu, Dec 19, 2019 at 10:39 PM Wen Gong <wgong@codeaurora.org> wrote:
> >>
> >> When simulate random transfer fail for sdio write and read, it crash
> >> sometimes.
> >>
> >> Test steps:
> >> 1. Add config and update kernel:
> >> CONFIG_FAIL_MMC_REQUEST=y
> >> CONFIG_FAULT_INJECTION=y
> >> CONFIG_FAULT_INJECTION_DEBUG_FS=y
> >>
> >> 2. run simulate fail:
> >> cd /sys/kernel/debug/mmc1/fail_mmc_request
> >> echo 10 > probability
> >> echo 10 > times # repeat until hitting issues
> >>
> >> 3. it crash, the act len of ath10k_htc_hdr is higher than allocate
> >> len, it cause panic:
> >> [   99.723482] skbuff: skb_over_panic: text:00000000caa0f780 len:57013
> >> put:57013 head:000000004116f24a data:0000000019ecb4dc tail:0xdef5
> >> end:0x640 dev:<NULL>
> >> [   99.737697] ------------[ cut here ]------------
> >> [   99.742327] kernel BUG at
> >> /mnt/host/source/src/third_party/kernel/v4.19/net/core/skbuff.c:104!
> >> [   99.750937] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> >> [   99.831154] Process kworker/0:2 (pid: 151, stack limit =
> >> 0x00000000728010bf)
> >> [   99.838200] CPU: 0 PID: 151 Comm: kworker/0:2 Tainted: G W 4.19.85
> >> #48
> >> [   99.846022] Hardware name: MediaTek krane sku0 board (DT)
> >> [   99.851429] Workqueue: events sdio_irq_work
> >> [   99.855614] pstate: 60000005 (nZCv daif -PAN -UAO)
> >> [   99.860402] pc : skb_panic+0x64/0x68
> >> [   99.863974] lr : skb_panic+0x64/0x68
> >> [   99.867542] sp : ffffff8008833a90
> >> [   99.870850] x29: ffffff8008833ac0 x28: ffffffe52e337370
> >> [   99.876159] x27: ffffffe52e328a90 x26: 000000000000e0d0
> >> [   99.881469] x25: ffffffe52e336b60 x24: 000000000000deb5
> >> [   99.886779] x23: ffffffe52e340680 x22: ffffffe4efd47e00
> >> [   99.892088] x21: 000000000000deb5 x20: ffffffa516d85b4c
> >> [   99.897397] x19: ffffffa526928037 x18: 0000000000000000
> >> [   99.902706] x17: 000000000000003c x16: ffffffa5265b6c80
> >> [   99.908015] x15: 0000000000000006 x14: 3a76656420303436
> >> [   99.913325] x13: 0000000000029bf0 x12: 0000000000000000
> >> [   99.918634] x11: 0000000000000000 x10: 0000000000000000
> >> [   99.923943] x9 : a3b907e4b2783000 x8 : a3b907e4b2783000
> >> [   99.929253] x7 : 0000000000000000 x6 : ffffffa526f66d76
> >> [   99.934563] x5 : 0000000000000000 x4 : 0000000000000000
> >> [   99.939872] x3 : 000000000002a5ab x2 : ffffffe53feed918
> >> [   99.945182] x1 : ffffffe53fee4a08 x0 : 000000000000008e
> >> [   99.950491] Call trace:
> >> [   99.952937]  skb_panic+0x64/0x68
> >> [   99.956165]  skb_put+0x7c/0x84
> >> [   99.959224]  ath10k_sdio_irq_handler+0x740/0xbb8 [ath10k_sdio]
> >> [   99.965055]  process_sdio_pending_irqs+0x58/0x1a4
> >> [   99.969758]  sdio_run_irqs+0x34/0x60
> >> [   99.973329]  sdio_irq_work+0x1c/0x28
> >> [   99.974930] cros-ec-spi spi2.0: SPI transfer timed out
> >> [   99.976904]  process_one_work+0x210/0x410
> >> [   99.976911]  worker_thread+0x234/0x3dc
> >> [   99.976923]  kthread+0x120/0x130
> >> [   99.982090] cros-ec-spi spi2.0: spi transfer failed: -110
> >> [   99.986054]  ret_from_fork+0x10/0x18
> >> [   99.986063] Code: aa1403e2 2a1503e4 a90023e9 97e37d1a (d4210000)
> >> [   99.986068] ---[ end trace cb6d948c5a0fd6c7 ]---
> >> [  100.017250] Kernel panic - not syncing: Fatal exception
> >> [  100.018879] cros-ec-spi spi2.0: Command xfer error (err:-110)
> >> [  100.023659] SMP: stopping secondary CPUs
> >> [  100.023703] Kernel Offset: 0x251dc00000 from 0xffffff8008000000
> >> [  100.023707] CPU features: 0x0,2188200c
> >> [  100.023709] Memory Limit: none
> >>
> >> The simulate fail of sdio is not a real sdio transter fail, it only
> >> set an error status in mmc_should_fail_request after the transfer end,
> >> actually the transfer is success, then sdio_io_rw_ext_helper will
> >> return error status and stop transfer the left data. For example,
> >> the really RX len is 286 bytes, then it will split to 2 blocks in
> >> sdio_io_rw_ext_helper, one is 256 bytes, left is 30 bytes, if the
> >> first 256 bytes get an error status by mmc_should_fail_request,then
> >> the left 30 bytes will not read in this RX operation. Then when the
> >> next RX arrive, the left 30 bytes will be considered as the header
> >> of the read, the top 8 bytes will be considered as ath10k_htc_hdr,
> >> but actually the 8 bytes is not the ath10k_htc_hdr, so the act_len
> >> from this ath10k_htc_hdr is not correct, if it is a big value, such
> >> as 57013, it will trigger skb_panic.
> >>
> >> Select the min value of act_len and alloc_len for skb_put and
> >> skb_put_data is reasonable.
> >>
> >> This patch only effect sdio chips.
> >>
> >> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.
> >>
> >> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> >> ---
> >>  drivers/net/wireless/ath/ath10k/sdio.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c
> >> b/drivers/net/wireless/ath/ath10k/sdio.c
> >> index 7b894dcaad2e..71ce2674c543 100644
> >> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> >> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> >> @@ -651,7 +651,7 @@ static int ath10k_sdio_mbox_rx_fetch(struct ath10k
> >> *ar)
> >>
> >>         htc_hdr = (struct ath10k_htc_hdr *)skb->data;
> >>         pkt->act_len = le16_to_cpu(htc_hdr->len) + sizeof(*htc_hdr);
> >> -       skb_put(skb, pkt->act_len);
> >> +       skb_put(skb, min_t(size_t, pkt->alloc_len, pkt->act_len));
> >>
> >>         return ret;
> >>  }
> >> @@ -687,7 +687,8 @@ static int ath10k_sdio_mbox_rx_fetch_bundle(struct
> >> ath10k *ar)
> >>                 htc_hdr = (struct ath10k_htc_hdr
> >> *)(ar_sdio->vsg_buffer + pkt_offset);
> >>                 pkt->act_len = le16_to_cpu(htc_hdr->len) +
> >> sizeof(*htc_hdr);
> >>
> >> -               skb_put_data(pkt->skb, htc_hdr, pkt->act_len);
> >> +               skb_put_data(pkt->skb, htc_hdr,
> >> +                            min_t(size_t, pkt->alloc_len,
> >> pkt->act_len));
> >>                 pkt_offset += pkt->alloc_len;
> >>         }
> >>
> >> --
> >> 2.23.0
