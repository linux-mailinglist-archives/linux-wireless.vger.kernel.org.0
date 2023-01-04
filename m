Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F02A65D677
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jan 2023 15:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbjADOqs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Jan 2023 09:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239776AbjADOqm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Jan 2023 09:46:42 -0500
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA98015FF2
        for <linux-wireless@vger.kernel.org>; Wed,  4 Jan 2023 06:46:40 -0800 (PST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1672843599; bh=nE8bNRCodlq0D3DMUjJh3lAL14Bo4+EYFYTIYfw9uGo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=xHw+5O4qxu08YExbf//ZQl6S5lYKHloJpy1cIFOWwU96tZxpSIfgSQeW7F5DdOo5m
         zXTS3IiQTK7uXIKFVb0neSTQH297LO2FONu7owLjX9piLOA7Mb8HFzw3VSZhWBlHBi
         sSlrtiAWmQKscGzXiI945oEQuTcWa6C3RL4Hpm4iOYZZ8n2V0noCk5WWsSVWLF5xEa
         GDBELMqXZaggaPUd+/czgOgPYoEJsycuGsojAxnguykY6guqkvem0Ez5NibanZbj1c
         0HmlUUw9+6SgbqW4xHWQYBLm9GOEZ0hztj1hXjc+9uhRbnIy+LMKTB/ifisbuIymRm
         ySi9zvDMIi0Pg==
To:     Minsuk Kang <linuxlovemin@yonsei.ac.kr>,
        linux-wireless@vger.kernel.org
Cc:     kvalo@kernel.org, dokyungs@yonsei.ac.kr, jisoo.jang@yonsei.ac.kr,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Subject: Re: [PATCH v2] ath9k: Fix potential stack-out-of-bounds write in
 ath9k_wmi_rsp_callback()
In-Reply-To: <20230104124130.10996-1-linuxlovemin@yonsei.ac.kr>
References: <20230104124130.10996-1-linuxlovemin@yonsei.ac.kr>
Date:   Wed, 04 Jan 2023 15:46:39 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87zgay1ho0.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Minsuk Kang <linuxlovemin@yonsei.ac.kr> writes:

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
> Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

Also (Kalle, I assume you can just add this):

Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
