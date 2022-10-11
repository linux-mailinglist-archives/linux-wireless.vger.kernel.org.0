Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FF25FADC1
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 09:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJKHtX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 03:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiJKHtW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 03:49:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A871688A24
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 00:49:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CBF26112E
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 07:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84F2C433D6;
        Tue, 11 Oct 2022 07:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665474560;
        bh=1WwSYM23oQxupcqStJLm5dOD3V1ZFzvJPyXZLixzaEI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=gh/oqtMl+fLOoVycmWzsk5oRwgBrOuqrHr3+A9rSH5K2wlxqLqGB1bEXNFvMVFLkz
         2uDSSwv1wMfXNUvtH7sy2kozNpOIo1QhtRPinVXDFyImWi6gjv7QSfG2rCmxRzw9ah
         gdv2uaAJJoUuyPnSek095Oh8NJEzhBv4VNgVtSTXxsyXGTpFrmK5f0YSziQ21b3sK5
         gsIJjTywEmPAkr1TtCD1maSz8zUQNru5NKdrtzGAijCK1v9XXhPyuTG6rOn9ljZ5oU
         74q7Ax0QYuTjezqBiQqk5nDga0Dkf8n39FCrU0RgpeBaVmRcTvtAT83tYcXOiTxS/M
         7Abx80/aSaZpg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: Send PME message during wakeup from D3cold
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221010033237.415478-1-quic_bqiang@quicinc.com>
References: <20221010033237.415478-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166547455486.8038.9803492494856020045.kvalo@kernel.org>
Date:   Tue, 11 Oct 2022 07:49:19 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> We are seeing system stuck on some specific platforms due to
> WLAN chip fails to wakeup from D3cold state.
> 
> With this flag, firmware will send PME message during wakeup
> and this issue is gone.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

The firmware you are using is old, please update to the latest one:

https://github.com/kvalo/ath11k-firmware/tree/master/WCN6855/hw2.0/1.1/WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16

It's very important that the testing happens on latest components.

No need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221010033237.415478-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

