Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7D5254320
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 12:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgH0KEr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 06:04:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24994 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbgH0KEq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 06:04:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598522686; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=kKxRrosUk4+JXqyUQN4HVkd0wJGJEwRdPu3QcR8Pk+o=;
 b=ZZt9SisBLrfPebnjjacNDcgVUKq6Mr+kc+SoLwvs8QgRiWg4kF/8CSuKoacPkrHRe4uwOL5q
 /ZyrP8eZXv0jDpRi6sTTFEwzKh8rBtraXo4GDLaek+dERLXeT37i+Pz4BVVCLpNK1Muh6W65
 OmYfl1rMYn2VxEn3twCz0P/M+tw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f478530c9ede11f5e71780b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 Aug 2020 10:04:32
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 41992C433CB; Thu, 27 Aug 2020 10:04:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CC66FC433C6;
        Thu, 27 Aug 2020 10:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC66FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: don't treat NULL pointer as an array
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200821211716.1631556-1-briannorris@chromium.org>
References: <20200821211716.1631556-1-briannorris@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     <linux-wireless@vger.kernel.org>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200827100431.41992C433CB@smtp.codeaurora.org>
Date:   Thu, 27 Aug 2020 10:04:31 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> wrote:

> I'm not a standards expert, but this really looks to be undefined
> behavior, when chip->dig_cck may be NULL. (And, we're trying to do a
> NULL check a few lines down, because some chip variants will use NULL.)
> 
> Fixes: fc637a860a82 ("rtw88: 8723d: Set IG register for CCK rate")
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Acked-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

22b726cbdd09 rtw88: don't treat NULL pointer as an array

-- 
https://patchwork.kernel.org/patch/11730581/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

