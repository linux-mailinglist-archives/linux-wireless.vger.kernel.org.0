Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37632D58AB
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 00:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfJMWfU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Oct 2019 18:35:20 -0400
Received: from webmail.newmedia-net.de ([185.84.6.166]:55320 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbfJMWfU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Oct 2019 18:35:20 -0400
X-Greylist: delayed 1193 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Oct 2019 18:35:19 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=sAvABYYWkOqEUXstZ/Py+FTGTOMBRBR1llb5mPcMIpg=;
        b=F92kOt8JrdrLwCex75w6QRWQUMv3/ZYlVPv+sRmtXoMn/IrdYgWd1d25oZL0CsqjTe2DTMr35CYVZgNzROJgBqeUXWBlF6oKNbsz7jNJb1hPwy5zoERsY4Rharx37MImavP+3YRDUlO63AotEpJVcsRJbILdcmj7zMhk+V+qZVc=;
Subject: Re: [RFC PATCH 0/2] ath10k: provide survey info as accumulated data
To:     Sven Eckelmann <sven@narfation.org>, ath10k@lists.infradead.org
Cc:     vnaralas@codeaurora.org, linux-wireless@vger.kernel.org,
        Sven Eckelmann <seckelmann@datto.com>
References: <20190918124259.17804-1-sven@narfation.org>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
Message-ID: <9a9ec99b-9643-7288-eed5-b549a9fe1487@newmedia-net.de>
Date:   Mon, 14 Oct 2019 00:15:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190918124259.17804-1-sven@narfation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [2003:c9:3f0e:8900:8835:685e:aa39:2c16]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1iJm8r-0004NH-Hr; Mon, 14 Oct 2019 00:15:09 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

i checked your patch on 10.4 based chipsets with 9984. the values are 
now looking bogus and wrong at all. busy and active time time in ms does 
increase in hours each second
the problem seem to be that your patch is 10.2.4 only related. 
ath_clean_survey does not trigger on 10.4 so the values double itself 
each time the event raises since you add the full values and not just a 
delta on top

Sebastian

Am 18.09.2019 um 14:42 schrieb Sven Eckelmann:
> From: Sven Eckelmann <seckelmann@datto.com>
>
> Hi,
>
> it was observed that ath9k provides accumulated survey counters but ath10k
> neither provides deltas nor accumulated counters. Instead it returns
> some value which was returned at some point from the firmware.
>
> But as it turns out, this data is not reliable. To make it more useful,
> ath10k has to:
>
> * retrieve counters rather frequently for hardware which is known to use
>    firmware versions with low number counter bits (for only 14-30s)
> * clean up received counter values
> * accumulate counters from firmware
>
> A comparison of the resulting output with these fixes can be seen under
> https://stats.freifunk-vogtland.net/d/ffv_node/nodeinfo?orgId=1&var-node=ac86749f4d60&fullscreen&panelId=5&from=1568782046974&to=1568807068706
>
> The left side of the graph shows the output before the patches were applied
> and the right side the output with the patches applied. Just as reference, an
> ath9k device in the same building is
> https://stats.freifunk-vogtland.net/d/ffv_node/nodeinfo?orgId=1&var-node=ac86740037e0&fullscreen&panelId=5&from=1568782046974&to=1568807068706
>
> Kind regards,
> 	Sven
>
> Sven Eckelmann (2):
>    ath10k: report survey info as accumulated values
>    ath10k: regularly fetch survey counters
>
>   drivers/net/wireless/ath/ath10k/core.c |  8 ++++
>   drivers/net/wireless/ath/ath10k/core.h |  3 ++
>   drivers/net/wireless/ath/ath10k/hw.c   | 13 +++--
>   drivers/net/wireless/ath/ath10k/mac.c  | 52 ++++++++++++++++++++
>   drivers/net/wireless/ath/ath10k/mac.h  |  3 ++
>   drivers/net/wireless/ath/ath10k/wmi.c  | 66 ++++++++++++++++++++++----
>   6 files changed, 130 insertions(+), 15 deletions(-)
>
