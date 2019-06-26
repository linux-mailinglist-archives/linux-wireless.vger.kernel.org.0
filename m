Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4584356D56
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2019 17:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfFZPKp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jun 2019 11:10:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43240 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZPKp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jun 2019 11:10:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 76CD660A50; Wed, 26 Jun 2019 15:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561561844;
        bh=8KTQAVNgQityLHOCSnNODF4aO9ffTUehNM9DE1ZMAkA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=X5XG1r2Rgsrq2CqTkCNi0/ii1CF+zWewF/Ep/RK3StUILua5IaDscLNpYVlmwOQ2+
         jllZD5mYZj1Za4UAoD4orN2ftCcFRE62w0O1fPR0kkgozw4rtKrN846BF4bJLoocsE
         t7cM0txqMTyiVKfoRxMeqb0/PaVRr4J9ZVo2qp9U=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 75B04607DE;
        Wed, 26 Jun 2019 15:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561561844;
        bh=8KTQAVNgQityLHOCSnNODF4aO9ffTUehNM9DE1ZMAkA=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=kjRHDAllCFaZSS9QlHzzyQfDMb39OgCq6QW679DetQ/Z4biWvuli/ZXnjBB18lu/k
         XB/Dveltb9oJMQJfSDrQFJ3NAUC04rmT51xXs5rELbZ7IwUnTuMbj1/jACq4NGNOna
         lrKRp+SD2nbPT8CoijqJ3aFx+hSOseJxh4d6jXPw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75B04607DE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath: fix SPDX tags
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1561474345-1439-1-git-send-email-kvalo@codeaurora.org>
References: <1561474345-1439-1-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190626151044.76CD660A50@smtp.codeaurora.org>
Date:   Wed, 26 Jun 2019 15:10:44 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> Commit ec8f24b7faaf ("treewide: Add SPDX license identifier -
> Makefile/Kconfig") marked various Makefiles and Kconfig files within ath
> directories as GPL-2.0. But these modules and drivers are actually ISC:
> 
> * ath
> * ar5523
> * ath10k
> * ath5k
> * ath6kl
> * ath9k
> * wcn36xx
> * wil6210
> 
> Fix SPDX tags accordingly.
> 
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to wireless-drivers.git, thanks.

e780d22757fb ath: fix SPDX tags

-- 
https://patchwork.kernel.org/patch/11015875/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

