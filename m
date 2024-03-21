Return-Path: <linux-wireless+bounces-5089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC5788587B
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 12:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7714E2855A1
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 11:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE60E58AC0;
	Thu, 21 Mar 2024 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAmOERZE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8883C3C17
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711021266; cv=none; b=IJXDpp+JhsBy1UGCkQhUAoCtuI4gU6AeTV6Y8Z2otzcP/qKa8FmEFYWxShILk/VFrAzCI6lY6E1NWDHE/7kYyAOkKpTXlxi/hUoGV9lBJmnXARTTroQqPO5/SXP83NlSi/ZGawpMMz0Q+gUaCAk7JIvuBhfV/E7p2YZvU6DWjfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711021266; c=relaxed/simple;
	bh=dhXj0sMSbf3W2sui2Z1tSKMD7c6sHo6XgzPWyJjdDzc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=KYpxbKN6oBAstXPYWgIh3tkikcL3L8MaAE+JVST8AgtvbkYDnyd+WR733yDBRK0x8sO9a4Rx/RogPPP5O+OHtMnaLsprkhyV6/7+UWBpIGraUNLQnH7y6hgYGwjeGnniOrv1J286uwPIR/405YaGCuBxl5EF6sNlNOKuMkmAV70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAmOERZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313A7C43394;
	Thu, 21 Mar 2024 11:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711021266;
	bh=dhXj0sMSbf3W2sui2Z1tSKMD7c6sHo6XgzPWyJjdDzc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=kAmOERZE9L8ANnSwBtQIOwO7pPaoK9/Ebm8h+6gXt/D6xUSHaB4YRJ9icVWIQKF0/
	 /mQywf9X0BJAiZEvIOyR7K0h4+0PfR75utSMBrs11aGxW6WwxmlDpu51ZxN/0HLpME
	 a5ttC1OCbTsefqYeayhf/9cET1zVOtc1PRnKV72Dp1iFXoBDKvcisAy1Y09vcyVBvN
	 9cQoFqDhWLpzZClLgnWoNMBYxZMxgcD1s4YDf3V5mMhXx8TdUkYBUfRCmRjQEAXUhv
	 UkTJkZxBvdewwneOZpUqXG7gmskjGiVb2DyF0yTCrRNzFl1hAA3uYP73AMO4JDl7ev
	 J/EmZtyyG8rGg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: remove duplicate definitions in wmi.h
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240314021654.304451-1-quic_kangyang@quicinc.com>
References: <20240314021654.304451-1-quic_kangyang@quicinc.com>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_kangyang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171102126347.4024062.3271271155664462733.kvalo@kernel.org>
Date: Thu, 21 Mar 2024 11:41:05 +0000 (UTC)

Kang Yang <quic_kangyang@quicinc.com> wrote:

> There are some duplicate definitions in wmi.h, remove them.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

3b8e475b27d7 wifi: ath11k: remove duplicate definitions in wmi.h

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240314021654.304451-1-quic_kangyang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


