Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5381C335D
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 13:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfJALwX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 07:52:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49980 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfJALwX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 07:52:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0844E61633; Tue,  1 Oct 2019 11:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569930742;
        bh=n+y4PPDekV0tqUqeEIg/2Mq5y4LvdwkG6tXwjxCQWkw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=YmluIcSJxS1EzmXvD6+F8zbTQcX6/Lw9wx9JlCPvoIRzMGa7pUd9q88qcwhfMpvLc
         Kb79QFT4OovNVEIE0FQ/uipMN0UJ2mPl7FM90zoVqQyoMUbnQXUgGnyBLmXu8gf+el
         tqSGCmm5k1evSIiUvWjQIgZ7cr6TwA4TSOgbBU0U=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1CFE060112;
        Tue,  1 Oct 2019 11:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569930739;
        bh=n+y4PPDekV0tqUqeEIg/2Mq5y4LvdwkG6tXwjxCQWkw=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=bgAPJUuHhXjdbfnBUrqEH/ikR81O4iZOD7YrVHGxQVOPxYdU2q/K+RK4U60birAru
         KRgcUjeOJ/SvfVIT1bEM7nqNTGsjRfUf4v5QlobZePCa5i9rJNHFCNCxe9Ikbw/YXE
         18/yKKJJ4gLq0YxHhz8pz7KvttUZr/P7TqaJ5hlE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CFE060112
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath9k_htc: Modify byte order for an error message
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190927025146.2888-1-masashi.honma@gmail.com>
References: <20190927025146.2888-1-masashi.honma@gmail.com>
To:     Masashi Honma <masashi.honma@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com,
        Masashi Honma <masashi.honma@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191001115222.0844E61633@smtp.codeaurora.org>
Date:   Tue,  1 Oct 2019 11:52:21 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Masashi Honma <masashi.honma@gmail.com> wrote:

> rs_datalen is be16 so we need to convert it before printing.
> 
> Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

e01fddc19d21 ath9k_htc: Modify byte order for an error message
cd486e627e67 ath9k_htc: Discard undersized packets

-- 
https://patchwork.kernel.org/patch/11163655/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

