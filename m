Return-Path: <linux-wireless+bounces-5797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F93896CBE
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 12:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9E11F2D09D
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 10:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39A013DDAC;
	Wed,  3 Apr 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qwfh1pkA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF30219E0
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140695; cv=none; b=XF6aRWnq/uOepp8rP9LzSBj+dFTVvaKwryKw1/6XKs27rdSI8mxaWILvZwYBbMm1l3r7T84FqrHLAzAVrYB3ycaGeViykdENBlZATJVWBHKV3zxjpyoZmfl59kkyYaq2WNbu+ip4+I/GX6ATE9AoXL+zkHYyCmx/4KAz0QTekro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140695; c=relaxed/simple;
	bh=nRxqRG35XPkOm9ujEDT+vmy7suP6a7xyli/k/7DN3Tg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=neXxUz+GzqzDYxYNw4Sty0sX5TVdWh1S4w9iU4gB1NY08gg+ojsyZirK/z9ZH2JQUoeO0Y0svXDsJwEvSrCPiikR2dmwxorNOvB+4uz+z3fKa2u1gjmTzWYSth4MnN5UYe1AJs94mdlnXIHtzgyukoJynRI+TcXDZYaUe3Y7KyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qwfh1pkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F172C43394;
	Wed,  3 Apr 2024 10:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712140695;
	bh=nRxqRG35XPkOm9ujEDT+vmy7suP6a7xyli/k/7DN3Tg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Qwfh1pkAa435kxRTaAYYZfQo1Y4XsW+MhwGNUOyYrbY//z8IzN9yzrGX+EYeqpp2S
	 bHvPem3HjxCDF3LZ5ygn1ITjbOFPNU/E1lwi/VdnCnzAAvcnGz/0HQXZ89PaY7U6bQ
	 WqTDnz27ohJnWRbq6rdLVAs+x0/fw+JIdI7clhIpFD8bjZsi4ICjhjJ6qHmDJpoW0Z
	 Wgb2cDhmc+2axcmdtsg0SMJfKLp6IAO/YcGGGnPoC7MmJOyPOKsvTzZFTqvS/Yl/SY
	 4zbHLCy/x4lowgelWGiFdsp9A1F22CB9vKxvU7Num8nWI/XAdzlGhwVRr3DoCXelyS
	 N/B53805Q77BA==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] [RESEND] wifi: ath12k: refactor the link capable
 flag
References: <20240403042056.1504209-1-quic_periyasa@quicinc.com>
Date: Wed, 03 Apr 2024 13:38:12 +0300
In-Reply-To: <20240403042056.1504209-1-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Wed, 3 Apr 2024 09:50:54 +0530")
Message-ID: <87o7aq68a3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> extend the link capable flag to accommodate inter-device capability.
>
> v2:
>  - Rename the terminology from chip to device
>
> Karthikeyan Periyasamy (2):
>   wifi: ath12k: extend the link capable flag
>   wifi: ath12k: fix link capable flags

Why the resend? I'm not really a fan of these "RESEND" versions. If you
need to resend something simply just increase the version number (in
this case to v3) and explain in the change log why you sent v3. That's a
lot more clear for everyone than having "v2", "v2 RESEND", "v2 RESEND
RESEND" and what not. It's not like we are running out of version
numbers ;)

But no need to resend because of this :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

