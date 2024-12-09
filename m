Return-Path: <linux-wireless+bounces-16079-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8117C9E9B0A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 16:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756C216690B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 15:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84244136671;
	Mon,  9 Dec 2024 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="st6izTpO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C347481D1;
	Mon,  9 Dec 2024 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759966; cv=none; b=A6SXmZZ/AYkBONtHzdWoo08t0kDqdqxvOjtazzR6cttRBq6oaB+4DvE7zuMr+cl2KdfKpaJD/fs1+9nS5+dN6Zotjq+w9S1WCDs/oBVO5e0OJ+O01Dwi3/N1FJu8MFiYw5g+u36wNP1jdIkgNvgm19sIaLp0bP94n6RtykpIF7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759966; c=relaxed/simple;
	bh=5ksp81xzpJEXbp0KJQe4n7Kdm061Nbc5HSH9zfWMiQQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=aocHhHr8ndu0bq+rt52wH7oGLuY7RZcGSef7czXLH8L0IED/cwrMXr7iWHAjwzDXU1Ge/oKjWv9Zk0JKatPN+ZjTUx+G8+yv0N0RL9WQyxOAOdV/ilDe9fjYga5O2io3myr8NXMHCVOhxnaGcXOjepxzCu7ucMxMP1Co48KZiPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=st6izTpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03074C4CED1;
	Mon,  9 Dec 2024 15:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733759965;
	bh=5ksp81xzpJEXbp0KJQe4n7Kdm061Nbc5HSH9zfWMiQQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=st6izTpOBSZGEuo1B0o+vtJBEOVys+5FnmaEUtIKxIEXONIbidvB/YYWsK6zdDg31
	 JzRNOB86Yr9zx7tQrdEsx/3hqnaVFmrA/mp1OBwx1/5cT5zvXmt85VGTBgemtGH1Bv
	 jcSA2LEfIhPMwElMrDiSWPg4JyFdQJh8oaEiSE2Ad9O1+ODOq7weyQAyNrMuDLfymj
	 NQXudSNws/jQc1zmZa7lyn4TnAsSea2nTEqgl/DovA/Ea728D+cf44DgefxYotLF1C
	 gtOYGHMNpMqB2AMBnA/AsrioUtgc/EZoH8EHSG7Bx6XlE/oi5U/uYU6eu/SFEZ2MOy
	 uz2CkVWqeCDyQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: brcmfmac: fix brcmf_vif_clear_mgmt_ies when stopping AP
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241121-brcmfmac-v1-1-02fc3fb427c2@gmail.com>
References: <20241121-brcmfmac-v1-1-02fc3fb427c2@gmail.com>
To: Renjaya Raga Zenta <ragazenta@gmail.com>
Cc: Arend van Spriel <aspriel@gmail.com>,
 Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>, linux-wireless@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com, SHA-cyfmac-dev-list@infineon.com,
 linux-kernel@vger.kernel.org, Renjaya Raga Zenta <ragazenta@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173375996198.157598.9983954124346124253.kvalo@kernel.org>
Date: Mon,  9 Dec 2024 15:59:23 +0000 (UTC)

Renjaya Raga Zenta <ragazenta@gmail.com> wrote:

> This removes the following error log when stopping AP:
> 
> ieee80211 phy0: brcmf_vif_set_mgmt_ie: vndr ie set error : -52
> 
> It happened if:
> 
> 1) previously wlan interface was in station mode (wpa_supplicant) and
>    connected to a hotspot
> 2) then started AP mode (hostapd)
> 3) and then stopped AP mode.
> 
> The error happened when it tried to clear BRCMF_VNDR_IE_PRBREQ_FLAG.
> This flag is not set in `brcmf_config_ap_mgmt_ie`, but
> BRCMF_VNDR_IE_ASSOCRSP_FLAG is set instead.
> 
> Signed-off-by: Renjaya Raga Zenta <ragazenta@gmail.com>

Patch applied to wireless-next.git, thanks.

aba23b0a6a0d wifi: brcmfmac: fix brcmf_vif_clear_mgmt_ies when stopping AP

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241121-brcmfmac-v1-1-02fc3fb427c2@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


