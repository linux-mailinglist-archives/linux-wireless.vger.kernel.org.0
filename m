Return-Path: <linux-wireless+bounces-7279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB5E8BDF8A
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 12:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18473B20A85
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 10:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAB914EC4B;
	Tue,  7 May 2024 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD/MYg66"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE06614EC4A
	for <linux-wireless@vger.kernel.org>; Tue,  7 May 2024 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077206; cv=none; b=teApmJhYY4qIAw+BXjRaQJHkUJ7PKD0lFgB11pfULQWTop/OV8+Q/hJNEWyatBkD/e6lPYHsUfwvNEXYvoG3qXz4OhYRKtg+gMca4UTzXX6Ixk+q63rOuyys0maarEXcB4/ZnN4qVTixdWaYhMNe+lV7AsFWwJtDZgrvLGRHUrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077206; c=relaxed/simple;
	bh=iQRTFLh2yI2uc1laUSTR2ZMOPd4Eqg8Na+Csb1Ap2+A=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=sbSDVkrRv+kyih7RXXsh62/OJfc825xO0OvvM6IAlGKYiut2z1Uucyg4VWcpcJTpFvm99wEdPpHgQC9CXATOBedwc8MUh7XJmisV+5ZY8cLabanxfXtvvg4spCS1w8+6mCMbz6hvAVJ6yv+VHhwpCxey6rI/8M6gIdeGNP2weDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GD/MYg66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869AEC2BBFC;
	Tue,  7 May 2024 10:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715077205;
	bh=iQRTFLh2yI2uc1laUSTR2ZMOPd4Eqg8Na+Csb1Ap2+A=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=GD/MYg66nTbSgZnYUjKWzCYZzx4JpGyqnr8PcEGAkAHNsIyvcts1ipaTpC+Jj/tRB
	 QLmIFmVX8gANfr6jkdTAxpIdOVpd4DbWpCmt2lzX8qsEPI5jUhPho1WBGy39wRlyUU
	 DJNV4gYkgeVST7Y2lG6ZE3Mfw1Twex4cZ4/6aydYLcdkN2JfZ6CgrH/iR14WethOvX
	 havSefyGcy3t6jhYsq5xSuObQEej6DEktk/QaakrrirdStyDCtPrXEbF8sSPGEV7bV
	 c+Wi4Yg6eDgfzNtzr7iDZ2SptmYI1ALs9nFFTcQyz0PLrFeIL3M0jg1psrL7fQIEB4
	 39vAwMs0kOaMQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/5] wifi: ath12k: remove redundant peer delete
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240429081525.983-5-quic_kangyang@quicinc.com>
References: <20240429081525.983-5-quic_kangyang@quicinc.com>
To: kangyang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_kangyang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171507720282.3827098.15356808712274335251.kvalo@kernel.org>
Date: Tue,  7 May 2024 10:20:04 +0000 (UTC)

kangyang <quic_kangyang@quicinc.com> wrote:

> Firmware will create internal peer for monitor mode. For host no need to
> do peer create and peer delete.
> 
> So remove related code.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

What about QCN9274? The commit message doesn't mention that at all. Is it safe
to assume that QCN9274 firmware acts the same?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240429081525.983-5-quic_kangyang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


