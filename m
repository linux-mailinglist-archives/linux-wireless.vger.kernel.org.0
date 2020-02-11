Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C09DF1598A1
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 19:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgBKSaw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 13:30:52 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:31540 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727361AbgBKSav (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 13:30:51 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581445851; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=YZrWNc0PPLzyyZfUE7mdiAtQVb0WXuALcDDFod34Rzc=;
 b=TqixAMRi0OhZEJLf0bP2S1PKwWm2wN0neffSYUChTLwWzygm17vnI8kAQ0vpPNG3CtcPCbel
 S4tfUR9MNHY+ifZOh/pXds42idOIY0HAijf4GsaD4JTkFPdNIV0cpxvtt0/OyPtPj6fPQNNV
 wa7neEmVGPTVDGXhkc/XvvpnAvw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e42f2da.7f0939136030-smtp-out-n03;
 Tue, 11 Feb 2020 18:30:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4C171C433A2; Tue, 11 Feb 2020 18:30:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EC6B0C43383;
        Tue, 11 Feb 2020 18:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC6B0C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [RESEND V2 1/4] ath11k: drop tx_info from ath11k_sta
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200204151135.25302-1-john@phrozen.org>
References: <20200204151135.25302-1-john@phrozen.org>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200211183050.4C171C433A2@smtp.codeaurora.org>
Date:   Tue, 11 Feb 2020 18:30:50 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> wrote:

> We will start using ieee80211_tx_status_ext() so we do not need to track
> tx rates inside a struct ieee80211_tx_info. It is currently not possible
> to populate that struct with HE rate info anyhow.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

be43ce646b93 ath11k: drop tx_info from ath11k_sta
6a0c370259c7 ath11k: add HE rate accounting to driver

-- 
https://patchwork.kernel.org/patch/11364815/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
