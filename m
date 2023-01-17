Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F115566DCEB
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 12:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbjAQLzA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 06:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbjAQLys (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 06:54:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D973360AD
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 03:54:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB475B81187
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 11:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23492C433EF;
        Tue, 17 Jan 2023 11:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673956484;
        bh=plfAzU12xKvSUDkCHWZ7UUeSv1uzi5VPXK+vbQgkiLg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=feClskLEoqLeKmFhNY/aY6WMQVTtVeyZGkX0K/lqz3RkXHp2Km+sHVng8zMXOxKA4
         5S2AWyIYORIkly1YQdFNstiPtHTm67EZRlw9dKZksf1jrq3xlQMkviApxXDXKxvuke
         PZHqexQ4RjZOxuUbth5qzMZmgvtZOOpEms34JeftcoRlAtk9YqpehMRu8I9/8iGvzx
         aIx7vVTUcPkY6HCLSNO+OENRW8RxwdiSuj19dZCoQ9q/5s26OwS4oBDv4BDA5yXWvt
         1XhK76cXvc7oGXVl2dStFEC793IJRXtM15M7nBZ7RLx8TppUPZqmT4vAEzeaVve0U7
         EczmkBLgaDKUQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] ath9k: Fix potential stack-out-of-bounds write in
 ath9k_wmi_rsp_callback()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230104124130.10996-1-linuxlovemin@yonsei.ac.kr>
References: <20230104124130.10996-1-linuxlovemin@yonsei.ac.kr>
To:     Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Cc:     linux-wireless@vger.kernel.org, toke@toke.dk,
        dokyungs@yonsei.ac.kr, jisoo.jang@yonsei.ac.kr,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167395648095.22891.7330403073627711064.kvalo@kernel.org>
Date:   Tue, 17 Jan 2023 11:54:42 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Minsuk Kang <linuxlovemin@yonsei.ac.kr> wrote:

> Fix a stack-out-of-bounds write that occurs in a WMI response callback
> function that is called after a timeout occurs in ath9k_wmi_cmd().
> The callback writes to wmi->cmd_rsp_buf, a stack-allocated buffer that
> could no longer be valid when a timeout occurs. Set wmi->last_seq_id to
> 0 when a timeout occurred.
> 
> Found by a modified version of syzkaller.
> 
> BUG: KASAN: stack-out-of-bounds in ath9k_wmi_ctrl_rx
> Write of size 4
> Call Trace:
>  memcpy
>  ath9k_wmi_ctrl_rx
>  ath9k_htc_rx_msg
>  ath9k_hif_usb_reg_in_cb
>  __usb_hcd_giveback_urb
>  usb_hcd_giveback_urb
>  dummy_timer
>  call_timer_fn
>  run_timer_softirq
>  __do_softirq
>  irq_exit_rcu
>  sysvec_apic_timer_interrupt
> 
> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
> Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

8a2f35b98306 wifi: ath9k: Fix potential stack-out-of-bounds write in ath9k_wmi_rsp_callback()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230104124130.10996-1-linuxlovemin@yonsei.ac.kr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

