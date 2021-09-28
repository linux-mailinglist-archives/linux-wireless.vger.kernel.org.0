Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6309C41B169
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 15:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240932AbhI1OAB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 10:00:01 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:53418 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240898AbhI1OAB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 10:00:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632837501; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=m3B1qN05dLRIc1FoDoMKuANOq+i0q5N936G6b9QVU4Q=;
 b=UhjGVTrWinNgfn5RskRjyCuWgAPoS5cZWXR/8RoR1lnzl0u4gJ5yX6w93uQD8HCFO7UrJgr2
 Hin1R6/rndXEEdsHnWm4fMjhoWqYtP7CdjMfkoPlXbzokN3dmZ4O4/wm17Z69F4sCZlfY0dt
 elqbs8sP7cQ3j0se7+RolTMi1X4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 61531f6647d64efb6d86c8d6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 13:57:58
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 16CB7C4360D; Tue, 28 Sep 2021 13:57:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 61EE1C4338F;
        Tue, 28 Sep 2021 13:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 61EE1C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] ath11k: add handler for scan event
 WMI_SCAN_EVENT_DEQUEUED
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210914164226.38843-1-jouni@codeaurora.org>
References: <20210914164226.38843-1-jouni@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Wen Gong <wgong@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210928135758.16CB7C4360D@smtp.codeaurora.org>
Date:   Tue, 28 Sep 2021 13:57:58 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> wrote:

> When wlan interface is up, 11d scan is sent to the firmware, and the
> firmware needs to spend couple of seconds to complete the 11d scan. If
> immediately a normal scan from user space arrives to ath11k, then the
> normal scan request is also sent to the firmware, but the scan started
> event will be reported to ath11k until the 11d scan complete. When timed
> out for the scan started in ath11k, ath11k stops the normal scan and the
> firmware reports WMI_SCAN_EVENT_DEQUEUED to ath11k for the normal scan.
> ath11k has no handler for the event and then timed out for the scan
> completed in ath11k_scan_stop(), and ath11k prints the following error
> message.
> 
> [ 1491.604750] ath11k_pci 0000:02:00.0: failed to receive scan abort comple: timed out
> [ 1491.604756] ath11k_pci 0000:02:00.0: failed to stop scan: -110
> [ 1491.604758] ath11k_pci 0000:02:00.0: failed to start hw scan: -110
> 
> Add a handler for WMI_SCAN_EVENT_DEQUEUED and then complete the scan to
> get rid of the above error message.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

3 patches applied to ath-next branch of ath.git, thanks.

441b3b5911f8 ath11k: add handler for scan event WMI_SCAN_EVENT_DEQUEUED
c677d4b1bcc4 ath11k: indicate scan complete for scan canceled when scan running
62db14ea95b1 ath11k: indicate to mac80211 scan complete with aborted flag for ATH11K_SCAN_STARTING state

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210914164226.38843-1-jouni@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

