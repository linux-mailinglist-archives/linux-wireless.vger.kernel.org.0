Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90E7BE9E75
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2019 16:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfJ3PIr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Oct 2019 11:08:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60552 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfJ3PIr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Oct 2019 11:08:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AFFA06119B; Wed, 30 Oct 2019 15:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572448126;
        bh=t9mKk8row3OjrBOpQ5PdlkOpZwZfNmADOYMWRBEzM1c=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Jw6gV1c4t40ucxWxoOiwggEdhCV9wjrLyz5+YECxP2vBr4SO8mhpMUKytFpMuxSc3
         w4P+LDzwMfujFSnPN2NIlWvnCKJZ4upTGRIFe8R3W8j/r1R1S5LXImRo0rsTvuH7zg
         qw3Fts13FN44aj170r3yWR19tURQGJUzwb2ZHWgY=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9E42661139;
        Wed, 30 Oct 2019 15:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572448124;
        bh=t9mKk8row3OjrBOpQ5PdlkOpZwZfNmADOYMWRBEzM1c=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=GZHtUulvF437o+fFWWewrRyNTxDT3u1+pvfYBrthU60nDyEqPCvqe33tyApYiQVwK
         bw4vHBEAuGwDiaxY2Ew1qTkGZUpbmXAJ4ilLixKdv3GR8WjBcRVHaC1T4VH4MJUuSO
         6SElSkWq/DlF2GmJVrmFIi8/YMGsT4sf520T/hcU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E42661139
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5.4 v2] iwlwifi: fw api: support new API for scan config
 cmd
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191029154720.26477-1-luca@coelho.fi>
References: <20191029154720.26477-1-luca@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191030150846.AFFA06119B@smtp.codeaurora.org>
Date:   Wed, 30 Oct 2019 15:08:44 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Ayala Beker <ayala.beker@intel.com>
> 
> The API was reduced to include only knowledge currently needed by the
> FW scan logic, the rest is legacy.  Support the new, reduced version.
> 
> Using the old API with newer firmwares (starting from
> iwlwifi-*-50.ucode, which implements and requires the new API version)
> causes an assertion failure similar to this one:
> 
> [    2.854505] iwlwifi 0000:00:14.3: 0x20000038 | BAD_COMMAND
> 
> Signed-off-by: Ayala Beker <ayala.beker@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to wireless-drivers.git, thanks.

3d206e6899a0 iwlwifi: fw api: support new API for scan config cmd

-- 
https://patchwork.kernel.org/patch/11218089/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

