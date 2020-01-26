Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56F66149B78
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 16:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgAZPir (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 10:38:47 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:36554 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbgAZPir (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 10:38:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580053126; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=CV9d+B68EtPMcv1gmRGAvflgaQUqOrSU5Q7MYbVztuQ=;
 b=U7MR4ViMxCqtD99FjlrMpurr2EqD/dSScXroOtAAwRioVCsvkZTzQLMmOnvD38ODoIY1VQnu
 zmSHa7ftGRk4hRAaanoNjx7oA7HeKhST6QWgyZsXHb8fnWjMQ8sS3nYEgvjy6eliGyEe9MFR
 zLMHxCdRi+GviQ4yWTJ/pCT4J3s=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2db283.7efcf056cea0-smtp-out-n03;
 Sun, 26 Jan 2020 15:38:43 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DF08CC447A1; Sun, 26 Jan 2020 15:38:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AB0A6C433A2;
        Sun, 26 Jan 2020 15:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB0A6C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/11] rtw88: fix rate mask for 1SS chip
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191220092156.13443-2-yhchuang@realtek.com>
References: <20191220092156.13443-2-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200126153842.DF08CC447A1@smtp.codeaurora.org>
Date:   Sun, 26 Jan 2020 15:38:42 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> The rate mask is used to tell firmware the supported rate depends on
> negotiation. We loop 2 times for all VHT/HT 2SS rate mask first, and then
> only keep the part according to chip's NSS.
> 
> This commit fixes the logic error of '&' operations for VHT/HT rate, and
> we should run this logic before adding legacy rate.
> 
> To access HT MCS map, index 0/1 represent MCS 0-7/8-15 respectively. Use
> NL80211_BAND_xxx is incorrect, so fix it as well.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> Reviewed-by: Chris Chiu <chiu@endlessm.com>

9 patches applied to wireless-drivers-next.git, thanks.

35a68fa5f96a rtw88: fix rate mask for 1SS chip
73a2d0b83424 rtw88: fix TX secondary channel offset of 40M if current bw is 20M or 40M
e339b6493524 rtw88: 8822c: update power sequence to v15
3f43f10bd619 rtw88: remove unused spinlock
962562cde154 rtw88: remove unused variable 'in_lps'
65ae64d37575 rtw88: remove unused vif pointer in struct rtw_vif
fc83c616d4d9 rtw88: use rtw_hci_stop() instead of rtwdev->hci.ops->stop()
f48abf064ade rtw88: assign NULL to skb after being kfree()'ed
bbdd1d854e0a rtw88: change max_num_of_tx_queue() definition to inline in pci.h

-- 
https://patchwork.kernel.org/patch/11305077/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
