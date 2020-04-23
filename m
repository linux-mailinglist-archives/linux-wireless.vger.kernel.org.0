Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DE01B54B9
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 08:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgDWGbb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 02:31:31 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:37304 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725562AbgDWGbb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 02:31:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587623490; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=JWdOKARKVZs7UePq/d5QYKFe6b8sjNaAYgTY5R3kAO0=;
 b=t5i4hM4QP8WbHgjONktzYOB6E5pnL/W9cmOptFR/svTDR7Qvhw9HnN/yhYjpI/GrUAYU/yiR
 wHb3wuDiJ7L+jNT/jyuCAxS8ixlYIivZAN9+4gFz2Xx6jec2OlLgeKh4+gNHD4omsGCScsiq
 nwfhTlvwpGR2hZn+M1ZpRCGVHKY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea13639.7fd91681e260-smtp-out-n03;
 Thu, 23 Apr 2020 06:31:21 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0FEA1C433BA; Thu, 23 Apr 2020 06:31:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C763C433D2;
        Thu, 23 Apr 2020 06:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C763C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/2] ath10k: Set sk_pacing_shift to 6 for 11AC WiFi chips
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1533724802-30944-3-git-send-email-wgong@codeaurora.org>
References: <1533724802-30944-3-git-send-email-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200423063121.0FEA1C433BA@smtp.codeaurora.org>
Date:   Thu, 23 Apr 2020 06:31:21 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> Upstream kernel has an interface to help adjust sk_pacing_shift to help
> improve TCP UL throughput.
> The sk_pacing_shift is 8 in mac80211, this is based on test with 11N
> WiFi chips with ath9k. For QCA6174/QCA9377 PCI 11AC chips, the 11AC
> VHT80 TCP UL throughput testing result shows 6 is the optimal.
> Overwrite the sk_pacing_shift to 6 in ath10k driver for QCA6174/9377 PCI.
> 
> Tested with QCA6174 PCI with firmware
> WLAN.RM.4.4.1-00109-QCARMSWPZ-1, but this will also affect QCA9377 PCI.
> It's not a regression with new firmware releases.
> 
> There have 2 test result of different settings:
> 
> ARM CPU based device with QCA6174A PCI with different
> sk_pacing_shift:
> 
>  sk_pacing_shift  throughput(Mbps)             CPU utilization
>          6            500(-P5)      ~75% idle, Focus on CPU1: ~14%idle
>          7            454(-P5)      ~80% idle, Focus on CPU1: ~4%idle
>          8               288        ~90% idle, Focus on CPU1: ~35%idle
>          9              ~200        ~92% idle, Focus on CPU1: ~50%idle
> 
> 5G TCP UL VTH80 on X86 platform with QCA6174A PCI with sk_packing_shift
> set to 6:
> 
>   tcp_limit_output_bytes            throughput(Mbps)
>  default(262144)+1 Stream                 336
>  default(262144)+2 Streams                558
>  default(262144)+3 Streams                584
>  default(262144)+4 Streams                602
>  default(262144)+5 Streams                598
>  changed(2621440)+1 Stream                598
>  changed(2621440)+2 Streams               601
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>

The final result of this patch is unclear so I'm dropping this. Please
resend if the issue still exists.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/10559733/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
