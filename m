Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C78458E23
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 13:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbhKVMWm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 07:22:42 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:25084 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239522AbhKVMWk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 07:22:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637583574; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=badTdAeiK7xcG9Sp7wYhaDwLAIKhT+cXxa3sjIgTA8Y=; b=slXW7RghjbyOGrsMIDi7N5Ot4hSu+VQFiKLTqFBmxA6wYIDh2b7/vv2IHbBraIVNNP4P7x5t
 mzpjv5Wch1ZRPBCOfRLGhflsdHWFg4J1rv85B0YInT8iNprAivYbZ3snb82e1+owwNQ3WGyM
 BPURc3LhNpp3zPHHaPpgzggzNuQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 619b8ad66bacc185a57edf3b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Nov 2021 12:19:34
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6224CC43617; Mon, 22 Nov 2021 12:19:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F004AC4338F;
        Mon, 22 Nov 2021 12:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org F004AC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] ath11k: add wait operation for tx management packets for flush from mac80211
References: <20211118095254.7916-1-quic_wgong@quicinc.com>
Date:   Mon, 22 Nov 2021 14:19:29 +0200
In-Reply-To: <20211118095254.7916-1-quic_wgong@quicinc.com> (Wen Gong's
        message of "Thu, 18 Nov 2021 04:52:54 -0500")
Message-ID: <871r389ycu.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> In ath11k, tx of management packet is doing in a work queue. Sometimes
> the workqueue does not finish tx immediately, then it lead after the next
> step of vdev delete finished, it start to send the management packet to
> firmware and lead firmware crash.
>
> ieee80211_set_disassoc have logic of ieee80211_flush_queues after it
> send_deauth_disassoc to ath11k, its purpose is make sure the deauth
> was actually sent, so it need to change ath11k to match the purpose
> of mac80211.
>
> To address these issue wait for tx mgmt and tx data packets.
>
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01230-QCAHSTSWPLZ_V2_TO_X86-1
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

I sometimes see new warnings with this patch:

[  142.346474] ath11k_pci 0000:06:00.0: failed to flush mgmt transmit queue 0
[  147.466367] ath11k_pci 0000:06:00.0: failed to flush mgmt transmit queue 0

And more importantly this breaks suspend on my NUC testbox:

[  175.141820] PM: suspend entry (deep)
[  175.150512] Filesystems sync: 0.008 seconds
[  175.229703] Freezing user space processes ... (elapsed 0.003 seconds) done.
[  175.233506] OOM killer disabled.
[  175.233588] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[  175.242457] printk: Suspending console(s) (use no_console_suspend to debug)
[  175.245269] wlan0: deauthenticating from 00:03:7f:48:81:59 by local choice (Reason: 3=DEAUTH_LEAVING)
[  175.285881] e1000e: EEE TX LPI TIMER: 00000011
[  180.745259] ath11k_pci 0000:06:00.0: failed to flush mgmt transmit queue 0
[  185.864977] ath11k_pci 0000:06:00.0: failed to flush mgmt transmit queue 0
[  185.970601] PM: Some devices failed to suspend, or early wake event detected
[  185.974081] usb usb3: root hub lost power or was reset
[  185.974135] usb usb4: root hub lost power or was reset
[  186.098870] nvme nvme0: 8/0/0 default/read/poll queues
[  186.297077] OOM killer enabled.
[  186.297361] Restarting tasks ... done.
[  186.343733] PM: suspend exit

My setup:

Tag:	ath-202111221111

[  151.123732] ath11k_pci 0000:06:00.0: MSI vectors: 32
[  151.123851] ath11k_pci 0000:06:00.0: qca6390 hw2.0
[  151.720618] ath11k_pci 0000:06:00.0: chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0xffffffff
[  151.720912] ath11k_pci 0000:06:00.0: fw_version 0x101c06cc fw_build_timestamp 2020-06-24 19:50 fw_build_id 

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
