Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDA9303235
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jan 2021 03:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbhAYOFE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jan 2021 09:05:04 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:45507 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729152AbhAYOEK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 09:04:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611583433; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=mGLzoDGq2ydQS17PgLcjujXTP/yZxARi+VqpxX9BJPg=;
 b=UrkGH7RS49QwwBEKOU09tGQr7UozUWIe1HpbWWAF+8O5Q4iGDO3QpqTUB7X7cvax9J+B8rSK
 5NABEc13WcvicptSj7Jm82/Ah/PHAOAK63zgRu5w+vgxJ9oLgZ66FI8QLVFE9GrT25vGXSaO
 jFpMTHINba+6t4WtR3U+605CF60=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 600ecfa1d75e1218e3e83d42 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Jan 2021 14:03:13
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 10BECC43461; Mon, 25 Jan 2021 14:03:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 893C1C433C6;
        Mon, 25 Jan 2021 14:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 893C1C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [wireless-drivers] mt7601u: fix kernel crash unplugging the
 device
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <3b85219f669a63a8ced1f43686de05915a580489.1610919247.git.lorenzo@kernel.org>
References: <3b85219f669a63a8ced1f43686de05915a580489.1610919247.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        kuba@kernel.org, matthias_berndt@gmx.de, mozlima@gmail.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210125140313.10BECC43461@smtp.codeaurora.org>
Date:   Mon, 25 Jan 2021 14:03:13 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> The following crash log can occur unplugging the usb dongle since,
> after the urb poison in mt7601u_free_tx_queue(), usb_submit_urb() will
> always fail resulting in a skb kfree while the skb has been already
> queued.
> 
> Fix the issue enqueuing the skb only if usb_submit_urb() succeed.
> 
> Hardware name: Hewlett-Packard 500-539ng/2B2C, BIOS 80.06 04/01/2015
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:skb_trim+0x2c/0x30
> RSP: 0000:ffffb4c88005bba8 EFLAGS: 00010206
> RAX: 000000004ad483ee RBX: ffff9a236625dee0 RCX: 000000000000662f
> RDX: 000000000000000c RSI: 0000000000000000 RDI: ffff9a2343179300
> RBP: ffff9a2343179300 R08: 0000000000000001 R09: 0000000000000000
> R10: ffff9a23748f7840 R11: 0000000000000001 R12: ffff9a236625e4d4
> R13: ffff9a236625dee0 R14: 0000000000001080 R15: 0000000000000008
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fd410a34ef8 CR3: 00000001416ee001 CR4: 00000000001706f0
> Call Trace:
>  mt7601u_tx_status+0x3e/0xa0 [mt7601u]
>  mt7601u_dma_cleanup+0xca/0x110 [mt7601u]
>  mt7601u_cleanup+0x22/0x30 [mt7601u]
>  mt7601u_disconnect+0x22/0x60 [mt7601u]
>  usb_unbind_interface+0x8a/0x270
>  ? kernfs_find_ns+0x35/0xd0
>  __device_release_driver+0x17a/0x230
>  device_release_driver+0x24/0x30
>  bus_remove_device+0xdb/0x140
>  device_del+0x18b/0x430
>  ? kobject_put+0x98/0x1d0
>  usb_disable_device+0xc6/0x1f0
>  usb_disconnect.cold+0x7e/0x20a
>  hub_event+0xbf3/0x1870
>  process_one_work+0x1b6/0x350
>  worker_thread+0x53/0x3e0
>  ? process_one_work+0x350/0x350
>  kthread+0x11b/0x140
>  ? __kthread_bind_mask+0x60/0x60
>  ret_from_fork+0x22/0x30
> 
> Fixes: 23377c200b2eb ("mt7601u: fix possible memory leak when the device is disconnected")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Acked-by: Jakub Kicinski <kubakici@wp.pl>

Patch applied to wireless-drivers.git, thanks.

0acb20a5438c mt7601u: fix kernel crash unplugging the device

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/3b85219f669a63a8ced1f43686de05915a580489.1610919247.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

