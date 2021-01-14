Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2F22F5B38
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 08:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbhANHWx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 02:22:53 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:39821 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbhANHWw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 02:22:52 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610608947; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=6Qup6eTt72dD/FoH11S+QWujoErcazjSwoOinFYv054=; b=MBQ9vl7QToex0ewMv/q74hQQceGJfVb4n58Xq+wsHYWWSTN7HtyzNyPVw2kQBUAQddGpVZRX
 +5zzN7pEzD3lYDjZc+yrO9a+JSa1n2J+lzHf1wcOzeFTwcJ6fGgjOAnmouFNG1Xz4ioVjpOR
 frzuEHTxQZpmrxEiE/94LoSqnX8=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ffff119415a6293c5e8c418 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 14 Jan 2021 07:22:01
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B056CC43461; Thu, 14 Jan 2021 07:22:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DA940C433ED;
        Thu, 14 Jan 2021 07:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA940C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <phhuang@realtek.com>
Subject: Re: [PATCH RESEND v3 0/8] rtw88: improve TX performance in field
References: <20210114010950.3316-1-pkshih@realtek.com>
Date:   Thu, 14 Jan 2021 09:21:57 +0200
In-Reply-To: <20210114010950.3316-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Thu, 14 Jan 2021 09:09:42 +0800")
Message-ID: <874kjkrnje.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> Improve TX performance in aspects of protocol and software design. Also,
> update PHY parameters to fix incorrect RSSI report.
>
> v2: Since 5/5 of v1 is too large, I split it into three patches.
> v3: Since 6/7 of v2 is still too large for patchwork, I split parameter
>     into four patches.
>
> ---
> RESEND v3 due to no appearance of patchwork

Please avoid using "RESEND", instead just increase the version (in this
case you should have used v4). Makes my sorting easier and it's not like
we are running out of numbers for versions :)

And mailing lists and patchwork can be slow sometimes (recently more
often), so please wait at least 12h before resubmitting any patches. Now
both v3 and "v3 RESEND" are in patchwork.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
