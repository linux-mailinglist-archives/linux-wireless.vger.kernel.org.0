Return-Path: <linux-wireless+bounces-30015-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8039CD285F
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 07:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C425130164FA
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 06:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F9A2BEC4A;
	Sat, 20 Dec 2025 06:04:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F071547E7;
	Sat, 20 Dec 2025 06:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766210647; cv=none; b=mVCSolNj5rR8256VeTrexZLEMMzqfP9vo/CGrl78mE+T8HjB8kJv8WmXC6QZmJo7adRLZz4OfErUbZHGH9S17zqkRA3VVP7+pTX5Lj7nXkjzSWaCr1c8x2+msmGajNn6jXfihsoTuitvbdYDUFkVUqPA1A9lvsk0pk9Fg0rIZCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766210647; c=relaxed/simple;
	bh=JhhZKgbhQDuIZvY+tywjTM/+EOuhlgXcOjO3AWdtoY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uIZGMM67EvuPlE0MHCI2Il8+b/k3UgOFHcYdkX8ubymvuqAOrT+79p7FOP1Idjo/RNLguhX9ZIonLI78qbvD45YIyYMev14saqxnJTgTsHOrOzEzbmfrzvMa090RzmCzfgCo2iAWaTf9OfLq2wCYAIcppfj7E1lovDuoVhGSSc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDAEC4CEF5;
	Sat, 20 Dec 2025 06:04:01 +0000 (UTC)
Message-ID: <e0e9e690-c56e-4b56-90f9-2af46a7feaf3@nxsw.ie>
Date: Sat, 20 Dec 2025 06:04:00 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] dt-bindings: wireless: ieee80211: Add
 disable-rfkill property
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
 <M7kfFb5fz-WB43U_xCUwgxpmBJ4TNdp4jE6yFu6HmemIcDx5tXO6H4xnW_pEQz6DMkKm-3POdB9hIdB092zhGQ==@protonmail.internalid>
 <20251220-surface-sp11-for-next-v5-2-16065bef8ef3@gmail.com>
From: Bryan O'Donoghue <bod.linux@nxsw.ie>
Content-Language: en-US
In-Reply-To: <20251220-surface-sp11-for-next-v5-2-16065bef8ef3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/12/2025 00:21, Jérôme de Bretagne via B4 Relay wrote:
> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> 
> For some devices, Wi-Fi is entirely hard blocked by default making
> the Wi-Fi radio unusable, except if rfkill is disabled as expected
> on those models.
> 
> Commit c6a7c0b09d5f ("wifi: ath12k: Add Support for enabling or
> disabling specific features based on ACPI bitflag") added a way to
> support features set via ACPI, including the DISABLE_RFKILL bit.
> 
> Add a disable-rfkill property to expose the DISABLE_RFKILL bit
> equivalent for devices described by a Devicetree instead of ACPI.
> 
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> ---
>   Documentation/devicetree/bindings/net/wireless/ieee80211.yaml | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> index d89f7a3f88a71d45d6f4ab2ae909eae09cbcaf9a..c10a4675640be947cd0b5eaec2c7ff367fd93945 100644
> --- a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> @@ -29,6 +29,12 @@ properties:
>         different 5 GHz subbands. Using them incorrectly could not work or
>         decrease performance noticeably
> 
> +  disable-rfkill:
> +    type: boolean
> +    description:
> +      Disable rfkill for some devices on which Wi-Fi would be entirely hard
> +      blocked by default otherwise
> +
>   additionalProperties: true
> 
>   examples:
> 
> --
> 2.47.3
> 
> 
> 

Is this really a hardware description though ?

Its really more of a logical/functional description. It tells the 
runtime what todo, not what the hardware is.

You could also have a list of quirks in ath12k for this or have a 
user-space utility look for the appropriate platform device string name 
and disable rfkill.

I think this logic belongs in drivers/net/wireless/ath/ath12k/ 
triggering on a compat string.

Should be achievable.

---
bod

