Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769842A9125
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 09:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgKFIWB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 03:22:01 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:36949 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgKFIWB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 03:22:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604650921; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=2FJPbK0c+CPsTL5tSDrssuxGM/WEiJh9GSXGGryDmIo=;
 b=qzQtKDynbK45LTN3pI5e39IonKAr9bBvQg9U8QyoFSrEpttN4micuEubBU4nDYi85711TduG
 PJ495a49NwWffiHvR9QR7GRr11cp6e+wpxlbSaNGj2glZgbqVBFr7iwQ/TXGXj08cBOCrIyI
 Q2EvBmKoBXEqIow62g4Ct0QX4zE=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5fa507a81baf490ee932b90a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 06 Nov 2020 08:22:00
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 23EBAC433FE; Fri,  6 Nov 2020 08:22:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5C41BC433C8;
        Fri,  6 Nov 2020 08:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C41BC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] MAINTAINERS: update Yan-Hsuan's email address
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201012081140.18085-1-tony0620emma@gmail.com>
References: <20201012081140.18085-1-tony0620emma@gmail.com>
To:     tony0620emma@gmail.com
Cc:     tony0620emma@gmail.com, linux-wireless@vger.kernel.org,
        tehuang@realtek.com, pkshih@realtek.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201106082200.23EBAC433FE@smtp.codeaurora.org>
Date:   Fri,  6 Nov 2020 08:22:00 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tony0620emma@gmail.com wrote:

> From: Yan-Hsuan Chuang <tony0620emma@gmail.com>
> 
> Switch my email to gmail.com address.
> 
> Signed-off-by: Yan-Hsuan Chuang <tony0620emma@gmail.com>

Patch applied to wireless-drivers.git, thanks.

397a973b9978 MAINTAINERS: update Yan-Hsuan's email address

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201012081140.18085-1-tony0620emma@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

