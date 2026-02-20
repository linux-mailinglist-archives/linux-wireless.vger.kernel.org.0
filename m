Return-Path: <linux-wireless+bounces-32065-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODqdCcufmGnJKAMAu9opvQ
	(envelope-from <linux-wireless+bounces-32065-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 18:54:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D86169EA9
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 18:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F4202306221C
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 17:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E413634DCFD;
	Fri, 20 Feb 2026 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/kT1Cv5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C117633D512;
	Fri, 20 Feb 2026 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771610020; cv=none; b=VJCtw9/3gvKMu6syUmD3WU+IRPVAELTHwWUctnn4VFB5xD+tcznh1buHDVkX/JAe+lcD9ljwyTEo9B5bCSkyGZvHTryIuVuoFZneMrYrSmiUHVZetnn6Wl7qHEQyF4XwbuXw//YrjjBJ3/qheFnw7Rg1ZlS0KF3L3uWF1+BVdWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771610020; c=relaxed/simple;
	bh=zNATZPRtqPD3ySxmy8GYe+CARDOEJ9t0TrF6n5pOmTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDQAoQ8Nn6WQ4RXe2fWWOSFfQYyxmtUEHUD1Bn6OZGATC4lnRM7w2qSscIwzWhoUJN/wQuM0jZqyIbVXDVicNib/LT2znkvT2ycpy2UiWUs/itagJ3B9ZLRLmPWyGTmj38HVqetbN694vSblyOZFoHOa09bGPKCP1cwUb925mq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/kT1Cv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B9EC116C6;
	Fri, 20 Feb 2026 17:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771610020;
	bh=zNATZPRtqPD3ySxmy8GYe+CARDOEJ9t0TrF6n5pOmTE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B/kT1Cv5HlExiMa1VET81TqQAYYr9tLcOCAnJJOdYaK/sPblFipClpHYyjogdEkG0
	 HKk85M77RiFqctmJv2TKiFzu0iTYJ98/4FyPJyPHRLzUFPff0p9dtjSyWqTnpNl151
	 hIn5yV2EWQmaVjj4NBWUpNo7stuvoREiuWcuUE51B11JG4W46absJE1rza03DKOni7
	 yffyAmnqEx/nFTM8RU+HQMaX7rJuM2MSqY/sKZfNI53l9saPewBvCrwSwMBwrVqkld
	 KdLhrcXUnSMVKKQMzK+kbVvcnrDlhrlQjh9QUSv13NXam3yqbRhppYpAq5tKj0a3Ua
	 WCmRfCeSGkzeg==
Message-ID: <3b0d26bd-35ff-40af-af8e-fbc1dd0d31cd@kernel.org>
Date: Fri, 20 Feb 2026 09:53:38 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 0/2] wifi: mac80211: fetch FILS and
 unsolicited probe response templates by link ID
To: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
 Jeff Johnson <jjohnson@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Sriram R <quic_srirrama@quicinc.com>
References: <20260220-fils-prob-by-link-v1-0-a2746a853f75@oss.qualcomm.com>
From: Jeff Johnson <jjohnson@kernel.org>
Content-Language: en-US
In-Reply-To: <20260220-fils-prob-by-link-v1-0-a2746a853f75@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32065-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,nbd.name,mediatek.com,gmail.com,collabora.com,sipsolutions.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jjohnson@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6D86169EA9
X-Rspamd-Action: no action

On 2/19/2026 11:42 AM, Raj Kumar Bhagat wrote:
> Currently, the FILS discovery and unsolicited probe response templates
> are always fetched from the default link of a virtual interface in both
> Multi-Link Operation (MLO) and non-MLO cases. However, in the MLO case
> there is a need to fetch these templates from a specific link instead of
> the default link.
> 
> Hence, add support for fetching these templates based on the link ID from
> the corresponding link data.
> 
> ---
> Sriram R (2):
>       wifi: mac80211: fetch FILS discovery template by link ID
>       wifi: mac80211: fetch unsolicited probe response template by link ID
> 
>  drivers/net/wireless/ath/ath11k/mac.c           |  4 +--
>  drivers/net/wireless/ath/ath12k/mac.c           |  6 ++--

Acked-by: Jeff Johnson <jjohnson@kernel.org> # for drivers/net/wireless/ath

>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c |  4 +--
>  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c |  6 ++--
>  include/net/mac80211.h                          |  8 +++--
>  net/mac80211/tx.c                               | 40 ++++++++++++++++---------
>  6 files changed, 44 insertions(+), 24 deletions(-)
> ---
> base-commit: 37a93dd5c49b5fda807fd204edf2547c3493319c
> change-id: 20260220-fils-prob-by-link-eef176414f1b
> 


