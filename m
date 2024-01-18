Return-Path: <linux-wireless+bounces-2138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B4E831288
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 06:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0136A1C20930
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 05:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EF3B652;
	Thu, 18 Jan 2024 05:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhhEF4x4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAE0B64A
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 05:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705557043; cv=none; b=X1OQeQMNYaXgsfai7UF2rWXKxUVjKGqYCEqOZx+7dTQOnvNZgT/MZ215BywYocFCeX61WUsz6tofqQalrdejrkmokUA32KPgKZfBvIJp8eHySCLzv0sSbssT9PP6v6mpTBZIWPjLtfFhrCun+r3x9YDcX1CcvTcBiv+ikbc2Ys8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705557043; c=relaxed/simple;
	bh=mjwx3WCbvWDQ4H30ScARB1J9Rfuf6sNrNVOFpJlAQhQ=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=lVrZQ/Pf62JYc7BwGglwU1Yj73D1LbcQ8IIBT1A66BgzPKO3tGj7BsC9sU/GAYotxmXjfnqAcyZ2+7XZNK3WulB8afM6RgmakFGSHBCrTY9vza0NT2SmOsUIB7peKC2r12RAixGQz3w6QW+HCgfn+7z3tHVWAxPI+pRKuf4xvFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhhEF4x4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666E5C43390;
	Thu, 18 Jan 2024 05:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705557043;
	bh=mjwx3WCbvWDQ4H30ScARB1J9Rfuf6sNrNVOFpJlAQhQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=nhhEF4x4zmL5ReCojrNUX5hWGpWwUU0HqnTuPFZyZj7MviVQXy7xCcG1J/8AbqRP+
	 xonO7OKntqGOTBzHMLnbuh3KviUqWKe+yraapI4ZTKUZkJ3O/JZcMOsaa2H4wuQ5n0
	 /hLkzD5LaL3x3TCfQNvdx1dGsRPGsaDB6Bd80z/DXGdhgknvOhCPTyzQsTRvntqhdQ
	 fJSMzEU7TYJGGuT2buGBFf9iI2jAghRiViXnixPB6wjCfAM9VyyDnrNLtDBtM6981s
	 bMG82ifMQmJxYu4QitR4yaF/qC4ZSkesxcdv7JN7XH9s8Z5soTFivTHN1tE9Tt+9KG
	 P1xIXqltBeKZA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/3] wifi: ath12k: replace ENOTSUPP with EOPNOTSUPP
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240117080431.2907471-2-quic_periyasa@quicinc.com>
References: <20240117080431.2907471-2-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <ath11k@lists.infradead.org>,
 <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>, Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170555703932.2637903.971806943065664355.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 05:50:41 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> ENOTSUPP is not a standard error code, don't use it. Replace with
> EOPNOTSUPP instead.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

49b88e5f3fa1 wifi: ath12k: replace ENOTSUPP with EOPNOTSUPP
3422402bacd0 wifi: ath11k: replace ENOTSUPP with EOPNOTSUPP
bc2ef64931c2 wifi: ath10k: replace ENOTSUPP with EOPNOTSUPP

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240117080431.2907471-2-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


