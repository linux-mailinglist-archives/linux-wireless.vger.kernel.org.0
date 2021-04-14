Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C695035EDE5
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Apr 2021 08:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243063AbhDNG4I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Apr 2021 02:56:08 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:61397 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346593AbhDNGzi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Apr 2021 02:55:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618383317; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=O/9JmR/lSUgD4+YDVIxo/BnPhDCdjgMq/e3zKbchFDs=; b=nHTtu+8Wfi74ydSJEDwCDnFepvCIAPY2JY8gCrdqjkEHp9/UYwJmR4XxWOC9IOBzgYtfIdbW
 8QLjuEdlXlPutGJpYgWoZFyVYL4gRrHX1Q56cvX2JJ/5D8w+c59CpkgBNgvCNSfQY2y1Eg1F
 WqK3PpHTuqWprzWrPuNNCpUih3Q=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 607691c09a9ff96d956d1761 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 14 Apr 2021 06:54:56
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 92246C43463; Wed, 14 Apr 2021 06:54:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7B75AC43461;
        Wed, 14 Apr 2021 06:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7B75AC43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ramon Fontes <ramonreisfontes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
        davem@davemloft.net
Subject: Re: [PATCH] mac80211_hwsim: indicate support for 60GHz channels
References: <20210413010613.50128-1-ramonreisfontes@gmail.com>
Date:   Wed, 14 Apr 2021 09:54:52 +0300
In-Reply-To: <20210413010613.50128-1-ramonreisfontes@gmail.com> (Ramon
        Fontes's message of "Mon, 12 Apr 2021 22:06:13 -0300")
Message-ID: <87a6q1l5j7.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ramon Fontes <ramonreisfontes@gmail.com> writes:

> Advertise 60GHz channels to mac80211.

SoB missing:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#signed-off-by_missing

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
