Return-Path: <linux-wireless+bounces-4687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345C087AE8C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 19:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E2FFB260A4
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 18:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD5460264;
	Wed, 13 Mar 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9+UVPHD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EF860263
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349129; cv=none; b=O8CDBoulBGNddDxZ0SWJ5NUq3NoTP+SygKw9LMB1wF4Fo8Yzz7fUN0l7VCXfNE+4Nr/JtoA9vn61OfI7eun7VDgT2wRIc4SoSAlGvO95DoOdJSdZZxvElQCMTpD//VrGq298XDAXvnbvKYZWJNG9Fe87gQ2wolauh71pQSot1IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349129; c=relaxed/simple;
	bh=iWmS2Spgv1Gr93S5/dBCQwU7XXs/+racpo5Z0qjdcOM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=jSV2U6nJCuyJO4inPQbQf2GJo4Rdq5zKmh5vuVVZ1LuM5BSB/UrfzIA53O98BvEXMC5C3sTKY0KluKAkYwsApKDIiQ1JSkri13pmAwk74V0ke96p6KA+xpFUMTM/cBJfBTcawTFrqBbyzwb5eD2hSHaSWKyOoTFroI4d9hghqbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9+UVPHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A80FC433C7;
	Wed, 13 Mar 2024 16:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349128;
	bh=iWmS2Spgv1Gr93S5/dBCQwU7XXs/+racpo5Z0qjdcOM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=R9+UVPHDlgOeLelpwakkprs8Z4KeTK82X9TwrOfFkkLbTOUchIIj5x4DgSRkLDOZ/
	 NM6GlgXWyedip6qYiT/zHvQI19NViamWFRZh44NMTyDbngJYTqUKXpzRopv3wZIB70
	 0w2DBRuvlAJ2OUVXrsZC5FKz4bJpVKo7Zix4wWDgdTDAmepoZNNyjjz+pNmdKxfpc7
	 HE7gwH/SRkTchmzf5KwOzz6ROwlYm3UbZtD7HaTiAGtru55KB5FhdSXtK129/aNfHf
	 4dg6YMexRZvDXQHQ9wV2NCI7fXKPKazdeh0KE+Yn0M/AZa61EfTF0dxTPUyd9Ra4an
	 ytgV8LW3w9VAA==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
  <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: Re: [PATCH v4 01/12] wifi: ath12k: add multiple radio support in a
 single MAC HW un/register
References: <20240312135557.1778379-1-quic_ramess@quicinc.com>
	<20240312135557.1778379-2-quic_ramess@quicinc.com>
	<4a527729-2bf8-47ce-8275-d36b76bde95c@quicinc.com>
	<3178cf8c-d328-4fe2-b3be-f5c4c908f20f@quicinc.com>
	<605a673e-3686-47d0-b71b-1e314fde65db@quicinc.com>
	<87il1qf571.fsf@kernel.org>
Date: Wed, 13 Mar 2024 18:58:45 +0200
In-Reply-To: <87il1qf571.fsf@kernel.org> (Kalle Valo's message of "Wed, 13 Mar
	2024 18:48:50 +0200")
Message-ID: <87edcef4qi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>
>> On 3/13/2024 5:57 AM, Rameshkumar Sundaram wrote:
>>> On 3/13/2024 3:23 AM, Jeff Johnson wrote:
>>>> and guess we have to figure out how to suppress the ath12k-check issues with
>>>> this macro
>>> ath12k-check complains about the reuse of ah and index arguments which 
>>> may get evaluated multiple times if its an arithmetic expression, But 
>>> areas where we use the macro in our code aren't doing so.
>>> Do you have any suggestions here ? or shall we go back and use this 
>>> for-loop inline.
>>
>> The macro makes sense -- we'll need to update the overrides in ath12k-check.
>
> IIRC it is possible to avoid variable reuse in macros with typeof()
> operator (or something like that). I can't remember the details right
> now but I think there are examples in the kernel code.

Here's the GCC documentation with an example:

https://gcc.gnu.org/onlinedocs/gcc/Typeof.html

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

