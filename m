Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE6552254
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 06:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfFYExP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 00:53:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55502 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfFYExP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 00:53:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5747960867; Tue, 25 Jun 2019 04:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561438394;
        bh=0PTm5aueCleXr3/4IPxcFUoSNh6YuLWUu+js7/+jTuo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=lEI1dLVV5amFS/Y/IJouk/tt4O7DePXPbSeIBOr9TqRZpSUCzDvab4rmpnBy4T5b0
         IOLXtt+cK4aV80/PckOi1DQo+XvQS2wwy1K4TCT+aazXr4zbOl+JUNeRuwmQqTz6xy
         CDUctqZ62Wp5LbvQaxjLB3fBDh4WP6cOupSzPKwY=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ECAEA6070D;
        Tue, 25 Jun 2019 04:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561438393;
        bh=0PTm5aueCleXr3/4IPxcFUoSNh6YuLWUu+js7/+jTuo=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=eyBuRVJNO9GWfnLXo5WrtNFrK2GXZE7GsX0nhCqAVZYHX/s17lGhVsWZf3fhArQtp
         u79JxcnmZt8raszudab99oUtKtSAKYkEXJ2DrktEW7DMFdRYjxu6m7R+m07MIoFy1w
         uBHK4OTO8xSckFfzPqe8JIaA9/MXsZGFKCWrs3bI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ECAEA6070D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mwifiex: ignore processing invalid command response
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1561126484-7735-1-git-send-email-gbhat@marvell.com>
References: <1561126484-7735-1-git-send-email-gbhat@marvell.com>
To:     Ganapathi Bhat <gbhat@marvell.com>
Cc:     <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Cathy Luo <cluo@marvell.com>,
        Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        "Rakesh Parmar" <rakeshp@marvell.com>,
        Swati Kushwaha <swatiuma@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625045314.5747960867@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 04:53:14 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ganapathi Bhat <gbhat@marvell.com> wrote:

> From: Swati Kushwaha <swatiuma@marvell.com>
> 
> Firmware can send invalid command response, the processing of
> which can attempt to modify unexpected context and cause issues.
> To fix this, driver should check that the command response ID is
> same as the one it downloaded, and ignore processing of invalid
> response.
> 
> Signed-off-by: Swati Kushwaha <swatiuma@marvell.com>
> Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>

Patch applied to wireless-drivers-next.git, thanks.

74f202aaae0a mwifiex: ignore processing invalid command response

-- 
https://patchwork.kernel.org/patch/11010163/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

