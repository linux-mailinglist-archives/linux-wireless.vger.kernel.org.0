Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C53CE10E839
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2019 11:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfLBKIe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Dec 2019 05:08:34 -0500
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:42722
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726276AbfLBKId (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Dec 2019 05:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575281313;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=e7IZnQvVspwBb6rL2WP6C2RiBlgYjGp/KTl+rG/que0=;
        b=YREr6Ivg70L1hp5ps2/91j7cO2myUIzvQJSXaDHOWyHn145jw+QyXNbatF3UJf44
        4uHKYCJrXlpi3vhWFku+BlwBOw8RfW1uVWPtOjOqm8ky38etVMwI/FNMWkvxBUyzThO
        B8DgvQT8AAwfqHyjrRsr6rCrOvDxF2urKRMuciWM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575281313;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=e7IZnQvVspwBb6rL2WP6C2RiBlgYjGp/KTl+rG/que0=;
        b=b+FvyWkFR9EEVU21jrQ7z8vP+8/6fBbgst9jnBQNnHHEkMWoXLIRyoXbpZ91/WqJ
        2bo0yyCKSdx0bNElAd5y86RyT0ec2ITO6li5RgQGvfgKSfkaMPWOrAycp6tzNHDm8Lh
        d1wc5gtfX8HQ9cvZD0mFduQJmlAp6yUv+bx8Ggv4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3058C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath: add support for special 0x0 regulatory domain
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <0101016eb614d832-1f2459b1-1555-4ce7-8f90-5704d201bc10-000000@us-west-2.amazonses.com>
References: <0101016eb614d832-1f2459b1-1555-4ce7-8f90-5704d201bc10-000000@us-west-2.amazonses.com>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016ec61545af-2f2eff26-b30d-4bff-8103-d7d0dc645313-000000@us-west-2.amazonses.com>
Date:   Mon, 2 Dec 2019 10:08:33 +0000
X-SES-Outgoing: 2019.12.02-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> Some sdio chips of rome QCA6174's regulatory domain code of EEPROM is
> empty, then ath_is_world_regd will return false for this case, and
> it will lead function __ath_reg_dyn_country not work, thus the regdomain
> will not update for NL80211_REGDOM_SET_BY_COUNTRY_IE type, it result
> ath10k set the same regdomain/reg_5ghz_ctl/reg_2ghz_ctl to firmware,
> then the tx power will not changed with different regdomain's AP. The
> regulatory domain code of EEPROM of some QCA6174 PCIE chip is 0x6c, it
> means world wide regdomain, for this chip, it does not have the issue.
> 
> For empty reulatory domain code chip, set it to world regulatory domain
> in functio ath_regd_sanitize, then it will fix the issue.
> 
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00029.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

2dc016599cfa ath: add support for special 0x0 regulatory domain

-- 
https://patchwork.kernel.org/patch/11266721/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

