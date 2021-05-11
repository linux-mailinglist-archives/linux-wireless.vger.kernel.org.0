Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716C637ADBE
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 20:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhEKSGg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 14:06:36 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:15038 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbhEKSGg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 14:06:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620756329; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=p2I4kJJP91F30kEE+0p2ly+jfTgaa79dWOL/aWL6+ng=; b=AxHoxuoZVgfRz1oNfMo+d/o5XD7eb/532/Zt9nNss86dk2yccja+MGBi3FRBpTVa08K8KCzr
 RO3wcG9A7q56atXX1R2Kt7s0lTfccOt2aD0bEvSQ3fRMdf+o+edQ/89n37vb4bVHfTuu33iW
 N5JyxaLx0wzfMjchRAQexZE+/xw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 609ac7685702f8d96944a3bd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 11 May 2021 18:05:28
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 28C7AC4338A; Tue, 11 May 2021 18:05:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 981BAC433D3;
        Tue, 11 May 2021 18:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 981BAC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pkshih <pkshih@realtek.com>
Cc:     "linux-firmware\@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: Request to update 8852a firmware of rtw89 to v0.13.8.0
References: <57e9f582340545c79a9ab3433e2a4a7d@realtek.com>
Date:   Tue, 11 May 2021 21:05:20 +0300
In-Reply-To: <57e9f582340545c79a9ab3433e2a4a7d@realtek.com> (Pkshih's message
        of "Thu, 29 Apr 2021 08:59:57 +0000")
Message-ID: <87cztx87tr.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pkshih <pkshih@realtek.com> writes:

> Please help to update 8852a firmware.
> This is first time I send a pull request. If anything is wrong, please let me know.

rtw89 driver is not in upstream yet, and it has not been reviewed
either. I recommend holding off pulling the firmware until the driver is
reviewed.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
