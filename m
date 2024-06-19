Return-Path: <linux-wireless+bounces-9249-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B141190EFDB
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 16:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5AEB1C21A19
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668E714E2C9;
	Wed, 19 Jun 2024 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+gLRYl8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417D61482EE
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806420; cv=none; b=fmGrNm3n2Deii/Kx9I+Mbcxs8Col4nbowDNgpnCF5J0PKJrBgzFMfCJj4KIo/hew5DBvTuO3jM02FRL/d2aetMBxRjR2W0QghFAPLtWrDvtoPZWogz+g4CEXkKb1lLNAN9cCZMaINj1ligI09+6YXW8Kv96utPoSTkcs5ZkG5aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806420; c=relaxed/simple;
	bh=NQyi1a2zLyx4i/sgAfmUTZEz1dspq8q7MpovmmxN66M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Jj3mP6jo10KB+oDvPNfJ4ZcIVwElZ3zicSq817Q2O9CWexNEl9dHlAT24IVCRkT9s7P+VbEVakr7e4T01AOLqItodc1w8mlEBEtzwK65b/gCMJEbuO1glQLHXYEM2QsmSx+UUvw/D0A+Xfnp3B/DNrciZUG2kHOj8SJB0qvMcNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+gLRYl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CC0C2BBFC;
	Wed, 19 Jun 2024 14:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718806419;
	bh=NQyi1a2zLyx4i/sgAfmUTZEz1dspq8q7MpovmmxN66M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=B+gLRYl8ZJZ2aLi4eh15lkgPXO/eAVl15Kl784HvlZeUSQQFHdpE61FSIkxoyHeT0
	 CZ5M7MdScSvjMqCY0v9ySCGTgzek3PrqXHl+sMtic/5K/I+XP/bn4QbQUm26tFq5o9
	 vTR225nUv9b8WKMTmHglvSf8urgd6BdiKpMb8HDf0ntGzblVgqJLWZTo694hAlU/j1
	 FQ6DktoF2auStxW1UT+Q2MMZKl+u12vaWsJf3rskQIE7BCOjyq6hQr/1ToYqN7JkdN
	 F17KgMqHRi6ZN2aD2p6wWUxKmOZlirfKpmc805qCF+T43OHLuWOnSL8g0I1jfXHvlK
	 c2CglD1w8Elug==
From: Kalle Valo <kvalo@kernel.org>
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Cc: ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org,  Lingbo
 Kong <quic_lingbok@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: Fix pdev id sent to firmware for single
 phy devices
References: <20240611043342.2672998-1-quic_rgnanase@quicinc.com>
Date: Wed, 19 Jun 2024 17:13:36 +0300
In-Reply-To: <20240611043342.2672998-1-quic_rgnanase@quicinc.com> (Ramya
	Gnanasekar's message of "Tue, 11 Jun 2024 10:03:42 +0530")
Message-ID: <878qz1kokv.fsf@kernel.org>
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

But WCN7850 already works so I'm not really understanding the bug
description. Can you elaborate, please?

> @@ -81,5 +81,8 @@ int ath12k_mac_rfkill_config(struct ath12k *ar);
>  int ath12k_mac_wait_tx_complete(struct ath12k *ar);
>  void ath12k_mac_handle_beacon(struct ath12k *ar, struct sk_buff *skb);
>  void ath12k_mac_handle_beacon_miss(struct ath12k *ar, u32 vdev_id);
> +u8 ath12k_mac_get_target_pdev_id(struct ath12k *ar);
> +u8 ath12k_mac_get_target_pdev_id_from_vif(struct ath12k_vif *arvif);
> +struct ath12k_vif *ath12k_mac_get_vif_up(struct ath12k *ar);

AFAICS ath12k_mac_get_target_pdev_id_from_vif() and
ath12k_mac_get_vif_up() can be static, no need to add them to mac.h.

So we are left with ath12k_mac_get_target_pdev_id() but I don't see it
called anywhere. Isn't that dead code we are adding?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

