Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C211F610F
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2020 06:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgFKEop (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jun 2020 00:44:45 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:55945 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726316AbgFKEoo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jun 2020 00:44:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591850684; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ikzb0AXHT7wF27xmYg2wkPWoCDmWqzTZNOfugibW4pk=;
 b=foF0HlmViuxh5YYVmLL9KLMgAmMvRlSgg/BIxbhrZpfpk7Qaar11i5Jzin87CwPjPG6W2n0E
 qVKuQV8xq/HvNWMtlc5eifsaoGGB2YZMFltFLM2a9TrTyJcgMEp5KF3+UcmLKEy9pkSjVbz2
 zAyogRuGe9z36Z2IKqHT7HTUYrQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5ee1b6974c9690533a2985ce (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Jun 2020 04:44:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 97DF0C433CB; Thu, 11 Jun 2020 04:44:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EFFB1C433CA;
        Thu, 11 Jun 2020 04:44:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Jun 2020 21:44:06 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 12/12] ath11k: set the multiple bssid hw cap
In-Reply-To: <20200604070952.15481-13-john@phrozen.org>
References: <20200604070952.15481-1-john@phrozen.org>
 <20200604070952.15481-13-john@phrozen.org>
Message-ID: <feb3d62d0c2ec9934c03a35779bcc4c3@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-06-04 00:09, John Crispin wrote:
> This patch sets the SUPPORTS_MULTI_BSSID inside ath11k.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> 
[...]

> diff --git a/drivers/net/wireless/ath/ath11k/wmi.h
> b/drivers/net/wireless/ath/ath11k/wmi.h
> index 548fa05cb1f6..14cffda43ed0 100644
> --- a/drivers/net/wireless/ath/ath11k/wmi.h
> +++ b/drivers/net/wireless/ath/ath11k/wmi.h
> @@ -109,8 +109,8 @@ enum {
> 
>  enum {
>  	WMI_HOST_VDEV_FLAGS_NON_MBSSID_AP	= 1,
> -	WMI_HOST_VDEV_FLAGS_TRANSMIT_AP		= 2,
> -	WMI_HOST_VDEV_FLAGS_NON_TRANSMIT_AP	= 4,
> +	WMI_HOST_VDEV_FLAGS_NON_TRANSMIT_AP	= 2,
> +	WMI_HOST_VDEV_FLAGS_TRANSMIT_AP		= 4,
>  };
> 
John,

Not sure how you got the above values? Please confirm.

#define VDEV_FLAGS_NON_MBSSID_AP      0x00000001   /* legacy AP */
#define VDEV_FLAGS_TRANSMIT_AP        0x00000002   /* indicate if this 
vdev is transmitting AP */
#define VDEV_FLAGS_NON_TRANSMIT_AP    0x00000004   /* explicitly 
indicate this vdev is non-transmitting AP */
#define VDEV_FLAGS_EMA_MODE           0x00000008   /* vdev is EMA and 
supports multiple beacon profiles. */

-Rajkumar
