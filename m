Return-Path: <linux-wireless+bounces-13022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 870E197CC78
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 18:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFA21C208DF
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 16:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2681A08D6;
	Thu, 19 Sep 2024 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muTv9jPz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB7019DF81;
	Thu, 19 Sep 2024 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726762692; cv=none; b=dBkN/oTtiEA5q+J1hs569DrlPfAOW1AFofhEJ5d4QAwahGp4Qz4vevV0jVn5vedGyvP0mhFPU4DQ2HQg8tkhc+d7w+CyFJWqY/w3ZHzQzyiYJ37PkZjh742hh9EAvZBVk3ppzLktQtYuzD+HBGvqntYx2MocG6FJKgX7djlPeEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726762692; c=relaxed/simple;
	bh=1Y9QM9N8WZCVVLzO7C2hSdota86qUdgdCvodudX0vts=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=TJTpDYZKgWrtrvCg0PgElPagBtAvRu/Z0Rnfe/T6t/O6K3gokZ0E9IR+gRwN6FAyNN4Gw9a68IOYzhWB+n97UtyiiOxIzuqQVDl7AaLYBw/beIK9+eKJyrZEfaCpIWcytAFz1MLhwFPfoXwaz87HpXM8YTxqC6sQkUpXlXCRP4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muTv9jPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE09C4CEC4;
	Thu, 19 Sep 2024 16:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726762692;
	bh=1Y9QM9N8WZCVVLzO7C2hSdota86qUdgdCvodudX0vts=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=muTv9jPzD+ujTo4mjAGnBsWctykA66Ibpydzy3whVBUjA8JZPoxIfY05SeT0nJ4q4
	 frEDrEhCTWleDBEKfJbzMzL9DbR+fdwv8QipPIFOUznSe2ExOPLjKpmh5ru5jSmS3W
	 DPt67me0wwiPz2gkvfT0+UEwtlBFMAGUk7NMeDg0+xUGZSNUWiReFgjcMMUbrDXN+a
	 gaDbQwZMajlOelj0M/ag1A3Xpblfpep69ImLJ1PmoRvvWFe2L2Yg6069kfp9rOc5rt
	 c6tUQ247OZJ0E6sAKhuv9rUEiBrY1wgcN9ofkri/eoY21hMejlTj3h7kqVnbjZeoJW
	 jZyrOcofyEXkQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: wcn36xx: fix a typo
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240913094319.13718-1-algonell@gmail.com>
References: <20240913094319.13718-1-algonell@gmail.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: Loic Poulain <loic.poulain@linaro.org>, wcn36xx@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Andrew Kreimer <algonell@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172676268850.263986.1195211562513254578.kvalo@kernel.org>
Date: Thu, 19 Sep 2024 16:18:10 +0000 (UTC)

Andrew Kreimer <algonell@gmail.com> wrote:

> Fix a typo in comments.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

e2f4563bd1fa wifi: wcn36xx: fix a typo in struct wcn36xx_sta documentation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240913094319.13718-1-algonell@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


