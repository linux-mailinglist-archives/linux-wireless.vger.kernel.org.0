Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA124326226
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Feb 2021 12:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhBZLv1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 06:51:27 -0500
Received: from z11.mailgun.us ([104.130.96.11]:28099 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhBZLvX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 06:51:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614340268; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=y72/r/U4LEvk0bxctDJrSARbQ+sIvUt5ZXCD6lQZ9R4=;
 b=MxtsIX9kHZ37VVOuky+YPMg3WC2OxTyveZ4d/BPNQrDCr6yn6P5TmBDtSoandF5XLFuNDN4g
 E59gqc+KmAWimebhgIHoMdaMMaM4CH1X1gxwttUU9PWvrEWP1Fz+BdY6oE5fh7m0s5sRv266
 twO7+PLttZ8qlJa8eAGQyArnQOQ=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6038e0884ba4640b2bc3c6bb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Feb 2021 11:50:32
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 427DCC433ED; Fri, 26 Feb 2021 11:50:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 73461C433CA;
        Fri, 26 Feb 2021 11:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73461C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [wireless-drivers] mt76: dma: do not report truncated frames to
 mac80211
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <a03166fcc8214644333c68674a781836e0f57576.1612697217.git.lorenzo@kernel.org>
References: <a03166fcc8214644333c68674a781836e0f57576.1612697217.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, kuba@kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210226115032.427DCC433ED@smtp.codeaurora.org>
Date:   Fri, 26 Feb 2021 11:50:32 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Commit b102f0c522cf6 ("mt76: fix array overflow on receiving too many
> fragments for a packet") fixes a possible OOB access but it introduces a
> memory leak since the pending frame is not released to page_frag_cache
> if the frag array of skb_shared_info is full. Commit 93a1d4791c10
> ("mt76: dma: fix a possible memory leak in mt76_add_fragment()") fixes
> the issue but does not free the truncated skb that is forwarded to
> mac80211 layer. Fix the leftover issue discarding even truncated skbs.
> 
> Fixes: 93a1d4791c10 ("mt76: dma: fix a possible memory leak in mt76_add_fragment()")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Patch applied to wireless-drivers.git, thanks.

d0bd52c591a1 mt76: dma: do not report truncated frames to mac80211

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/a03166fcc8214644333c68674a781836e0f57576.1612697217.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

