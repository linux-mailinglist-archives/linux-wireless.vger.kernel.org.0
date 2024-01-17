Return-Path: <linux-wireless+bounces-2098-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F95983074D
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 14:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06593B23E38
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 13:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD09A200CB;
	Wed, 17 Jan 2024 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJg/+hFg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9983C200A4
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705499215; cv=none; b=Ixz5mm34vYXPED8NbO6mdohJOXf0BQZ0UlfftskMqERjWsAJtNg7X2yh8BclssoNAXn9F1l1uEw9JlTih5Kmyz/hbdkACGV6/apfXj3vxc5F7gjsOLG7lozVRhohkMTmKIq4Qm5cSLswOriyCrtYNEWYLhhkjh+3w2ZsNvmiobA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705499215; c=relaxed/simple;
	bh=e3JTofgI2+PhasG9mKkzSWi1yrgoiuyT4q7TbhSdBq8=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:References:Date:
	 In-Reply-To:Message-ID:User-Agent:MIME-Version:Content-Type; b=XiGRBkmhCwDWoD9uJuEUQdiqsX8GAzGWIjhFaf6BKy/f6gobh0pATPnibFjvpNfSw2glgsGDXdqnuuOp6k2wQoQfokL1Gp8xy+zXovwAssS4kMpyOTyHpErdCEPj0UNWejKS/uGtN2GUsTzUOObnxuGacRvXwIFIdw5xxshbhX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJg/+hFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E72C433C7;
	Wed, 17 Jan 2024 13:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705499215;
	bh=e3JTofgI2+PhasG9mKkzSWi1yrgoiuyT4q7TbhSdBq8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=EJg/+hFgLtiLLcBu6fyJinitqbBTGn25BNaE/vgzRaHObfB/nJZvG3JjKOVb0POr9
	 ZKEHoEz/+W3H9GVzbbkOaISdGvpe8mIlID6JSzyexFJeOwbdlv6GEmkYZ3Op6cMDnn
	 VnqNhjjjkuMf3Uj1PqTef1Pk4IjuV0b23sJrlQQRlYo/+IhCCJ6XjqE/cw/uoNhypi
	 LCtPZTijIYCvrKYatB+/FefLWOvCLG4Q4Xo7kRjb9a0+0lDcx+FCKghBdK4CHHZS1q
	 ux6o40PcjxYGlN9i35DXQjc/KZEIB4YNKas2Jp9CM43koLDMHYcZK2aZU4gp9yghd1
	 iwvyL5vvDX9Aw==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] wifi: ath12k: some improvement to RX throughput
References: <20231129020414.56425-1-quic_bqiang@quicinc.com>
Date: Wed, 17 Jan 2024 15:46:52 +0200
In-Reply-To: <20231129020414.56425-1-quic_bqiang@quicinc.com> (Baochen Qiang's
	message of "Wed, 29 Nov 2023 10:04:11 +0800")
Message-ID: <874jfc5ayb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> Some fields of hal_reo_update_rx_queue are wrongly
> defined, fix it in the first patch.
>
> Currently the maximum block ACK window size is 256,
> with the second patch, it is extended to BA1024.
>
> The small MAC buffer ring becomes the bottle neck
> in RX throughput test, so enlarge its size to get
> a better peak result. This is done is the third patch.
>
> With above three changes, more than 6% increase is
> seen in RX throughput test.
>
> v2:
>  1. wifi: ath12k: fix wrong definitions of hal_reo_update_rx_queue
> 	no change.
>  2. wifi: ath12k: add support for BA1024
> 	a) s/doen/done
> 	b) update struct hal_rx_reo_queue_1k
>  3. wifi: ath12k: change MAC buffer ring size to 2048
> 	no change.
>
> Baochen Qiang (3):
>   wifi: ath12k: fix wrong definitions of hal_reo_update_rx_queue
>   wifi: ath12k: add support for BA1024
>   wifi: ath12k: change MAC buffer ring size to 2048

I had conflicts, please double check:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=1ee7c1872873d82a71e05a4e17cbf9a569bc8ec9
https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=4d75db679457b5b7e04271f5174d9128d7d73ecf
https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=db549be42740d286ee6ec8b2860b4e4789be2167


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

