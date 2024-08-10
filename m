Return-Path: <linux-wireless+bounces-11245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A26B594DB3C
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 09:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21E41C2109B
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 07:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122694E1CA;
	Sat, 10 Aug 2024 07:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMFN45cl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FE44409;
	Sat, 10 Aug 2024 07:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723275642; cv=none; b=JNQRCyECnD7rQ6m/XZlnd9xtfeyFHctorNNQeJBZZhquJhOG2dmyK6TolK/s9ndi4k/V5ZkEcekaC6idVvkQ40ueqRqLRZvo8GXMJUBNDTfnm1tp81CHcbyGjbGwI3TyU4ezwCJPH6BFYIVKE0pq2BWcevciqKv9Bahrv0uhON0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723275642; c=relaxed/simple;
	bh=Nl4OXvIMotYY8Q5haHsAFwkxwm98GxGwhJj9xrOO2HM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=caaJV3vWhYmVzsrhIbFa2Asr+lFsVJorYQXSIDFYrAYCkzc0YhIxj6wpiytNiuEOjpnynav0gAy+JZ9Q6RM1Ml1I4C86/R3UUzIu9qFVh91goB895BWpX9ieiuGpOhbJNbo7Kej0PgHrHMooQxvzdYjm7CmRdPvqknYF9sbKRLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMFN45cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10228C32781;
	Sat, 10 Aug 2024 07:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723275641;
	bh=Nl4OXvIMotYY8Q5haHsAFwkxwm98GxGwhJj9xrOO2HM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=AMFN45cl3GpwU/lkaJfHgWJznULD3wnjCEP2DnpKPRAckch0vUiNbLpYlZIZ88S6s
	 T/rPXslunD5T4G8yDM28Upn8QFszVYune9pejqu0WlbRLZqvgp6PJhkXcidCoAX5ku
	 epFg9gd0kJ8N/g92xNPXpTC8Qj87yMS1Pp1HDQWHTbGuQb/wZ7mDwyjCwzMzsu+qiA
	 wo4fCVMkly7QD+jJ8rqO/z+WvekaTRolfc59ZXRE1NbleUbttbpCOBcUNuStwvDLJt
	 KZfma8pDxlTKQS5j09dhOuTbatVZJlM4wv7i47xMsz7LXVYR8HR/KVf/KGGEnndcK2
	 ZlED+gd4cNDFw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [next] wifi: ipw2x00: libipw: Avoid
 -Wflex-array-member-not-at-end warnings
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ZrJqtUpCI+uCeb4D@cute>
References: <ZrJqtUpCI+uCeb4D@cute>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Stanislav Yakovlev <stas.yakovlev@gmail.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172327563820.395581.15278397593129937648.kvalo@kernel.org>
Date: Sat, 10 Aug 2024 07:40:39 +0000 (UTC)

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> So, in order to avoid ending up with a flexible-array member in the
> middle of multiple other structs, we use the `__struct_group()`
> helper to create a new tagged `struct libipw_hdr_3addr_hdr`.
> This structure groups together all the members of the flexible
> `struct libipw_hdr_3addr` except the flexible array.
> 
> As a result, the array is effectively separated from the rest of the
> members without modifying the memory layout of the flexible structure.
> We then change the type of the middle struct members currently causing
> trouble from `struct libipw_hdr_3addr` to `struct libipw_hdr_3addr_hdr`.
> 
> We also want to ensure that when new members need to be added to the
> flexible structure, they are always included within the newly created
> tagged struct. For this, we use `static_assert()`. This ensures that the
> memory layout for both the flexible structure and the new tagged struct
> is the same after any changes.
> 
> This approach avoids having to implement `struct libipw_hdr_3addr_hdr`
> as a completely separate structure, thus preventing having to maintain
> two independent but basically identical structures, closing the door
> to potential bugs in the future.
> 
> Also, remove a couple of unused structures `struct libipw_ibss_dfs` and
> `struct libipw_assoc_request`.
> 
> So, with these changes, fix the following warnings:
> 
> drivers/net/wireless/intel/ipw2x00/libipw.h:403:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/ipw2x00/libipw.h:420:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/ipw2x00/libipw.h:433:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/ipw2x00/libipw.h:441:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/ipw2x00/libipw.h:447:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/ipw2x00/libipw.h:460:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/ipw2x00/libipw.h:468:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/ipw2x00/libipw.h:476:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/ipw2x00/libipw.h:592:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Patch applied to wireless-next.git, thanks.

089332e703b6 wifi: ipw2x00: libipw: Avoid -Wflex-array-member-not-at-end warnings

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ZrJqtUpCI+uCeb4D@cute/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


