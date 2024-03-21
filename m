Return-Path: <linux-wireless+bounces-5088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54862885879
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 12:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092DC1F220FC
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 11:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE1E58AAB;
	Thu, 21 Mar 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3v9iapx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D463C17
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711021227; cv=none; b=RzUd+Bz63gEe0NrjfGz7w7CGBBRcQ6uNEyZEmruANjWnIY/zcNXzUhMhql6aV0ShhwIDSsrH0EgvoFT/xzLy/IMm4crjjNv/ktjbE9TJCCD80cOpywKvis0k/c/ovyXFo+YPgSsObX3GJ9TTCBdkQIPOFt3iBLnsh5WTAbzIjl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711021227; c=relaxed/simple;
	bh=BDrs6bk24h92KdGirrXYHOyB22BWqkXqdzBUtsoeK70=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=l1RPEZzz7sBDe8Rgu4XLVrGDOURlN4RtzPFkdtRN1aQXSaenDBkwXRPD0/FyFRFyG77QEZ0+5YNqcnySjHMCoQafioXyC0P/stoYSgc+PBsgZRB8oEGeiscxSAaLeE0aExT9zfnADupfYaLR/Fx6Rdpmuq0KzlfOQmBlxaDInsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3v9iapx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98ED2C433C7;
	Thu, 21 Mar 2024 11:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711021227;
	bh=BDrs6bk24h92KdGirrXYHOyB22BWqkXqdzBUtsoeK70=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=C3v9iapxnEr8TgEo3fE91CLPlfvPhg/d6Hten8qu64UMm4cQVhqyQ/TXiuIcTG69Q
	 gw8GXO+i+P7ufJB1xphF1xJUtjhxUcKdoPa7i1JbRpJPdODB9+4qhJhC3IaTHMUZ6b
	 t5HHRFBuEf8mExhogi3IjvUaQIxLyVx0MOkji/P8pQXpIyugJqL+FB44LLl3VQ1h42
	 Mf1pzGLwSqQKqHKKdoKsWoMYBuQxkD9rARO0CPFjH4BT28P1lOIM7qX2znjJRt2rb7
	 O0EUlFm/bwq3yvuWs974589WIy++XTZLEB9Lr0Wke7gdHyM5bpa1CKza/g3kh7qblw
	 ndz0mwew+FMaQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: do not process consecutive RDDM event
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240111071406.14053-1-quic_bqiang@quicinc.com>
References: <20240111071406.14053-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171102122457.4024062.7715360244094507698.kvalo@kernel.org>
Date: Thu, 21 Mar 2024 11:40:26 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Currently we do reset for each RDDM event from MHI, however there are
> cases, see below log, that we get two or more consecutive events, and
> it is pointless to do reset for the subsequent ones. What's more, it
> makes reset process more likely to fail.
> 
> [ 1502.115876] ath11k_pci 0000:04:00.0: boot notify status reason MHI_CB_EE_RDDM
> [ 1502.115884] ath11k_pci 0000:04:00.0: firmware crashed: MHI_CB_EE_RDDM
> [ 1502.224041] ath11k_pci 0000:04:00.0: boot notify status reason MHI_CB_EE_RDDM
> [ 1502.224050] ath11k_pci 0000:04:00.0: firmware crashed: MHI_CB_EE_RDDM
> 
> Add a check to avoid reset again and again. This is done by tracking previous
> MHI status: if we receive a new RDDM event while the previous one is
> also the same, we treat it as duplicate and ignore it, because normally
> we should receive a MHI_CB_EE_MISSION_MODE event between them.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

7c352a4d0183 wifi: ath11k: do not process consecutive RDDM event

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240111071406.14053-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


