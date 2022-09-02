Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7A85AAEBC
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 14:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbiIBM3M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 08:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbiIBM2T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 08:28:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A4BDF0A0;
        Fri,  2 Sep 2022 05:24:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE6F0B82A99;
        Fri,  2 Sep 2022 12:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBE4C433D7;
        Fri,  2 Sep 2022 12:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662121378;
        bh=oyHGH9UTftZEqKaUXOjKGBBK38sKQD7Du+L1lAYRoyI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ngaUmljQn+cV8AmFsr51zw9JlSriE1KyTfqrh+WZzk2v2ZlWRnI0fvS5SmFQVVhRH
         N3FoB+DlIgMV86GdCHn70k/nL50+j1kRDcLFII3XC+hurNzitrWsTvJAFP8BJ5g9Cv
         6qtNfVPbTHcAhI2DqspH/6tzqLzp6m/j11rajLbcknxozOffWGz4pGnEu2qvsVAWWl
         yx25+IYK/+5FdKvpvqLq7BTDlsTDjYgzPk5g+xx4H4ML9Iiztr9s8qsiTTrF8TMnJ1
         4rqOswsEVtN9MUm/Af593njcxtft6KEIs8AVUmA+Mc1ELWNNldpgnFPC0esUuKyjdr
         lmroSiSwKNh/Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] ath11k: Add WoW support for WCN6750
References: <20220902112520.24804-1-quic_mpubbise@quicinc.com>
        <20220902112520.24804-3-quic_mpubbise@quicinc.com>
Date:   Fri, 02 Sep 2022 15:22:51 +0300
In-Reply-To: <20220902112520.24804-3-quic_mpubbise@quicinc.com> (Manikanta
        Pubbisetty's message of "Fri, 2 Sep 2022 16:55:20 +0530")
Message-ID: <87h71qartw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> Add support for WoW on WCN6750 chipset.
>
> Unlike other chips where WoW exit happens after sending WoW wakeup
> WMI command, exit from WoW suspend in the case of WCN6750 happens
> upon sending a WoW exit SMP2P (Shared memory point to point) message
> to the firmware.
>
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
>
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>

In the future please always add "wifi:" to wireless patches. No need to
resend because of this, I can fix it.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
