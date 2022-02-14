Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44824B590E
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 18:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355970AbiBNRrf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 12:47:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbiBNRrf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 12:47:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066A6652C4
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 09:47:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7B62B80DCD
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 17:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4B7C340E9;
        Mon, 14 Feb 2022 17:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644860844;
        bh=MDolvpeYbkZQWOyDXYeyhtIlGQ/yEDl7GGAp7F8ATBY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=DQvOV2WZaNwqLulN7CrgLGnf5/u2vXHQpqQPL2ELWj4nJiqUlhWlg4rFdP3FTeInd
         i7NqjTyyiEbwZJDwk0By7SOmycv6aIxATZW7gUHFw2qT4pomIv0s0rrSBhR2a2LrpN
         daGSE8xt44S+LzLNj9g31QSTmB29iOkiDSqJy6DB29rfbr7n/FnUGv3YtzLeuGACNM
         ugTuipsQ4cVRAz3P8y8baEeBDIqvs0IlURv2zGXz4qhRDXqA32xhjf4lNquWGIKpgC
         mKXf0MpGVlpMhcRMHa93FEBWpLCPTBGo79KnkL0OGVXqnSUhfZwcaNYuvI3kXzxaZ4
         mzG75BIQRrQTw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4] ath11k: fix destination monitor ring out of sync
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220210064706.6171-1-quic_kathirve@quicinc.com>
References: <20220210064706.6171-1-quic_kathirve@quicinc.com>
To:     Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164486084170.4355.17341295247550421852.kvalo@kernel.org>
Date:   Mon, 14 Feb 2022 17:47:23 +0000 (UTC)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Kathirvel <quic_kathirve@quicinc.com> wrote:

> More than 20000 PPDU id jumping causing status ring and destination
> ring processing not sync. The status ring is processed and the
> destination ring is not processed. Since destination is not reaped for
> so long, backpressure occurs at the destination ring.
> 
> To address this issue update the PPDU id with the latest PPDU, this
> will allow the destination ring to be reaped and will prevent the
> rings from getting out of sync.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1.r1-00026-QCAHKSWPL_SILICONZ-2
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

1e15aacd1238 ath11k: fix destination monitor ring out of sync

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220210064706.6171-1-quic_kathirve@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

