Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B5E278E6D
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 18:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgIYQ3T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 12:29:19 -0400
Received: from z5.mailgun.us ([104.130.96.5]:53548 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbgIYQ3T (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 12:29:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601051358; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=NjK4owSULU8JHvRatopntT5qz1N0FLAoZnC+e4pzxjE=; b=Cx1FCn2BZvPk0tDmYaDwVFWaVTjMBp+F4uArH/wmJg+UMoPhcVKarGECX9iR2EQ2EbnOVb5R
 h058zH9tGxjT+FXaqHJhWqvloTva2N7nBMTkkHdeg9/NtzKduSy/cl5ab0zO1aJaw5oE0PjD
 JdYcvc9PpVHs+YU3BAb8HQ4upek=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f6e1aded106659f82b418e9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 25 Sep 2020 16:29:18
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 11118C433FE; Fri, 25 Sep 2020 16:29:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 65D5FC433CA;
        Fri, 25 Sep 2020 16:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65D5FC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <tehuang@realtek.com>
Cc:     <yhchuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 5/5] rtw88: show current regulatory in tx power table
References: <20200925061219.23754-1-tehuang@realtek.com>
        <20200925061219.23754-6-tehuang@realtek.com>
Date:   Fri, 25 Sep 2020 19:29:14 +0300
In-Reply-To: <20200925061219.23754-6-tehuang@realtek.com>
        (tehuang@realtek.com's message of "Fri, 25 Sep 2020 14:12:19 +0800")
Message-ID: <87mu1dg6qt.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<tehuang@realtek.com> writes:

> From: Tzu-En Huang <tehuang@realtek.com>
>
> In the transmit power table, it is important to know what the regulatory
> currently is. For different regulatories, there are different
> transmit power limits. Show which regulatory the driver is currently
> using.
>
> Change-Id: Id92aa6a833053fbf0b065c9ff946d7d4722897fd

No Change-Id tags, but I can remove it during commit. No need to resend
just because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
