Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399B9306F05
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jan 2021 08:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhA1HW3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jan 2021 02:22:29 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:43195 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhA1HUT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jan 2021 02:20:19 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611818397; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=fnhqldCAxiYhzPpb1kHl8v9nujBo9uC6ZvptVGXCOcY=;
 b=sh+Hg1go9fMF32JW1rIIv3w8WfdR51P2ramvK+NL5PnOAwZK0lliEGRLD/T3ryFvkIGAZUsb
 FO1VJHKyVAsDD0VkwI0KeX+p7cOmEd/uP507n8viwH3Qio0zcfVch0avDNIOx5Qt1jTed90J
 2baAsmZ73SxDXsb7hXXsb1oqNxY=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6012657bbeacd1a252a23d54 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 Jan 2021 07:19:23
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0E1A9C43461; Thu, 28 Jan 2021 07:19:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 115FCC433C6;
        Thu, 28 Jan 2021 07:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 115FCC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] ath10k: pass the ssid info to get the correct bss
 entity
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1607312195-3583-3-git-send-email-wgong@codeaurora.org>
References: <1607312195-3583-3-git-send-email-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org, wgong@codeaurora.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210128071923.0E1A9C43461@smtp.codeaurora.org>
Date:   Thu, 28 Jan 2021 07:19:23 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> When connect to an AP with WPA mode, ath10k need to set need_ptk_4_way to
> firmware in WMI_PEER_ASSOC_CMD, then the data path is disallow in
> firmware, it will be allowed untill firmware finish the 4 way handshake.
> 
> It failed with a test case with below steps:
> 1. configure AP with WPA mode with ssid1 SimpleConnect_a_orbvt_ch1,
>    bssid1 and channel 1.
> 2. connect to ssid1 and ping success.
> 3. wait 10 seconds which is less than
>    IEEE80211_SCAN_RESULT_EXPIRE(30 seconds).
> 4. configure AP with OPEN mode with ssid2 SimpleConnect_b_z3a00_ch1,
>    but use same bssid1 and channel 1 of step 1.
> 5. disconnect ssid1.
> 6. connect to ssid2 and ping fail.
> 
> Fail reason:
> When run step 6, ath10k_peer_assoc_h_crypto() called cfg80211_get_bss()
> with bssid and chan info, but ssid1 and ssid2 have the same bssid and
> channel, then there have 2 entry for ssid1 and ssid2 in cfg80211. The
> ssid1's order is before ssid2 in bss_list, and ssid1's age is less than
> the expire time which is IEEE80211_SCAN_RESULT_EXPIRE(30 seconds). Then
> ssid1's entry is selected and ath10k_peer_assoc_h_crypto() parsed it and
> get the rsnie and then need_ptk_4_way is set to firmware, so data path
> is disallowed and it will not receive 4 way handshake for OPEN mode,
> so ping fail in step 6.
> 
> This patch is to pass the ssid info to cfg80211_get_bss() as same as
> cfg80211_mlme_assoc() and cfg80211_mlme_auth(), then it will find the
> correct bss entry in above test case, then case success.
> 
> For AP mode, the ssid info is filled in ieee80211_start_ap(), for STATION
> mode, it is filled in ieee80211_mgd_assoc(). Tested for both AP/STATION
> mode with QCA6174 hw3.2 PCI, it is success start/connect/ping for
> WPA/OPEN mode.
> 
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00110-QCARMSWP-1
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

22df5e1bec25 ath10k: pass the ssid info to get the correct bss entity

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1607312195-3583-3-git-send-email-wgong@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

