Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6A976E40E
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 11:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjHCJNL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 05:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjHCJMg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 05:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB0C19B0
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 02:12:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD2AA61CE5
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 09:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59997C433C7;
        Thu,  3 Aug 2023 09:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691053949;
        bh=qw2vBVs61mUR4qNIQQoaQ7yqtAZW3+ItPnYXuXFJZvs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=PDRd9HkzJJkezc3ySwrhNP/5SuoSYA7l56vVOchoKqXxiW/whJ9HM9q27iQacOXJX
         EjfsEjOMJ02nakpJaopt5DvIySLArA0vglFbZaew02rFT4OIH758A3aHXcOT6DZb6c
         oYQLsZMwO7uDOif1C8Z4tG9fc28A8392ADAvClZx3mHNvpRvHGeVMhPLzSHEPOF8nZ
         AZWCToL8L0PvjNXYOSM11OzOkDtEshi3TYf0uQ8xgKuvKApM2r+tZJam4uV2QLDaqy
         31306VcrXI9sBUuT7SMXTchwWqR0cTUwuh9GGGwV4p12xQCP4c3QufkzYkE7IJoMmk
         TfB1VRYYbrSXg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 01/11] wifi: ath12k: rename HE capabilities setup/copy
 functions
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230725224034.14045-2-quic_alokad@quicinc.com>
References: <20230725224034.14045-2-quic_alokad@quicinc.com>
To:     Aloka Dixit <quic_alokad@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Aloka Dixit <quic_alokad@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169105394648.894438.12789099943827737318.kvalo@kernel.org>
Date:   Thu,  3 Aug 2023 09:12:28 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <quic_alokad@quicinc.com> wrote:

> Functions ath12k_mac_setup_he_cap() and ath12k_mac_copy_he_cap()
> propagate HE and 6GHz capabilities to the userspace using an instance
> of struct ieee80211_sband_iftype_data. This structure now has a new
> member 'eht_cap' to include EHT capabilities as well.
> Rename the above mentioned functions to indicate that their use is not
> limited to HE.
> 
> Also, replace the local variable 'band' with 'sband' and reuse
> 'band' for the type enum nl80211_band.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

11 patches applied to ath-next branch of ath.git, thanks.

e22f5b780c69 wifi: ath12k: rename HE capabilities setup/copy functions
a7a6a45d37fe wifi: ath12k: move HE capabilities processing to a new function
1476014fadb6 wifi: ath12k: WMI support to process EHT capabilities
dbe90679bfa1 wifi: ath12k: propagate EHT capabilities to userspace
38013653a697 wifi: ath12k: add EHT PHY modes
17bbb8aa74fd wifi: ath12k: prepare EHT peer assoc parameters
5b70ec6036c1 wifi: ath12k: add WMI support for EHT peer
6734cf9b4cc7 wifi: ath12k: peer assoc for 320 MHz
22e1d1166c27 wifi: ath12k: add MLO header in peer association
9211df5c025a wifi: ath12k: parse WMI service ready ext2 event
07c01b86f21d wifi: ath12k: configure puncturing bitmap

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230725224034.14045-2-quic_alokad@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

