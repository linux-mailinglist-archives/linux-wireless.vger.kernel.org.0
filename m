Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F950715BB4
	for <lists+linux-wireless@lfdr.de>; Tue, 30 May 2023 12:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjE3K15 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 May 2023 06:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjE3K1d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 May 2023 06:27:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C1512D
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 03:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F30ED62243
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 10:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BF8C433D2;
        Tue, 30 May 2023 10:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685442346;
        bh=qPUpIZyFJ9rClm3MpkB/4K96+Gd+Kdto8bi8GRUVsFc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NW05/GXBJNphgoixxH9a9PxP6agDWaShxNXHjm9TfafrsvF+w5kmNzHcwEWAJQ4if
         eX3xUn149sE73tHqiaPQyRx8prVWK30eUtVR13ecsTaRQLLbrfNz/C9i3/wTSzigPy
         jXko8tn2GI3iMJAst9JzsxgCQSSzVlVT4HG9nC2f45xkE3OBDADyVZCXjTLx4r8oUz
         zo9tlEc/r3yTXwsHwJfRHGdmn9dnPA31/MVYYKvlj+j6iJ3cHuVQLiXRkk/P/ivrRf
         yRfTBcv2o9LcvXK+XIRu48Nxbj6QuHESqvQ5DqthwA7qHPX/UHyDgpRKALX5wpcHVX
         n8eGtnrB1yB2A==
From:   Kalle Valo <kvalo@kernel.org>
To:     petter@technux.se
Cc:     linux-wireless@vger.kernel.org, s.hauer@pengutronix.de,
        Larry.Finger@lwfinger.net, andreas@fatal.se, g0000ga@gmail.com,
        iam@valdikss.org.ru, kernel@pengutronix.de, linux@ulli-kroll.de,
        morrownr@gmail.com, mr.nuke.me@gmail.com, pkshih@realtek.com,
        tpkuester@gmail.com, Petter Mabacker <petter.mabacker@esab.se>
Subject: Re: [PATCH] wifi: rtw88: usb: Make work queues high prio
References: <20230530091532.2711675-1-petter@technux.se>
Date:   Tue, 30 May 2023 13:25:39 +0300
In-Reply-To: <20230530091532.2711675-1-petter@technux.se> (petter's message of
        "Tue, 30 May 2023 11:15:32 +0200")
Message-ID: <87zg5mjeu4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

petter@technux.se writes:

> From: Petter Mabacker <petter.mabacker@esab.se>
>
> The rtw8822cu driver have problem to handle high rx or tx rates compared
> with high load (such as high I/O) on slower systems, such as for example
> i.MX6 SoloX and similar platforms.
>
> The problems are more frequent when having the access point close to the
> device. On slower systems it's often enough to download a large file,
> combined with generating I/O load to trigger:
>
> [  374.763424] rtw_8822cu 1-1.2:1.2: failed to get tx report from firmware
> [  377.771790] rtw_8822cu 1-1.2:1.2: failed to send h2c command
> [  407.813460] rtw_8822cu 1-1.2:1.2: firmware failed to report density after scan
> [  414.965826] rtw_8822cu 1-1.2:1.2: failed to send h2c command
> [  444.993462] rtw_8822cu 1-1.2:1.2: firmware failed to report density after scan
> [  452.144551] rtw_8822cu 1-1.2:1.2: failed to send h2c command
> [  482.183445] rtw_8822cu 1-1.2:1.2: firmware failed to report density after scan
> [  489.426263] rtw_8822cu 1-1.2:1.2: failed to send h2c command
>
> Another way is to simply perform a wifi rescan.
>
> Benchmarking shows that setting a high prio workqueue for tx/rx will
> significally improve things. Also compared alloc_workqueue with
> alloc_ordered_workqueue, but even thou the later seems to slightly
> improve things it's still quite easy to reproduce the above issues. So
> that leads to the decision to go for alloc_workqueue.
>
> Thanks to Ping-Ke Shih <pkshih@realtek.com> that came up with the idea
> of exploring tweaking of the work queue's within a similar discussion.
>
> Fixes: a82dfd33d1237 ("wifi: rtw88: Add common USB chip support")
> Signed-off-by: Petter Mabacker <petter.mabacker@esab.se>
> ---
>  drivers/net/wireless/realtek/rtw88/usb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
> index 44a5fafb9905..bfe0845528ec 100644
> --- a/drivers/net/wireless/realtek/rtw88/usb.c
> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> @@ -716,7 +716,7 @@ static int rtw_usb_init_rx(struct rtw_dev *rtwdev)
>  	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
>  	int i;
>  
> -	rtwusb->rxwq = create_singlethread_workqueue("rtw88_usb: rx wq");
> +	rtwusb->rxwq = alloc_workqueue("rtw88_usb: rx wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
>  	if (!rtwusb->rxwq) {
>  		rtw_err(rtwdev, "failed to create RX work queue\n");
>  		return -ENOMEM;
> @@ -750,7 +750,7 @@ static int rtw_usb_init_tx(struct rtw_dev *rtwdev)
>  	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
>  	int i;
>  
> -	rtwusb->txwq = create_singlethread_workqueue("rtw88_usb: tx wq");
> +	rtwusb->txwq = alloc_workqueue("rtw88_usb: tx wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
>  	if (!rtwusb->txwq) {
>  		rtw_err(rtwdev, "failed to create TX work queue\n");
>  		return -ENOMEM;

Should this workqueue be ordered or not? Please check Tejun's patchset
about using ordered queues:

https://lore.kernel.org/lkml/20230421025046.4008499-1-tj@kernel.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
