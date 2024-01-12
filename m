Return-Path: <linux-wireless+bounces-1820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065B382C30A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 16:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4861F2513C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 15:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A344A76909;
	Fri, 12 Jan 2024 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vH+Z0++E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D24768E0
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 15:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E299DC433C7;
	Fri, 12 Jan 2024 15:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705074418;
	bh=igEeV4GkCvqUGqVrM5kh4M1lITRFNUlb7FBFynlbMJI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=vH+Z0++EVXTiW4epCVxhtxdJs+02tksp8zU2XTP0lVUM+7dwVMaPRoFGK9bV1f4pS
	 +7EReTkt3uUeBzy/xb6pVn3s/bUGc6H0lwv85TBKkTz+24vfvkmEYZxgDPH/h0zXcE
	 JhD4rDZiU/BIliE6VkcNmKDPhOyXo/H/KiubJ0VLPmxsicyOWtxXcEIl1J6KwAzZAu
	 ivHp0Nz3FHx2HUtOAFZz871gEMF4CtSzz6mB32/+1ZiEbWaxGP7hLqGH+L0nKdVyC3
	 rcgt+ZHKtUr0UBKjuBIn52LXVyDhuCDxe2OTGmFxNOBShUsv9IFpYTVZnePHRgRv6G
	 vXlfRiJLsFlEw==
From: Kalle Valo <kvalo@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  Baochen Qiang
 <quic_bqiang@quicinc.com>,  ath11k@lists.infradead.org,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 2/2] wifi: ath11k: add support for QCA2066
In-Reply-To: <20240112-dangerous-cow-of-excitement-fdbaa6@lemur> (Konstantin
	Ryabitsev's message of "Fri, 12 Jan 2024 09:38:22 -0500")
References: <20240109021336.4143-1-quic_bqiang@quicinc.com>
	<20240109021336.4143-3-quic_bqiang@quicinc.com>
	<e19baf59-c17b-4e2b-96d7-f4fc9812c99a@quicinc.com>
	<56282bad-b59d-4572-a6f1-1b905bf0edbd@quicinc.com>
	<da6ff953-07a4-4226-a7dc-b816f8dc5724@quicinc.com>
	<20240112-dangerous-cow-of-excitement-fdbaa6@lemur>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 12 Jan 2024 17:46:54 +0200
Message-ID: <874jfia70x.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On Wed, Jan 10, 2024 at 08:20:46AM -0800, Jeff Johnson wrote:
>> Unfortunately automated tasks don't parse cover letters. But it looks
>> like b4 doesn't handle or warn about:
>> prerequisite-patch-id: 640366721125b1adea0eeabd5cdfca5e91476e7c
>> 
>> And not quite sure how it would handle that.
>
> B4 should be able to handle dependencies like that in the future. For example,
> we can already locate this patch using:
>
> https://lore.kernel.org/all/?q=patchid%3A640366721125b1adea0eeabd5cdfca5e91476e7c

Oh, that is a very useful feature. Thank you.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

