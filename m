Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00B84BB2E5
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 13:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfIWLiA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 07:38:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59970 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfIWLiA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 07:38:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 577F26021C; Mon, 23 Sep 2019 11:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569238679;
        bh=2I/5C3miHhycYLlOUJjnVMrMsUai7Gnf06+uP6sdz58=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=iUAkXLojpkzKpMHXmpN19O61gnlEmWINyXUBGc+XefMgrvdG3qR6GXzn5F9Jdg/Zo
         dAbQXfH2ABx5ZeUhOSocRUvBwV5zPbfGG9D4VtrbGx8Z54D6efs7xO84pgsmhpzzYK
         8pySXL6dZbTxZAIYnKE2oCX8Z1CQnUlxIZvd3iQQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-136-106-186.rev.dnainternet.fi [37.136.106.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6B9C76021C;
        Mon, 23 Sep 2019 11:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569238678;
        bh=2I/5C3miHhycYLlOUJjnVMrMsUai7Gnf06+uP6sdz58=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=el3+fo6uA2ATgf/0t075+sw4FFD+XyO8hlgjum0TSrn5L6mkfPNmFl6nDsSrxmIB4
         2c3xZn81Em9FlD4HKChE0e+qxlbhdpvUY1Zmh+9zTmdzla1f26A22SJYH1b6snt8pw
         4VhaWzR2hPQzDlZ//08xFHLOiR3wLfraBMRRT7rw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B9C76021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] ath10k: add fw coredump for sdio when firmware assert
References: <1567132338-7407-1-git-send-email-wgong@codeaurora.org>
        <874l15c20j.fsf@codeaurora.org>
        <6b7927f633cb7cbe2ba0d958d7d06f9a@codeaurora.org>
Date:   Mon, 23 Sep 2019 14:37:54 +0300
In-Reply-To: <6b7927f633cb7cbe2ba0d958d7d06f9a@codeaurora.org> (Wen Gong's
        message of "Mon, 23 Sep 2019 19:09:51 +0800")
Message-ID: <87v9tj6y5p.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> On 2019-09-21 19:38, Kalle Valo wrote:
>>
>> What's wrong with ath10k_sdio_hif_diag_read()? AFAICS this whole
>> function duplicates just what it does.
>
> ath10k_sdio_hif_diag_read's buffer size is limit,
> and the dump memory/register's buffer size is larger than the diag
> window's limit,
> if use it directly will trigger crash like this for every time.

You shouldn't blindly add extra code to ath10k workaround issues. And if
you really need to use a workaround, then it needs to properly explained
in the commit and as well as commented in the code. But before that the
issue needs to be thoroughly investigated and understood where the
problem is coming from. Because it might be even completely unrelated to
ath10k.

> [  149.947624] ath10k_sdio mmc1:0001:1: ath10k_sdio_hif_diag_read
> buf_len :4
> [  149.954741] ath10k_sdio mmc1:0001:1: ath10k_sdio_hif_diag_read
> buf_len :240
> [  151.005143] Unable to handle kernel paging request at virtual
> address ffffffc0080ab980
> [  151.013077] Mem abort info:
> [  151.015866]   ESR = 0x96000045
> [  151.018918]   Exception class = DABT (current EL), IL = 32 bits
> [  151.024830]   SET = 0, FnV = 0
> [  151.027880]   EA = 0, S1PTW = 0
> [  151.031016] Data abort info:
> [  151.033892]   ISV = 0, ISS = 0x00000045
> [  151.037723]   CM = 0, WnR = 1
> [  151.040691] swapper pgtable: 4k pages, 39-bit VAs, pgdp =
> 0000000073b23692
> [  151.047560] [ffffffc0080ab980] pgd=0000000000000000,
> pud=0000000000000000
> [  151.054354] Internal error: Oops: 96000045 [#1] PREEMPT SMP
> [  151.059925] Modules linked in: ath10k_sdio ath10k_core rfcomm
> uinput cros_ec_rpmsg mtk_cam_isp ath mac80211 mtk_fd hci_uart btqca
> bluetooth mtk_scp mtk_rpmsg rpmsg_core ecdh_generic mtk_scp_ipi bridge
> stp llc nf_nat_tftp nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp esp6
> ah6 xfrm6_mode_tunnel xfrm6_mode_transport xfrm4_mode_tunnel
> xfrm4_mode_transport ip6t_REJECT ip6t_ipv6header ipt_MASQUERADE fuse
> cfg80211 iio_trig_sysfs cros_ec_sensors_sync cros_ec_sensors
> cros_ec_sensors_ring industrialio_triggered_buffer kfifo_buf
> cros_ec_sensors_core lzo_rle lzo_compress zram asix usbnet mii joydev
> [last unloaded: ath10k_core]
> [  151.114537] Process swapper/0 (pid: 0, stack limit =
> 0x00000000e30dc665)
> [  151.121238] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.72 #11
> [  151.127327] Hardware name: MediaTek kukui rev1 board (DT)
> [  151.132724] pstate: 20000085 (nzCv daIf -PAN -UAO)
> [  151.137525] pc : __memcpy+0x110/0x180
> [  151.141193] lr : swiotlb_tbl_unmap_single+0x84/0x150
> [  151.146151] sp : ffffff8008003c60
> [  151.149462] x29: ffffff8008003c90 x28: ffffffa2a9611f38
> [  151.154774] x27: ffffffa2a92cc018 x26: 0000000000000000
> [  151.160087] x25: ffffffa2a90b8000 x24: 0000000000000001
> [  151.165399] x23: ffffffa2a975e000 x22: 0000000000001400
> [  151.170710] x21: 0000000000000000 x20: 00000000fc7ff000
> [  151.176021] x19: 00000000000000f0 x18: 0000000000000020
> [  151.181332] x17: 0000000000000000 x16: 0000000000000000
> [  151.186643] x15: 00000000ffffffff x14: 0000000000000000
> [  151.191955] x13: 0000000000000000 x12: 0000000000000000
> [  151.197266] x11: 0000000000000000 x10: 0000000000000000
> [  151.202578] x9 : 0000000000000000 x8 : 0000000000000000
> [  151.207890] x7 : 0000000000000000 x6 : ffffffc0080ab980
> [  151.213202] x5 : ffffff8016ffbdc8 x4 : 0000000000000000
> [  151.218514] x3 : 0000000000000002 x2 : 0000000000000070
> [  151.223825] x1 : fffffff37c7ff040 x0 : ffffffc0080ab980
> [  151.229138] Call trace:
> [  151.231585]  __memcpy+0x110/0x180
> [  151.234899]  unmap_single+0x6c/0x84
> [  151.238386]  swiotlb_unmap_sg_attrs+0x54/0x80
> [  151.242744]  __swiotlb_unmap_sg_attrs+0xa0/0xb8
> [  151.247277]  msdc_unprepare_data+0x6c/0x84
> [  151.251372]  msdc_request_done+0x58/0x84
> [  151.255292]  msdc_data_xfer_done+0x1a0/0x1c8
> [  151.259559]  msdc_irq+0x12c/0x17c

Did you investigate this? Is the buffer you reading to DMA accessible?
What about the alignment? Is there a certain length which is the limit
for crashes? And so on...

-- 
Kalle Valo
