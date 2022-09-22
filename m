Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200E35E5C29
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 09:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiIVHSQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 03:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiIVHSP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 03:18:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD6EEE15
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 00:18:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 612026288B
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 07:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8C9C433D6;
        Thu, 22 Sep 2022 07:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663831093;
        bh=LczCGyYUtgLHBheWTd2v0OQvFzS3TqRlUwYWCvFwhis=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=b9IHPC/jDIKu3a1VDbmH1Jxz6eh4p4pHjK/jd8XFyvGl7wdMcUnF1cCiQpY44EIT9
         H34rNIzr8H1b9xj/N3rj9zEd4NWtd51CGBd3/LqxbfKCpHtttKSV6brPiVpiiEoJc0
         q5luePp66qRDtBvujzZvfLQJKNho2bNbwReYV+/6PVjd+5Mgr1i4OXGcXHFsEQU8ch
         dMsD0uObbyZYwHmVTWIHAF8clhTVcPt2Cu1nby4TgwB57e+l1ytYTxkA1e0tGx6ZrR
         70QZH9Wx52pz3BUeTzM0R3SwI+pH9NQmdocRNcNKVn3frV7x4bIz/IuN43LsF/brSA
         b0YZHkV19TrTw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath10k: reset pointer after memory free to avoid
 potential
 use-after-free
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220505092248.787-1-quic_wgong@quicinc.com>
References: <20220505092248.787-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166383109059.28267.2524811686657433761.kvalo@kernel.org>
Date:   Thu, 22 Sep 2022 07:18:12 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> When running suspend test, kernel crash happened in ath10k, and it is
> fixed by commit b72a4aff947b ("ath10k: skip ath10k_halt during suspend
> for driver state RESTARTING").
> 
> Currently the crash is fixed, but as a common code style, it is better
> to set the pointer to NULL after memory is free.
> 
> This is to address the code style and it will avoid potential bug of
> use-after-free.
> 
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00110-QCARMSWP-1
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

1e1cb8e0b73e wifi: ath10k: reset pointer after memory free to avoid potential use-after-free

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220505092248.787-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

