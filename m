Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71031B965C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 07:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgD0FBv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 01:01:51 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:44223 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726172AbgD0FBu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 01:01:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587963710; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ETHfgszYFiaBJe6H/LRYDpV2n8mr+HCLzybHaBW7Uhg=;
 b=ggx28W8XgHA9zRYZS+Ps7xS+OlwNyQW+ApJ27numQb/gyYKsmsQVYRoraSsrpVnqzzNNRgIm
 3oxJcFHM1JNavltsNlyQIQb/sHeGdcOajt+rS+bamN6At0pbwchpmmRDg5Xni9XFVfLzqneb
 wkzkhP3+jlY0bXyAqaah1V9tFXM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea66739.7fa3e0805688-smtp-out-n05;
 Mon, 27 Apr 2020 05:01:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3FA72C433D2; Mon, 27 Apr 2020 05:01:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DCFD9C433CB;
        Mon, 27 Apr 2020 05:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DCFD9C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: enable rx duration report default for wmi tlv
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200423022758.5365-1-wgong@codeaurora.org>
References: <20200423022758.5365-1-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong@codeaurora.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200427050145.3FA72C433D2@smtp.codeaurora.org>
Date:   Mon, 27 Apr 2020 05:01:45 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> When run command "iw dev wlan0 station dump", the rx duration is 0.
> When firmware indicate WMI_UPDATE_STATS_EVENTID, extended flag of
> statsis not set by default, so firmware do not report rx duration.
> 
> one sample:
> localhost # iw wlan0 station dump
> Station c4:04:15:5d:97:22 (on wlan0)
>         inactive time:  48 ms
>         rx bytes:       21670
>         rx packets:     147
>         tx bytes:       11529
>         tx packets:     100
>         tx retries:     88
>         tx failed:      36
>         beacon loss:    1
>         beacon rx:      31
>         rx drop misc:   47
>         signal:         -72 [-74, -75] dBm
>         signal avg:     -71 [-74, -75] dBm
>         beacon signal avg:      -71 dBm
>         tx bitrate:     54.0 MBit/s MCS 3 40MHz
>         rx bitrate:     1.0 MBit/s
> 	rx duration:    0 us
> 
> This patch enable firmware's extened flag of stats by setting flag
> WMI_TLV_STAT_PEER_EXTD of ar->fw_stats_req_mask which is set in
> ath10k_core_init_firmware_features via WMI_REQUEST_STATS_CMDID.
> 
> After apply this patch, rx duration show value with the command:
> Station c4:04:15:5d:97:22 (on wlan0)
>         inactive time:  883 ms
>         rx bytes:       44289
>         rx packets:     265
>         tx bytes:       10838
>         tx packets:     93
>         tx retries:     899
>         tx failed:      103
>         beacon loss:    0
>         beacon rx:      78
>         rx drop misc:   46
>         signal:         -71 [-74, -76] dBm
>         signal avg:     -70 [-74, -76] dBm
>         beacon signal avg:      -70 dBm
>         tx bitrate:     54.0 MBit/s MCS 3 40MHz
>         rx bitrate:     1.0 MBit/s
>         rx duration:    358004 us
> 
> This patch do not have side effect for all chips, because function
> ath10k_debug_fw_stats_request is already exported to debugfs
> "fw_stats" and WMI_REQUEST_STATS_CMDID is safely sent after condition
> checked by ath10k_peer_stats_enabled in ath10k_sta_statistics.
> 
> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00042.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

4913e675630e ath10k: enable rx duration report default for wmi tlv

-- 
https://patchwork.kernel.org/patch/11504895/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
