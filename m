Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E27A40D658
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 11:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbhIPJhY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 05:37:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40075 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235417AbhIPJhY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 05:37:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631784963; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Dlno9iZgVTyWpqnJjOxv4E/8xZlHwmErWjAI6J5ici4=; b=op+c4B/1hedu3RO9gpVdrAbst8l1WDTPiMKXt0UUqcSl5dkx8cMViBaR6JIG1n3do+DdNftC
 qLtlE3obmCgpKVN30AjyYq38kt9dl6aYEz1jn/HewWrGyx2amelJP1ct7p2pRNH5qxD0XJzJ
 fI5X3JaElpSvF8LU4dDH0GH27tY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 61430ff6e0f78151d68fa0de (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Sep 2021 09:35:50
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6B3DEC4360C; Thu, 16 Sep 2021 09:35:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C5CFC4338F;
        Thu, 16 Sep 2021 09:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 4C5CFC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        Miles Hu <milehu@codeaurora.org>,
        Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Subject: Re: [PATCH 3/3] ath11k: monitor mode clean up to use separate APIs
References: <20210721162053.46290-1-jouni@codeaurora.org>
        <20210721162053.46290-4-jouni@codeaurora.org>
Date:   Thu, 16 Sep 2021 12:35:45 +0300
In-Reply-To: <20210721162053.46290-4-jouni@codeaurora.org> (Jouni Malinen's
        message of "Wed, 21 Jul 2021 19:20:53 +0300")
Message-ID: <87sfy4zwum.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> writes:

> From: Seevalamuthu Mariappan <seevalam@codeaurora.org>
>
> If monitor interface is enabled in co-exist mode, only local traffic are
> captured. It's caused by missing monitor vdev in co-exist mode. So,
> monitor mode clean up is done with separate Monitor APIs. For this,
> introduce monitor_started and monitor_vdev_created boolean flags.
>
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01725-QCAHKSWPL_SILICONZ-1

Seevalamuthu, in upstream IPQ8074 doesn't even support monitor mode:

static const struct ath11k_hw_params ath11k_hw_params[] = {
	{
		.hw_rev = ATH11K_HW_IPQ8074,
		.name = "ipq8074 hw2.0",
...
		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
					BIT(NL80211_IFTYPE_AP) |
					BIT(NL80211_IFTYPE_MESH_POINT),

So I wonder how did you test this? Is this something which is only
tested on ancient QSDK kernels and not with upstream kernels?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
