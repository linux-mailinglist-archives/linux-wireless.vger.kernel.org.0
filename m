Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936941E81E4
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 17:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgE2PeR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 11:34:17 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:61738 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725901AbgE2PeO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 11:34:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590766454; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=4h6mUhCfTn/PPwY0CqyuZa1NJ92KFZY1OPYa8ryUDI0=; b=oJKv5OqPqG9eac+0o+RM+XSKweqPu0d10kgF9VMGU2roY+PJaS7BpCU/6pUPhyCHXiOX6BUZ
 Nw8dpSFmXXSXJAMdv5qjY2OhqxQg0mBgGx7gcZzLjGtZPVwH6ILB3rvlh41RAOPGIzoBCoI8
 5VtbhNBcKRkf4fsQNH/szAsooVQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ed12b75cb0458693350746c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 15:34:13
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 126A8C4339C; Fri, 29 May 2020 15:34:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B55AC433CB;
        Fri, 29 May 2020 15:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B55AC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        openwrt-devel@lists.openwrt.org,
        Ansuel Smith <ansuelsmth@gmail.com>
Subject: Re: [PATCH v13] ath10k: add LED and GPIO controlling support for various chipsets
References: <1523027875-5143-1-git-send-email-kvalo@codeaurora.org>
        <b23e65cf-4be7-72db-7955-32eae196953e@dd-wrt.com>
        <3608947.bSrYYtX6KI@bentobox> <3445075.COMLMNsY4U@bentobox>
Date:   Fri, 29 May 2020 18:34:07 +0300
In-Reply-To: <3445075.COMLMNsY4U@bentobox> (Sven Eckelmann's message of "Mon,
        25 May 2020 18:04:49 +0200")
Message-ID: <87k10usqkw.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> writes:

> On Monday, 25 May 2020 11:22:13 CEST Sven Eckelmann wrote:
> [...]
>> And it still can with this OpenWrt version. But it doesn't seem to happen with 
>> the most recent OpenWrt reboot-13353-gb1604b744b. But there are nearly 4000 
>> commits inbetween. So no idea what changed (just a timing thing or an actual 
>> fix - no idea).
>
> Seems like there is a fix which solves some lost interrupt problems for 
> IPQ40xx. Without this change, I see the reported problem. And with the patch, 
> it is gone. Or in commits:
>
> * creates timeout problems: 46b949a067e5 ("ipq40xx: enlarge PCIe BAR size")
> * works fine: 18e942b6c4e5 ("ipq40xx: fix pcie msi IRQ trigger level")
>
> If you look in the git logs [1], you can see that the working commit is a 
> child of the broken one. So at least from my point of view, my initial report 
> is no blocker anymore for Sebastian's patch (or Kalle's version of it).

Great. If the patch is good to take can someone rebase the latest
version and resubmit, please?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
