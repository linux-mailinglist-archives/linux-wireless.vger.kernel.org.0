Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D04466406B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jan 2023 13:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjAJM0F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 07:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238551AbjAJMZZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 07:25:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088BDCC1
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 04:25:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF74AB8159E
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 12:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F064CC433EF;
        Tue, 10 Jan 2023 12:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673353511;
        bh=pQwKNKpoYxfyOYyA77pv++Up4PIdhs6brRmSfFIGtU0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ISITD6RE2QyOVyjBTuIxcB4IQ7u1cI0t8rTv+BmKm0gbA3UaQBmtNK1gMAobar+IK
         I1C7lXDrZ9W2RTuGjZqSS4uGqhDG7Bd5CdNQ0GzCabG83UXx8QWjLbDEAmcMC1GuAe
         JKe0TkRXlGuvBEfeIzmf55XENfO6rkRnwv/DCG+pE+rHNRWQFKUWTSnscHOmj1f5za
         FvZ0hWdpRLa5dY0SHWQXG3USYMDPZNOmMv0DT4doTc5cViKTJNuxD9YxjKxt4nISi+
         wsGk+d3bNqWi8OaAd4+Mfqi26H4xiNhbhOKB+mnF6PgyR1Y8rsAy7eO6It9rYw+ASG
         CGz0fMduSmDcQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Minsuk Kang <linuxlovemin@yonsei.ac.kr>,
        linux-wireless@vger.kernel.org, dokyungs@yonsei.ac.kr,
        jisoo.jang@yonsei.ac.kr
Subject: Re: [PATCH v2] ath9k: Fix potential stack-out-of-bounds write in ath9k_wmi_rsp_callback()
References: <20230104124130.10996-1-linuxlovemin@yonsei.ac.kr>
        <87zgay1ho0.fsf@toke.dk>
Date:   Tue, 10 Jan 2023 14:25:06 +0200
In-Reply-To: <87zgay1ho0.fsf@toke.dk> ("Toke \=\?utf-8\?Q\?H\=C3\=B8iland-J\?\=
 \=\?utf-8\?Q\?\=C3\=B8rgensen\=22's\?\= message of
        "Wed, 04 Jan 2023 15:46:39 +0100")
Message-ID: <87ilhefufx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:

> Minsuk Kang <linuxlovemin@yonsei.ac.kr> writes:
>
>> Fix a stack-out-of-bounds write that occurs in a WMI response callback
>> function that is called after a timeout occurs in ath9k_wmi_cmd().
>> The callback writes to wmi->cmd_rsp_buf, a stack-allocated buffer that
>> could no longer be valid when a timeout occurs. Set wmi->last_seq_id to
>> 0 when a timeout occurred.
>>
>> Found by a modified version of syzkaller.
>>
>> BUG: KASAN: stack-out-of-bounds in ath9k_wmi_ctrl_rx
>> Write of size 4
>> Call Trace:
>>  memcpy
>>  ath9k_wmi_ctrl_rx
>>  ath9k_htc_rx_msg
>>  ath9k_hif_usb_reg_in_cb
>>  __usb_hcd_giveback_urb
>>  usb_hcd_giveback_urb
>>  dummy_timer
>>  call_timer_fn
>>  run_timer_softirq
>>  __do_softirq
>>  irq_exit_rcu
>>  sysvec_apic_timer_interrupt
>>
>> Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
>
> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>
> Also (Kalle, I assume you can just add this):
>
> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")

Yes, will add.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
