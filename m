Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7101A4500FE
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Nov 2021 10:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhKOJTJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 04:19:09 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:17748 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbhKOJTA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 04:19:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636967764; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=T8+RQzVfslpBOJviaoNoPaFLVCw6TxpqzDr9gTCLcrQ=;
 b=EqC8RgcicN+mWOPwXe4a8czaB+j4OgPHiLaJmWmR7EOsBEt0tLSPP4yR+NjSZwsrZwH6ywST
 l+3i53I6H0n6lv2Xh5IOnTDG415nLSPZVG2wP/4wESP5BJ88nBBnQwl6ABoMSa2ubokT99Ur
 mV7AWw3UCyc34BeKnTV6zUGNa8M=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 61922529a9c3e8b85b317965 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Nov 2021 09:15:21
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 36957C43618; Mon, 15 Nov 2021 09:15:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CB03DC4338F;
        Mon, 15 Nov 2021 09:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org CB03DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix fw crash due to peer get authorized before
 key
 install
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1636554200-12345-1-git-send-email-quic_periyasa@quicinc.com>
References: <1636554200-12345-1-git-send-email-quic_periyasa@quicinc.com>
To:     Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163696770288.20888.17754900524964884624.kvalo@codeaurora.org>
Date:   Mon, 15 Nov 2021 09:15:20 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Firmware expects host to authorize the peer after the successful key
> install. But host authorize the peer before the key install, this trigger
> the firmware assert which leads to Q6 crash. To avoid this Q6 crash, host
> should authorize the peer after the key install. So introduce is_authorized
> in peer object to identify that peer is authorize or not. When
> IEEE80211_STA_CONTROL_PORT flag is unset, peer move to authorize state
> before the vdev up. When the same flag is set then peer move to authorize
> state after vdev up. So added authorise check in ath11k_bss_assoc() to
> handle the earlier state transition case. Also added the WMI authorize
> procedure in ath11k_mac_op_sta_state() to handle the non-earlier state
> transition case.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01492-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

85f36923be47 ath11k: fix fw crash due to peer get authorized before key install

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1636554200-12345-1-git-send-email-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

