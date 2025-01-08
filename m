Return-Path: <linux-wireless+bounces-17197-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B4DA05F7C
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 16:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39287188899C
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 15:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED591FCFE7;
	Wed,  8 Jan 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjK8ubFs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1AA1FE44D
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348417; cv=none; b=B/CIsWfp0sSQvlJvYiHzw56cDw8+FuTkjjSu7xRL7doAfukm8L0lFOa+jarn5RLuQ9S48SzHeHLr9/njKtBUJZECVVpjpxyNmoHATvZfr15X/ZjlQH+mdH9fncfL8BadVSHz9KvRb1H021lk5joU3jIAdrrt38kYDBvWl/MSu28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348417; c=relaxed/simple;
	bh=vuYT0K69rEkRC3CxiBZ9EB/G1aA4QJsYU0rhO3H3f6g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=YtErHYlYrwYFgqr+a+vGB+cmmvofq3RiTZGCEiCF/1iSDSkPO3rwI12YAhQ6pA7GTdYtyy6ExoJ4SKwQ/gtgmRemOqgOgda4AJzqrjcVNo6MJBXXktemXsFiOpr2EqJITE/+npxonMWhqq2tZDTrdo+0C+ox5PpPbWnxPFlA6tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjK8ubFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430ACC4CEDD;
	Wed,  8 Jan 2025 15:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736348416;
	bh=vuYT0K69rEkRC3CxiBZ9EB/G1aA4QJsYU0rhO3H3f6g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=BjK8ubFsl2AIUIwnNps134FfLIpO8rjI81wVwCZWvq8BZ9oJ1n9ni6R9s7YHpGkZa
	 UzP0KbsHun1nr5dP7/KSTja22dGJhbC0X65FJ1aLgFFZ/sPJtjy6CMSXw62zZPwynK
	 oFiNES0SdW+BydaLZ9TxJ4xp166fH1w4HI0Yuz0MzIYeMmKp1+tg8lWVKjd5W/g9O5
	 blruWdfpNq5Oj/zlNZXt9fd8WfBJydzPmOWDN4RCreWfmczq2EDANzfadL9PMQezk+
	 sDQS6BF4nXca5fMgeL4PAedCxn+JTOGqv6eSdMk7QIq8wg1WztmMDZ34tIWVS4H7QB
	 Rvirhl5aRcpkw==
From: Kalle Valo <kvalo@kernel.org>
To: sean.wang@kernel.org
Cc: nbd@nbd.name,  lorenzo.bianconi@redhat.com,  sean.wang@mediatek.com,
  deren.wu@mediatek.com,  mingyen.hsieh@mediatek.com,
  linux-wireless@vger.kernel.org,  linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/6] Revert "wifi: mt76: mt7925: Update
 mt7925_mcu_uni_[tx,rx]_ba for MLO"
References: <20250108022509.217803-1-sean.wang@kernel.org>
Date: Wed, 08 Jan 2025 17:00:13 +0200
In-Reply-To: <20250108022509.217803-1-sean.wang@kernel.org> (sean wang's
	message of "Tue, 7 Jan 2025 18:25:04 -0800")
Message-ID: <87v7uppczm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

sean.wang@kernel.org writes:

> From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
>
> This reverts commit 3cc610e9069db69e4a0f6304993f4c98db52c3c7.

Why? The commit message should always answer that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

