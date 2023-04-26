Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F726EEDF4
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Apr 2023 08:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239459AbjDZGEI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Apr 2023 02:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDZGEH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Apr 2023 02:04:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72843213B
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 23:04:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0700F618C9
        for <linux-wireless@vger.kernel.org>; Wed, 26 Apr 2023 06:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD47C433D2;
        Wed, 26 Apr 2023 06:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682489045;
        bh=NKlsr26o1nZ46Pg3FtTO0jgQ8SsYgX7W/XJ+pGjtVUc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=VRO4FI8RWAVelaJQWVXkx5QeyH6eBLUSoAxro2ETMiGbBbg1oJxEo4Z1fBJwOF+nT
         RILXJuzVU4hEBvD513hg56Gl3lyndoVMexcBob3eT2/iTEtOm2/REev//YzpDekwYi
         bceAxxodOKmWbd3Ii/QafGqqy7wizQpOL9OF2za/fmIJw8iVDIyNnnXVpmXtYhPsET
         LzX45RVudVo7jnGWKmXULtHHijNS9O/1tiabYpEbAjTHXJZYtx/rnLpD0+U1Hgzetg
         xto1LfwPWBXW0/j4q4JOlsO0LQmWf/w2y4vnAN19B4K0CtWU48nJQoRoUCnoJG1nhm
         qPadw7w/dZ1dg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Aloka Dixit <quic_alokad@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 00/11] wifi: ath12k: (v3) EHT support
References: <20230413215156.2649-1-quic_alokad@quicinc.com>
Date:   Wed, 26 Apr 2023 09:03:59 +0300
In-Reply-To: <20230413215156.2649-1-quic_alokad@quicinc.com> (Aloka Dixit's
        message of "Thu, 13 Apr 2023 14:51:45 -0700")
Message-ID: <87ildjtc1c.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <quic_alokad@quicinc.com> writes:

> Add driver support to bring AP up in EHT mode, configure a preamble
> puncturing bitmap and associate with an EHT client.
>
> v3: Modified patches 6 and 9 to fix some issues,
> changelog included in the respective patches.
> v2: This version modifies only few commit descriptions,
> changelog included in the respective patches.
>
> Following list gives the details for each patch.
> 1-4: Propagation of EHT capabilities from target to userspace.
> Patches 1, 2 refactor the existing code to make EHT additions easier.
> 5: Addition of EHT phy modes.
> 6-9: EHT related additions in peer association.
> 10: Process the new WMI service ready ext2 event.
> 11: Preamble puncturing support.
>
> Aloka Dixit (9):
>   wifi: ath12k: rename HE capabilities setup/copy functions
>   wifi: ath12k: move HE capabilities processing to a new function
>   wifi: ath12k: process EHT capabilities
>   wifi: ath12k: propagate EHT capabilities to userspace
>   wifi: ath12k: prepare EHT peer assoc parameters
>   wifi: ath12k: add WMI support for EHT peer
>   wifi: ath12k: peer assoc for 320 MHz
>   wifi: ath12k: parse WMI service ready ext2 event
>   wifi: ath12k: configure puncturing bitmap
>
> Muna Sinada (1):
>   wifi: ath12k: add EHT PHY modes
>
> Pradeep Kumar Chitrapu (1):
>   wifi: ath12k: add MLO header in peer association

This breaks WCN7850 support:

[  144.039164] ath12k_pci 0000:06:00.0: BAR 0: assigned [mem 0xda200000-0xda3fffff 64bit]
[  144.039315] ath12k_pci 0000:06:00.0: enabling device (0000 -> 0002)
[  144.046220] ath12k_pci 0000:06:00.0: Hardware name: wcn7850 hw2.0
[  144.118539] mhi mhi0: Requested to power ON
[  144.118716] mhi mhi0: Power on setup success
[  144.222303] mhi mhi0: Wait for device to enter SBL or Mission mode
[  144.627712] ath12k_pci 0000:06:00.0: chip_id 0x2 chip_family 0x4 board_id 0x104 soc_id 0x40170200
[  144.627945] ath12k_pci 0000:06:00.0: fw_version 0x1005bc12 fw_build_timestamp 2022-10-11 12:13 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
[  144.959196] ath12k_pci 0000:06:00.0: failed to parse tlv -22
[  144.959317] ath12k_pci 0000:06:00.0: failed to parse ext2 event tlv -22
[  150.263567] ath12k_pci 0000:06:00.0: failed to receive wmi service ready event: -110
[  150.276547] ath12k_pci 0000:06:00.0: failed to start core: -110

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
