Return-Path: <linux-wireless+bounces-11331-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E8D94FD46
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 07:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3921AB211CA
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 05:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F2E2374C;
	Tue, 13 Aug 2024 05:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoIOB9kq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECF91CF9B
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 05:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723527459; cv=none; b=DF+dWm4zzd6IuHVltU1fdKLNtCqC73VdGROlQJIYdFYtxWvBbRvlD9ph/mzaJzdjKzm+cKPJeGDeoXWWYyUaQgaoZpibto/bm3t4UCOebFypK7ZnU+7d+4D2iUlMfAdkLA+mg/CILXDrU+mIDINOKtFSLu+npdx2MYJ6lLZJtCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723527459; c=relaxed/simple;
	bh=VIPGR320Y7Rivy+1q2HS3AcUVzT2ZyXizwLc9SN61NQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kq4l5L2bBifepX6B1A3T749Il6hzKjG+GUvDse8lgTO45gVZQxsIJ2rApxGGG3Lbsh4ctOVm1QOYuMtLQgHsbECjKHoJ54l1mewGLrXedWoCjraFpdMmMvmcf3I4+mKSCuO45Suv6/gHYI/c10bLvQLP3d6/KlAuslXClbxBN7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoIOB9kq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D083C4AF0B;
	Tue, 13 Aug 2024 05:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723527458;
	bh=VIPGR320Y7Rivy+1q2HS3AcUVzT2ZyXizwLc9SN61NQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aoIOB9kqhy8q71oSLTrjlsj0fuOWa1XqBnxGmzzqf2bXKmMiui2VrAuR+VwvqiJhW
	 caZex7P2Kq8lN+zJ1SIk2okL3jF0LJGvkhxbZILIBOMG4QgomUqw6zY/pJDmE/dsyk
	 n5r6/nHHE8jiCXz/NzjFODxj5h+6n/TQ0P12S83VDkOxKhcWsxlWfWe+RDBtwBpmdl
	 hzpfRYOVMavWTIYGrdwV8BWBx2o54a/0OFfKYdrVZRe1WLbaz0FVxWwsT/vVZGeJ/A
	 SdCxaEbun6+XixVDE8/XT6ZLfFuD7N8YhGgGNfDk//W6skW2Pdt421ieFDjjGQsWzm
	 8mPPmexoBa0Ug==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id DB7B55F7C0;
	Tue, 13 Aug 2024 13:37:35 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Gacel Perfinian <gcperfinian@up.edu.ph>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20240812131811.565-2-gcperfinian@up.edu.ph>
References: <20240812131811.565-2-gcperfinian@up.edu.ph>
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory info for
 Philippines (PH) on 6GHz
Message-Id: <172352745587.1740740.10621361224039297904.b4-ty@kernel.org>
Date: Tue, 13 Aug 2024 13:37:35 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 12 Aug 2024 21:18:12 +0800, Gacel Perfinian wrote:
> The Philippine National Telecommunications Commission has issued
> Memorandum Circular 002-07-2024 [1] on 05 July 2024, amending
> the allowed frequencies for HIPERLANs and RLANs specified in Section 2
> of Memorandum Circular No. 03-05-2007 [2]. The amendment has been in
> force since 22 July, 15 days after publication in The Philippine Star
> and copies furnished to the UP Law Center as mandated by law.
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory info for Philippines (PH) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/003c282a297f

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


