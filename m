Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2800110C4D5
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 09:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfK1ISp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 03:18:45 -0500
Received: from a27-56.smtp-out.us-west-2.amazonses.com ([54.240.27.56]:37964
        "EHLO a27-56.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726882AbfK1ISp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 03:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574929124;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=BkMMtgYCkiPbXKb0T/ldFNoIv5ZNkXsiA8qo04qMK0A=;
        b=K4s/T9Eox7vuTbYVdwLv3ZS9hCNW1aQjL1RORil8fUG//jg+TZV/DO5aFX4RoIov
        nJEeZ77jLvIKSKHGSExNuJZ32T+O+HK9gJ0RAQGaobqvXeZdRqRPfWkGNtOP8YV3ifB
        jVAQxx7Vu+suwSnX+r7KGWWogtGtuSSh9nBITNmg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574929124;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=BkMMtgYCkiPbXKb0T/ldFNoIv5ZNkXsiA8qo04qMK0A=;
        b=M7CyvsrzKwVg53aCaaJiwj8PC5Go2V0Q6t8QfRqMnVXEq1vfseSUWEClmSKa5X/s
        wGf2xjhdtColKqtwubPDnMnuFmMhAzQidngLOA1cdcNWdLwyX+2B1IOciSEB+Z+ZusM
        4ZrzBZeDycW7k3ITbW/Tt5w1udaQTIHaRGs9AT94=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11667C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mwifiex: fix possible heap overflow in
 mwifiex_process_country_ie()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1574352278-7592-1-git-send-email-gbhat@marvell.com>
References: <1574352278-7592-1-git-send-email-gbhat@marvell.com>
To:     Ganapathi Bhat <gbhat@marvell.com>
Cc:     <linux-wireless@vger.kernel.org>, Cathy Luo <cluo@marvell.com>,
        Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Brian Norris <briannorris@chromium.org>,
        Mohammad Tausif Siddiqui <msiddiqu@redhat.com>,
        huangwen <huangwenabc@gmail.com>,
        Ganapathi Bhat <gbhat@marvell.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016eb1174b65-36c6895a-0aa0-4662-892c-5abd70e93b79-000000@us-west-2.amazonses.com>
Date:   Thu, 28 Nov 2019 08:18:44 +0000
X-SES-Outgoing: 2019.11.28-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ganapathi Bhat <gbhat@marvell.com> wrote:

> mwifiex_process_country_ie() function parse elements of bss
> descriptor in beacon packet. When processing WLAN_EID_COUNTRY
> element, there is no upper limit check for country_ie_len before
> calling memcpy. The destination buffer domain_info->triplet is an
> array of length MWIFIEX_MAX_TRIPLET_802_11D(83). The remote
> attacker can build a fake AP with the same ssid as real AP, and
> send malicous beacon packet with long WLAN_EID_COUNTRY elemen
> (country_ie_len > 83). Attacker can  force STA connect to fake AP
> on a different channel. When the victim STA connects to fake AP,
> will trigger the heap buffer overflow. Fix this by checking for
> length and if found invalid, don not connect to the AP.
> 
> This fix addresses CVE-2019-14895.
> 
> Reported-by: huangwen <huangwenabc@gmail.com>
> Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>

Patch applied to wireless-drivers.git, thanks.

3d94a4a8373b mwifiex: fix possible heap overflow in mwifiex_process_country_ie()

-- 
https://patchwork.kernel.org/patch/11256477/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

