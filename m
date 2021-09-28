Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BF141AD6B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 12:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbhI1K6X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 06:58:23 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:36746 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240288AbhI1K6W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 06:58:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632826603; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=kgc6bVZtUMzywqUnKIJwEJJLvR6lppnN1wOHpjT4trU=;
 b=RMntBy6mYCM8OhhvP5it6WyJvCRdd+r+0Fjgv3Wt6JMS87wayqcuREL8ANRMENJOxUYZK3dS
 gAqUop6Lfguj6tTDe15ZvJSylhJyWbnYlEeMImd2uUbeokxCrylD75qOFY70sGOYAIiw7Vn2
 XoATwvipR6Df7K8aYywQuIfbfv4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6152f4ea3cc3a01f262d8f8f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 10:56:42
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5651CC43460; Tue, 28 Sep 2021 10:56:42 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7B19DC4338F;
        Tue, 28 Sep 2021 10:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 7B19DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Add support for RX decapsulation offload
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210721204217.120572-1-jouni@codeaurora.org>
References: <20210721204217.120572-1-jouni@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sriram R <srirrama@codeaurora.org>,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210928105642.5651CC43460@smtp.codeaurora.org>
Date:   Tue, 28 Sep 2021 10:56:42 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> wrote:

> Add support for rx decapsulation offload by advertising
> the support to mac80211 during registration. Also ensure
> the frames have the RX_FLAG_8023 flag set in decap offload
> frames before passing to mac80211.
> 
> Since the packets delivered to the driver are in 802.3 format, these
> can be sent to the network core with minimal processing in mac80211.
> This helps in releasing some CPU cycles in the host processor and
> thereby improving the performance.
> 
> Two exceptions are made before passing decap frames, one is
> for EAPOL packets since mac80211 8023 fast rx for the sta
> is set only after authorization, other case is for multicast
> packets to validate PN in mac80211. In both the cases the
> decap frames are converted to 80211 frame and sent to mac80211.
> 
> Ethernet decap can be enabled by using frame_mode modparam:
> 
> insmod ath11k frame_mode=2
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00844-QCAHKSWPL_SILICONZ-1 v2
> 
> Co-developed-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
> Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
> Signed-off-by: Sriram R <srirrama@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

2167fa606c0f ath11k: Add support for RX decapsulation offload

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210721204217.120572-1-jouni@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

