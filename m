Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D735B319B6
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jun 2019 07:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfFAFGr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Jun 2019 01:06:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50430 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfFAFGr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Jun 2019 01:06:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C6CE060C72; Sat,  1 Jun 2019 05:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559365606;
        bh=0rQKj4Z3TH7f4HqARwB1c8TiOOWdm0uC/zyCjBgDN0E=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=EX2PI6rn6lOCV7bhASc58a20SVYSyp6fC67xW7j9icbWZRV/E8DG2FdrsbHLCSX0R
         9iW3k+dfwg/R0rlTG2o4Gc1+3igb1Ha+Ausxci4S+HYMgwbKYazon/mYucRc9ReQpj
         9LkZgHd3hHzmhyNjLYsrFZgqYVFMdy8t/rcFkcas=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AB0F660312;
        Sat,  1 Jun 2019 05:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559365604;
        bh=0rQKj4Z3TH7f4HqARwB1c8TiOOWdm0uC/zyCjBgDN0E=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=NvtHx5n4opRad6Swy7wfOsRPCJQ8f4Y5ebWV+xtbpAHH9/9duAytd+1LB+DYPJN1v
         DXQYrCDfbEk9OIU0rotwLSizdRV+9IdANgaZIG0IM6HmN7hyJF6FI1TKYe2JkokZVt
         ZDz8xpCplWPjTmJSRWzy5leYH6cohejtZeOgLogs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB0F660312
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mwifiex: Fix heap overflow in mwifiex_uap_parse_tail_ies()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190531131841.7552-1-tiwai@suse.de>
References: <20190531131841.7552-1-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        huangwen <huangwen@venustech.com.cn>,
        Solar Designer <solar@openwall.com>,
        Marcus Meissner <meissner@suse.de>,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190601050646.C6CE060C72@smtp.codeaurora.org>
Date:   Sat,  1 Jun 2019 05:06:46 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Takashi Iwai <tiwai@suse.de> wrote:

> A few places in mwifiex_uap_parse_tail_ies() perform memcpy()
> unconditionally, which may lead to either buffer overflow or read over
> boundary.
> 
> This patch addresses the issues by checking the read size and the
> destination size at each place more properly.  Along with the fixes,
> the patch cleans up the code slightly by introducing a temporary
> variable for the token size, and unifies the error path with the
> standard goto statement.
> 
> Reported-by: huangwen <huangwen@venustech.com.cn>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Patch applied to wireless-drivers.git, thanks.

69ae4f6aac15 mwifiex: Fix heap overflow in mwifiex_uap_parse_tail_ies()

-- 
https://patchwork.kernel.org/patch/10970141/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

