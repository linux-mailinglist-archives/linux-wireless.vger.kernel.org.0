Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4438725A81B
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Sep 2020 10:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgIBI4H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Sep 2020 04:56:07 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:57554 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgIBI4G (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Sep 2020 04:56:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599036966; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=2ce2F4zRZYG8Jis1eewE/n2YwOCUGhGhznqE4MPxRnY=;
 b=w/4NwnKMXktJ3KY7C/2k+QXdHhYw44VbxyZOTthGe+x1rVpH/+kV4nWwRWz52raLkZlThzUV
 d8vgQ11BX8zPYss822hjr1YgUewmPGBj39SEwc7Oduow9PVtlZMRbd8Cf+xhiHX/TcSYEs+R
 P594xMcwo5DBuk0CwlH1SL5v9I8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f4f5e11cc683673f9d0ffd7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Sep 2020 08:55:45
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 813BEC433A1; Wed,  2 Sep 2020 08:55:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2FA0C433C9;
        Wed,  2 Sep 2020 08:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2FA0C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 03/10] wcn36xx: Add ieee802.11 VHT flags
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200829033846.2167619-4-bryan.odonoghue@linaro.org>
References: <20200829033846.2167619-4-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200902085545.813BEC433A1@smtp.codeaurora.org>
Date:   Wed,  2 Sep 2020 08:55:45 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> This patch adds ieee802.11 VHT flags for the wcn3680b.
> 
> - RX_STBC1
> - SU Beamformee
> - MU Beamformee
> - VHT80 SGI
> - Single spatial stream
> 
> RX LDPC is declared as supported in the datasheet but not enabled at this
> time.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Fails to apply. Please use ath.git master branch as the baseline.

error: patch failed: drivers/net/wireless/ath/wcn36xx/main.c:1212
error: drivers/net/wireless/ath/wcn36xx/main.c: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11743921/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

