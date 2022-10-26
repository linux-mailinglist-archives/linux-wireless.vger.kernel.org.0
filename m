Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C00460DD92
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Oct 2022 10:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiJZIye (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Oct 2022 04:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiJZIyd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Oct 2022 04:54:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C775EB1
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 01:54:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 231E8B82142
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 08:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4F7C433D7;
        Wed, 26 Oct 2022 08:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666774463;
        bh=/qYpe6VsL4mFLuYpO4O25L46bgg9KOjxUaOHpY0nglI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sw81+F7IchG5aBJFhqDvcoIGDrMVb3rCarZtGBq47PcH74uGzX0L1Mumw5BOeXFKK
         u+XFpv9VKjjbgvsUqM1BLn9JLJm16HMHFPy4KAwiK4lTStt1Ep4rOL2tYf7Zv72AAi
         I+9upcXgUgceEYO68SmWpE8LqASc0R/nVsg/XOdp7+mNn78isQwCpyACT9sZqeb2jl
         twMXvhWQcIVFxMlW0mMo9ScMICFU1s6Jr0SWG1wgsa6ErI4AvuBfIXnwT0p9wWWSmx
         9KjOj8yb4xFiL4XEJS7zcoaa2h7zKIoAtPiHfnop5NXyWSIDhCkgkKiK6TTocBFWYr
         /oxhdOFxzQ8qg==
Date:   Wed, 26 Oct 2022 10:54:15 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Ajay.Kathat@microchip.com
Cc:     Claudiu.Beznea@microchip.com, linux-wireless@vger.kernel.org,
        kvalo@kernel.org
Subject: Re: wilc1000 kernel crash
Message-ID: <20221026085415.6jgwrhq4sunqaypm@0002.3ffe.de>
References: <20221024135407.7udo3dwl3mqyv2yj@0002.3ffe.de>
 <6d022f41-85bb-cde2-0b3d-feef0a0711f2@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d022f41-85bb-cde2-0b3d-feef0a0711f2@microchip.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ajay,

On 22/10/25 08:26, Ajay.Kathat@microchip.com wrote:
> > In handle_rcvd_ntwrk_info() scan_req->scan_result isn't valid anymore,
> > although it doesn't contain NULL. Thus the driver is calling into a
> > bogus function pointer. There seems to be no locking between the
> > asynchronous calls within the workqueue (wilc_enqueue_work()) and when
> > the interface is disabled (wilc_deinit()). wilc_deinit() will free the
> > host_if_drv object which might still be used within the workqueue
> > context.
> 
> 
> Please try the below code changes with your test setup environment.

The workqueue handling and wilc_deinit() run in parallel, correct? ..

> --- a/drivers/net/wireless/microchip/wilc1000/hif.c
> +++ b/drivers/net/wireless/microchip/wilc1000/hif.c
> @@ -495,12 +495,18 @@ static void handle_rcvd_ntwrk_info(struct 
> work_struct *work)
>   {
>          struct host_if_msg *msg = container_of(work, struct 
> host_if_msg, work);
>          struct wilc_rcvd_net_info *rcvd_info = &msg->body.net_info;
> -       struct wilc_user_scan_req *scan_req = 
> &msg->vif->hif_drv->usr_scan_req;
> +       struct host_if_drv *hif_drv = msg->vif->hif_drv;
> +       struct wilc_user_scan_req *scan_req;
>          const u8 *ch_elm;
>          u8 *ies;
>          int ies_len;
>          size_t offset;
> 
> +       if (!hif_drv || !hif_drv->usr_scan_req.scan_result)
> +               goto done;

.. So what if hif_drv will be set to NULL right after this check?

I don't think you'll get around using proper locking here.

> +
> +       scan_req = &hif_drv->usr_scan_req;
> +
>          if (ieee80211_is_probe_resp(rcvd_info->mgmt->frame_control))
>                  offset = offsetof(struct ieee80211_mgmt, 
> u.probe_resp.variable);
>          else if (ieee80211_is_beacon(rcvd_info->mgmt->frame_control))
> @@ -1574,6 +1580,9 @@ void wilc_network_info_received(struct wilc *wilc, 
> u8 *buffer, u32 length)
>                  return;
>          }
> 
> +       if (!hif_drv->usr_scan_req.scan_result)
> +               return;
> +

This is also racy. What if scan_result is cleared right after this
check? Then the work item will still get added to the work queue.

Here is the call tree:

isr_bh_routine() [interrupt thread ctx]
  wilc_handle_isr()
    mutex_lock(hif_cs)
    wilc_wlan_handle_isr_ext()
	  wilc_wlan_handle_rxq()
	    wilc_wlan_handle_rx_buff()
          wilc_wlan_cfg_indicate_rx()
            wilc_network_info_received()
			  wilc_enqueue_work(handle_rcvd_ntwrk_info)
    mutex_unlock(hif_cs)

handle_rcvd_ntwrk_info [hif_workqueue ctx]
  if (scan_result)
    scan_result()

wilc_mac_close() [ioctl ctx?]
  wilc_deinit_host_int()
    wilc_deinit()
	mutex_lock(deinit_lock)
	if (scan_result)
	  scan_result()
	  scan_result = NULL
	kfree(hif_drv)
	hif_drv = NULL
	mutex_unlock(deinit_lock)

I don't see any synchronization mechanisms, between these threads.

>          msg = wilc_alloc_work(vif, handle_rcvd_ntwrk_info, false);
>          if (IS_ERR(msg))
>                  return;
> 
> The above changes should avoid the kernel crash exception.

As mentioned above, I think this will just decrease the chance that
it is happening. Nonetheless, I've tried your changes but it doesn't
fix the crash.

> > BTW, ignore the "FW not repsonding" for now, that seems to be a
> > different problem.
> 
> "FW not responding" log indicates the chip sleep command failure from 
> Host to the FW. It's a temporary failure log for specific command. 
> During the de-init process, this logs is often observed. IIRC, there was 
> a change in the latest driver that reduced its frequency but I am unable 
> to recall the exact change.

So what is a "temporary failure"? It is a pr_warn() and customers
(rightfully) complains about them. Apart from that, it only happens on
the second "ifconfig wlan0 up". There are no messages during the first
one. So I suspect there is still something fishy.

-michael
