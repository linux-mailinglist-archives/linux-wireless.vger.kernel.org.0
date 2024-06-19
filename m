Return-Path: <linux-wireless+bounces-9248-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB85990EF9F
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 16:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E380B22A68
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 14:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DED14F10F;
	Wed, 19 Jun 2024 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBuU4uDz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB7A150994
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805725; cv=none; b=DLcpwK0996hu8DRIlGQGOMA7voQYWiCZKLb157K+bS29YjmnIcYM/GbWp+YfIAprWjAlttxJVUuC+2oLWoalih3jVH0RwBolWY+9y4ahWB4ppx7MhyEQGkIFdIWIe3kiZMkYjcrj67QBM028qPdLkbtCkK4MpuSD9Y97B11ey8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805725; c=relaxed/simple;
	bh=Av3irBLT/qJrLnpsPEfk2KQnfhItJzwZDqPrVXcn1nM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=RqOviXjYu+yRg8q0e/Ce1a8kOb9222uvGP/sNusM6LGHy61cdBANqsjxU8R2+o6RHTBgdJUi7hmxaMnG2AhXC6IaB0lSpgUuWF4e5fVGUe0p+1NtmzAl3y1poD8It/iReDusOPfEAMS+pjT5HHr8F+0cya1gtD2O5uZZ8QYZKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBuU4uDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278CAC4AF09;
	Wed, 19 Jun 2024 14:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718805725;
	bh=Av3irBLT/qJrLnpsPEfk2KQnfhItJzwZDqPrVXcn1nM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=DBuU4uDzMy9jpF3+Fykqt9QGwaNh21Z0dG769q6cF0tqFn2vfhwHK+t/+9JfKb28P
	 fafzaLXwA0Tm7iAB7g11cOnHYn3sZOvqkhXb7iOiKk8QegsFfJpUmQtPvqHXvsqy93
	 YbBpHnrVda+kbqZ26mzwRUNyRRji/Y/kalqBpHTVaw7TMWaOJsA4/qqJ3NdX5VfjWU
	 9vgubJGiQNtVrY7ov6Iijtxin0sG9iyA8EnwZ1VEC3Q1x+IJxbnnmIqTgiL8XRjhBh
	 g0LcjQ0Nm/1219+xfZYlkd0H3ouGRz1QOEzTNSS/x9r9pGhcHnXerYpVzrW2j8yBT2
	 DENgEd5TcgIdQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix legacy peer association due to missing
 HT
 or 6 GHz capabilities
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240612225336.2303119-1-quic_pradeepc@quicinc.com>
References: <20240612225336.2303119-1-quic_pradeepc@quicinc.com>
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>, Aditya Kumar Singh <quic_adisi@quicinc.com>,
 Zachary Smith <dr.z.smith@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171880572225.581414.15884241377177036601.kvalo@kernel.org>
Date: Wed, 19 Jun 2024 14:02:03 +0000 (UTC)

Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com> wrote:

> Currently SMPS configuration failed when the Information
> Elements (IEs) did not contain HT or 6 GHz capabilities. This
> caused legacy peer association to fail as legacy peers do not
> have HT or 6 GHz capabilities. Fix this by not returning an
> error when SMPS configuration fails due to the absence of HT
> or 6 GHz capabilities.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: f0e61dc7ecf9 ("wifi: ath12k: refactor SMPS configuration")
> Reported-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> Reported-by: Zachary Smith <dr.z.smith@gmail.com>
> Closes: https://lore.kernel.org/all/CAM=znoFPcXrn5GhDmDmo50Syic3-hXpWvD+vkv8KX5o_ZTo8kQ@mail.gmail.com/
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> Reported-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

3005c63a3673 wifi: ath12k: fix legacy peer association due to missing HT or 6 GHz capabilities

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240612225336.2303119-1-quic_pradeepc@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


