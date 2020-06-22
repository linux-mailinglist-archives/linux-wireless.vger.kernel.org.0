Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820B92039D2
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 16:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgFVOpk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 10:45:40 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:34828 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728293AbgFVOpj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 10:45:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592837139; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=cNXPHmIlXcSkC7ANXNOGHfDbNK9npeVRcpkoD5hWORc=; b=m3xdCAQhVQwFX73h8m5ZwbVkt7a63e1ATiEAJKhrdyICfEOm7YgnkG5doEdNLgPOVYYjPAaM
 RK4aO4F78feDTDRwaB3Gk99vhCMrBU3yL4yg2B9zAQLn7F11vFAO1GUTIkY5KHhWtETIOAIf
 BlKCDCcs1qQMjtaU/Waxf7i1oj8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5ef0c410bfb34e631cff02ca (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jun 2020 14:45:36
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3C192C433C6; Mon, 22 Jun 2020 14:45:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9F3F0C433CA;
        Mon, 22 Jun 2020 14:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F3F0C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH 3/3] ath11k: add support for BSS coloring
References: <20200617150021.4183253-1-john@phrozen.org>
        <20200617150021.4183253-3-john@phrozen.org>
Date:   Mon, 22 Jun 2020 17:45:31 +0300
In-Reply-To: <20200617150021.4183253-3-john@phrozen.org> (John Crispin's
        message of "Wed, 17 Jun 2020 17:00:21 +0200")
Message-ID: <87h7v3f9bo.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> writes:

> Whenever the MAC detects a color collision or any of its associated station
> detects one the FW will send out an event. Add the code to parse and handle
> this event. and pass the data up to mac80211.
>
> The FW does not provide an offload future such as the one used for CSA. The
> CCA process is hence triggered via the beacon offload tx completion events
> sent out by the FW.
>
> Signed-off-by: John Crispin <john@phrozen.org>

On what hardware and firmware did you test this? I'll add that to the
commit log.

> +	if (ev->obss_color_bitmap & BIT(arvif->vif->bss_conf.he_bss_color.color)) {
> +		/* FW sometime sends out stray events. Ignore them if our color is free */
> +		ieeee80211_obss_color_collision_notify(arvif->vif, ev->obss_color_bitmap);
> +
> +		ath11k_info(ab, "OBSS color collision detected vdev:%d, event:%d, bitmap:%08llx\n",
> +			    ev->vdev_id, ev->evt_type, ev->obss_color_bitmap);
> +	}

Is this really something so important that we should print it to the
log? What should the user do after seeing this warning?

And warnings should be printed with ath11k_warn(), but maybe this should
be a debug message?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
