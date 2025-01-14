Return-Path: <linux-wireless+bounces-17510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C715A11045
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 19:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB610165A80
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 18:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E854A1F9F52;
	Tue, 14 Jan 2025 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBkm/BIF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C003A18952C;
	Tue, 14 Jan 2025 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879787; cv=none; b=COMAmd8StotNbZqGjT7KSp7KBxCMHagscPatWDfHh72fjS8ncYLrF4w1O0PTMzvEoC6G9tGj4HX36MxZ43ZiHjJf/j8Vx5243IR4lI+CFlZYiaPaKIr8XgB4xaOqWYnpDKrhWdPWJvJQj8Oc/mLLlCGoIdpQrELMnrCAoPdpnwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879787; c=relaxed/simple;
	bh=Tko+N3Fz0tu5dRw0EkJkvT2WNdyCin78QJz13mh47A8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=o2247acwhrFrhGprpNEI/XJuaw5VT3sYXnFaGlJIAMQXO+NguDA41MXM3CGCCue36RdmGWN4bH0Te2QlOKZyJPEk5Tai0VJoSQvzka+19VDUpNuA85iBYYRRYHKD+rrEw8Q+5byt6nkXOdbhQ4f7xJHMcMKbJ5sjjI0HpRo34G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBkm/BIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059D4C4CEDD;
	Tue, 14 Jan 2025 18:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736879787;
	bh=Tko+N3Fz0tu5dRw0EkJkvT2WNdyCin78QJz13mh47A8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=NBkm/BIFvRWOP6hvQBCXsDMO3pjUWew/AtfOx/KlMOSgzoGrTQ9HdxK3jWB+y/2cY
	 efGbUqoTw+LzO3bv2Xv3j97xSNgn1dvALC76nPoDi74SbIp+N5nT64J1obZBngtc91
	 e7Uw9ArO6Lo7yrjk6X4Ngxo409BPtUZXouV/bNWMfGBhOsLypjNqV6dsCA2KJdhiTU
	 LmYQ+qQ+bRTbwjEJWtGJFPnCeilB3saoE888kxg/XXRrc8OdjEmTuvCLKvLQWBunTt
	 CUPwF2iL7nww1q5NDP0/pb6NxpG0Z5k05laha+Wuq8fHH2HOPzm2/FJ5C61e8uvlD3
	 Lfq/cZZZtggrQ==
From: Kalle Valo <kvalo@kernel.org>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,  <linux-wireless@vger.kernel.org>,
  <ath12k@lists.infradead.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] wifi: ath12k: relocate
 ath12k_mac_ieee80211_sta_bw_to_wmi()
References: <20250110-fix_link_sta_bandwidth_update-v1-0-61b6f3ef2ea3@quicinc.com>
	<20250110-fix_link_sta_bandwidth_update-v1-1-61b6f3ef2ea3@quicinc.com>
Date: Tue, 14 Jan 2025 20:36:24 +0200
In-Reply-To: <20250110-fix_link_sta_bandwidth_update-v1-1-61b6f3ef2ea3@quicinc.com>
	(Aditya Kumar Singh's message of "Fri, 10 Jan 2025 00:13:12 +0530")
Message-ID: <87zfjtnsyf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Kumar Singh <quic_adisi@quicinc.com> writes:

> An upcoming change will invoke ath12k_mac_ieee80211_sta_bw_to_wmi() from a
> line located above its current definition. Hence, relocate it to above
> so that it can be invoked later on.
>
> No functionality changes. Compile tested only.
>
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

