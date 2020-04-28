Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562A91BB999
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 11:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgD1JNG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 05:13:06 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:32668 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726462AbgD1JNF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 05:13:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588065185; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=zJlamWiQ80rdRVmN2kxUNycGaDkRRO8J7VFN+Onu9vI=;
 b=n5/ZUS+HwQcAyleqb9HsoAwkN1RzdIHColEZp+oD+ZVqgLrsLPOEXIwxw+AySyxVnUqCQ364
 fFWg5HxGqrW1uG3CFWldx1wD5LOK/sLsHKfOIcVf2crCZag9BrK/WRFDql63lx3F1lJhUJ/G
 eyTuj2KWpST88NsyFzBqZK0zI1A=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea7f39f.7fea8e5efab0-smtp-out-n01;
 Tue, 28 Apr 2020 09:13:03 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0319AC433F2; Tue, 28 Apr 2020 09:13:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A1A33C433CB;
        Tue, 28 Apr 2020 09:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1A33C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] ath10k: enable firmware peer stats info for wmi
 tlv
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200427080416.8265-2-wgong@codeaurora.org>
References: <20200427080416.8265-2-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong@codeaurora.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200428091303.0319AC433F2@smtp.codeaurora.org>
Date:   Tue, 28 Apr 2020 09:13:03 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> For wmi tlv type, firmware disable peer stats info by default, after
> enable it, firmware will report WMI_TLV_PEER_STATS_INFO_EVENTID if
> ath10k send WMI_TLV_REQUEST_PEER_STATS_INFO_CMDID to firmware.
> 
> Enable it will only set a flag in firmware, firmware will not report
> it without receive request WMI command.
> 
> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00042.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

4 patches applied to ath-next branch of ath.git, thanks.

2289bef25e32 ath10k: enable firmware peer stats info for wmi tlv
0f7cb26830a6 ath10k: add rx bitrate report for SDIO
3344b99d69ab ath10k: add bitrate parse for peer stats info
4cc02c7c1494 ath10k: correct tx bitrate of iw for SDIO

-- 
https://patchwork.kernel.org/patch/11511409/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
