Return-Path: <linux-wireless+bounces-8059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E2A8CEE48
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 11:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D161C20B15
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 09:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781E3171CC;
	Sat, 25 May 2024 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wwvbsh3k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D38D11182;
	Sat, 25 May 2024 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716628526; cv=none; b=CjbYjMijeA+Srllp6gUyFK42ioXhw9LKDD0MxBV6Td3pfYdk+8f2nYl8m85W1ltkOC08S3pJInD6E8D13c3IPp25NZYsmGev9c2tmxPZwH7X8yklgB5Ymp3vbDCsxd5WaCnCwA5U4W5g9/fjzCKIizxs3joiuYOsNgBxDDiyi5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716628526; c=relaxed/simple;
	bh=5O/2NC0ZC7GcRUeBdQJ7keatQdN3MPSj+yKACm9w/bY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=nvsDSXtpGGucQPkebvpdYyvJGxsTpBBcosSu/M2fO605ztLhSsvzx8q9ID04IWU57KHi4lFbjpAfReATEMcD70elI+B5gIG/O0aT0AvWi18/pphzDGZWp6kIUZo/o8DaH47AA9Ol3t3wMexXfXW+h/14cKDIpyiYbUGhccPznR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wwvbsh3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862B3C3277B;
	Sat, 25 May 2024 09:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716628525;
	bh=5O/2NC0ZC7GcRUeBdQJ7keatQdN3MPSj+yKACm9w/bY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Wwvbsh3knDF/5OUwzPLF5qmCgGV8DcWpLnoh5yOkOB/PxO30EL+7YAnlzbjbL9ZHc
	 noWzpExjaTkoMH94gFrccXbHliuBEQ1BdLJyJX9LGktBTeF/SPFcWUSbR1pYodHPbz
	 mp0YsrNHdzgdQuROQSBtHhtIW93uovkNBQhocPepWR1Uh1Ouo9kcYOd7eiQ+fegUvI
	 ulWO/+GLe2VdGm3zXvvBHZXBzimTi84PRgRFUqWzC97fCEto03amo1qRCX8QTrR+QO
	 deb9U82753rQekX13nonWqvnQ3k9iQPS6dHlgWAl5nZnNIJPYr+86maWnX2/7tZAmW
	 6kXPSXVrWdkQA==
From: Kalle Valo <kvalo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,  Brian
 Norris <briannorris@chromium.org>,  Francesco Dolcini
 <francesco@dolcini.it>,  David Lin <yu-hao.lin@nxp.com>
Subject: Re: [PATCH] wifi: mwifiex: fix parsing of more than two AKM suites
References: <20240523081428.2852276-1-s.hauer@pengutronix.de>
Date: Sat, 25 May 2024 12:15:22 +0300
In-Reply-To: <20240523081428.2852276-1-s.hauer@pengutronix.de> (Sascha Hauer's
	message of "Thu, 23 May 2024 10:14:28 +0200")
Message-ID: <878qzyntg5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sascha Hauer <s.hauer@pengutronix.de> writes:

> params->crypto.n_akm_suites seems to be limited to two AKM suites. Once
> there are more they will be passed as extra elements of type WLAN_EID_RSN
> or WLAN_EID_VENDOR_SPECIFIC.
>
> This takes some snippets from the downstream vendor driver to parse
> these elements and to set the correct protocol and key_mgmt bits to
> enable the desired key managements algorithms in the hardware.
>
> This patch is not a request for inclusion, more a heads up that there's
> something missing and the question if the approach taken is the right
> one or if there are other preferred ways to fix this issue.

Please mark patches like this as "[PATCH RFC]", that way we maintainers
know to drop them automatically.

> --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> @@ -9,6 +9,112 @@
>  #include "11ac.h"
>  #include "11n.h"
>  
> +struct wpa_suite_ucast {
> +        /* count */
> +        u16 count;
> +        /** wpa_suite list */
> +	__be32 suite[1];
> +} __packed;

The comments here are not adding any extra information, please remove.

In general having a some kind of prefix in the struct name would be
nice. I don't know what mwifiex uses (if any) but, for example, in
ath12k we use 'ath12k_'.

> +struct IEEEtypes_Rsn_t {

Lower case, no '_t' and also improve the naming.

> +        /** Rsn : version */
> +        u16 version;
> +        /** Rsn : group cipher */
> +        __be32 group_cipher;
> +        /** Rsn : pairwise cipher */
> +        struct wpa_suite_ucast pairwise_cipher;
> +} __packed;

Useless comments.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

