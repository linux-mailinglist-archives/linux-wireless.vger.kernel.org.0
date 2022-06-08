Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580C9542948
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 10:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiFHIVM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 04:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiFHIUC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 04:20:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EE939D75B
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 00:47:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A4E4B82515
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 07:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE2BC341C0;
        Wed,  8 Jun 2022 07:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654674430;
        bh=yvu+XdMFiYKzmkUpRuVRRA1Yu7kjSGpaOTkKf4YGTdk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GCnlRo79fUsSg0+4qDw5GbEKRcH/VpnV2Nph6C/DnCwV6O+x4GcDezDLYKC7KbnUA
         RX3umZS6P9MOhBW9ju7h/fwhV/mthNU6Z6FFcQ7Dz2k6Gi+NiGTXnorcI+Zt2R5I8B
         go3E7uT7kzQ9OWq1otZ0kvNfNL8khgHLzg2I/Y7rHo+ZLxPNqoHMh4Dxz2BufuiJvg
         v5EZnzNUxcYZDQB2dcRSRyymuyKRNb2b7ljyImsiaxfqNu96B93Jp/W8/YziT/Y8Ts
         JVXIkES0Py1x4zI1gSp8WXdaQto1gsrDe3HJgEHJcJP5VNZ2kaqAlt3ix3Zxydolri
         g6/REpkS+5WzQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <nathan@kernel.org>,
        <Larry.Finger@lwfinger.net>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] rtw88: 8821c: fix access const table of channel parameters
References: <20220608020312.9663-1-pkshih@realtek.com>
Date:   Wed, 08 Jun 2022 10:47:07 +0300
In-Reply-To: <20220608020312.9663-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Wed, 8 Jun 2022 10:03:12 +0800")
Message-ID: <877d5rr404.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> We would like to make chip_info table const, but 8821c uses one field as
> a variable, and causes core dump. To fix this, move the field to another
> struct that can be read and written.
>
> BUG: unable to handle page fault for address: ffffffffc09f52f4
> PGD 5b5215067 P4D 5b5215067 PUD 5b5217067 PMD 111f61067 PTE 8000000111e07161
> Oops: 0003 [#1] PREEMPT SMP NOPTI
> CPU: 6 PID: 436 Comm: NetworkManager Not tainted 5.18.0-rc7-debug-01822-g89d8f53ff6e7 #1 5cac31ca93432e53341863abfb3332fd98b144da
> Hardware name: HP HP Desktop M01-F1xxx/87D6, BIOS F.12 12/17/2020
> RIP: 0010:rtw8821c_phy_set_param+0x262/0x380 [rtw88_8821c]
> Code: e8 53 f3 c0 d6 48 8b 43 10 4c 8b 63 38 be 24 0a 00 00 48 89 df 48
>  8b 40 68 e8 3a f3 c0 d6 89 e9 be 28 0a 00 00 48 89 df d3 e8 <41> 89 84
>  24 54 01 00 00 48 8b 43 10 4c 8b 63 38 48 8b 40 68 e8 15
> RSP: 0018:ffffb08c417cb6f0 EFLAGS: 00010286
> RAX: 0000000064b80c1c RBX: ffff93d15a0120e0 RCX: 0000000000000000
> RDX: 0000000034028211 RSI: 0000000000000a28 RDI: ffff93d15a0120e0
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000006 R12: ffffffffc09f51a0
> R13: ffff93d15a0156d0 R14: 0000000000000000 R15: 0000000000000001
> FS:  00007f4e9b73d1c0(0000) GS:ffff93d83ab80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffc09f52f4 CR3: 0000000103b9e000 CR4: 0000000000350ee0
> Call Trace:
>  <TASK>
>  rtw_core_start+0xbd/0x190 [rtw88_core de79d6bdfd083d102030858972032e5706726279]
>  rtw_ops_start+0x26/0x40 [rtw88_core de79d6bdfd083d102030858972032e5706726279]
>  drv_start+0x42/0x100 [mac80211 21e803d0ad10691f64c6c81ecc24c0c6c36e5d58]
>  ieee80211_do_open+0x2fb/0x900 [mac80211 21e803d0ad10691f64c6c81ecc24c0c6c36e5d58]
>  ieee80211_open+0x67/0x80 [mac80211 21e803d0ad10691f64c6c81ecc24c0c6c36e5d58]
>  __dev_open+0xdd/0x180
>  [...]
>
> Fixes: 89d8f53ff6e7 ("wifi: rtw88: Fix Sparse warning for rtw8821c_hw_spec")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Cc: Larry Finger <Larry.Finger@lwfinger.net>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Thanks for the quick fix, I'll queue this for v5.19.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
