Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19AA3035DD
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jan 2021 06:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388972AbhAZFzk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jan 2021 00:55:40 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:43919 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729626AbhAYOnN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 09:43:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611585754; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=QQM/nt2FFonPCqifNIq2JACCDZxSRJDHrOOwPcz1i0Q=;
 b=wUL/Vm5vXfvDSNQ9vNcrEkzwHmkkiukMyzX+q/dJAVHw6ULZ+84f9SrOTpxl2Q5M4O/A7rYL
 F/xY8gH3GspH4pdYr9IPrIsSR0P+PhkByDoMkQQP99rGR3x0t7eCMyrmHY8dUy/h4Ss3TIGj
 92eSr+cfhrTDnH8qIrBr78ftvOg=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 600ed8b75677aca7bddb40b4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Jan 2021 14:41:59
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B9301C433ED; Mon, 25 Jan 2021 14:41:59 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 460CAC433CA;
        Mon, 25 Jan 2021 14:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 460CAC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mt7601u: use ieee80211_rx_list to pass frames to the
 network
 stack as a batch
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <5c72fa2dda45c1ae3f285af80c02f3db23341d85.1610580222.git.lorenzo@kernel.org>
References: <5c72fa2dda45c1ae3f285af80c02f3db23341d85.1610580222.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        kuba@kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210125144159.B9301C433ED@smtp.codeaurora.org>
Date:   Mon, 25 Jan 2021 14:41:59 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Similar to mt76 driver, rely on ieee80211_rx_list in order to
> improve icache footprint
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Patch applied to wireless-drivers-next.git, thanks.

2a9269b1cdc3 mt7601u: use ieee80211_rx_list to pass frames to the network stack as a batch

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/5c72fa2dda45c1ae3f285af80c02f3db23341d85.1610580222.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

