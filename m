Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C67645FF3
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 18:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiLGRSP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 12:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiLGRRp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 12:17:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E536069333
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 09:17:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 976FCB81F86
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 17:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3932DC433D6;
        Wed,  7 Dec 2022 17:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670433439;
        bh=tPvUf0/sHdPV2YSh+0nDeUZk9yqOADgoGBRp/xdd1ec=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=QNWHRme9Df4ybFR7rFOSzuxpFvTW3G8Qp7Az4UX8sbO0IWRdl1CPnBvxx0Ut0Uf9J
         ejCxHHXihKOfaMYAzd+gA1gwKxI3OzNW4604voB7AQwkOfG4fUuTa6pjr07hf1ni4v
         16l43HKxOwvn3e3r6MXq1ZxpIBupIuWpP7nuOHwWFoI2L7hru0bxjo2Ah42P7CGy7Q
         gJMGWAm2l5j9QoUTzu4swvRqpahw5n1UDkqpM+AvTbQ0HHt+U96oVA7e8/ds1BiH1e
         Ax2bpxMc/szaPSvYsIdRAZTh0H1nG2TYQP9MPVd+LNLW/UdH1PXz8BnlII8YtRwVjw
         4x6bWlr0Cx9Jg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCHv2 1/8] wifi: dt: bindings: net: add IPQ5018 compatible
 entry
 for ath11k
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221122132152.17771-2-quic_kathirve@quicinc.com>
References: <20221122132152.17771-2-quic_kathirve@quicinc.com>
To:     Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Sriram R <quic_srirrama@quicinc.com>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167043343244.16838.6003784480944515283.kvalo@kernel.org>
Date:   Wed,  7 Dec 2022 17:17:18 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Kathirvel <quic_kathirve@quicinc.com> wrote:

> Add IPQ5018 device support for ath11k.
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Co-developed-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

8 patches applied to ath-next branch of ath.git, thanks.

679d708a10ec dt: bindings: net: ath11k: add IPQ5018 compatible
8dfe875aa24a wifi: ath11k: update hw params for IPQ5018
26af7aabd2d8 wifi: ath11k: update ce configurations for IPQ5018
b42b3678c91f wifi: ath11k: remap ce register space for IPQ5018
711b80acbdfb wifi: ath11k: update hal srng regs for IPQ5018
ba60f2793d3a wifi: ath11k: initialize hw_ops for IPQ5018
69968f88f177 wifi: ath11k: add new hw ops for IPQ5018 to get rx dest ring hashmap
25edca7bb18a wifi: ath11k: add ipq5018 device support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221122132152.17771-2-quic_kathirve@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

