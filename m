Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BC21A969A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 10:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgDOIeJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Apr 2020 04:34:09 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:45967 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbgDOIeH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Apr 2020 04:34:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586939647; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=SLHAYva2OLrmNU4E0D7HTfMDBN5YIO5M/rgVRwyA7MM=;
 b=Q+C9rNLtsu3i8/8Pi7JoJcpj7iMrU7m99iESJykBfSP1UQ9K0PsDnMf0TkWT8e8r1t9zUz8K
 NciVOg69TLPpVVL5lxjE2wK0N4r400KQlQGguA1lVDSnMLKz09XYbsJzuw0XvWqBg3PvcLWr
 Woo2a8ncBSIv/wa2cdD1hQncj+k=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e96c6f3.7f955406cb20-smtp-out-n03;
 Wed, 15 Apr 2020 08:33:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A191DC433BA; Wed, 15 Apr 2020 08:33:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 89F54C433F2;
        Wed, 15 Apr 2020 08:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89F54C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Update URL for wireless drivers
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200412110724.6uaoqmjc3it73nzo@nixos>
References: <20200412110724.6uaoqmjc3it73nzo@nixos>
To:     Nils =?utf-8?q?ANDR=C3=89-CHANG?= <nils@nilsand.re>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200415083355.A191DC433BA@smtp.codeaurora.org>
Date:   Wed, 15 Apr 2020 08:33:55 +0000 (UTC)
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

The MAINTAINERS file had huge changes in v5.7-rc1 and this won't apply
anymore. Please rebase this on top of Linus' tree and I'll apply it to
wireless-drivers once I have updated it to v5.7-rc1.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11484779/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
