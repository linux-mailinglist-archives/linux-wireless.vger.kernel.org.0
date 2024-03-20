Return-Path: <linux-wireless+bounces-4965-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED76880F57
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 11:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1E67B219D5
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 10:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77B13C46B;
	Wed, 20 Mar 2024 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyM4EW+X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AEC3C060
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929416; cv=none; b=M8r1OJAT54ah9flglUMHjgVHuiwG7ibQ4dyqtylgrX99zuvA+6+BsE6ULA3DsAUPC3fZKS9+ilP9tHSdHeR18/ClSRcWfbu4/l+YHduvr9THMl+inxQ6ElJkonbcOGmpDhyOy2T34d5+XoZPFnTjfX3ep3nyDTlc7HBV/G9FaAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929416; c=relaxed/simple;
	bh=gLxblALNIiiN/Cb9xDExB/Z6Irzv5jocK4NDwRzzZJ4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=TtZr/7lqkrRVBQi86R/RhF1BHFhwKhKZV0VRFY9AHXd6cI3vsLRha1E1OaWVdmh3DsJBKhoeIgfL3Oh5SxQ8XoX4+bsrLIJ2f0DC1/2EcuwwHweZ/NK8U/DdbMb3BL2ApTCF5xORg+YpJwuvMyVZndpLeHi8qhhvGIk/tHUqjpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyM4EW+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EA4C433C7;
	Wed, 20 Mar 2024 10:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710929416;
	bh=gLxblALNIiiN/Cb9xDExB/Z6Irzv5jocK4NDwRzzZJ4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=CyM4EW+X9jSj11wlZ5U90FuFWO8Nm1tkpcuwi9NIj0L6NkIqDFt16XP6B9doxYVLh
	 HW6PXQY3bLhibCA+EiYPYnfszksKZ+a7Wd9IKPbMia/N5n3SjWscNc67jE8rsWWUma
	 /cL1fnkcagYJa63+alsRuSHlVPRInTV9uMovTD6HqOhWPt2c4qgDCd1Nml7bMVktzU
	 qbKkthXAXKAZsfor0qDbr5n2tRqszGrdNwycG8fJI2RJXqTsF2ngPm6FyMRgF0W8AG
	 SZ2cp1MGoy5Hr8OXBr+BiKdUIOdxFpr3nb9wZYe+F9u/9juAhtP7mX7UCeNYabqev9
	 qhtCZ/xnknl8A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: remove duplicate definitions in wmi.h
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240314021830.305021-1-quic_kangyang@quicinc.com>
References: <20240314021830.305021-1-quic_kangyang@quicinc.com>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_kangyang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171092941363.3054175.16306737790680086874.kvalo@kernel.org>
Date: Wed, 20 Mar 2024 10:10:15 +0000 (UTC)

Kang Yang <quic_kangyang@quicinc.com> wrote:

> There are some duplicate definitions in wmi.h, remove them.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

54a3d0d6684e wifi: ath12k: remove duplicate definitions in wmi.h

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240314021830.305021-1-quic_kangyang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


