Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D701445014A
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Nov 2021 10:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbhKOJ2o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 04:28:44 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:58692 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236700AbhKOJ1g (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 04:27:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636968273; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=8t4DsSMao2L6j1TNomnRPPNMD+XcxA54KH3dyo9sTQQ=;
 b=MtOIbdn88n02q1eeLMpINnyrR8+FyrdzBXvv4orrWLBDP9w/J8Rp0O93+API2c291sEOQzmY
 rJCdYAfcd9oc0PabxSs42/dMLJZDDjRDHoxNKPPHHnjDhXr3TxEEWvxEc1SbL5w5YzjFUs30
 J05ZCU0X80aagis9dFZceqUMr9c=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6192275011cd6d40778f6f67 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Nov 2021 09:24:32
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9D726C4360D; Mon, 15 Nov 2021 09:24:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2BA95C4338F;
        Mon, 15 Nov 2021 09:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 2BA95C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: move peer delete after vdev stop of station for
 QCA6390 and WCN6855
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211027093825.12167-1-quic_wgong@quicinc.com>
References: <20211027093825.12167-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163696826945.13305.8157275042821853526.kvalo@codeaurora.org>
Date:   Mon, 15 Nov 2021 09:24:32 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> When station connect to AP, the wmi command sequence is:
> 
> peer_create->vdev_start->vdev_up
> 
> and sequence of station disconnect fo AP is:
> 
> peer_delete->vdev_down->vdev_stop
> 
> The sequence of disconnect is not opposite of connect, it caused firmware
> crash when it handle wmi vdev stop cmd when the AP is support TWT of
> 802.11 ax, because firmware need access the bss peer for vdev stop cmd.
> 
> [  390.438564] ath11k_pci 0000:05:00.0: wmi cmd send 0x6001 ret 0
> [  390.438567] ath11k_pci 0000:05:00.0: WMI peer create vdev_id 0 peer_addr c4:04:15:3b:e0:39
> [  390.472724] ath11k_pci 0000:05:00.0: mac vdev 0 start center_freq 2437 phymode 11ax-he20-2g
> [  390.472731] ath11k_pci 0000:05:00.0: wmi cmd send 0x5003 ret 0
> [  390.560849] ath11k_pci 0000:05:00.0: wmi cmd send 0x5005 ret 0
> [  390.560850] ath11k_pci 0000:05:00.0: WMI mgmt vdev up id 0x0 assoc id 1 bssid c4:04:15:3b:e0:39
> 
> [  399.432896] ath11k_pci 0000:05:00.0: WMI peer delete vdev_id 0 peer_addr c4:04:15:3b:e0:39
> [  399.432902] ath11k_pci 0000:05:00.0: wmi cmd send 0x6002 ret 0
> [  399.441380] ath11k_pci 0000:05:00.0: wmi cmd send 0x5007 ret 0
> [  399.441381] ath11k_pci 0000:05:00.0: WMI vdev down id 0x0
> [  399.454681] ath11k_pci 0000:05:00.0: wmi cmd send 0x5006 ret 0
> [  399.454682] ath11k_pci 0000:05:00.0: WMI vdev stop id 0x0
> 
> The opposite sequence of disconnect should be:
> 
> vdev_down->vdev_stop->peer_delete
> 
> This patch change the sequence of disconnect for station as above
> opposite sequence for QCA6390, firmware not crash again with this patch.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

b4a0f54156ac ath11k: move peer delete after vdev stop of station for QCA6390 and WCN6855

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211027093825.12167-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

