Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1F12A902B
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 08:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgKFHVm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 02:21:42 -0500
Received: from z5.mailgun.us ([104.130.96.5]:62806 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgKFHVm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 02:21:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604647302; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=f1H9b8iwuFP7YB9IDOFM48li6+QEDLP0G4r1bA+fhAo=; b=d6XqCJODBWfr+MmOw2Do7JXGSX/TCLv+LRolLOvmtyw4zq21kxevnC1cujnudUY782z2tUjL
 HyOxVaZxmomXn7MsKZ7Cqha0j338UpWj9nAOSqB2tr2bHTsI8fHdSoTvqfC06ADy+kEYzMgj
 jMeUHYqmFxKJ6IicMExg3sSXFGI=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5fa4f98598aeba5841bcd32a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 06 Nov 2020 07:21:41
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 542E8C433CB; Fri,  6 Nov 2020 07:21:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1B11C433C6;
        Fri,  6 Nov 2020 07:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1B11C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, kuabhs@chromium.org,
        briannorris@chromium.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org
Subject: Re: [PATCH v2] ath10k: Fix the parsing error in service available event
References: <1603904469-598-1-git-send-email-pillair@codeaurora.org>
Date:   Fri, 06 Nov 2020 09:21:36 +0200
In-Reply-To: <1603904469-598-1-git-send-email-pillair@codeaurora.org> (Rakesh
        Pillai's message of "Wed, 28 Oct 2020 22:31:09 +0530")
Message-ID: <874km3lzlr.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rakesh Pillai <pillair@codeaurora.org> writes:

> The wmi service available event has been
> extended to contain extra 128 bit for new services
> to be indicated by firmware.
>
> Currently the presence of any optional TLVs in
> the wmi service available event leads to a parsing
> error with the below error message:
> ath10k_snoc 18800000.wifi: failed to parse svc_avail tlv: -71
>
> The wmi service available event parsing should
> not return error for the newly added optional TLV.
> Fix this parsing for service available event message.
>
> Tested-on: WCN3990 hw1.0 SNOC

Firmware version missing.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
