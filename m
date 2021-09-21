Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823434135A5
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Sep 2021 16:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbhIUOx7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Sep 2021 10:53:59 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13900 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233799AbhIUOx6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Sep 2021 10:53:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632235950; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=XTsonDR+y2PGouwjvRW3GrSDtHUgwEO9NPTd8ohLSrc=;
 b=H3zlgewFlKBIRCWAI1z7HU3rMR60vJvBuPGbQmnBPQsxv8Gsa8LB/UY8lqIVggEaPvVWe6eC
 /UsYzN6PFFZm/tMc9ofZzmI3DwSUA2CF2v8XTxpV1lugjrMqTBSRnmlIMKesjDdBcgvwW5wG
 84QvnhVSim3fHn7Rp0RF1WF7bhw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6149f1a0ec62f57c9afe98bc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 21 Sep 2021 14:52:16
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2E740C43460; Tue, 21 Sep 2021 14:52:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7A563C4338F;
        Tue, 21 Sep 2021 14:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 7A563C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] rtw88: upgrade rtw_regulatory mechanism and
 mapping
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210830072014.12250-2-pkshih@realtek.com>
References: <20210830072014.12250-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <timlee@realtek.com>, <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210921145215.2E740C43460@smtp.codeaurora.org>
Date:   Tue, 21 Sep 2021 14:52:15 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Mapping table from country code to rtw_regulatory, which manages tx power
> limit according to countries, is updated. And mapping architecture is also
> upgraded. For more precise control on tx power limit, it allows different
> rtw_regulatory for different bands logically. Besides, a helper function
> to query rtw_regulatory for current band under current country is provided.
> 
> For older chips, some newly added rtw_regulatory may not be configured.
> To avoid that those chips have no limit on some countries mapping to a
> newer rtw_regulatory after table update, a backward selection mechanism
> of rtw_regulatory is introduced. It can help chips use a rtw_regulatory
> which has been configured as an alternative of a newer one which is not
> configured.
> 
> In addition, rtw88 actually doesn't manage channel plans by itself.
> Instead, it follows them from stack. So, correct some naming about
> chplan with regd, and remove the unnecessary channel control for now.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-drivers-next.git, thanks.

f8509c38ecec rtw88: upgrade rtw_regulatory mechanism and mapping
8d4fb3998c05 rtw88: add regulatory strategy by chip type
7285eb9693a2 rtw88: support adaptivity for ETSI/JP DFS region
fe7bc23a8c5e rtw88: move adaptivity mechanism to firmware

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210830072014.12250-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

