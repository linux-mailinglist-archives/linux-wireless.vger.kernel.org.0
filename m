Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE3732C13E
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 01:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243270AbhCCVRj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Mar 2021 16:17:39 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:55066 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1580477AbhCCSeP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Mar 2021 13:34:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614796437; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Ac+Gd3GM2hW82Saxrw1wKrEC8rkJjEHWwfXpNzzaSa0=; b=NIG7Lj35GH4alPfPIZPcxuX19S1paG+q43RDihfSpC7RG1jhiXrliX90USsg8Yr8vt7zuPaj
 wt9MSyaVY5Xai7oW0tDMfLMakVa+MMNJLZ+WV9wWra7AqSatZIk+F4PV8OGKyvAa1m4xmXb6
 1BmFDM53uhYUdNhL9wDLsNoYetw=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 603fd66b7b648e2436a0677b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 03 Mar 2021 18:33:15
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2B3D4C433ED; Wed,  3 Mar 2021 18:33:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2EFB5C43462;
        Wed,  3 Mar 2021 18:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2EFB5C43462
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Luca Coelho <luciano.coelho@intel.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iwlwifi: don't call netif_napi_add() with rxq->lock held (was Re: Lockdep warning in iwl_pcie_rx_handle())
References: <nycvar.YFH.7.76.2103021134060.12405@cbobk.fhfr.pm>
        <20210303155941.25521C43463@smtp.codeaurora.org>
        <nycvar.YFH.7.76.2103031901140.12405@cbobk.fhfr.pm>
Date:   Wed, 03 Mar 2021 20:33:09 +0200
In-Reply-To: <nycvar.YFH.7.76.2103031901140.12405@cbobk.fhfr.pm> (Jiri
        Kosina's message of "Wed, 3 Mar 2021 19:01:45 +0100 (CET)")
Message-ID: <87y2f46qai.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jiri Kosina <jikos@kernel.org> writes:

> On Wed, 3 Mar 2021, Kalle Valo wrote:
>
>> Patch applied to wireless-drivers.git, thanks.
>
> Thanks, but ...
>
>> 295d4cd82b01 iwlwifi: don't call netif_napi_add() with rxq->lock
>> held (was Re: Lockdep warning in iwl_pcie_rx_handle())
>
> ... i believe you want to drop the "(was ...") part from the patch 
> subject.

Too late now, it's already applied and pull request sent. Why was it
there in the first place?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
