Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBF341B235
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 16:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241325AbhI1Oia (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 10:38:30 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62325 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241395AbhI1Oi3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 10:38:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632839810; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=EDw3PyEIfg3aWiJp4IxUccYqKwjHMVaT8ASH+yp4NG8=;
 b=LfaxXQqTfF+20pvarQpVgKKfP9X+xUIEfyjWOxbMVrBuz1C0U4BbJarG0AwIX7am/O6cPnfA
 jJUuM4CUA6+FJzSJLoqBVhhUJC+KPbcLZmlSqP2P+55HDbilQLlyfMrzEO86/cUlEE9GepiK
 Zw02N2JoJs9DSJCOilwBV6sfiGU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6153285b713d5d6f965def88 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 14:36:11
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 183D7C4360C; Tue, 28 Sep 2021 14:36:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 17DB7C4338F;
        Tue, 28 Sep 2021 14:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 17DB7C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: sdio: Add missing BH locking around
 napi_schdule()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210824144339.2796122-1-festevam@denx.de>
References: <20210824144339.2796122-1-festevam@denx.de>
To:     Fabio Estevam <festevam@denx.de>
Cc:     kuba@kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, paulmck@kernel.org, marex@denx.de,
        wgong@codeaurora.org, alagusankar@silex-india.com,
        erik.stromdahl@gmail.com, Fabio Estevam <festevam@denx.de>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210928143611.183D7C4360C@smtp.codeaurora.org>
Date:   Tue, 28 Sep 2021 14:36:11 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fabio Estevam <festevam@denx.de> wrote:

> On a i.MX-based board with a QCA9377 Wifi chip, the following errors
> are seen after launching the 'hostapd' application:
> 
> hostapd /etc/wifi.conf
> Configuration file: /etc/wifi.conf
> wlan0: interface state UNINITIALIZED->COUNTRY_UPDATE
> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
> Using interface wlan0 with hwaddr 00:1f:7b:31:04:a0 and ssid "thessid"
> IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> wlan0: interface state COUNTRY_UPDATE->ENABLED
> wlan0: AP-ENABLED
> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
> ...
> 
> Fix this problem by adding the BH locking around napi-schedule(),
> in the same way it was done in commit e63052a5dd3c ("mlx5e: add
> add missing BH locking around napi_schdule()").
> 
> Its commit log provides the following explanation:
> 
> "It's not correct to call napi_schedule() in pure process
> context. Because we use __raise_softirq_irqoff() we require
> callers to be in a context which will eventually lead to
> softirq handling (hardirq, bh disabled, etc.).
> 
> With code as is users will see:
> 
> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
> "
> 
> Fixes: cfee8793a74d ("ath10k: enable napi on RX path for sdio")
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

019edd01d174 ath10k: sdio: Add missing BH locking around napi_schdule()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210824144339.2796122-1-festevam@denx.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

