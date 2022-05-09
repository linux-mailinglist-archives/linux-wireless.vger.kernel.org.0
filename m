Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E9B51FBC3
	for <lists+linux-wireless@lfdr.de>; Mon,  9 May 2022 13:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbiEIL6k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 May 2022 07:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiEIL6k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 May 2022 07:58:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E5F1E0288
        for <linux-wireless@vger.kernel.org>; Mon,  9 May 2022 04:54:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEA84612AF
        for <linux-wireless@vger.kernel.org>; Mon,  9 May 2022 11:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBD2C385AB;
        Mon,  9 May 2022 11:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652097285;
        bh=jQjOOtNpxpDFq6PzmcAd+quJ3sSW0LUC1b7oMv0wFNs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=iMGQrT1YNlPViSNCEGS7KBymcWcEP+4d7YL+07FMAS2F5dMvXYdMtLUryLzMJQFTr
         jgBS7etNr3a2raw9I8JSDVj5pIK0QT42lZzF+Vyx5wrWi5DuSoSDyr/MeG5g1EcFu5
         4YjqKI6ycMyRN9FZ/PuZzPemxiJf/hByQYm+xtS3vL+b0g4SPz5O3Pos2UzLppRERY
         Siubk4Qp+jE7CssroJ7EsFX8Z/at7sZ987VcY7dJnck5J1u63aEbumkrsgk4Ghapr6
         M711cPJKb2rqnKLZ0DVmYAThmjRZSqL9obTRkC68CGBKsADC0hFsLILrLaY7il4CQr
         W+ikIAutQDpcg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: reset 11d state in process of recovery
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220505034636.29582-1-quic_wgong@quicinc.com>
References: <20220505034636.29582-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165209728067.20365.11713036278436650363.kvalo@kernel.org>
Date:   Mon,  9 May 2022 11:54:44 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> When doing simulate_fw_crash operation periodically with a short interval
> time such as 10 seconds, it is easy happened WMI command timed out for
> WMI_SCAN_CHAN_LIST_CMDID in ath11k_reg_update_chan_list().
> 
> log:
> [42287.610053] ath11k_pci 0000:01:00.0: wmi command 12291 timeout
> [42287.610064] ath11k_pci 0000:01:00.0: failed to send WMI_SCAN_CHAN_LIST cmd
> [42287.610073] ath11k_pci 0000:01:00.0: failed to perform regd update : -11
> 
> Note that this issue does not occur with a longer interval such as 20 seconds.
> 
> The reason the issue occurs with a shorter interval is the following steps:
> 1) Upon initial boot, or after device recovery, the initial hw scan plus
> the 11d scan will run, and when 6 GHz support is present, these scans
> can take up to 12 seconds to complete, so ath11k_reg_update_chan_list()
> is still waiting the completion of ar->completed_11d_scan.
> 2) If a simulate_fw_crash operation is received during this time, those
> scans do not complete, and ath11k_core_pre_reconfigure_recovery()
> complete the ar->completed_11d_scan, then ath11k_reg_update_chan_list()
> wakeup and start to send WMI_SCAN_CHAN_LIST_CMDID, but firmware is crashed
> at this moment, so wmi timed out occur.
> 
> To address this issue, reset the 11d state during device recovery so that
> WMI_SCAN_CHAN_LIST_CMDID does not timed out for short interval time such
> as 10 seconds.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Fixes: 1f682dc9fb37 ("ath11k: reduce the wait time of 11d scan and hw scan while add interface")
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

9497b7880ffd ath11k: reset 11d state in process of recovery

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220505034636.29582-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

