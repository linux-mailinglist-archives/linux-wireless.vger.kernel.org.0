Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3A14170CA
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 13:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245455AbhIXLYo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 07:24:44 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:27907 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245299AbhIXLYn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 07:24:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632482590; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=TrcE+to5kPjAw28fHqBrw2JuocJEaXxrFLF8EUiunfg=;
 b=ZdI4IM/hKhnD1v7lOJhr4S4+Gacl/eolriQmy3QfaSViqMZxRYFhSGwHf05VVMzIbCFPH7BE
 P+wl17LNyHyQhyBP/Tx4Fww498z7D0yUG6cYqI0LBzLxqn+cASWDsSCwqx5oV6Mark7Jo0gL
 D2a5drkVKJyNwF5c2SBe+cv63js=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 614db504ec62f57c9a191159 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Sep 2021 11:22:44
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B8E55C43460; Fri, 24 Sep 2021 11:22:43 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C5A3BC4338F;
        Fri, 24 Sep 2021 11:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C5A3BC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] rtw88: 8821c: support RFE type4 wifi NIC
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210922023637.9357-1-pkshih@realtek.com>
References: <20210922023637.9357-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <vincent_fann@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210924112243.B8E55C43460@smtp.codeaurora.org>
Date:   Fri, 24 Sep 2021 11:22:43 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Guo-Feng Fan <vincent_fann@realtek.com>
> 
> RFE type4 is a new NIC which has one RF antenna shares with BT.
> RFE type4 HW is the same as RFE type2 but attaching antenna to
> aux antenna connector.
> 
> RFE type2 attach antenna to main antenna connector.
> Load the same parameter as RFE type2 when initializing NIC.
> 
> Signed-off-by: Guo-Feng Fan <vincent_fann@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-drivers-next.git, thanks.

b789e3fe7047 rtw88: 8821c: support RFE type4 wifi NIC
5db4943a9d6f rtw88: 8821c: correct 2.4G tx power for type 2/4 NIC

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210922023637.9357-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

