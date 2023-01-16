Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CF066C7B4
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 17:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjAPQd7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 11:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjAPQdN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 11:33:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055BE21A14
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 08:21:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFDCDB80DC7
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 16:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7332FC433EF;
        Mon, 16 Jan 2023 16:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673886066;
        bh=cqaDJ41YVlRONlaI0b6RAJYyi38MN0BUVuklxz49TD8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=MxolUrj1xJOMU+dZu6tM/MRNbHsjym/6kOH5DLz9o0jLAsmiu/Q6tB+Qovhe+M6aP
         9Vtb3AmPy9r2XsQ+IvFMJ8ynihfTG6FEJnDWo9hCEuYeYCKy5nDI0Lp210K1ptHPHl
         N1bDgoZ+YpcIe6hZ5+LphQYcuHLDiLpm/YeIHfQiSibtvtRfIwiXUZwD+L07zXbAOy
         dP36a5n9pxlrpRhAr1i8vsZFa7amh2GLluOR1c95EqAmTYQmztU5gWEpPTpprO0cqy
         UV981lOstAZqmOLQZluTXEyvCbjJYGdgVzVnDzYiNxeG0qw41nmWKjgthpWDyD9RDr
         eMMzBIFv7D2rQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtl8xxxu: Fix memory leaks with RTL8723BU,
 RTL8192EU
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <03b099c1-c671-d252-36f4-57b70d721f9d@gmail.com>
References: <03b099c1-c671-d252-36f4-57b70d721f9d@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167388606133.5321.1497309013061929727.kvalo@kernel.org>
Date:   Mon, 16 Jan 2023 16:21:05 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> The wifi + bluetooth combo chip RTL8723BU can leak memory (especially?)
> when it's connected to a bluetooth audio device. The busy bluetooth
> traffic generates lots of C2H (card to host) messages, which are not
> freed correctly.
> 
> To fix this, move the dev_kfree_skb() call in rtl8xxxu_c2hcmd_callback()
> inside the loop where skb_dequeue() is called.
> 
> The RTL8192EU leaks memory because the C2H messages are added to the
> queue and left there forever. (This was fine in the past because it
> probably wasn't sending any C2H messages until commit e542e66b7c2e
> ("wifi: rtl8xxxu: gen2: Turn on the rate control"). Since that commit
> it sends a C2H message when the TX rate changes.)
> 
> To fix this, delete the check for rf_paths > 1 and the goto. Let the
> function process the C2H messages from RTL8192EU like the ones from
> the other chips.
> 
> Theoretically the RTL8188FU could also leak like RTL8723BU, but it
> most likely doesn't send C2H messages frequently enough.
> 
> This change was tested with RTL8723BU by Erhard F. I tested it with
> RTL8188FU and RTL8192EU.
> 
> Reported-by: Erhard F. <erhard_f@mailbox.org>
> Tested-by: Erhard F. <erhard_f@mailbox.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215197
> Fixes: e542e66b7c2e ("rtl8xxxu: add bluetooth co-existence support for single antenna")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

b39f662ce164 wifi: rtl8xxxu: Fix memory leaks with RTL8723BU, RTL8192EU

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/03b099c1-c671-d252-36f4-57b70d721f9d@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

