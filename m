Return-Path: <linux-wireless+bounces-11491-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B160C9537E3
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 18:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519BF283D28
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 16:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2263F1AED29;
	Thu, 15 Aug 2024 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3IdeY/8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22381AC432
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737969; cv=none; b=CLBAIE0JYcSQaAHFjdbvWkM7XWX2F9+KJB7lkUkVYZ/ZYCTUkyevOyCF5YCBoipeZyv1utDbAfVrbanPLsfHr8BYDcQSTpoM/6/akqQd3viM/fAJvr+0RR7kbVjYMxZlKqoSqfJBQ67y9Fk44svPRSNt1rP1CSaF5Vurse4LUb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737969; c=relaxed/simple;
	bh=jRBX+LCD/1Z7RY8F7WSgOgemqIoD+qNV4OeL1tIzsts=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=C7WfL9VpMNxUBUm0+d9tS6zUIKLuBUY3/s/v81G/pFyHR5sm3VhQcWhlU3OtgbjuZYLvah57IGeUTd8BKlBSVQc9MN1qThd1HYNUkIMINYn3X80XqKtjDMDEm3PWh5MTO6RnmQOCGHg1JR5vq05tlChKjy2145x81KC7MFLYm2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3IdeY/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2376C32786;
	Thu, 15 Aug 2024 16:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723737968;
	bh=jRBX+LCD/1Z7RY8F7WSgOgemqIoD+qNV4OeL1tIzsts=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=q3IdeY/8Dp1KKuf3UWNn4sUqJK+gCtXFJ/DdvYJklGIb0dANyNOxORbAB+j52shKq
	 zic127i5YnPaRDJJtYKMOUtQGr6Ora1mYUgvnIvgJxM3zXOY20gh6j1AhXiITNPHA/
	 CPnkDHvlw8PxoZicPNm6hXge3JoEqBg3wRsE3ZvGx6Mn4WAtpk8fpJ/anQ5YBrgVR2
	 QOaMxotHmyNMos7/65RQMwz84xcqgFSa2CS0WOCsTgwikuHZsYcBThOEJWqX7VaRqE
	 y729khX32OSMSocsF4irqh8epgmPH07s1LGfUFLlVzP1mf7yK7XQQOs6nMZIUbGQip
	 7qMTefhxeGYVA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: ath12k: fix the stack frame size warning in
 ath12k_mac_op_hw_scan
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240809015841.2671448-1-quic_miaoqing@quicinc.com>
References: <20240809015841.2671448-1-quic_miaoqing@quicinc.com>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>,
 <linux-wireless@vger.kernel.org>, Miaoqing Pan <quic_miaoqing@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172373796602.1088510.1385102629331505053.kvalo@kernel.org>
Date: Thu, 15 Aug 2024 16:06:07 +0000 (UTC)

Miaoqing Pan <quic_miaoqing@quicinc.com> wrote:

> Fix the following W=1 kernel build warning:
> 
> drivers/net/wireless/ath/ath12k/mac.c: In function ‘ath12k_mac_op_hw_scan’:
> drivers/net/wireless/ath/ath12k/mac.c:3806:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

6274df2530e3 wifi: ath12k: fix the stack frame size warning in ath12k_mac_op_hw_scan

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240809015841.2671448-1-quic_miaoqing@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


