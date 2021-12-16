Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD30476EE9
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Dec 2021 11:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbhLPKbo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Dec 2021 05:31:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41884 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbhLPKbo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Dec 2021 05:31:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F14FAB82298;
        Thu, 16 Dec 2021 10:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F778C36AE4;
        Thu, 16 Dec 2021 10:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639650701;
        bh=TQcw2ql4+y5jLFCLm01cff+8HCYL6rNOGX6idQHMBkE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=UNdQpZZi6vcYo1n773/a33uW4GS12Gtq8ksLCj8vJ/jGJO+UQxxCudv5H2tLMkvpJ
         mUolIw/dvDbedOT9Vt/fz+0XtssNGYXLNOmLGgVoqfK8buiIvYBUHIfTd+a9cQDSMi
         pfR815PC6mu6+jTqKKNVtLabSxKRcNDBhH/vKp4cLCCoOlAT5VYTTg9ywW4bcHFkaZ
         z/M9SNyS2iOs8Kg1l9RrFajoil/C0KCFeVCcpidn3/HnrTLn0bytvhwGHGmxkFppXU
         uEbuzzRjk7KNAA4XQjHhRi5H42izKG46lF5EJxTp/CRL0xiLxzAhjG9eZXIyW9aN6F
         oB3a48OBYDgjQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, loic.poulain@linaro.org,
        benl@squareup.com
Subject: Re: [PATCH v3 3/3] wcn36xx: Implement downstream compliant beacon filtering
References: <20211214134630.2214840-1-bryan.odonoghue@linaro.org>
        <20211214134630.2214840-4-bryan.odonoghue@linaro.org>
Date:   Thu, 16 Dec 2021 12:31:36 +0200
In-Reply-To: <20211214134630.2214840-4-bryan.odonoghue@linaro.org> (Bryan
        O'Donoghue's message of "Tue, 14 Dec 2021 13:46:30 +0000")
Message-ID: <87ilvodenr.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:

> Downstream facilitates the direct programming of beacon filter tables via
> SMD commands.

I don't think the term downstream is clear for everyone, I guess with
that you mean the prima driver? I would prefer to use "prima driver" in
commit logs, I can change it and no need to resend because of this.

> --- a/drivers/net/wireless/ath/wcn36xx/hal.h
> +++ b/drivers/net/wireless/ath/wcn36xx/hal.h
> @@ -3468,6 +3468,23 @@ struct beacon_filter_ie {
>  	u8 ref;
>  } __packed;
>  
> +/* Downstream values for the bitmask field */
> +#define WCN36XX_FILTER_CAPABILITY_MASK		0x73cf
> +#define WCN36XX_FILTER_IE_DS_CHANNEL_MASK	0x00
> +#define WCN36XX_FILTER_IE_ERP_FILTER_MASK	0xF8
> +#define WCN36XX_FILTER_IE_EDCA_FILTER_MASK	0xF0
> +#define WCN36XX_FILTER_IE_QOS_FILTER_MASK	0xF0
> +#define WCN36XX_FILTER_IE_CHANNEL_SWITCH_MASK	0x00
> +#define WCN36XX_FILTER_IE_HT_BYTE0_FILTER_MASK	0x00
> +#define WCN36XX_FILTER_IE_HT_BYTE1_FILTER_MASK	0xF8
> +#define WCN36XX_FILTER_IE_HT_BYTE2_FILTER_MASK	0xEB
> +#define WCN36XX_FILTER_IE_HT_BYTE5_FILTER_MASK	0xFD
> +#define WCN36XX_FILTER_IE_PWR_CONSTRAINT_MASK	0x00
> +#define WCN36XX_FILTER_IE_OPMODE_NOTIF_MASK	0x00
> +#define WCN36XX_FILTER_IE_VHTOP_CHWIDTH_MASK	0xFC
> +#define WCN36XX_FILTER_IE_RSN_MASK		0x00
> +#define WCN36XX_FILTER_IE_VENDOR_MASK		0x00

TBH I don't see much value in the comment, there's only one set of
values, so I would like to remove it.

> --- a/drivers/net/wireless/ath/wcn36xx/smd.c
> +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
> @@ -3193,6 +3193,92 @@ int wcn36xx_smd_host_resume(struct wcn36xx *wcn)
>  	return ret;
>  }
>  
> +#define BEACON_FILTER(eid, presence, offs, val, mask, ref_val) \
> +	{					\
> +		.element_id = eid,		\
> +		.check_ie_presence = presence,	\
> +		.offset = offs,			\
> +		.value = val,			\
> +		.bitmask = mask,		\
> +		.ref = ref_val,			\
> +	}
> +
> +/* CORE/MAC/src/pe/lim/limSendMessages.c::beaconFilterTable[] */
> +static struct beacon_filter_ie bcn_filter_ies[] = {

I guess the comment refers to the prima driver, we shouldn't have that
in upstream. I can remove it.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
