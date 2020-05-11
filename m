Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3138A1CDA03
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 14:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbgEKMex (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 08:34:53 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:21739 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727019AbgEKMex (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 08:34:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589200492; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=zC3j9uNh7Los0CCJhpiVF6wtA6cm1oAtUB2lD3DkwII=;
 b=jWcLLun7r0ub88hcZeWQkEZ2JMKWQQ4aLKwcxK0nNtkD0jAQA0EjKK80cqqNuq6iRoj1PTQJ
 b/LijGAkXq5kq15/qH+Oya7z11FN4zhyqVTWrAmdqkiXshqwXXFboAV5lvtoWIGp9UZH5DR+
 Dw+ozzWKZpm94g0moVWj8gPyDlY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb9465f.7f33dd7d98f0-smtp-out-n02;
 Mon, 11 May 2020 12:34:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 254BDC432C2; Mon, 11 May 2020 12:34:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 12899C433CB;
        Mon, 11 May 2020 12:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12899C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: fix __le32 warning in
 ath10k_wmi_tlv_op_gen_request_peer_stats_info()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1588747649-18051-1-git-send-email-kvalo@codeaurora.org>
References: <1588747649-18051-1-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200511123439.254BDC432C2@smtp.codeaurora.org>
Date:   Mon, 11 May 2020 12:34:39 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> Sparse warned:
> 
> drivers/net/wireless/ath/ath10k/wmi-tlv.c:3013:34: warning: incorrect
> type in assignment (different base types)
> drivers/net/wireless/ath/ath10k/wmi-tlv.c:3013:34:    expected
> restricted __le32 [usertype] reset_after_request
> drivers/net/wireless/ath/ath10k/wmi-tlv.c:3013:34:    got unsigned int
> [usertype] reset
> 
> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00042.
> 
> Fixes: 0f7cb26830a6 ("ath10k: add rx bitrate report for SDIO")
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

e47210f72a68 ath10k: fix __le32 warning in ath10k_wmi_tlv_op_gen_request_peer_stats_info()

-- 
https://patchwork.kernel.org/patch/11530437/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
