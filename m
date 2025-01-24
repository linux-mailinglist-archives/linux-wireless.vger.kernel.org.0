Return-Path: <linux-wireless+bounces-17897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E583A1B1B5
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 09:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600281887CE3
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 08:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98F8218ADC;
	Fri, 24 Jan 2025 08:27:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39472218EB1
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.33.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737707228; cv=none; b=TzyIW/AtnIKC30uEPToDR13afK7OyBRdU9IiYd8ZWSxeD014KZj4MLyqOA6orXdLUM00Y/yh2IOk8G0UPvkejyqDP3dnVNs0rvHBqwnMY/2HjPBycLLAKmvrk5gdeOs9qFHoFQveLBkNmb55pmdUe2wvDNevYszhsGUhqL68x+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737707228; c=relaxed/simple;
	bh=N0Qc1X1+f+ue3xek5QxytJtxauP/NiWRYjbH84CJymc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ohKuIGfxXg7bhLMoKQ2Qo3VIBqaMEgqyEMT+mJVSTPBQbJyVRpZFch7zTD+Z8GCmAtiOF0lYEQd7nYSOYkqrNVDA6xBNvUlB2Ch+cyphdw8mgNgTmJonN/eh7ecFLSe4KNHK4Yq2YARvrOUws7B6j8XwUGHbVSlIv4eTfcvKsuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=srs.iliad.fr; arc=none smtp.client-ip=212.27.33.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=srs.iliad.fr
Received: from ns.iliad.fr (localhost [127.0.0.1])
	by ns.iliad.fr (Postfix) with ESMTP id A5C362008D;
	Fri, 24 Jan 2025 09:26:59 +0100 (CET)
Received: from [192.168.108.70] (freebox.vlq16.iliad.fr [213.36.7.13])
	by ns.iliad.fr (Postfix) with ESMTP id 977A42004D;
	Fri, 24 Jan 2025 09:26:59 +0100 (CET)
Message-ID: <2aba18dc3448b5a60a1a06b33fa591e562927693.camel@freebox.fr>
Subject: Re: [PATCH v9 6/9] wifi: ath12k: add support for setting fixed HE
 rate/GI/LTF
From: Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Muna Sinada <quic_msinada@quicinc.com>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 24 Jan 2025 09:26:59 +0100
In-Reply-To: <5861c953-436e-4f36-ae8b-5ef52fceb3b6@quicinc.com>
References: <20250114003813.2783550-1-quic_pradeepc@quicinc.com>
	 <20250114003813.2783550-7-quic_pradeepc@quicinc.com>
	 <f5c6d874e9d7682d52c5ed107a0ede952b5cf53f.camel@freebox.fr>
	 <5861c953-436e-4f36-ae8b-5ef52fceb3b6@quicinc.com>
Organization: Freebox
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


On Thu, 2025-01-23 at 17:09 -0800, Pradeep Kumar Chitrapu wrote:

Hello,

> I believe, this is default GI based on device capability of HE for=20
> ath11k or EHT for ath12k.

Your patch alters the behaviour of this code in
ath12k_peer_assoc_h_ht():

        /* As firmware handles these two flags (IEEE80211_HT_CAP_SGI_20    =
    =20
         * and IEEE80211_HT_CAP_SGI_40) for enabling SGI, reset both       =
    =20
         * flags if guard interval is Default GI                           =
    =20
         */
	if (arvif->bitrate_mask.control[band].gi =3D=3D NL80211_TXRATE_DEFAULT_GI)
	        arg->peer_ht_caps &=3D ~(IEEE80211_HT_CAP_SGI_20 |
				IEEE80211_HT_CAP_SGI_40);

	if (arvif->bitrate_mask.control[band].gi !=3D NL80211_TXRATE_FORCE_LGI) {
		if (ht_cap->cap & (IEEE80211_HT_CAP_SGI_20 |
	            IEEE80211_HT_CAP_SGI_40))
                        arg->peer_rate_caps |=3D WMI_HOST_RC_SGI_FLAG;
	}


I don't understand why a patch adding a feature to force GI would alter
the current behaviour without any actual forcing ?

--=20
Maxime




