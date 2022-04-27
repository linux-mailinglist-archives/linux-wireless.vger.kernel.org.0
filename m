Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8344511255
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 09:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358760AbiD0H31 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 03:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358759AbiD0H30 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 03:29:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D2644771;
        Wed, 27 Apr 2022 00:26:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB5F961ADE;
        Wed, 27 Apr 2022 07:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10FEC385AF;
        Wed, 27 Apr 2022 07:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651044374;
        bh=F6qI68i8z8l7t3NoHSf81x8+WLlXe4rKy/juqO44zaA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=qymtwT65aE4xSJbJTku1nlJrWbZnmwD/IveqmK7Qfhv4V7ZPCLkC6N5LEZjS8TavI
         dpv8ihHFl48Aq6br4n3N43bW2MIuQ18eiKmZx3kSx4ZWFmJQl1XVFOl6YsVbskB4TS
         vneEn2fKUP+9cZpgtuzbMxrH8f8sacGi9hb2WZgbdPlmrKKUC1KPwLtN3r4EQlbHB9
         FDkdUlcmyImUY2fKoCOYqkkGB2Yak8N0fYxxVLD2q3SZQk891UxhBIMzE+RrePzw6p
         X8C1ydmAcfgdWuPhbgUXQASlFMXPIGSMG997L6LcI0Olo55m+D50VngemF06QnT+MH
         AxGY9Phzl8ALQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 09/12] ath11k: Do not put HW in DBS mode for WCN6750
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220406094107.17878-10-quic_mpubbise@quicinc.com>
References: <20220406094107.17878-10-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        <mka@chromium.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165104436845.23965.9240232763822798831.kvalo@kernel.org>
Date:   Wed, 27 Apr 2022 07:26:12 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> wrote:

> Though WCN6750 is a single PDEV device, it is not a
> DBS solution. So, do not put HW in DBS mode for WCN6750.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

b6f6301041a3 ath11k: Do not put HW in DBS mode for WCN6750
95959d702ede ath11k: WMI changes to support WCN6750
33b67a4b4e64 ath11k: Update WBM idle ring HP after FW mode on

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220406094107.17878-10-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

