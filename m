Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4614E2519
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 12:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242182AbiCULSO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 07:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346728AbiCULR6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 07:17:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3CF13CA07
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 04:16:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E111E60AD8
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 11:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEA0C340E8;
        Mon, 21 Mar 2022 11:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647861392;
        bh=Gc6w4SyLoHH7rLdsaBZnS+Z+NN6F7MssyEh57+LkU58=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aGCs8tge8UXsglO3CyQJailDbuinA7+UO5mFHhzkyL0xQN21r9FCCWBP0ORn/YePE
         o1ygco3RTWA6/QkvyRM6oPUNapXR03amq7WhNT8QgDH5/d1w2E4zlkO30yxSr3M3hq
         LDWdNJ/haMFZSQzF0RbvJCJIXCKjjeuwISZFwLjDcafopaw2Uc0oAxoqyUZWY0vhPt
         mT4G7i2ljWSMrN6EK2KCjV/J/PZE0zJZa6W25C5EXy+YvyjkWA7DUUpsFwOMi3oq7g
         taaGUMYt2aZR+pMQEWCTK4zMcYmvsGS3NtfBm7W0SYAst1dr+90mXSLitqQK2HbzrS
         iNu36E2cbvplA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v8 1/4] ath11k: add support for device recovery for QCA6390/WCN6855
References: <20220228064606.8981-1-quic_wgong@quicinc.com>
        <20220228064606.8981-2-quic_wgong@quicinc.com>
Date:   Mon, 21 Mar 2022 13:16:29 +0200
In-Reply-To: <20220228064606.8981-2-quic_wgong@quicinc.com> (Wen Gong's
        message of "Mon, 28 Feb 2022 01:46:03 -0500")
Message-ID: <87pmmfmu7m.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

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

[...]

>  void ath11k_core_free(struct ath11k_base *ab)
>  {
> +	flush_workqueue(ab->workqueue_aux);
> +	destroy_workqueue(ab->workqueue_aux);
> +
>  	flush_workqueue(ab->workqueue);
>  	destroy_workqueue(ab->workqueue);

This had a conflict and in the pending branch I removed
flush_workqueue(ab->workqueue_aux). Flush is not needed before destroy.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
