Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFAC2845BB
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Oct 2020 08:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgJFGAt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Oct 2020 02:00:49 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:39253 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgJFGAs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Oct 2020 02:00:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601964048; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=GEBAQe0uEWkdwcHsB20EVKa51WOgqdYNx1/GyRQ0Jsk=; b=JlseUpiDKzyBz1zJmgz6yfr8GPdUvWcJ6QNlxW6sjOVnkazGUOR5+s3r339k8UhqUW+d5oVn
 YymE+koBiGSyXX54tRrwTYEpH+OtBV5Sefdkq75p+morJWaL40FHQA9ieiW4Kf5lvy7F3E/l
 wHnp3WOv4hXmt0sUkEfp/Lw9jNU=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f7c080fad37af35ec6d196c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 06 Oct 2020 06:00:47
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5320BC433F1; Tue,  6 Oct 2020 06:00:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B35EAC433C8;
        Tue,  6 Oct 2020 06:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B35EAC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wright Feng <wright.feng@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        chi-hsien.lin@cypress.com, Kurt Lee <kurt.lee@cypress.com>
Subject: Re: [PATCH] brcmfmac: Support DPP feature
References: <20201005070857.83974-1-wright.feng@cypress.com>
Date:   Tue, 06 Oct 2020 09:00:42 +0300
In-Reply-To: <20201005070857.83974-1-wright.feng@cypress.com> (Wright Feng's
        message of "Mon, 5 Oct 2020 02:08:57 -0500")
Message-ID: <87tuv7c2r9.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wright Feng <wright.feng@cypress.com> writes:

> From: Kurt Lee <kurt.lee@cypress.com>
>
> Let driver parse DPP frames from upper layer and do corresponding
> configuration to firmware.
>
> Signed-off-by: Kurt Lee <kurt.lee@cypress.com>

Wright's s-o-b missing.

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#signed-off-by_missing

> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -63,6 +63,9 @@
>  #define RSN_CAP_MFPC_MASK		BIT(7)
>  #define RSN_PMKID_COUNT_LEN		2
>  
> +#define DPP_AKM_SUITE_TYPE		2
> +#define WLAN_AKM_SUITE_DPP		SUITE(WLAN_OUI_WFA, DPP_AKM_SUITE_TYPE)

Shouldn't these be in include/linux/ieee80211.h?

> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
> @@ -233,6 +233,11 @@ static inline bool ac_bitmap_tst(u8 bitmap, int prec)
>  
>  #define WPA3_AUTH_SAE_PSK	0x40000	/* SAE with 4-way handshake */
>  
> +#define WFA_AUTH_DPP		0x200000 /* WFA DPP AUTH */

I assume this is Broadcom specific and this is the correct file for this
define. Please correct me if I'm wrong.

> +#define WFA_OUI			"\x50\x6F\x9A"	/* WFA OUI */

You should use this:

include/linux/ieee80211.h:#define WLAN_OUI_WFA                  0x506f9a

> +#define DPP_VER			0x1A	/* WFA DPP v1.0 */

Shouldn't this be also in include/linux/ieee80211.h?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
