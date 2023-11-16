Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9993F7EE1A4
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Nov 2023 14:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345227AbjKPNjr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 08:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344962AbjKPNjq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 08:39:46 -0500
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90ADCE
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 05:39:42 -0800 (PST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1700141981; bh=rjatQSWbdiwLb42wZ6Vl1PZ6KYVhhqUTX2EriQugFow=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=xTluYmRIZ5d4rQCps50X7fhaBNfFw0wLhwvMDg6bqNzXfS+FCjEz+3t4Yg+/4tkwI
         Xg6t3WkOvhuNyMw8X1QYvLkwCBcylEOPexUfyNrZeIm5MuiJyZkPdWccAWgxf9+k/V
         GnGYd6w+Yv5NAid4FDBCXT/WlzblyGOVFO9D595zb+0DR1+fBGoFoXppiCY+/F0De/
         kU/ZeQxgDidaeCNgK9Q5LXjCi2Xth5IW3WetVH3Vom4zPNxqEwB/e3i3+CuNKIZfgG
         6Vp62RIIrC2B0zQt4QYUOy4hv0SMeKHt/cd6IDwtSqG/IhhPGKfCjNvTuCSxLl2mEp
         Bq4c9RegtQVIg==
To:     Minsuk Kang <linuxlovemin@yonsei.ac.kr>,
        linux-wireless@vger.kernel.org
Cc:     kvalo@kernel.org, dokyungs@yonsei.ac.kr, jisoo.jang@yonsei.ac.kr,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Subject: Re: [PATCH v2] wifi: ath9k: Fix potential array-index-out-of-bounds
 read in ath9k_htc_txstatus()
In-Reply-To: <20231113065756.1491991-1-linuxlovemin@yonsei.ac.kr>
References: <20231113065756.1491991-1-linuxlovemin@yonsei.ac.kr>
Date:   Thu, 16 Nov 2023 14:39:41 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87leaxddgi.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Minsuk Kang <linuxlovemin@yonsei.ac.kr> writes:

> Fix an array-index-out-of-bounds read in ath9k_htc_txstatus(). The bug
> occurs when txs->cnt, data from a URB provided by a USB device, is
> bigger than the size of the array txs->txstatus, which is
> HTC_MAX_TX_STATUS. WARN_ON() already checks it, but there is no bug
> handling code after the check. Make the function return if that is the
> case.
>
> Found by a modified version of syzkaller.
>
> UBSAN: array-index-out-of-bounds in htc_drv_txrx.c
> index 13 is out of range for type '__wmi_event_txstatus [12]'
> Call Trace:
>  ath9k_htc_txstatus
>  ath9k_wmi_event_tasklet
>  tasklet_action_common
>  __do_softirq
>  irq_exit_rxu
>  sysvec_apic_timer_interrupt
>
> Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
