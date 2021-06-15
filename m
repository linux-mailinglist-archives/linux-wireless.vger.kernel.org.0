Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCDE3A8044
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 15:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhFONhm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 09:37:42 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:63350 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231235AbhFONhY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 09:37:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623764120; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=pnBlFlGA1t0ltpP51MqIm6PlzT9E15l1xJKmxIS2uqU=;
 b=wz4BPg6gKm7Qyw8DShFzy6LOIz0oyc0/g4R9P/YNmDPBNnQ1N/P31SSeA0GWq9z5ZSZpat+q
 RLZKJmdI082MmYbJkgmVBWEp6/Ta/G7FdLt2djmJbkekQNZFUHrgPDR/DnmroN43R+Y0bJsO
 JmJcb1R39myixTG3qdqFOfLY2Ek=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60c8ac69abfd22a3dc8cf588 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 13:34:33
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B73AEC43217; Tue, 15 Jun 2021 13:34:32 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B14FDC433F1;
        Tue, 15 Jun 2021 13:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B14FDC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: rndis_wlan: simplify is_associated()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210423094940.1593-1-zuoqilin1@163.com>
References: <20210423094940.1593-1-zuoqilin1@163.com>
To:     zuoqilin1@163.com
Cc:     jussi.kivilinna@iki.fi, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, zuoqilin <zuoqilin@yulong.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615133432.B73AEC43217@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 13:34:32 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

zuoqilin1@163.com wrote:

> From: zuoqilin <zuoqilin@yulong.com>
> 
> It is not necessary to define the variable ret to receive
> the return value of the get_bssid() method.
> 
> Signed-off-by: zuoqilin <zuoqilin@yulong.com>

Patch applied to wireless-drivers-next.git, thanks.

ad4d74cd8177 rndis_wlan: simplify is_associated()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210423094940.1593-1-zuoqilin1@163.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

