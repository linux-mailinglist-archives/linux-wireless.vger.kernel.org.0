Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80035B4461
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Sep 2022 08:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiIJG0f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Sep 2022 02:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIJG0e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Sep 2022 02:26:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6DC1A38C
        for <linux-wireless@vger.kernel.org>; Fri,  9 Sep 2022 23:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E0ECB806A0
        for <linux-wireless@vger.kernel.org>; Sat, 10 Sep 2022 06:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4701C433D6;
        Sat, 10 Sep 2022 06:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662791191;
        bh=yTVjIXVv9rN3IP/QkL7FC0AQ63K4AO/o3t0aBFJq0Qs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=kNXw8FMmIPmDZUfLQkHTNmdxCYkLrL7TVELkjQj1eKiwgP5SIM624Gafm1cfXVwj+
         Ls+y1K0FcEGgBP7gUn2IuiS2vqaGSYLRHHrr2FnOVCeZOqBTILMqu/iMoAMYU6BZvm
         iy/8A5X/MfkcTJKfJYmAQ9TaGTgjyJxe/VLpyf3QOAcu5NgngEHzmMuWXM6IGQg/sG
         s68my0Hlu2Trub4ph17bf75NK4yFhIcFlPgkvtY7Q0H+8Dn5FYopO1RiHeU6fM5hCu
         2TI/XoDzEG2nu04FT8Uxjra8fUyhB8CyRpMJV0ImOq2YcHOZ094bqrWH1zNR/Ol6Ue
         EPGZja/wvPgnw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] wifi: ath11k: Split PCI write/read functions
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220802075533.1744-2-quic_bqiang@quicinc.com>
References: <20220802075533.1744-2-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166279118836.2050.14810899093948746429.kvalo@kernel.org>
Date:   Sat, 10 Sep 2022 06:26:30 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> ath11k_pcic_write32/read32 tries to do wake up before doing actual
> write/read work, which means each time a u32 is written/read, wake
> up is performed. This is not necessary in case where we do a
> large amount of write/read, because only one time of wake up is needed.
> So split each one into two parts, the first part does wake up and
> release, and the second one does actual write/read work.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

90aad48eb56f wifi: ath11k: Split PCI write/read functions
876eb84882a8 wifi: ath11k: implement SRAM dump debugfs interface

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220802075533.1744-2-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

