Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484D14EBC51
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Mar 2022 10:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243880AbiC3IHf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Mar 2022 04:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241258AbiC3IHe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Mar 2022 04:07:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98A42E9E7
        for <linux-wireless@vger.kernel.org>; Wed, 30 Mar 2022 01:05:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55764617A5
        for <linux-wireless@vger.kernel.org>; Wed, 30 Mar 2022 08:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE98C340F0;
        Wed, 30 Mar 2022 08:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648627548;
        bh=lMwTSB85/tsnYn79vvntRMAyII4q2RgNdTc9seOc6a0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Sxzyy+4mwEhcVXrZVboKMFEJUqsKTeEKaLfjvLR/LUKiZoNkvNOawJVy5BE6w6r/p
         35aaE6ycEhtuVs2lQr3olOPx81JVybisN+CSOM6O1FMeEElXLqrTPZQ4YiRxS9LdPw
         VgRg9FwJL4Q6SP/aorlXEoxBdz06uyzrfiWOx2tfq+hOUVk7UwMDJSq1P6IMDamFY9
         zAlOebrdlT5Vg44TKjgIXSxKlmvUt+rRJltfpzmGzaqRG7wmZTLQvf5Nlil150t5Lq
         vpsmNsWPMm55BKMW5YG09HnwB+MtgA5bPX6aCzY9SMrKotbfc7uUu/wuGm9oCyHi2C
         WEs/qJ46JiTYw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/3] ath11k: add support to search regdb data in
 board-2.bin
 for WCN6855
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220319023543.14288-4-quic_wgong@quicinc.com>
References: <20220319023543.14288-4-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164862754496.10264.18242438305394450679.kvalo@kernel.org>
Date:   Wed, 30 Mar 2022 08:05:47 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> Currently ath11k only download the same regdb.bin file for all WCN6855
> chips, actually ath11k needs to distinguish all different WCN6855 chips.
> 
> This is to re-use the string type which include bus, chip id, board id,
> vendor, device, subsystem-vendor, subsystem-device and variant for
> WCN6855 to distinguish different regdb in board-2.bin.
> 
> ath11k will first load board-2.bin and search in it for the regdb data
> with the above parameters, if matched one regdb data, then download it
> to firmware, if not matched any one, then ath11k will download the file
> regdb.bin to firmware.
> 
> Add enum value ATH11K_BD_IE_REGDB and enum type ath11k_bd_ie_regdb_type
> to distinguish regdb data and board data since they are in the same file
> board-2.bin.
> 
> This only take effect for WCN6855 which supports regdb in hardware parameters.
> 
> Test log:
> [ 3833.091948] ath11k_pci 0000:05:00.0: boot using board name 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262'
> [ 3833.092072] ath11k_pci 0000:05:00.0: boot firmware request ath11k/WCN6855/hw2.0/board-2.bin size 205316
> [ 3833.092079] ath11k_pci 0000:05:00.0: board name
> [ 3833.092083] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
> [ 3833.092088] ath11k_pci 0000:05:00.0: 00000010: 2d 69 64 3d 31                                   -id=1
> [ 3833.092091] ath11k_pci 0000:05:00.0: board name
> [ 3833.092095] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
> [ 3833.092099] ath11k_pci 0000:05:00.0: 00000010: 2d 69 64 3d 32                                   -id=2
> [ 3833.092102] ath11k_pci 0000:05:00.0: board name
> [ 3833.092105] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
> [ 3833.092109] ath11k_pci 0000:05:00.0: 00000010: 2d 69 64 3d 33                                   -id=3
> [ 3833.092112] ath11k_pci 0000:05:00.0: board name
> [ 3833.092116] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 76 65 6e 64 6f 72 3d 31  bus=pci,vendor=1
> [ 3833.092119] ath11k_pci 0000:05:00.0: 00000010: 37 63 62 2c 64 65 76 69 63 65 3d 31 31 30 33 2c  7cb,device=1103,
> [ 3833.092123] ath11k_pci 0000:05:00.0: 00000020: 73 75 62 73 79 73 74 65 6d 2d 76 65 6e 64 6f 72  subsystem-vendor
> [ 3833.092126] ath11k_pci 0000:05:00.0: 00000030: 3d 31 37 63 62 2c 73 75 62 73 79 73 74 65 6d 2d  =17cb,subsystem-
> [ 3833.092130] ath11k_pci 0000:05:00.0: 00000040: 64 65 76 69 63 65 3d 33 33 37 34 2c 71 6d 69 2d  device=3374,qmi-
> [ 3833.092133] ath11k_pci 0000:05:00.0: 00000050: 63 68 69 70 2d 69 64 3d 32 2c 71 6d 69 2d 62 6f  chip-id=2,qmi-bo
> [ 3833.092137] ath11k_pci 0000:05:00.0: 00000060: 61 72 64 2d 69 64 3d 32 36 36 2c 76 61 72 69 61  ard-id=266,varia
> [ 3833.092140] ath11k_pci 0000:05:00.0: 00000070: 6e 74 3d 48 50 5f 47 38 5f 4c 61 6e 63 69 61 31  nt=HP_G8_Lancia1
> [ 3833.092144] ath11k_pci 0000:05:00.0: 00000080: 35                                               5
> [ 3833.092147] ath11k_pci 0000:05:00.0: board name
> [ 3833.092150] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 76 65 6e 64 6f 72 3d 31  bus=pci,vendor=1
> [ 3833.092154] ath11k_pci 0000:05:00.0: 00000010: 37 63 62 2c 64 65 76 69 63 65 3d 31 31 30 33 2c  7cb,device=1103,
> [ 3833.092157] ath11k_pci 0000:05:00.0: 00000020: 73 75 62 73 79 73 74 65 6d 2d 76 65 6e 64 6f 72  subsystem-vendor
> [ 3833.092161] ath11k_pci 0000:05:00.0: 00000030: 3d 31 37 63 62 2c 73 75 62 73 79 73 74 65 6d 2d  =17cb,subsystem-
> [ 3833.092165] ath11k_pci 0000:05:00.0: 00000040: 64 65 76 69 63 65 3d 33 33 37 34 2c 71 6d 69 2d  device=3374,qmi-
> [ 3833.092168] ath11k_pci 0000:05:00.0: 00000050: 63 68 69 70 2d 69 64 3d 32 2c 71 6d 69 2d 62 6f  chip-id=2,qmi-bo
> [ 3833.092172] ath11k_pci 0000:05:00.0: 00000060: 61 72 64 2d 69 64 3d 32 36 36                    ard-id=266
> [ 3833.092206] ath11k_pci 0000:05:00.0: board name
> [ 3833.092209] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 76 65 6e 64 6f 72 3d 31  bus=pci,vendor=1
> [ 3833.092213] ath11k_pci 0000:05:00.0: 00000010: 37 63 62 2c 64 65 76 69 63 65 3d 31 31 30 33 2c  7cb,device=1103,
> [ 3833.092216] ath11k_pci 0000:05:00.0: 00000020: 73 75 62 73 79 73 74 65 6d 2d 76 65 6e 64 6f 72  subsystem-vendor
> [ 3833.092220] ath11k_pci 0000:05:00.0: 00000030: 3d 31 37 63 62 2c 73 75 62 73 79 73 74 65 6d 2d  =17cb,subsystem-
> [ 3833.092223] ath11k_pci 0000:05:00.0: 00000040: 64 65 76 69 63 65 3d 33 33 37 34 2c 71 6d 69 2d  device=3374,qmi-
> [ 3833.092227] ath11k_pci 0000:05:00.0: 00000050: 63 68 69 70 2d 69 64 3d 32 2c 71 6d 69 2d 62 6f  chip-id=2,qmi-bo
> [ 3833.092230] ath11k_pci 0000:05:00.0: 00000060: 61 72 64 2d 69 64 3d 32 36 32                    ard-id=262
> [ 3833.092234] ath11k_pci 0000:05:00.0: boot found match regdb data for name 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262'
> [ 3833.092238] ath11k_pci 0000:05:00.0: board name
> [ 3833.092241] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
> [ 3833.092245] ath11k_pci 0000:05:00.0: 00000010: 2d 69 64 3d 31 31                                -id=11
> [ 3833.092248] ath11k_pci 0000:05:00.0: board name
> [ 3833.092251] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
> [ 3833.092255] ath11k_pci 0000:05:00.0: 00000010: 2d 69 64 3d 32 32                                -id=22
> [ 3833.092258] ath11k_pci 0000:05:00.0: board name
> [ 3833.092261] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
> [ 3833.092265] ath11k_pci 0000:05:00.0: 00000010: 2d 69 64 3d 33 33                                -id=33
> [ 3833.092268] ath11k_pci 0000:05:00.0: boot found regdb data for 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262'
> [ 3833.092272] ath11k_pci 0000:05:00.0: fetched regdb
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

801cb1d23428 ath11k: add support to search regdb data in board-2.bin for WCN6855

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220319023543.14288-4-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

