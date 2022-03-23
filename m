Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436E34E4ED7
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 10:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbiCWJEO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 05:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiCWJEM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 05:04:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF1072E15
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 02:02:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0EE6617A6
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 09:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F3EC340E8;
        Wed, 23 Mar 2022 09:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648026162;
        bh=rXCsEhloZ5QU8QIlegzd8ZSAKSU+r9o5PMatE9byQgE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=d3MI4/bKv/8wf6mEnWv7br0QvTT9IoRpAea/V4Il3L123gcgOrZK0i79yCXYOAob/
         d5IUQJmrrCDkyo3qBfm66vLx/G3nTyW09KmPVbPr7mU+ZnK2qmrfhcnP7M7ThVRP4B
         CrJMLwhdbVOecmO0JBlB1fhuojI3RSjadm+Gv4joQj0vf6pMPL74T5PlG7cVoXY9UX
         nhEJvN6dJ0qh/mmKbFGcM46JRRUAf6Rpiyt2WQiv4WRIO/NdiK1KVFGS8S48uuTw3l
         2r44z9UgoxhHtfWglDdrcAs1dOzsb8/slSkRgpWUmYM4F8ijTiWsGKp0ae+plnHAuP
         95wpUJ1Zo6ohw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v8 1/4] ath11k: add support for device recovery for
 QCA6390/WCN6855
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220228064606.8981-2-quic_wgong@quicinc.com>
References: <20220228064606.8981-2-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164802615605.545.4592174487303801360.kvalo@kernel.org>
Date:   Wed, 23 Mar 2022 09:02:41 +0000 (UTC)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> Currently ath11k has device recovery logic, it is introduced by this
> patch "ath11k: Add support for subsystem recovery" which is upstream
> by https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=ath11k-bringup&id=3a7b4838b6f6f234239f263ef3dc02e612a083ad.
> 
> The patch is for AHB devices such as IPQ8074, it has remote proc module
> which is used to download the firmware and boots the processor which
> firmware is running on. If firmware crashed, remote proc module will
> detect it and download and boot firmware again. Below command will
> trigger a firmware crash, and then user can test feature of device
> recovery.
> 
> Test command:
> echo assert > /sys/kernel/debug/ath11k/qca6390\ hw2.0/simulate_fw_crash
> echo assert > /sys/kernel/debug/ath11k/wcn6855\ hw2.0/simulate_fw_crash
> 
> Unfortunately, QCA6390 is PCIe bus, it does not have the remote proc
> module, it use mhi module to communicate between firmware and ath11k.
> So ath11k does not support device recovery for QCA6390 currently.
> 
> This patch is to add the extra logic which is different for QCA6390.
> When firmware crashed, MHI_CB_EE_RDDM event will be indicate by
> firmware and then ath11k_mhi_op_status_cb which is the callback of
> mhi_controller will receive the MHI_CB_EE_RDDM event, then ath11k
> will start to do recovery process, ath11k_core_reset() calls
> ath11k_hif_power_down()/ath11k_hif_power_up(), then the mhi/ath11k
> will start to download and boot firmware. There are some logic to
> avoid deadloop recovery and two simultaneous recovery operations.
> And because it has muti-radios for the soc, so it add some logic
> in ath11k_mac_op_reconfig_complete() to make sure all radios has
> reconfig complete and then complete the device recovery.
> 
> Also it add workqueue_aux, because ab->workqueue is used when receive
> ATH11K_QMI_EVENT_FW_READY in recovery process(queue_work(ab->workqueue,
> &ab->restart_work)), and ath11k_core_reset will wait for max
> ATH11K_RESET_TIMEOUT_HZ for the previous restart_work finished, if
> ath11k_core_reset also queued in ab->workqueue, then it will delay
> restart_work of previous recovery and lead previous recovery fail.
> 
> ath11k recovery success for QCA6390/WCN6855 after apply this patch.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03003-QCAHSPSWPL_V1_V2_SILICONZ_LITE-2
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

4 patches applied to ath-next branch of ath.git, thanks.

13da397f884d ath11k: add support for device recovery for QCA6390/WCN6855
38194f3a605e ath11k: add synchronization operation between reconfigure of mac80211 and ath11k_base
78e3e6094220 ath11k: Add hw-restart option to simulate_fw_crash
0d7a8a6204ea ath11k: fix the warning of dev_wake in mhi_pm_disable_transition()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220228064606.8981-2-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

