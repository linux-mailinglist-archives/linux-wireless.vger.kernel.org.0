Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887B44EEC97
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 13:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244245AbiDALxb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 07:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240724AbiDALx3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 07:53:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88EB27085F
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 04:51:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 848B1B82371
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 11:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A92C340F2;
        Fri,  1 Apr 2022 11:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648813897;
        bh=AyWwa1J0ROIKoHEO/t9OAevXpeOcPdXLgGUuPLlLr8w=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Ik3RF4bnqJXbBBr+H+P13eDSHcre37wRTQh3M/3oxSKH0L9Xq27oBXNYCYbfoqRH7
         pQfVAIrp7++4nSji6YhveYZ1Sqkra1qJ0LaW03etuMl8+CfCmmz6JezUQR0z2Utbly
         gY8nTt+4nWmiJbvBCLMVXGr1mispgH2NphlB+6vss5DOFllmQn+3DQTeE7awwf3VZq
         VkBDEIx9YMWDOx5c/TykX946NEFcKMQFgjvYvlUlJL9npIj5CvCaHMjdBkCmfRwzTB
         skskTrEBb2OeI3KxGeNIZixdgNJnq4AQ9ndGkJDOAKfo4tEmtE7kOjPgkGshXhUxvA
         toP1SNRACAwJA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5.18] ath11k: fix driver initialization failure with WoW
 unsupported hw
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220331073110.3846-1-quic_nmaran@quicinc.com>
References: <20220331073110.3846-1-quic_nmaran@quicinc.com>
To:     Nagarajan Maran <quic_nmaran@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Nagarajan Maran <quic_nmaran@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164881389362.6665.5091759680024849832.kvalo@kernel.org>
Date:   Fri,  1 Apr 2022 11:51:36 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nagarajan Maran <quic_nmaran@quicinc.com> wrote:

> In the "ath11k_wow_init", error value "EINVAL" is returned
> when the check for firmware support of WoW feature fails,
> which in turn stops the driver initialization.
> 
> Warning message:
> [   31.040144] ------------[ cut here ]------------
> [   31.040185] WARNING: CPU: 1 PID: 51 at drivers/net/wireless/ath/ath11k/wow.c:813 ath11k_wow_init+0xc8/0x13a8 [ath11k]
> [   31.043846] Modules linked in: ath11k_pci ath11k qmi_helpers
> [   31.054341] CPU: 1 PID: 51 Comm: kworker/u8:1 Tainted: G        W    5.17.0-wt-ath-594817-ga7f6aa925cf8-dirty #17
> [   31.060078] Hardware name: Qualcomm Technologies, Inc. IPQ8074/AP-HK10-C2 (DT)
> [   31.070578] Workqueue: ath11k_qmi_driver_event ath11k_qmi_driver_event_work [ath11k]
> [   31.077782] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   31.085676] pc : ath11k_wow_init+0xc8/0x13a8 [ath11k]
> [   31.092359] lr : ath11k_mac_register+0x548/0xb98 [ath11k]
> [   31.097567] sp : ffff80000aa13c40
> [   31.102944] x29: ffff80000aa13c40 x28: ffff800009184390 x27: ffff000002959f20
> [   31.106251] x26: ffff000002828000 x25: ffff000002830000 x24: ffff000002830000
> [   31.113369] x23: ffff000002820000 x22: ffff00000282854c x21: 0000000000000000
> [   31.120487] x20: ffff00000295cf20 x19: ffff000002828540 x18: 0000000000000031
> [   31.127605] x17: 0000000000000004 x16: ffff0000028285fc x15: ffff00000295b040
> [   31.134723] x14: 0000000000000067 x13: ffff00000282859c x12: 000000000000000d
> [   31.141840] x11: 0000000000000018 x10: 0000000000000004 x9 : 0000000000000000
> [   31.148959] x8 : ffff00000289d680 x7 : 0000000000000000 x6 : 000000000000003f
> [   31.156077] x5 : 0000000000000040 x4 : 0000000000000000 x3 : ffff000002820968
> [   31.163196] x2 : 0000000000000080 x1 : 0080008af9981779 x0 : ffff000002959f20
> [   31.170314] Call trace:
> [   31.177421]  ath11k_wow_init+0xc8/0x13a8 [ath11k]
> [   31.179684]  ath11k_core_qmi_firmware_ready+0x430/0x5e0 [ath11k]
> [   31.184548]  ath11k_qmi_driver_event_work+0x16c/0x4f8 [ath11k]
> [   31.190623]  process_one_work+0x134/0x350
> [   31.196262]  worker_thread+0x12c/0x450
> [   31.200340]  kthread+0xf4/0x110
> [   31.203986]  ret_from_fork+0x10/0x20
> [   31.207026] ---[ end trace 0000000000000000 ]---
> [   31.210894] ath11k_pci 0000:01:00.0: failed to init wow: -22
> [   31.215467] ath11k_pci 0000:01:00.0: failed register the radio with mac80211: -22
> [   31.221117] ath11k_pci 0000:01:00.0: failed to create pdev core: -22
> 
> Fix this by returning value "0" when FW doesn't support WoW
> to allow driver to proceed with initialize sequence and also
> remove the unnecessary "WARN_ON".
> 
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> 
> Fixes: ba9177fcef21 ("ath11k: Add basic WoW functionalities")
> Signed-off-by: Nagarajan Maran <quic_nmaran@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Even though I asked you to mark this for v5.18, I now realised that commit
ba9177fcef21 is only in ath-next. So I'll apply this to ath-next as well.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220331073110.3846-1-quic_nmaran@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

