Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EDA38187F
	for <lists+linux-wireless@lfdr.de>; Sat, 15 May 2021 13:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhEOLte (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 May 2021 07:49:34 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:22028 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229516AbhEOLtd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 May 2021 07:49:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621079300; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=y5Y5e3HYszgKCGVdgrxV+YR7CHd9EXpWhkEnLQTR2/g=;
 b=cHbBSOysJpBlpkXrbffKfext8+rlM4GjchtwEychv6XGq9ekd+gCmpdf2kaDNXwm97ieITYi
 JGa1d4KLwvEIuhWggdUYqfVvAIbO+clD7o6qDa5Oh2bX3h/RFF1DqY/vCkhhF/HgSqfTPWr9
 bSehhRNb/m9cl0nf72vkSWOFAXI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 609fb4fe5f788b52a51e5865 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 15 May 2021 11:48:14
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6599FC4338A; Sat, 15 May 2021 11:48:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AF0EAC433F1;
        Sat, 15 May 2021 11:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF0EAC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5.13] mt76: validate rx A-MSDU subframes
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210513070303.20253-1-nbd@nbd.name>
References: <20210513070303.20253-1-nbd@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210515114814.6599FC4338A@smtp.codeaurora.org>
Date:   Sat, 15 May 2021 11:48:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> Mitigate A-MSDU injection attacks (CVE-2020-24588) by detecting if the
> destination address of a subframe equals an RFC1042 (i.e., LLC/SNAP)
> header, and if so dropping the complete A-MSDU frame. This mitigates
> known attacks, although new (unknown) aggregation-based attacks may
> remain possible.
> 
> This defense works because in A-MSDU aggregation injection attacks, a
> normal encrypted Wi-Fi frame is turned into an A-MSDU frame. This means
> the first 6 bytes of the first A-MSDU subframe correspond to an RFC1042
> header. In other words, the destination MAC address of the first A-MSDU
> subframe contains the start of an RFC1042 header during an aggregation
> attack. We can detect this and thereby prevent this specific attack.
> For details, see Section 7.2 of "Fragment and Forge: Breaking Wi-Fi
> Through Frame Aggregation and Fragmentation".
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Patch applied to wireless-drivers.git, thanks.

2c2bdd2372af mt76: validate rx A-MSDU subframes

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210513070303.20253-1-nbd@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

