Return-Path: <linux-wireless+bounces-30016-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91993CD2878
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 07:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 089C93018D71
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 06:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDEF2F25F8;
	Sat, 20 Dec 2025 06:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIKl6yP1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A361F131A;
	Sat, 20 Dec 2025 06:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766210875; cv=none; b=pvSBcKaVY0V0rr2cp77j9h04DJ76TKPrM3SXePQB0C07Gwfau+bbDkXtnGk9jsFqi9S+H/PQpF2E5+zUXtYN63791V90hor20xI8snOBWwqx+yf2C9v53gR15UkLF43VnIw/n2Rj0JMCpgwmTJTb1C9pAUUnmnWAsyPnV/HeR6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766210875; c=relaxed/simple;
	bh=VX0dE+JZYIwLPwmtZYo3MjEeyWBbD/TEvkAunGo1edE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=coI4ZIk3CNjpcgngn+sb7D9UDKyQCIJdxbNoKKd26qeQgpsisg4uF+PYnW/cf02ZI4vChZsg10wFkjDWxWzV688ZS2haLNtem44thjpt6Z2xphcP8YJDQXx7LI8QlexPToAzv2F3dmxjyK2wNzxpksy6k4W87DaPYjhXaP/SoBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIKl6yP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EFEC4CEF5;
	Sat, 20 Dec 2025 06:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766210875;
	bh=VX0dE+JZYIwLPwmtZYo3MjEeyWBbD/TEvkAunGo1edE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DIKl6yP1ICX3q2p7ewS25HLugEAtwBK0udFePyVqZqLFEjdjPmpM3VrvaOxUoWQl/
	 ne3Az7vvEsSPVYVWVPH9kbWZ4wXauVhttJuoQ2BwRCX0Ms9VtFIvoS1JOo+QWi0+5K
	 H9w2qVj5/8dztmVvhtFSnwmHmiPXP3KMPySNveeFFCq3B1cdBFpxEsrzrKMWqG/F0A
	 xPUtzEngVul7KtFHPB8trk1WA64KyciQNwvonO9ZF7pHXqBZUhizpE8qSmbY7GC2Z2
	 4N3P2txnfhyVcBtOrHO3iQkjEzucZsgyz/FzQT2oOjed1Csvf0j3fnwv/WuMwRfSZz
	 4PvxZJFtTju0g==
Message-ID: <37b947bc-ae54-49ef-bac6-1ec13772d03f@kernel.org>
Date: Sat, 20 Dec 2025 06:07:49 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] wifi: ath12k: Add support for disabling rfkill via
 devicetree
To: jerome.debretagne@gmail.com, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jeff Johnson <jjohnson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, ath12k@lists.infradead.org,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Dale Whinham <daleyo@gmail.com>
References: <20251220-surface-sp11-for-next-v5-0-16065bef8ef3@gmail.com>
 <L8oRgLxJXJOSFskrI_YHusMp-Hx1nToNTGzEAuYfFmvK_uyJ0tJiJbXOQTcwHMbWOHTKcRws9ehpNIEZhAfWng==@protonmail.internalid>
 <20251220-surface-sp11-for-next-v5-7-16065bef8ef3@gmail.com>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-US
In-Reply-To: <20251220-surface-sp11-for-next-v5-7-16065bef8ef3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/12/2025 00:22, Jérôme de Bretagne via B4 Relay wrote:
> From: Dale Whinham <daleyo@gmail.com>
> 
> Some devices (e.g. Microsoft Surface Pro 11) indicate that the rfkill
> feature should be disabled by means of an ACPI bitflag.
> 
> If ACPI is not being used (i.e. booting using a devicetree) then this
> property will not be read and therefore rfkill may be enabled and
> the ath12k will be hard-blocked with no way to disable it.
> 
> Add a devicetree property that allows to disable the rfkill feature.
> 
> Signed-off-by: Dale Whinham <daleyo@gmail.com>
> Tested-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> ---
>   drivers/net/wireless/ath/ath12k/core.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index cc352eef1939937ce902bee2fbd9737ca3ab5993..e10073bb975cfd2e9ee418edcc49d0d51cf93de1 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -77,6 +77,9 @@ static int ath12k_core_rfkill_config(struct ath12k_base *ab)
>   	if (ath12k_acpi_get_disable_rfkill(ab))
>   		return 0;
> 
> +	if (of_property_read_bool(ab->dev->of_node, "disable-rfkill"))
> +		return 0;
> +
>   	for (i = 0; i < ab->num_radios; i++) {
>   		ar = ab->pdevs[i].ar;
> 
> 
> --
> 2.47.3
> 
> 
> 

Just maintain a list of devices with the quirk. disable-rfkill won't fly 
because it doesn't describe hardware and DT != ACPI that way.

---
bod

