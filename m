Return-Path: <linux-wireless+bounces-11242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA23694DB34
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 09:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEAA3282791
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 07:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16D147F46;
	Sat, 10 Aug 2024 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/4ilU4J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4C12F41
	for <linux-wireless@vger.kernel.org>; Sat, 10 Aug 2024 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723274542; cv=none; b=FE+NvZC6/Nct9VTN4RKVnWdyP+jOog8jkchvMhuyStEVaw4niYn115en1k/tYzaa9DC80JUEgIYFYiByvELyaSOkgK4TqBVp2MMiFoPEPaUKK9VFcz5pqXQXcVqxMZjMNn1DgLCExrx8+y/YW6aLBenkAPrFq1LjEXNdxixAxtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723274542; c=relaxed/simple;
	bh=Pbqm3PkmLLQVIYfE6v0Pt+CoPVT0HoRMZbG37w3EmjU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=NfiJhC2YdlXw8pJ0nqMKVOmUaeX4ShIj7xu29agyu/3USVjo2npCAtj/pB9q0XUXYdpPSrLMXQKMQs+sk0Ro87VBIiXnt99dmZpemMPDwWd+Njg00eHD6j9RKhFaeJW1F7HxI6+4iepjPyO9lofD7Bm6/iBO7yr/1oT+7uWi9kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/4ilU4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F47C32781;
	Sat, 10 Aug 2024 07:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723274542;
	bh=Pbqm3PkmLLQVIYfE6v0Pt+CoPVT0HoRMZbG37w3EmjU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=M/4ilU4JhGjRntXt6aV3JEIfJ35a9MYc9NJ+FdPxNnoIoojsndx2JyZlPiXFR0+AN
	 xgc6KcyNe90o8Gi5NtOe3tYGVgUg3zh2Wjexu8Xd7b6bgdtBzDHuaHrhV3wJSaHOr7
	 O8FWRWIYjcuVKjfJKUA9YW0UHaytaT2zTOJYq66RyFkrTJN2DXS9DmLZVzO+CiuO4U
	 OObZNuhJOAsCfDzhmjFMXW2MbHzHiUL91YNNvyNwFyHBnsXbrDkKlVv+mKjfF359XI
	 DK00zrLrgfCEbXgPSr8EBsSZfmNCiIErsGMb8y1CpFMgSN/ZuIjGE8Lzg1Ucz7QqcQ
	 d4i//qdr/s/WA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Revert "wifi: ath9k: use devm for request_irq()"
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240808103758.11696-1-toke@toke.dk>
References: <20240808103758.11696-1-toke@toke.dk>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 linux-wireless@vger.kernel.org, =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgens?=
	=?utf-8?q?en?= <toke@redhat.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172327453929.252867.13740588424207683681.kvalo@kernel.org>
Date: Sat, 10 Aug 2024 07:22:21 +0000 (UTC)

Toke Høiland-Jørgensen <toke@toke.dk> wrote:

> This reverts commit 92da4ce847bc5d942ddfdb102dba92f4e2797a59.
> 
> Felix pointed out that moving to devm for request_irq() can lead to a use after
> free, and that avoiding that means having explicit frees that makes the devm
> thing pretty pointless. So let's just revert the patch.
> 
> Link: https://lore.kernel.org/r/201f06b6-14f5-41bb-8897-49665cf14b66@nbd.name
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

89fbe672bd0e Revert "wifi: ath9k: use devm for request_irq()"

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240808103758.11696-1-toke@toke.dk/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


