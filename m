Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117B0545DC0
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 09:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346671AbiFJHrC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 03:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346980AbiFJHq6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 03:46:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5D013C4E8
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 00:46:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71E846200D
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 07:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68CBC34114;
        Fri, 10 Jun 2022 07:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654847216;
        bh=JY4GgLP2+0nLIIgzpt5WND7IpUBnloTfPY2RlSwN66s=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=l2lN2A29++Pkmk/jcBzCC/pOktkca+CAGRZRCVXXEtj/k8xN5eIxTd/3Bs/e7+Zyf
         beet0S3UFOikanWk+ujTmtHnTuxtee8fMs5VuSmQ98qkfsgVul6dXoDFtuqcq6gJMp
         FjDTEtHweLPHrGaYH5Cc9MMQKvtnLZwwEWVV1BPFrZrcNI8PY0+cAezMwoHZGmmrv9
         BBjYOFAlsj+V0Y1rOWepeMv1jmtX1E0+ACQBaoPLYDvr9p2P4bXmZS5PbS1NX0qH1C
         A68j4RKHyiM9roWRT4WqMhVTxdgQJWGfaTseIS5zEWh8fxeRQu02/P2atnm4jyZmda
         ZZlDRSsYCM0kw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: 8821c: fix access const table of channel
 parameters
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220608020312.9663-1-pkshih@realtek.com>
References: <20220608020312.9663-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <nathan@kernel.org>,
        <Larry.Finger@lwfinger.net>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165484720974.14668.11719754250943711867.kvalo@kernel.org>
Date:   Fri, 10 Jun 2022 07:46:55 +0000 (UTC)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

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
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Patch applied to wireless.git, thanks.

90f4b5499cdd rtw88: 8821c: fix access const table of channel parameters

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220608020312.9663-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

