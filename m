Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898BC1B9660
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 07:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgD0FC3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 01:02:29 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:44223 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726172AbgD0FC3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 01:02:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587963748; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=pneIcqUKNkjA5dNSxGYhj5odGKcbp0Kn/Pe8WNrPj88=;
 b=NjubBGrSovoV887AxcZJb4C+Xg9h1PhUbDj5+ZmBvaUkapvaZ5RclB4+aAsQCYjCX1A6UtYm
 Vx8hqSK69wpYPYRlSBVwXFvTomgaYYU94wsvJpvB8tv12wM3n97YAePvFy+yzaKi8sexnPpj
 fdJpuvgm2XinhWsld7kKaLN1tYo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea66760.7ff0e4d58030-smtp-out-n03;
 Mon, 27 Apr 2020 05:02:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 31367C433BA; Mon, 27 Apr 2020 05:02:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8EC20C433D2;
        Mon, 27 Apr 2020 05:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EC20C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: add statistics of tx retries and tx failed when tx
 complete disable
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200423024134.10601-1-wgong@codeaurora.org>
References: <20200423024134.10601-1-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong@codeaurora.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200427050223.31367C433BA@smtp.codeaurora.org>
Date:   Mon, 27 Apr 2020 05:02:23 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> When tx complete is disabled, all tx status will be set with status
> HTT_TX_COMPL_STATE_ACK and indicate to mac80211 by ieee80211_tx_status,
> then it does not have the statistics for retries and failed packets.
> count of tx retries and tx failed of command "iw wlan0 station dump"
> are both 0. If tx complete is not disabled, then firmware report the
> tx status and ath10k indicate the status to mac80211, then mac80211
> save the statistics and command "iw wlan0 station dump" show them.
> 
> for example:
> localhost ~ # iw dev wlan0 station dump
> Station 3c:28:6d:96:fd:69 (on wlan0)
> 	inactive time:	5 ms
> 	rx bytes:	1325012
> 	rx packets:	6477
> 	tx bytes:	85264
> 	tx packets:	518
> 	tx retries:	0
> 	tx failed:	0
> 
> This patch only effect chips with tx complete disabled, e.g. SDIO.
> 
> with this patch, output of command "iw dev wlan0 station dump":
> Station c4:04:15:5d:97:22 (on wlan0)
>         inactive time:  608 ms
>         rx bytes:       180366
>         rx packets:     991
>         tx bytes:       98765577
>         tx packets:     64624
>         tx retries:     14682
>         tx failed:      47086
> 
> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00042.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

59a022cc14cf ath10k: add statistics of tx retries and tx failed when tx complete disable

-- 
https://patchwork.kernel.org/patch/11504903/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
