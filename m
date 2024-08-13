Return-Path: <linux-wireless+bounces-11345-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C79D2950198
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 11:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064901C21A4F
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 09:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E1717F4F2;
	Tue, 13 Aug 2024 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntkdBQ4D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7202A18A6A3
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542706; cv=none; b=tr21sAfH6ipKvYtThriX9GBCdp8hZnpJ+WKf4ILVwqo141V/Ld4aLfEzuV9R6gwjykutybXrN26mbh9RteINtu5JJzPGB350tQXqcSgMii7XvDB0ujzuetX/g/Q3qCpX6Frq5QaW6OKLsDcIs65DrQifsz/R3Oc/y2wdkfCCpBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542706; c=relaxed/simple;
	bh=g+ist62yHFCep9m1MDDybMsQEi8sSZA4kAS3d50JRPc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=KHu4KJ01Eh39RQLi71dJx/NP/XinFYhlSHD1byJIEj/Yb+yMQM+vwJePggBW1+AAM378/KLNCXiPl8AJBVDmnW8fDs1DaAz5zMP6VZX6fBWGELZMHIRIhJmYqBFN7sx271NWi+QbNUc0fFI+bBU1B0VabVpkQMTRMBCcSGQjZf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntkdBQ4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD36C4AF10;
	Tue, 13 Aug 2024 09:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723542706;
	bh=g+ist62yHFCep9m1MDDybMsQEi8sSZA4kAS3d50JRPc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ntkdBQ4DvU0W8SiG6tlz41Kq5sNp10jzwJByhi7MzQkGPsKVTCzhs+YxqgXfktWM5
	 M6VRmbJfIDGalbw6hNsWijIfaoOJAD1ClOHOcr2uNinQmmeV5OMtI0BV559H0+348y
	 Uu8aEqV2gpEzhIF9joJXlD90zUZE3NT0Qy+UvFhSe7OMItC9ba7QykayztgAyA9iPP
	 wJuZQdlHuRNbkz0BXMqkWkEQk4LBVG+JF+yDJqoRQ5m0TDfIctYnjHWn/yDP+O7fof
	 Nx8rIE8fmc9vewfEjIijwAzsBpLL1fld5zgvIutPIy8ed5PDDfc7r1JoHrls7iVqg0
	 4NMBA4Uy5KjLg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: ath-current-20240812
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <7c3b295d-3d5e-40ee-ac33-c92669f29d51@quicinc.com>
References: <7c3b295d-3d5e-40ee-ac33-c92669f29d51@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>,
 <ath11k@lists.infradead.org>, <ath12k@lists.infradead.org>,
 <quic_jjohnson@quicinc.com>, <quic_kvalo@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172354270280.696913.4904457179910192763.kvalo@kernel.org>
Date: Tue, 13 Aug 2024 09:51:44 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> The following changes since commit de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed:
> 
>   Linux 6.11-rc2 (2024-08-04 13:50:53 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git
> tags/ath-current-20240812
> 
> for you to fetch changes up to 38055789d15155109b41602ad719d770af507030:
> 
>   wifi: ath12k: use 128 bytes aligned iova in transmit path for WCN7850
> (2024-08-05 12:28:07 +0300)
> 
> ----------------------------------------------------------------
> ath.git patch for v6.11
> 
> We have a single patch for the next 6.11-rc which introduces a
> workaround to ath12k which addresses a WCN7850 hardware issue that
> prevents proper operation with unaligned transmit buffers.
> 
> ----------------------------------------------------------------
> Baochen Qiang (1):
>       wifi: ath12k: use 128 bytes aligned iova in transmit path for WCN7850
> 
>  drivers/net/wireless/ath/ath12k/dp_tx.c | 72 +++++++++++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/hw.c    |  6 +++
>  drivers/net/wireless/ath/ath12k/hw.h    |  4 ++
>  drivers/net/wireless/ath/ath12k/mac.c   |  1 +
>  4 files changed, 83 insertions(+)

Pulled, thanks.

e37a9184f270 Merge tag 'ath-current-20240812' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/7c3b295d-3d5e-40ee-ac33-c92669f29d51@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


