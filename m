Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898963D9180
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jul 2021 17:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbhG1PEm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jul 2021 11:04:42 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:27986 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237157AbhG1PCm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jul 2021 11:02:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627484561; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=NE4Uf2LzvBa7qL1Cs7t6CG96ltNpdf3BjEAB2BHvn9U=;
 b=Aw54OS4755Obn/4p9hnQj259k5IlPGx7M3DJtQ/0oBDjZqWTlOMVd5JaTF6bpTT0PhU+DYcE
 Qt3CRVPXGUSRgJagGbr0p+jnF5y4xlu16959A3aFVXVPQOW4fvpx9YCkN0ozsm4TrOKOisyr
 FOhyqf9gI7WepEsIzdEG3HDy20U=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6101715d9771b05b24601f18 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 28 Jul 2021 15:01:49
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E9447C4338A; Wed, 28 Jul 2021 15:01:48 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4CC8FC433F1;
        Wed, 28 Jul 2021 15:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4CC8FC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5.14 1/2] iwlwifi: add new SoF with JF devices
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210719144523.0545d8964ff2.I3498879d8c184e42b1578a64aa7b7c99a18b75fb@changeid>
References: <20210719144523.0545d8964ff2.I3498879d8c184e42b1578a64aa7b7c99a18b75fb@changeid>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Yaara Baruch <yaara.baruch@intel.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210728150148.E9447C4338A@smtp.codeaurora.org>
Date:   Wed, 28 Jul 2021 15:01:48 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> wrote:

> From: Yaara Baruch <yaara.baruch@intel.com>
> 
> Add new SoF JF devices to the driver.
> 
> Signed-off-by: Yaara Baruch <yaara.baruch@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

2 patches applied to wireless-drivers.git, thanks.

a5bf1d4434b9 iwlwifi: add new SoF with JF devices
891332f697e1 iwlwifi: add new so-jf devices

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210719144523.0545d8964ff2.I3498879d8c184e42b1578a64aa7b7c99a18b75fb@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

