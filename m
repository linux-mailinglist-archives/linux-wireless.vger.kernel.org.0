Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7AB14775EB
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Dec 2021 16:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238532AbhLPPa2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Dec 2021 10:30:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36388 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhLPPa2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Dec 2021 10:30:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 828B561E3D;
        Thu, 16 Dec 2021 15:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85519C36AE0;
        Thu, 16 Dec 2021 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639668626;
        bh=RDnK/K07NtTmO+k0mAmuN27towLm3zlyf2V+0+o0h1s=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=d/jNmwm5C/MkXK6E8htSzjZ2pD6aMFx3D8/e1AmU7vx1Sc0KMKSeaAL4TBsHcQB/A
         Kz1ZSTWQ7CZSSVS2OUwtAfUNjvYRr/qXm5nbK7621yoRepcsGo9GIQa+MXgXYMMGmQ
         nkVpYaUYSH4SOGdb3nlUoxw4+Ft1QKEfoClo7gPb0V9bA8Xg0hLlbCchaB0ONVM4qr
         JP+L4LtunHIUD/lCfIub3v23kc2ZJmgcZUVEXXd4XpXttVWDphKYsKfMTbsplsOxtt
         W9LhFZXfA4QbtFLd2hVdZfd7sK0gJbxf7lOKfumSw1/5kwyMfLIccMeNn1U6MK/xJL
         z4L+g5SMmivyw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, loic.poulain@linaro.org,
        benl@squareup.com
Subject: Re: [PATCH v3 3/3] wcn36xx: Implement downstream compliant beacon filtering
References: <20211214134630.2214840-1-bryan.odonoghue@linaro.org>
        <20211214134630.2214840-4-bryan.odonoghue@linaro.org>
Date:   Thu, 16 Dec 2021 17:30:22 +0200
In-Reply-To: <20211214134630.2214840-4-bryan.odonoghue@linaro.org> (Bryan
        O'Donoghue's message of "Tue, 14 Dec 2021 13:46:30 +0000")
Message-ID: <87wnk4bm9d.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:

> Downstream facilitates the direct programming of beacon filter tables via
> SMD commands.
>
> The purpose of beacon filters is quote:
>
> /* When beacon filtering is enabled, firmware will
>  * analyze the selected beacons received during BMPS,
>  * and monitor any changes in the IEs as listed below.
>  * The format of the table is:
>  *    - EID
>  *    - Check for IE presence
>  *    - Byte offset
>  *    - Byte value
>  *    - Bit Mask
>  *    - Byte reference
>  */
>
> The default downstream firmware filter table looks something like this:
> tBeaconFilterIe gaBcnFilterTable[12] =
> {
>   { WLAN_EID_DS_PARAMS, 0u, { 0u, 0u, 0u, 0u } },
>   { WLAN_EID_ERP_INFO, 0u, { 0u, 0u, 248u, 0u } },
>   { WLAN_EID_EDCA_PARAM_SET, 0u, { 0u, 0u, 240u, 0u } },
>   { WLAN_EID_QOS_CAPA, 0u, { 0u, 0u, 240u, 0u } },
>   { WLAN_EID_CHANNEL_SWITCH, 1u, { 0u, 0u, 0u, 0u } },
>   { WLAN_EID_QUIET, 1u, { 0u, 0u, 0u, 0u } },
>   { WLAN_EID_HT_OPERATION, 0u, { 0u, 0u, 0u, 0u } },
>   { WLAN_EID_HT_OPERATION, 0u, { 1u, 0u, 248u, 0u } },
>   { WLAN_EID_HT_OPERATION, 0u, { 2u, 0u, 235u, 0u } },
>   { WLAN_EID_HT_OPERATION, 0u, { 5u, 0u, 253u, 0u } },
>   { WLAN_EID_PWR_CONSTRAINT, 0u, { 0u, 0u, 0u, 0u } },
>   { WLAN_EID_OPMODE_NOTIF, 0u, { 0u, 0u, 0u, 0u } }
> };
>
> Add in an equivalent filter set as present in the downstream Linux driver.
> For now omit the beacon filter "rem" command as downstream does not have an
> explicit call to that SMD command. The filter mask should only count when
> we are inside BMPS anyway.
>
> Replicating the downstream ability to program the filter table gives us
> scope to add and remove elements in future. For now though this patch
> makes the rote-copy of the downstream Linux beacon filter table, which we
> can tweak as desired from now on.
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

[...]

> +static struct beacon_filter_ie bcn_filter_ies[] = {
> +	BEACON_FILTER(WLAN_EID_DS_PARAMS, 0, 0, 0,
> +		      WCN36XX_FILTER_IE_DS_CHANNEL_MASK, 0),
> +	BEACON_FILTER(WLAN_EID_ERP_INFO, 0, 0, 0,
> +		      WCN36XX_FILTER_IE_ERP_FILTER_MASK, 0),
> +	BEACON_FILTER(WLAN_EID_EDCA_PARAM_SET, 0, 0, 0,
> +		      WCN36XX_FILTER_IE_EDCA_FILTER_MASK, 0),
> +	BEACON_FILTER(WLAN_EID_QOS_CAPA, 0, 0, 0,
> +		      WCN36XX_FILTER_IE_QOS_FILTER_MASK, 0),
> +	BEACON_FILTER(WLAN_EID_CHANNEL_SWITCH, 1, 0, 0,
> +		      WCN36XX_FILTER_IE_CHANNEL_SWITCH_MASK, 0),
> +	BEACON_FILTER(WLAN_EID_HT_OPERATION, 0, 0, 0,
> +		      WCN36XX_FILTER_IE_HT_BYTE0_FILTER_MASK, 0),
> +	BEACON_FILTER(WLAN_EID_HT_OPERATION, 0, 2, 0,
> +		      WCN36XX_FILTER_IE_HT_BYTE2_FILTER_MASK, 0),
> +	BEACON_FILTER(WLAN_EID_HT_OPERATION, 0, 5, 0,
> +		      WCN36XX_FILTER_IE_HT_BYTE5_FILTER_MASK, 0),
> +	BEACON_FILTER(WLAN_EID_PWR_CONSTRAINT, 0, 0, 0,
> +		      WCN36XX_FILTER_IE_PWR_CONSTRAINT_MASK, 0),
> +	BEACON_FILTER(WLAN_EID_OPMODE_NOTIF, 0, 0, 0,
> +		      WCN36XX_FILTER_IE_OPMODE_NOTIF_MASK, 0),
> +	BEACON_FILTER(WLAN_EID_VHT_OPERATION, 0, 0, 0,
> +		      WCN36XX_FILTER_IE_VHTOP_CHWIDTH_MASK, 0),
> +	BEACON_FILTER(WLAN_EID_RSN, 1, 0, 0,
> +		      WCN36XX_FILTER_IE_RSN_MASK, 0),
> +	BEACON_FILTER(WLAN_EID_VENDOR_SPECIFIC, 1, 0, 0,
> +		      WCN36XX_FILTER_IE_VENDOR_MASK, 0),
> +};

All static variables should be const so I changed this to const as well.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
