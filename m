Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41283A7B87
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 12:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhFOKNs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 06:13:48 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:58968 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhFOKNr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 06:13:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623751903; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Skb+WLzy+Bf/zXmHd3XxHoPQCl5tVD+TVbCIMn5SMOU=;
 b=jWgnydLxldFZvIBjUsbNKdlgNZ7IrYhG1Re51B/IJqZDQJf3M9qjscYSX6c6IgYg1gnpnuhL
 QVgRP7c7cthhp4cau6v1rNn+ewRTE/m/hss9YJVLnCOa+U49uG5gkxEcqwhTNOguu/Rvm7aV
 8d+f0jctZ2IA1LuvN5WqqQaIgzo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60c87cdee570c05619572fa1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 10:11:42
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BE3AAC433F1; Tue, 15 Jun 2021 10:11:42 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D326C433D3;
        Tue, 15 Jun 2021 10:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D326C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: ssb: remove unreachable code
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1621306352-3632-1-git-send-email-tiantao6@hisilicon.com>
References: <1621306352-3632-1-git-send-email-tiantao6@hisilicon.com>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     <m@bues.ch>, <linux-wireless@vger.kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615101142.BE3AAC433F1@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 10:11:42 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tian Tao <tiantao6@hisilicon.com> wrote:

> The return value of ssb_bus_unregister can only be 0 or -1, so this
> condition if (err == -EBUSY) will not hold, so delete it.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Acked-by: Michael Büsch <m@bues.ch>

Patch applied to wireless-drivers-next.git, thanks.

233bc2837282 ssb: remove unreachable code

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1621306352-3632-1-git-send-email-tiantao6@hisilicon.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

