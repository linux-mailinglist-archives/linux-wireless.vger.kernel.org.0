Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121DD41AFFB
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 15:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbhI1NZO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 09:25:14 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:47263 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240576AbhI1NZM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 09:25:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632835413; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=WBk27qcFzuvtnx+A0S6t+bXXtqabwrqjpgZSb+TuFyE=;
 b=EALUwEr8fybjNLOdpO4DfwURvnqwuoHtWWsEAUqkRVXquPREkDBPKWuYUoJVYR62ngDhHPnI
 2cOv8FpmMAQiY4GOPX1UPOM3fmugVhaXNt4mQ3FcENnvYWMshPiJYh4fiZVhJed/RWLDvUDx
 VwQE44FRsMotaSGlKgg3Plaf6wQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 615317221abbf21d34faa90c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 13:22:42
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3B736C4360C; Tue, 28 Sep 2021 13:22:41 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B6BAC4338F;
        Tue, 28 Sep 2021 13:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 8B6BAC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] ath11k: re-enable ht_cap/vht_cap for 5G band for
 WCN6855
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210804181217.88751-2-jouni@codeaurora.org>
References: <20210804181217.88751-2-jouni@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Wen Gong <wgong@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210928132241.3B736C4360C@smtp.codeaurora.org>
Date:   Tue, 28 Sep 2021 13:22:41 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> wrote:

> WCN6855 uses single_pdev_only, so it supports both the 5G and 6G bands
> in the same ath11k/pdev and it needs to enable ht_cap/vht_cap for the 5G
> band, otherwise it will downgrade to non-HT mode for the 5G band. Some
> chips like QCN9074 only support the 6G band, not the 5G band, and use
> the flag ar->supports_6ghz which is true to discard ht_cap/vht_cap.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

3 patches applied to ath-next branch of ath.git, thanks.

54f40f552afd ath11k: re-enable ht_cap/vht_cap for 5G band for WCN6855
74bba5e5ba45 ath11k: enable 6G channels for WCN6855
0f17ae43823b ath11k: copy cap info of 6G band under WMI_HOST_WLAN_5G_CAP for WCN6855

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210804181217.88751-2-jouni@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

