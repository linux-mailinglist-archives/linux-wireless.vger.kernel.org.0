Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CE75A630D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 14:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiH3MQp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Aug 2022 08:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiH3MQo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Aug 2022 08:16:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E297CAB1B5
        for <linux-wireless@vger.kernel.org>; Tue, 30 Aug 2022 05:16:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A7ED6160B
        for <linux-wireless@vger.kernel.org>; Tue, 30 Aug 2022 12:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB68C433D6;
        Tue, 30 Aug 2022 12:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661861802;
        bh=/N05Ut6pL6u3K483klYAOd9CgyYiliwvzUbSC8NeEmM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=O6Ew6NjK1no1vTWscccFnSwjPNKTbwStX00x0Y0WxFjd26Aztpu4SH4ZnBPXltihG
         elNm4pIMjXPcOm0FuG3SC4FZjEln3cPn+bCN2vEcKw/Xn08pw5CUULoIXTrDx3TfQ4
         bGM3nDpd0BLMI9+niMpKD/zkDSZhW/cg2BBVEtSGuJZPqrGiRJT5lokmeRoHyR+2+d
         o9EH9NvmGJc4oyuqC9Xs1Qv5HgCieoL4DJkx7mFZEWOivHZ8q17qEGVWICVFAj9I/m
         bFdc47Vy/DEFYwfkBCRPVXCq7yjl3X90U/t4sKk3KVyrQfEmByW+OAIBoY/yE85CUV
         rTfakDqXFIzkA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] ath9k: avoid uninit memory read in ath9k_htc_rx_msg()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <7acfa1be-4b5c-b2ce-de43-95b0593fb3e5@I-love.SAKURA.ne.jp>
References: <7acfa1be-4b5c-b2ce-de43-95b0593fb3e5@I-love.SAKURA.ne.jp>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166186178944.2851.7181874556097643606.kvalo@kernel.org>
Date:   Tue, 30 Aug 2022 12:16:41 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> syzbot is reporting uninit value at ath9k_htc_rx_msg() [1], for
> ioctl(USB_RAW_IOCTL_EP_WRITE) can call ath9k_hif_usb_rx_stream() with
> pkt_len = 0 but ath9k_hif_usb_rx_stream() uses
> __dev_alloc_skb(pkt_len + 32, GFP_ATOMIC) based on an assumption that
> pkt_len is valid. As a result, ath9k_hif_usb_rx_stream() allocates skb
> with uninitialized memory and ath9k_htc_rx_msg() is reading from
> uninitialized memory.
> 
> Since bytes accessed by ath9k_htc_rx_msg() is not known until
> ath9k_htc_rx_msg() is called, it would be difficult to check minimal valid
> pkt_len at "if (pkt_len > 2 * MAX_RX_BUF_SIZE) {" line in
> ath9k_hif_usb_rx_stream().
> 
> We have two choices. One is to workaround by adding __GFP_ZERO so that
> ath9k_htc_rx_msg() sees 0 if pkt_len is invalid. The other is to let
> ath9k_htc_rx_msg() validate pkt_len before accessing. This patch chose
> the latter.
> 
> Note that I'm not sure threshold condition is correct, for I can't find
> details on possible packet length used by this protocol.
> 
> Link: https://syzkaller.appspot.com/bug?extid=2ca247c2d60c7023de7f [1]
> Reported-by: syzbot <syzbot+2ca247c2d60c7023de7f@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

b383e8abed41 wifi: ath9k: avoid uninit memory read in ath9k_htc_rx_msg()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/7acfa1be-4b5c-b2ce-de43-95b0593fb3e5@I-love.SAKURA.ne.jp/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

