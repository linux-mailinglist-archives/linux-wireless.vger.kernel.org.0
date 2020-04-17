Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E747E1AD5F2
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 08:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgDQGP7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 02:15:59 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:12436 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726710AbgDQGP7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 02:15:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587104158; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=O17NyqFtfItT/B15uG75/Ryl4iD/9VK6oS2uppm3CRo=;
 b=ICGKcz28/6YS5THCEqpeoHvLSbLvwrAV1SbvBUTAVbtoo9gKjTK0XPTCMvI9cdrDZNE5+BQy
 2lD9L+pp/NMcY2ST9fOwsk9Buz2YLrw063/GAerjEH7Y9bpre+yYgX7UyjWd18Vkh9n/xiN9
 XNdz3qVutdIAHJ/8Vv7+yf2z73o=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e99499d.7fdb70a10c00-smtp-out-n04;
 Fri, 17 Apr 2020 06:15:57 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9014CC433F2; Fri, 17 Apr 2020 06:15:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 875D7C433F2;
        Fri, 17 Apr 2020 06:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 875D7C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] MAINTAINERS: Update URL for wireless drivers
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200415140052.2lftkixe37llmtjl@nixos>
References: <20200415140052.2lftkixe37llmtjl@nixos>
To:     Nils =?utf-8?q?ANDR=C3=89-CHANG?= <nils@nilsand.re>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200417061557.9014CC433F2@smtp.codeaurora.org>
Date:   Fri, 17 Apr 2020 06:15:57 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nils wrote:

> Previously, http://wireless.kernel.org would redirect to
> https://wireless.wiki.kernel.org, however, this is no longer the case
> and most pages return 404.
> 
> https is used because http://wireless.kernel.org/* redirects to
> https://wireless.wiki.kernel.org/*
> 
> Signed-off-by: Nils ANDRÉ-CHANG <nils@nilsand.re>

Patch applied to wireless-drivers.git, thanks.

e0c5c33dd237 MAINTAINERS: Update URL for wireless drivers

-- 
https://patchwork.kernel.org/patch/11491341/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
