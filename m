Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6BB7880FD
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 09:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjHYHhk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 03:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243251AbjHYHhP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 03:37:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF9F2115
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 00:37:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 477DE6194B
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 07:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F92C433C7;
        Fri, 25 Aug 2023 07:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692949029;
        bh=hN0YbyiYrl8AjNUF/1t/u5T7kx0yqD0TeUUlrQE2plg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Nrg6nBDrMmxqXdYF5fepANNakZ7UkIAotoNtbwc/ZYvUo3ge0Z4xybUE97XE40+bh
         l/wsMOPQnsr3Yt2FpX6xz3aDvrAL0c3W/WNb/E/jyY0VFyDwlJUbD9gtsP9QNM6Bi+
         98huwsfWDrVMTg/Hkiot6TUdq3TpqfOost/R8noAqYVO8q6k/KBuzyBAqY3oM+C3Dt
         /xR25VLENxo5AvVBfDo3TrNIOLyzdvseW3b1fEDrF8/qKiDN/8pBPMsnAKDO3rL+UD
         W1TxSYV9jUYwcTXZW48LrAHu6fdv84dhhr93wqHo3KJApgSxHrJCIVsmf0PeBjIUD0
         iSGzIdeAVh17A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath12k: add check max message length while
 scanning
 with extraie
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230809081657.13858-1-quic_wgong@quicinc.com>
References: <20230809081657.13858-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169294902664.1674223.5798401346278788819.kvalo@kernel.org>
Date:   Fri, 25 Aug 2023 07:37:08 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> Currently the extraie length is directly used to allocate skb buffer. When
> the length of skb is greater than the max message length which firmware
> supports, error will happen in firmware side.
> 
> Hence add check for the skb length and drop extraie when overflow and
> print a message.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

2f5124e86ae7 wifi: ath12k: add check max message length while scanning with extraie

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230809081657.13858-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

