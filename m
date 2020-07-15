Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6607F220A17
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 12:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbgGOKgB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 06:36:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52535 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728781AbgGOKgA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 06:36:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594809360; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=LQdfZxUjVAxnZelA4s5Yc2qi3Up7i50KwhxtqgTG7xc=;
 b=ZL8Zh/4SyY9/s6kQpaBt4leiKS6dbvWTXg9fhFownTHLgz/xzvN7+HL/P9E75mXD4W+mV92r
 YS5610k6eBVRInn58JR+Mh0nFzYkUbQNVIe3CcKFaGvtgsRUgwUYPZVcr/LCbeje44KPACGh
 ww03d++1i/PNpE3t26hWRzsY75Q=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-west-2.postgun.com with SMTP id
 5f0edc0bee6926bb4f6f679e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 10:35:55
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D77E2C433CB; Wed, 15 Jul 2020 10:35:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C6456C433CA;
        Wed, 15 Jul 2020 10:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6456C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] rtlwifi: Fix endian issue in ps.c
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200604005733.7905-2-Larry.Finger@lwfinger.net>
References: <20200604005733.7905-2-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200715103554.D77E2C433CB@smtp.codeaurora.org>
Date:   Wed, 15 Jul 2020 10:35:54 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> wrote:

> Sparse reports the following endian issues:
> 
>   CHECK   drivers/net/wireless/realtek/rtlwifi/ps.c
> drivers/net/wireless/realtek/rtlwifi/ps.c:772:42: warning: restricted __le32 degrades to integer
> drivers/net/wireless/realtek/rtlwifi/ps.c:772:42: warning: cast to restricted __le32
> drivers/net/wireless/realtek/rtlwifi/ps.c:775:42: warning: restricted __le32 degrades to integer
> drivers/net/wireless/realtek/rtlwifi/ps.c:775:42: warning: cast to restricted __le32
> drivers/net/wireless/realtek/rtlwifi/ps.c:778:42: warning: restricted __le32 degrades to integer
> drivers/net/wireless/realtek/rtlwifi/ps.c:778:42: warning: cast to restricted __le32
> drivers/net/wireless/realtek/rtlwifi/ps.c:867:42: warning: restricted __le32 degrades to integer
> drivers/net/wireless/realtek/rtlwifi/ps.c:867:42: warning: cast to restricted __le32
> drivers/net/wireless/realtek/rtlwifi/ps.c:870:42: warning: restricted __le32 degrades to integer
> drivers/net/wireless/realtek/rtlwifi/ps.c:870:42: warning: cast to restricted __le32
> drivers/net/wireless/realtek/rtlwifi/ps.c:873:42: warning: restricted __le32 degrades to integer
> drivers/net/wireless/realtek/rtlwifi/ps.c:873:42: warning: cast to restricted __le32
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

2 patches applied to wireless-drivers-next.git, thanks.

0df9edb37f3c rtlwifi: Fix endian issue in ps.c
97794e638cf5 rtlwifi: rtl8188ee: Fix endian issue

-- 
https://patchwork.kernel.org/patch/11586759/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

