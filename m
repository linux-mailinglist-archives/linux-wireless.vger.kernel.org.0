Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73D4220856
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 11:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbgGOJMd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 05:12:33 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:33885 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730559AbgGOJM0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 05:12:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594804346; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=E5BdF7LdvVidPptozr4pm6bLnmmBUQWUQSzhVYfPv0Y=;
 b=l0Nq6MzEF5FgY4Eoq4TPXqtxYDhWfSKmbee0h2w8VXthX95g1gdjS33LSLNqzqLidGJaN8L5
 4ceOzpLZoxVxfWp65MjQSBjFTJFhOZ9MH5LOpGgO8pgNPgOvp3EdGECevHhgAATUD7nYxsK/
 Xm6u8EeR3Ipos4BPW8SJOn40x8E=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-west-2.postgun.com with SMTP id
 5f0ec873ee6926bb4f589c0e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 09:12:19
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B673CC43395; Wed, 15 Jul 2020 09:12:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DD101C433CA;
        Wed, 15 Jul 2020 09:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD101C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mwifiex: Use macro MWIFIEX_MAX_BSS_NUM for specifying
 limit
 of interfaces
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200626152938.12737-1-pali@kernel.org>
References: <20200626152938.12737-1-pali@kernel.org>
To:     =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200715091218.B673CC43395@smtp.codeaurora.org>
Date:   Wed, 15 Jul 2020 09:12:18 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pali Rohár <pali@kernel.org> wrote:

> This macro is already used in mwifiex driver for specifying upper limit and
> is defined to value 3. So use it also in struct ieee80211_iface_limit.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>

Patch applied to wireless-drivers-next.git, thanks.

0ef0ace3e8e7 mwifiex: Use macro MWIFIEX_MAX_BSS_NUM for specifying limit of interfaces

-- 
https://patchwork.kernel.org/patch/11627789/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

