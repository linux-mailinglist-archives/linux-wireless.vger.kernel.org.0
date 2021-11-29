Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7BB461B4C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 16:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhK2PwN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 10:52:13 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:39519 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbhK2PuG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 10:50:06 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638200808; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=vZUaxIxdjFlhWiYowHvoa+o2WN9GNEEMMdBJfyVcvgQ=;
 b=QmkXDBcFw4KuLO4KuPH0gvIqPJuwa6Gh9D2hiDjGd9W/Wp18mNWF4dRJfm3Ft76Ao3JcusHx
 87XHXvo/fLn1UdbXHajDD2fjAdf4Snb/7fNCxQkFzBJqIdK9OKWkGYabtlvDupVHOSC30Dac
 BUR4H1c/wIzVWfa8+V+8qjLw/Jw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 61a4f5e786d0e4d8889799b8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Nov 2021 15:46:47
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2D4E1C4360C; Mon, 29 Nov 2021 15:46:47 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AB28BC4338F;
        Mon, 29 Nov 2021 15:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org AB28BC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Avoid NULL ptr access during mgmt tx cleanup
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1637832614-13831-1-git-send-email-quic_srirrama@quicinc.com>
References: <1637832614-13831-1-git-send-email-quic_srirrama@quicinc.com>
To:     Sriram R <quic_srirrama@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Sriram R <quic_srirrama@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163820080368.7221.13211393859054966547.kvalo@codeaurora.org>
Date:   Mon, 29 Nov 2021 15:46:47 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sriram R <quic_srirrama@quicinc.com> wrote:

> Currently 'ar' reference is not added in skb_cb during
> WMI mgmt tx. Though this is generally not used during tx completion
> callbacks, on interface removal the remaining idr cleanup callback
> uses the ar ptr from skb_cb from mgmt txmgmt_idr. Hence
> fill them during tx call for proper usage.
> 
> Also free the skb which is missing currently in these
> callbacks.
> 
> Crash_info:
> 
> [19282.489476] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [19282.489515] pgd = 91eb8000
> [19282.496702] [00000000] *pgd=00000000
> [19282.502524] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> [19282.783728] PC is at ath11k_mac_vif_txmgmt_idr_remove+0x28/0xd8 [ath11k]
> [19282.789170] LR is at idr_for_each+0xa0/0xc8
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00729-QCAHKSWPL_SILICONZ-3 v2
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

a93789ae541c ath11k: Avoid NULL ptr access during mgmt tx cleanup

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1637832614-13831-1-git-send-email-quic_srirrama@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

