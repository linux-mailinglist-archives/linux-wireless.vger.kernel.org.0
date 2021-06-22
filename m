Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614013B0899
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 17:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhFVPV4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 11:21:56 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38200 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232169AbhFVPV4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 11:21:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624375180; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=iJDvUVfRV50lcgkv07h01Gonl2kz48uPaVYOkC54lyk=;
 b=iz8PJK/+viYkkl02NuSMC0JNGdydLLgYCLMShTS/Re9O4nSUgy7s4mgnRtzIAm+ER6Jdtd3m
 I0ULVdiSU6QyFbFy/jwNHBkwyEK3f9PXp6EZVnGEuKD9Bkv15vAC0SXndf/JqKp1cwCC3Zhx
 ze8sUWEZ2mbB2E0EEh9l9hYGFCk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60d1ff731200320241e13da9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Jun 2021 15:19:15
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E5611C4338A; Tue, 22 Jun 2021 15:19:14 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2DB9DC433F1;
        Tue, 22 Jun 2021 15:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2DB9DC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: Remove duplicate include of coex.h
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210430024951.33406-1-wanjiabing@vivo.com>
References: <20210430024951.33406-1-wanjiabing@vivo.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net,
        Wan Jiabing <wanjiabing@vivo.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210622151914.E5611C4338A@smtp.codeaurora.org>
Date:   Tue, 22 Jun 2021 15:19:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wan Jiabing <wanjiabing@vivo.com> wrote:

> In commit fb8517f4fade4 ("rtw88: 8822c: add CFO tracking"),
> "coex.h" was added here which caused the duplicate include.
> Remove the later duplicate include.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Patch applied to wireless-drivers-next.git, thanks.

3eab8ca6b175 rtw88: Remove duplicate include of coex.h

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210430024951.33406-1-wanjiabing@vivo.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

