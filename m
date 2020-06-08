Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632991F173E
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2020 13:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgFHLJj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Jun 2020 07:09:39 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:62063 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729439AbgFHLJh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Jun 2020 07:09:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591614576; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=2Ada7sZatggk3l3fjZBMFmKd/YZJ7FNHvvExJZSCofc=; b=ph48npScEtQz07XNv1j5UIpmVrJhxrB8WQWn1AWtDM+q0dQkI1zzZi8Wt7J7sFxe6leSupVs
 hztmT2tA8QqbPY3eXjHDos9ekwlg0CxbgXPWdfBsGt6lyA/CONVBE3Eo3mXZyj+5xKPSa45V
 3pWgwNNJY477z3cJW6Ewe5aSMkM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ede1c6460667f2e2f05f765 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Jun 2020 11:09:24
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2FDFEC433CB; Mon,  8 Jun 2020 11:09:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C878BC43387;
        Mon,  8 Jun 2020 11:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C878BC43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH 12/12] ath11k: set the multiple bssid hw cap
References: <20200604070952.15481-1-john@phrozen.org>
        <20200604070952.15481-13-john@phrozen.org>
Date:   Mon, 08 Jun 2020 14:09:18 +0300
In-Reply-To: <20200604070952.15481-13-john@phrozen.org> (John Crispin's
        message of "Thu, 4 Jun 2020 09:09:52 +0200")
Message-ID: <87ftb5ke5d.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> writes:

> This patch sets the SUPPORTS_MULTI_BSSID inside ath11k.
>
> Signed-off-by: John Crispin <john@phrozen.org>

On what hardware and firmware did you test this?

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

I wonder if this is a safe thing to do? Do all firmware branches use
these new values?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
