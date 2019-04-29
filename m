Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75747E4E3
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 16:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfD2Oje (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 10:39:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55514 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbfD2Oje (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 10:39:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 012D760E57; Mon, 29 Apr 2019 14:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556548774;
        bh=LWy9oGKusitzGP2I5h7oakHmHfuLqrC4+igzse3/mQw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=EDltTrngm4vEtRuB32X2ZAfTv0JZuzbEioZpflPx4v95W8zBu1EBQNkJqMip3vLwS
         6No03C094VWu0Rrn1e9OaMxGe67ZgEFM47bnD0IWq5OGITsQEJYXxT4blr4OgGQ9HY
         ihXEBlW+d9AtMuXWBgQW25oWdDBY2XVjB6sQ3a8M=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 576E4605A2;
        Mon, 29 Apr 2019 14:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556548773;
        bh=LWy9oGKusitzGP2I5h7oakHmHfuLqrC4+igzse3/mQw=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=hoDBgk1wKfkLIKtCGOAIZID/DuNkbk5+6VsIbljPZUYTw+B6G3ME84F0nscwy+Fff
         D5rNLJBEdAleX2ZV/X8P+s0Cs6jAi6o2YEQQHUqW8MGTj7vJnEIAAdcNMq6vFOP1LN
         j2BWpf50LzM6j5Kd+nbmn6Mc4j0HD29F9WMJpDfY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 576E4605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] ath10k: add struct for high latency PN replay
 protection
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1556260871-2919-2-git-send-email-kvalo@codeaurora.org>
References: <1556260871-2919-2-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Wen Gong <wgong@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190429143934.012D760E57@smtp.codeaurora.org>
Date:   Mon, 29 Apr 2019 14:39:33 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> Add the struct for PN replay protection and fragment packet
> handler.
> 
> Also fix the bitmask of HTT_RX_DESC_HL_INFO_MCAST_BCAST to match what's currently
> used by SDIO firmware. The defines are not used yet so it's safe to modify
> them. Remove the conflicting HTT_RX_DESC_HL_INFO_FRAGMENT as
> it's not either used in ath10k.
> 
> Tested on QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00007-QCARMSWP-1.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

5 patches applied to ath-next branch of ath.git, thanks.

e1bddde9737a ath10k: add struct for high latency PN replay protection
28ce53b6cfda ath10k: add handler for HTT_T2H_MSG_TYPE_SEC_IND event
130c77495708 ath10k: add PN replay protection for high latency devices
33f9747291ff ath10k: add fragmentation handler for high latency devices
a8b10da05cbe ath10k: enable QCA6174 hw3.2 SDIO hardware

-- 
https://patchwork.kernel.org/patch/10918335/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

