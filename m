Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B093B2533AB
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 17:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgHZP24 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 11:28:56 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31952 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbgHZP2z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 11:28:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598455734; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ROkLxWP4NzDyff/Tr9O4JChUSz/ZIMEUIJzNHeoRt2Q=;
 b=vuD6xqsW6Ki+RjFoASKTnq7wFpcG6j6hXqHjBlPJ2Fq5ta2VjcRtFf7hYKCG+e0z6BF1Ljj2
 uI9SKSN5rhLp9u0ApW8eh8GmWhyxMkfEGwoRKS9jRGhdDTiSYIThwAjCMGkRedy7DllKQF2/
 dQVolgZWrrA07wqufKcEJXkuI2M=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f467fb2e64cc21df805ff5d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 26 Aug 2020 15:28:50
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 24BE6C43387; Wed, 26 Aug 2020 15:28:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E373C433CB;
        Wed, 26 Aug 2020 15:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E373C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/36] wcn36xx: Add ability to identify WCN3680
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200803031132.1427063-2-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-2-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200826152849.24BE6C43387@smtp.codeaurora.org>
Date:   Wed, 26 Aug 2020 15:28:49 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> The WCN3680 has some specific behaviours that we want to capture to
> distinguish it from the WCN3620 and WCN3660 respectively.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

First 8 patches already failed to apply:

error: patch failed: drivers/net/wireless/ath/wcn36xx/txrx.c:272
error: drivers/net/wireless/ath/wcn36xx/txrx.c: patch does not apply
stg import: Diff does not apply cleanly

8 patches set to Changes Requested.

11696999 [01/36] wcn36xx: Add ability to identify WCN3680
11697001 [02/36] wcn36xx: Add ieee802.11 VHT flags
11697003 [03/36] wcn36xx: Add 802.11ac MCS rates
11697005 [04/36] wcn36xx: Specify ieee80211_rx_status.nss
11697007 [05/36] wcn36xx: Add 802.11ac HAL param bitfields
11697009 [06/36] wcn36xx: Add Supported rates V1 structure
11697011 [07/36] wcn36xx: Use existing pointers in wcn36xx_smd_config_bss_v1
11697013 [08/36] wcn36xx: Set feature DOT11AC for wcn3680

-- 
https://patchwork.kernel.org/patch/11696999/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

