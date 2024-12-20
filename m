Return-Path: <linux-wireless+bounces-16647-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB489F958D
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 16:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E044716C9A0
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 15:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3CD1C5F08;
	Fri, 20 Dec 2024 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRKILxDO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5846D249EB
	for <linux-wireless@vger.kernel.org>; Fri, 20 Dec 2024 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709048; cv=none; b=GTfmEDIOkhrBtK1R3T9+pWasfXQofOmIAq4M8yQj2D6XkjkxSVva2zQQIKLtOwHYgj9MKRk7gLqc0heFSaH+yYJWBpMy1iRxbY+E/hBxIOatDgAyqSxYrKAL55k4dNjgW35xIrV4brdLA2dafWLLdqmyjJWfbMlRHxLeeyK2HD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709048; c=relaxed/simple;
	bh=ktv6hTJvatOdLf8QRamLBtFjYchk1/vaWBbpmEoSXsI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=jAvN7KpsopXSOe32NySx+KsmEEebde5c6YfFuL9K3wrv4YkrXrLGqyQqcMYmeiYpJFmNdt3gbDPu6LDAXk8K0Ar8aTIsyxrBGAOej5IdBZS3smh97t6kNwVSlc0lV/pJppXBBXHXH++itjkU/I4x/NqkgkBP14WZ0ucRxMmLuq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRKILxDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089ADC4CECD;
	Fri, 20 Dec 2024 15:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734709048;
	bh=ktv6hTJvatOdLf8QRamLBtFjYchk1/vaWBbpmEoSXsI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=iRKILxDOi3tECpU7ZkQh7b3n9GJPogIwDurltPCceYyyD2nbDxMrfY0Tlbw/VkRB5
	 mxf1/pGRRU6W0cz7z7m7elEB4qE5BIKMMnKAbWbnVFqnfhx4gTxIM+9oGpBwupXyTi
	 haU/ANRKv0Woih2WSw97e35Yzhv1kSn6MoL+FR702ZrZVk9irHHV2q0mxIgHlwoeU8
	 SgqpwmeZqPFuXYYsNzVmTKGiLmHb4ccXsb0IsSBaj+nqB3fGaR4b+hQOGXaAm4DDXh
	 gaFEoktawwAxffoBXaUXOdemGfVtrWNIx2scKR9q7w7DbW44mB+ghFgzWkzoQUMF8p
	 Fn3WtZf5g/JBA==
From: Kalle Valo <kvalo@kernel.org>
To: Muna Sinada <quic_msinada@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Ramya
 Gnanasekar <quic_rgnanase@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: set flag for mgmt no-ack frames in Tx
 completion
References: <20241219190845.605116-1-quic_msinada@quicinc.com>
Date: Fri, 20 Dec 2024 17:37:25 +0200
In-Reply-To: <20241219190845.605116-1-quic_msinada@quicinc.com> (Muna Sinada's
	message of "Thu, 19 Dec 2024 11:08:45 -0800")
Message-ID: <87seqifjre.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Muna Sinada <quic_msinada@quicinc.com> writes:

> From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
>
> IEEE80211_TX_STAT_NOACK_TRANSMITTED flag signifies that frame was
> successfully transmitted without any errors when no-ack is requested.
>
> In WMI Tx management completion path, driver is not setting
> IEEE80211_TX_STAT_NOACK_TRANSMITTED flag for the frames with
> IEEE80211_TX_CTL_NO_ACK. Without this flag, the management frame
> statistics will not track such frames.
>
> Add IEEE80211_TX_STAT_NOACK_TRANSMITTED flag as part of the flags in
> skb transmit information when WMI is processing Tx completion for
> management frames.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

