Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69C2DE9E95
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2019 16:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfJ3PNY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Oct 2019 11:13:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34210 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfJ3PNY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Oct 2019 11:13:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 677E561066; Wed, 30 Oct 2019 15:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572448403;
        bh=bTFoXXHtT54AZpimf/1etutVoG+HS1pIqnZSpiLck8U=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=md6Aj/hxoFY78diGitDe17wdXQhatEzBNAdak5BWSAqd2PmX8TsMCkNr0tRqjSH8U
         YIK+IxVQciTJsXTyEhc5YqardH39hVN0KOzo5NXeRCxCEFTcje/WakZRFaOVl3BRNN
         RSb+oiTBRDm+bICfosBT5abIx+/FpcoQhdo9+4xg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B868661139;
        Wed, 30 Oct 2019 15:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572448401;
        bh=bTFoXXHtT54AZpimf/1etutVoG+HS1pIqnZSpiLck8U=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=olb191fxF1NVukR+GnoM31O3YmwI8GVCLdF03JPkaVIlfLEmVtfqzI+J20Ph0jKzZ
         fXNrtoKd06qnf4mVCprvmy4ckAWgFDeMBSuckh11R5pu7sePWBgNK+Jzh3tM5OIjcH
         zb8NcN9/mwEcydtWqy+steITpOUTNjwXIHiJ5jLc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B868661139
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wil6210: add SPDX license identifiers
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1572283361-22874-1-git-send-email-merez@codeaurora.org>
References: <1572283361-22874-1-git-send-email-merez@codeaurora.org>
To:     Maya Erez <merez@codeaurora.org>
Cc:     Lior David <liord@codeaurora.org>, linux-wireless@vger.kernel.org,
        wil6210@qti.qualcomm.com, Maya Erez <merez@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191030151323.677E561066@smtp.codeaurora.org>
Date:   Wed, 30 Oct 2019 15:13:22 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maya Erez <merez@codeaurora.org> wrote:

> From: Lior David <liord@codeaurora.org>
> 
> Change all files to add SPDX license identifiers and
> remove license text.
> This is only an administrative change, there is no change
> in actual license or copyright for any file.
> 
> Signed-off-by: Lior David <liord@codeaurora.org>
> Signed-off-by: Maya Erez <merez@codeaurora.org>

I assume this was supposed to be v2, so dropping.

Patch set to Superseded.

-- 
https://patchwork.kernel.org/patch/11216171/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

