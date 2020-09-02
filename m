Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8778925A807
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Sep 2020 10:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIBIti (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Sep 2020 04:49:38 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:63287 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgIBIth (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Sep 2020 04:49:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599036577; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=I0iYqSQa3db+7uh9desXLHZ4fjXnW/jbFK7U1Rw2W5o=;
 b=j9jlg1aYWL1Bamk5E7bCosmxRx/xFEkBiiwwFyCGr0GqTyUSISUQtOnaZfqWOLchgv38g899
 6lf8rLm56InGGNghb87pI37uwd4tRhNXDBiJh95Lz21KNhqg4/NE1sxaDXWHzwjkVuZFSJhC
 37QDlpG8W/M5CFwCgQtAo7PPIbc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f4f5c98ba408b30ce798622 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Sep 2020 08:49:28
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5359DC433C9; Wed,  2 Sep 2020 08:49:27 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 74E7BC433C9;
        Wed,  2 Sep 2020 08:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 74E7BC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/10] wcn36xx: Add a chip identifier for WCN3680
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200829033846.2167619-2-bryan.odonoghue@linaro.org>
References: <20200829033846.2167619-2-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200902084927.5359DC433C9@smtp.codeaurora.org>
Date:   Wed,  2 Sep 2020 08:49:27 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> The WCN3680 has some specific behaviours that we want to capture to
> distinguish it from the WCN3620 and WCN3660 respectively.
> 
> Add an identifier for this purpose.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

9 patches applied to ath-next branch of ath.git, thanks.

034f0befc1ff wcn36xx: Add a chip identifier for WCN3680
8490987bdb9a wcn36xx: Hook and identify RF_IRIS_WCN3680
10630b150bd6 wcn36xx: Add 802.11ac MCS rates
6ea131acea98 wcn36xx: Fix warning due to bad rate_idx
1af05d43b9be wcn36xx: Specify ieee80211_rx_status.nss
ff11d0c96a6d wcn36xx: Add 802.11ac HAL param bitfields
8f454b2ffb25 wcn36xx: Add Supported rates V1 structure
f32248a7a257 wcn36xx: Use existing pointers in wcn36xx_smd_config_bss_v1
dfe92b6206f5 wcn36xx: Set feature DOT11AC for wcn3680

-- 
https://patchwork.kernel.org/patch/11743917/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

