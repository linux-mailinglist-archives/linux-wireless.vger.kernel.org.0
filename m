Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF4930267F
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jan 2021 15:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbhAYOrq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jan 2021 09:47:46 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:22788 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729627AbhAYOn6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 09:43:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611585811; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=JQCeSO+UyihZe5pDNw/XWqrDbLL0i7HZrQP7wx7z/MI=;
 b=dcyWV/lx6Ot1JqSJ396P6XkfvyUSz//cS39SNkLde7NAl7xL8n+PxeNlhsPqtT1FdhKDg15w
 jacNKBRprUvLmyoCF//MeD+LF7j5uh1p9fb0w71X0ek5k82LFQxLdDSSQUAU6eOe/L6+m/Ms
 cZzeqqKAomv2DVkRn6X0RyEItrM=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 600ed8f2ad4c9e395b04709d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Jan 2021 14:42:58
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A7220C43462; Mon, 25 Jan 2021 14:42:58 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 18BB0C433ED;
        Mon, 25 Jan 2021 14:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18BB0C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: mt7601u: process tx URBs with status EPROTO properly
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <72392e8341aa8591c0b9962661a6ca26b1198f32.1610919534.git.lorenzo@kernel.org>
References: <72392e8341aa8591c0b9962661a6ca26b1198f32.1610919534.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        kuba@kernel.org, z.han@gmx.net
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210125144258.A7220C43462@smtp.codeaurora.org>
Date:   Mon, 25 Jan 2021 14:42:58 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Similar to commit 0e40dbd56d67 ("mt7601u: process URBs in status EPROTO
> properly"), do not process tx URBs if marked with status set to EPROTO.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Patch applied to wireless-drivers-next.git, thanks.

f43fcaef87a3 mt7601u: process tx URBs with status EPROTO properly

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/72392e8341aa8591c0b9962661a6ca26b1198f32.1610919534.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

