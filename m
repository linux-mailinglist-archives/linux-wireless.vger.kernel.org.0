Return-Path: <linux-wireless+bounces-9255-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C52790F533
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 19:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DA91C211FC
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 17:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E162E633;
	Wed, 19 Jun 2024 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R841AzNd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96DC1848
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818528; cv=none; b=Jink613xOHe3xLAFu79Svz5XmImueyXK1XKLa9X5T2rxbQe9AwO+CaKAdsOgD3NEeCM8gzkskGUwPbsTFuDlIljgmI/p0JxJBPLsH3x3G9d2nzQxi698gKdPpOVZnx0QP0tpQiJujKozJzxjI2umxdv8Vd2IUMQpGnpDMe84Zwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818528; c=relaxed/simple;
	bh=oze187ZZReIDVRa21rN3O6QaiO6jCdWekl7qUIOJ+ws=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=T/TygPNJL1oC8v069rBdSLx1mFP0xf/iM016LMKHQ4KBhC7UMpxf6agd8NwM2uVionRLVSDLzJWX1aUvTtZbozb093zXUvuS3/KzipP8jTQTocKrSrqpijOyjv+X/IJH+Ek82mFozNX8B4gHgkNCrtjKiWEuPFM2Dj1avYxIgSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R841AzNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C450C2BBFC;
	Wed, 19 Jun 2024 17:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718818528;
	bh=oze187ZZReIDVRa21rN3O6QaiO6jCdWekl7qUIOJ+ws=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=R841AzNda+0OiAiOCj8ICcGtg4DhRHALd7bUSi34XLhWH/79TQdCJyfiBTRWUBSLw
	 F63ni/qFgJUdEJvvCsFZOXlp80nqGuYe1tcleFHi3hdRksE9qDlXrlvIY/H7BziZUm
	 ECyUyEAY/H2xhQYcWWlo+MZ9mOORjVooylyMl1PTHE2XqV62APnqs7vGhkcbcTEIAP
	 LDdyTyomUmKUBMibXxtT+S0Qc40qm5Ee4FlRFwMWm04j6B7ysKC5ALxUtyjNkTYaKb
	 hAWz+yvWPtyw19QYdBJuSnRJeDg7cG9AS3R4CWk7Sg4rbuAcoPsfzwkFnaiwjUEwwN
	 A6AcD3Qb+nWOg==
From: Kalle Valo <kvalo@kernel.org>
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Cc: ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org,  Lingbo
 Kong <quic_lingbok@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: Fix pdev id sent to firmware for single
 phy devices
References: <20240611043342.2672998-1-quic_rgnanase@quicinc.com>
Date: Wed, 19 Jun 2024 20:35:25 +0300
In-Reply-To: <20240611043342.2672998-1-quic_rgnanase@quicinc.com> (Ramya
	Gnanasekar's message of "Tue, 11 Jun 2024 10:03:42 +0530")
Message-ID: <87zfrgkf8i.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:

> From: Lingbo Kong <quic_lingbok@quicinc.com>
>
> Pdev id from mac phy capabilities will be sent as a part of
> HTT/WMI command to firmware. This causes issue with single pdev
> devices where firmware does not respond to the WMI/HTT request
> sent from host.
>
> For single pdev devices firmware expects pdev id as 1 for 5 GHz/6 GHz
> phy and 2 for 2 GHz band. Add wrapper ath12k_mac_get_target_pdev_id()
> to help fetch right pdev for single pdev devices.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>

[...]

> +static bool ath12k_mac_band_match(enum nl80211_band band1, enum WMI_HOST_WLAN_BAND band2)
> +{
> +	return (((band1 == NL80211_BAND_2GHZ) && (band2 & WMI_HOST_WLAN_2G_CAP)) ||
> +		(((band1 == NL80211_BAND_5GHZ) || (band1 == NL80211_BAND_6GHZ)) &&
> +		   (band2 & WMI_HOST_WLAN_5G_CAP)));
> +}

This is not really pleasent to read. What about something like this:

switch (band1) {
case NL80211_BAND_2GHZ:
        if (band2 & WMI_HOST_WLAN_2G_CAP)
                return true;

        break;
case NL80211_BAND_5GHZ:
case NL80211_BAND_6GHZ:
        if (band2 & WMI_HOST_WLAN_5G_CAP)
                return true;

        break;
}

return false;

Or any other ideas?

> +u8 ath12k_mac_get_target_pdev_id(struct ath12k *ar)
> +{
> +	struct ath12k_vif *arvif;
> +	struct ath12k_base *ab = ar->ab;
> +
> +	if (!ab->hw_params->single_pdev_only)
> +		return ar->pdev->pdev_id;
> +
> +	arvif = ath12k_mac_get_vif_up(ar);
> +
> +	if (arvif)
> +		return ath12k_mac_get_target_pdev_id_from_vif(arvif);
> +	else
> +		return ar->ab->fw_pdev[0].pdev_id;
> +}

I find this easier to read:

arvif = ath12k_mac_get_vif_up(ar);
if (!arvif)
	return ar->ab->fw_pdev[0].pdev_id;

return ath12k_mac_get_target_pdev_id_from_vif(arvif);

But I still would prefer to have some a code comment explaining the idea
behind here, especially why it's safe to use fw_pdev[0].pdev_id directly
and what scenario that is.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

