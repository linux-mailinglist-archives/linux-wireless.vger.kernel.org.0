Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A741010C4A8
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 09:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfK1IAr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 03:00:47 -0500
Received: from a27-187.smtp-out.us-west-2.amazonses.com ([54.240.27.187]:39194
        "EHLO a27-187.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726963AbfK1IAr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 03:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574928046;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=R170+eucBgwGB7vYzNNsgn9IJoatW8gOmldds1sVyjg=;
        b=mioruUJg94nm4wS2aZ0BcmWzr2bh2c8PFBTj5gNKGof7cZU2tA3/B5X1Lfn2/QNh
        G2ok4qqjeK5mB3Rta9yytqNfGzlmWQYJstcWCYT2b8q7nToMy/BNC9834A/nWIoxx4+
        +MiTZOkPWUiaO4foQGaW+2jahpkUfhp3/wg334qA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574928046;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=R170+eucBgwGB7vYzNNsgn9IJoatW8gOmldds1sVyjg=;
        b=dvNajh+Z41y4VWNFi+tKP1MB6sHOWP9ApvyEW6B+QdJTv92Ydx2tjJNhCTehrVBY
        3VgLEN4Xbf64Iah+iafFUKx7F0ja6Rgw4gejBf7nf0GLmM18vK1Q8CsBkSGrQyR5jg9
        aG/X5pfJWYbVB4B4kloPCx1NzihNpX0Ry6nS1yJs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C5FEC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] libertas: Fix two buffer overflows at parsing bss
 descriptor
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191122052917.11309-1-huangwenabc@gmail.com>
References: <20191122052917.11309-1-huangwenabc@gmail.com>
To:     huangwenabc@gmail.com
Cc:     linux-wireless@vger.kernel.org, linux-distros@vs.openwall.org,
        security@kernel.org, libertas-dev@lists.infradead.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016eb106d929-1a3d21ee-77b1-4cc4-a3af-a2adeaafe048-000000@us-west-2.amazonses.com>
Date:   Thu, 28 Nov 2019 08:00:46 +0000
X-SES-Outgoing: 2019.11.28-54.240.27.187
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

huangwenabc@gmail.com wrote:

> From: Wen Huang <huangwenabc@gmail.com>
> 
> add_ie_rates() copys rates without checking the length 
> in bss descriptor from remote AP.when victim connects to 
> remote attacker, this may trigger buffer overflow.
> lbs_ibss_join_existing() copys rates without checking the length 
> in bss descriptor from remote IBSS node.when victim connects to 
> remote attacker, this may trigger buffer overflow.
> Fix them by putting the length check before performing copy.
> 
> This fix addresses CVE-2019-14896 and CVE-2019-14897.
> 
> Signed-off-by: Wen Huang <huangwenabc@gmail.com>

Please fix the warning reported by kbuild bot.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11257187/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

