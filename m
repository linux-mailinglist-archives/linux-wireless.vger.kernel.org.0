Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7DE91879D1
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 07:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgCQGpN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 02:45:13 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:17448 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbgCQGpN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 02:45:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584427513; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=zQJWgM6wDAs32LyIxKjExk1LeWRgD5zCDpYBSNwoUms=;
 b=au3+9W4wY1RlrMfYlOnSxtCfrYEw/IV+kN48Ub51zkAJt53X6oCAWXOAgIvlmTjG1PJbEMrB
 lTiKPnetrirPcGCMDmJA36sKsTzNL/r0wewVoLALQ8VpnyG5IW+Cps2qgqYL/khKvW7yTR0O
 M9uw09NVckt+FBE+E08/zdNHWpo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7071ec.7f46139ffed8-smtp-out-n03;
 Tue, 17 Mar 2020 06:45:00 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C5C15C43637; Tue, 17 Mar 2020 06:45:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 241BBC433CB;
        Tue, 17 Mar 2020 06:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 241BBC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V3 3/4] ath11k: add WMI calls required for handling BSS
 color
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191217141921.8114-3-john@phrozen.org>
References: <20191217141921.8114-3-john@phrozen.org>
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200317064500.C5C15C43637@smtp.codeaurora.org>
Date:   Tue, 17 Mar 2020 06:45:00 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> wrote:

> If the he_operation field of the beacon sets a BSS color, we need to inform
> the FW of the settings. This patch adds the WMI command handlers required
> to do so.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

5a032c8d1953 ath11k: add WMI calls required for handling BSS color
beb2f77297b0 ath11k: add handling for BSS color

-- 
https://patchwork.kernel.org/patch/11297707/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
