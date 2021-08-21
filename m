Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E213F3BFC
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 20:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhHUSQs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Aug 2021 14:16:48 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:31326 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhHUSQq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Aug 2021 14:16:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629569767; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=9waew1/QjLClNnSburo9F7aS//45teSrpR57Zw2s7BI=;
 b=TUCFrA3oJa94C3kcJy8oxmfIJH9VoKHdN4Jn8s+CTy7R3lggarwgUwTPl+3Ty9FOaLN3VXnt
 yZjilDsFXurI3vPAvj+kRq699rt5W4YB5zT9KWXhQzr+lD5+DNw0EKMn/dRK3xLT8JzG9Plk
 U4ByVh1pTFm2YtKvN0epAfK/n9Y=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 612142cd89fbdf3ffeb1ef92 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 21 Aug 2021 18:15:41
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 97D21C43616; Sat, 21 Aug 2021 18:15:40 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 27806C4338F;
        Sat, 21 Aug 2021 18:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 27806C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: add quirk to disable pci caps on HP Pavilion
 14-ce0xxx
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210630174608.5329-1-Larry.Finger@lwfinger.net>
References: <20210630174608.5329-1-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, Ugo Remery <ugo.remery@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210821181540.97D21C43616@smtp.codeaurora.org>
Date:   Sat, 21 Aug 2021 18:15:40 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> wrote:

> From: Ugo Remery <ugo.remery@gmail.com>
> 
>     8821CE causes random freezes on HP Pavilion 14-ce0019nf. Add a quirk
>     to disable pci ASPM capability.

s-o-b lines missing.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210630174608.5329-1-Larry.Finger@lwfinger.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

