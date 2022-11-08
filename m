Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897B0621885
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 16:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiKHPkH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 10:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiKHPkG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 10:40:06 -0500
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB19413D01
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 07:40:03 -0800 (PST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1667922002; bh=T3eNaPLKCXTTqj9l12jXa6LDSYVWKlAFCmW9A5hBHJ4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bqs8arlu3cj1r7VwbB3ewXAgKBWjeWwy4UnaLQ55meBMHN4Vwid8HknA/5x+OsgSS
         Hx5iGCXgyG8trF06HbBlnkwx03/HwVXxQlKIrkAtqMfokXE4IfoqOEKQ968hADmXes
         hKx2wHe6DqqeuukGRCY+kY4DQqPyHrw9Vw3Uw2360cud2dNcQAnDBoOl+zDOG7KJIo
         hqZWmzhfZwWuNU6zvIVux9aZMsMGWOUx1x4xI2dQN77sdsVtZZZYrTJxzXCX+OiXOW
         QHQ3s0FA9gBHWGHkLcRReVIByY0JyL0ZN07GLs6RK5sKGlVFmbtU8zSaxoJ8ugzUSS
         KXGRDvfdkeizQ==
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org
Cc:     bjlockie@lockie.ca, johannes@sipsolutions.net, nbd@nbd.name,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH v2 wireless] wifi: mac8021: fix possible oob access in
 ieee80211_get_rate_duration
In-Reply-To: <8d0116580f2c5eafaea29acb2cbbc348ff853f5b.1667920478.git.lorenzo@kernel.org>
References: <8d0116580f2c5eafaea29acb2cbbc348ff853f5b.1667920478.git.lorenzo@kernel.org>
Date:   Tue, 08 Nov 2022 16:40:01 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87y1slzc8e.fsf@toke.dk>
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

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Fix possible out-of-bound access in ieee80211_get_rate_duration routine
> as reported by the following UBSAN report:
>
> UBSAN: array-index-out-of-bounds in net/mac80211/airtime.c:455:47
> index 15 is out of range for type 'u16 [12]'
> CPU: 2 PID: 217 Comm: kworker/u32:10 Not tainted 6.1.0-060100rc3-generic
> Hardware name: Acer Aspire TC-281/Aspire TC-281, BIOS R01-A2 07/18/2017
> Workqueue: mt76 mt76u_tx_status_data [mt76_usb]
> Call Trace:
>  <TASK>
>  show_stack+0x4e/0x61
>  dump_stack_lvl+0x4a/0x6f
>  dump_stack+0x10/0x18
>  ubsan_epilogue+0x9/0x43
>  __ubsan_handle_out_of_bounds.cold+0x42/0x47
> ieee80211_get_rate_duration.constprop.0+0x22f/0x2a0 [mac80211]
>  ? ieee80211_tx_status_ext+0x32e/0x640 [mac80211]
>  ieee80211_calc_rx_airtime+0xda/0x120 [mac80211]
>  ieee80211_calc_tx_airtime+0xb4/0x100 [mac80211]
>  mt76x02_send_tx_status+0x266/0x480 [mt76x02_lib]
>  mt76x02_tx_status_data+0x52/0x80 [mt76x02_lib]
>  mt76u_tx_status_data+0x67/0xd0 [mt76_usb]
>  process_one_work+0x225/0x400
>  worker_thread+0x50/0x3e0
>  ? process_one_work+0x400/0x400
>  kthread+0xe9/0x110
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x22/0x30
>
> Fixes: db3e1c40cf2f ("mac80211: Import airtime calculation code from mt76=
")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
