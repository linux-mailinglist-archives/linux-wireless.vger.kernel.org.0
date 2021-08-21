Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820BF3F3C3F
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 21:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhHUTTL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Aug 2021 15:19:11 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:24990 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhHUTTL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Aug 2021 15:19:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629573511; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=+Shqa2PB7TqENFViJp0EvRpg6aZRA6eP9jZwGMAAwbM=;
 b=TRIEMdnF5+oTFlnzCiTMPKocDDjYJLbB7TBO4rzqTbWuorz41emXyyo7bb0SnU+yEbgqXp+2
 vtJwTSGtmeMVZP0n4Oy9pVcZt3h3LAgPtid5SEnNe8nnGXMom6Hl+xIMyLCfm3Wh7RbE1vyk
 1bbQbo2u50LEBy5yyxwQpRHf5k4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 612151850f9b337f114269f3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 21 Aug 2021 19:18:29
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6237CC43460; Sat, 21 Aug 2021 19:18:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20719C4360C;
        Sat, 21 Aug 2021 19:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 20719C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] rtw88: adjust the log level for failure of tx report
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210713104524.47101-1-pkshih@realtek.com>
References: <20210713104524.47101-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <timlee@realtek.com>, <phhuang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210821191828.6237CC43460@smtp.codeaurora.org>
Date:   Sat, 21 Aug 2021 19:18:28 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> We find that some disconnect events are related to failure of
> tx report, so increase log level to improve debuggability.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-drivers-next.git, thanks.

584dce175f04 rtw88: adjust the log level for failure of tx report
81a68a1424ba rtw88: 8822c: add tx stbc support under HT mode
0c283b47539a rtw88: change beacon filter default mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210713104524.47101-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

