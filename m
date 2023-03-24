Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24786C8050
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Mar 2023 15:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjCXOt7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Mar 2023 10:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjCXOtq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Mar 2023 10:49:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B74820579
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 07:49:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3168262972
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 14:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A613EC433D2;
        Fri, 24 Mar 2023 14:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679669378;
        bh=Hl8W0w9BtHpICBcGok2UYwa+8acwZYFJHjOzIeFWJDM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=oy16oRUHxjuk07I4+78mpaFTIk4K7ilRS5IJOxNDrxMrVMIetRP48/DA7ONRsdtIN
         YP2IjkX4yZKJQ3PbPSuLElkNnwF2+yy0HT8qkLJnrxmwwPpTNJWGLC4MwBEFerov6T
         IqZTauETTw8gH1lWX+bylV0xovpJH+99oCmFfKGDIvu9RKfotulbvQD1sNqfUvJPMn
         QAAK7GOcj2z8Flt3N3RmJrzO6g1st/Ux1zI9Pm/7vW2RqYetLhfGcwonw9xVI75Kxu
         DwtI0UzoH/Km4CWz9S2obL6SCU65VxX73liVx+5Q6wKy1IWkSDYL6Dqd2hQ8mR+w43
         rIGmQWGSRxYvg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: incorrect channel survey dump
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230320091208.25535-1-quic_hprem@quicinc.com>
References: <20230320091208.25535-1-quic_hprem@quicinc.com>
To:     Harshitha Prem <quic_hprem@quicinc.com>
Cc:     ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Harshitha Prem <quic_hprem@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167966937560.27260.15117945912260469719.kvalo@kernel.org>
Date:   Fri, 24 Mar 2023 14:49:37 +0000 (UTC)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Harshitha Prem <quic_hprem@quicinc.com> wrote:

> When underlying hardware supports more than one band, then wiphy
> is aware of all the frequency bands present. Example, say
> wiphy0 is aware of 2 GHz, 5 GHz and 6 GHz band information.
> Hence, when an virtual AP interface is brought up in auto channel
> selection on each band. Survey is initiated from the userspace application
> for all the virtual AP interfaces simultaneously.
> 
> For survey dump collection, freq_to_idx() api is used to map the index of
> particular frequency to populate its survey. When the dump was collected,
> the index fetched was incorrect. Example, in case of multi-hardware,
> the index of channel 36 was reported as 14, because wiphy0 had index 0-13
> for 2 GHz channels, instead of 0 for that ar which resulted in invalid
> survey sent to userspace application.
> 
> The incorrect index was because of the mapping did not consider whether
> the freq band is present in its radio structure (ar) or not.
> 
> To handle this, the freq_to_idx() api should map index for the
> particular band in the ar structure.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

25d165c49802 wifi: ath12k: incorrect channel survey dump

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230320091208.25535-1-quic_hprem@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

