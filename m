Return-Path: <linux-wireless+bounces-20528-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1A8A68545
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 07:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B06719C1EBF
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 06:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00EA191F92;
	Wed, 19 Mar 2025 06:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTcXOra4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A180E552
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 06:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742366867; cv=none; b=u2BMpOchNSWXCHwQM5bJAd7Y1dO8VlM1/+00ha1HDwYB6qV+bBO3xcTR+K/huLv6d6yq3hjWsqZabsxNHdBf3AmFQQrnyad1gFUyRQz1pOU7nAgJcc5v+HxvbPmG3zaPkydQja1iQrTIaLbNgnFOj/na+GAJ30NTlSjs7+bH5mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742366867; c=relaxed/simple;
	bh=dkk8rVsY9g7fXu1+Fkdnu/Wf4wEQhWFdgFk0a0RO/9Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cxB2FwL7edZy9g+d/Cyla0XYGHeMu4I4Io0JwVcYwtmg/OTrxaFRwgR3yPlgoFI0UZqrNHkh9LPZ9448f7GALHyMGrjH6zITCn2IHJ8fdpAq8oTshrfXhHzSLBPl0coEBlSwuFSS7Pnqbmrnv9fAkTn9SJzHF9mDkUKgDeLc8F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTcXOra4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD620C4CEEA;
	Wed, 19 Mar 2025 06:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742366867;
	bh=dkk8rVsY9g7fXu1+Fkdnu/Wf4wEQhWFdgFk0a0RO/9Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FTcXOra4KeutWaXtBXjL42kD4mU6htGHwCTIDMQ36rZ7ZMvEB1o6y5XB+o8goj63V
	 n7vnacOVUn1vdiMKSUE8vOIl27blmXIKwykzbMnY2+eLwrauUXEnNcLQA7YsGSpXAP
	 L5P26fV5sgYOt9Ds8Q5HrsOjSOYaEy+XtVfgWZ9h6NBexU2l/wV6YEV54x112/nx4Q
	 YMhxgxyakTy5RQokCtZY6RXoJBj/feXvwr38He3CIqo5Irq2KgeebtOGMNh7Nrz6JI
	 IpWBpTtdjMlHw/iVzh2fB/qVKAbDSEKUJoYD6Wdkfb7u3smQC+q71rRuoaY4IPZ2z8
	 roZJUb3Uf5rXw==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 4BCAE5F9B4;
	Wed, 19 Mar 2025 14:47:44 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20250317073040.8726-1-pkshih@gmail.com>
References: <20250317073040.8726-1-pkshih@gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Indonesia
 (ID) for 2025
Message-Id: <174236686427.821834.15108936552440451997.b4-ty@kernel.org>
Date: Wed, 19 Mar 2025 14:47:44 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 17 Mar 2025 15:30:40 +0800, Ping-Ke Shih wrote:
> Indonesia. Ministry of Communication and Information released Regulation
> of the Minister of Communication and Digital Number 2 of 2025 concerning
> Amendments to the Regulation of the Minister of Communication and
> Informatics Number 2 of 2023 concerning the Use of Radio Frequency
> Spectrum Based on Class Permits.
> 
> According to type 1 access (using RLAN for end user needs) of Radio Local
> Area Network (RLAN) section:
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory info for Indonesia (ID) for 2025
      https://git.kernel.org/wens/wireless-regdb/c/6953f19b96f4

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


