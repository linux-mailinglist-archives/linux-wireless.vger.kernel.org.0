Return-Path: <linux-wireless+bounces-4402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CE6872772
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 20:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C582DB232A4
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 19:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDC1250FE;
	Tue,  5 Mar 2024 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmbEN/Qd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B491E1B809;
	Tue,  5 Mar 2024 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709666461; cv=none; b=UP3PLwFq5ByUDQNlZjkwKVulE7BBs3J0YVnQWbAttTLdlwhCiEbR8z7XphGh4KMhf0tfsCu7YagttN73OTKoMBHAjgsm6kOH3YxbExzX2Cx03Kx7eugJVGLamn9YAGa1nKzSwXDjc5IF8vOsDmCrQsi2RKsruQVXiRhUgx7xmt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709666461; c=relaxed/simple;
	bh=jG8PjPDjHjrzDu50mfZQbgkQ+cDwgQ7Iq6c6nCmgzwY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gmJsKvQwwhVwZXmlA9wZ5oxbNpnFRun+YGEB4N0Lhw+kShhmZuUYkc2IXWNM0OIKFEAtD3tevdmgWg4Aiq2UBcWPTWYLgQhPo32DOJJranmvZ4X1Pg9cKrgMEWj13Exy1L5sliuggq3UC4JrbT+ktwaEBZWomZO8ZjW1/WOwyWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmbEN/Qd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03ED8C433C7;
	Tue,  5 Mar 2024 19:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709666461;
	bh=jG8PjPDjHjrzDu50mfZQbgkQ+cDwgQ7Iq6c6nCmgzwY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=kmbEN/QdufeshqadsHgjXE85SU3L0z8KHYggPny+2OevlwR1rTVgV4izDZkSg7jDy
	 AvLvND/kK6D2n7r8ZKDdUfPmZeZQSZUId0sIvZmHnUMHtklpj+b71cwtdL8Ao0IpWN
	 1lSEmghmvIMKt3osl/fCUkBO3UYwlY1Jo/yVJHIMJgr8xoFQWXH7pQVc6lK/Pj2sFK
	 WhsHrSEa01JM59SjumY/bwDWuhNggOdhwGQZdLpGtSBSC9MgdBG/c0FEs599QjWb1b
	 5hJifFFcfbXErF3xU4fwoHxjy0OHuqjEYjrLxlM7YVM9MX+AO1HOi33rP8XAjW+8bg
	 iyZfVC9hXj6Qg==
From: Kalle Valo <kvalo@kernel.org>
To: Marc Gonzalez <mgonzalez@freebox.fr>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  ath10k
 <ath10k@lists.infradead.org>,  wireless <linux-wireless@vger.kernel.org>,
  DT <devicetree@vger.kernel.org>,  Rob Herring <robh+dt@kernel.org>,
  Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Pierre-Hugues Husson <phhusson@freebox.fr>,  Jami
 Kettunen <jamipkettunen@gmail.com>,  Jeffrey Hugo
 <quic_jhugo@quicinc.com>,  Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
	<b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr>
	<871q8wk7o3.fsf@kernel.org>
	<3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr>
	<87wmqoilzf.fsf@kernel.org>
	<c58e67e6-6a7f-4963-86b9-580165bf05ba@freebox.fr>
	<87cyse8j9m.fsf@kernel.org>
	<6d4b1381-c121-4cda-a8c9-9ccac56bd447@freebox.fr>
	<87plw87nsc.fsf@kernel.org>
	<0816f7bb-3c97-4b90-8e19-191552ea6e26@freebox.fr>
Date: Tue, 05 Mar 2024 21:20:57 +0200
In-Reply-To: <0816f7bb-3c97-4b90-8e19-191552ea6e26@freebox.fr> (Marc
	Gonzalez's message of "Tue, 5 Mar 2024 18:32:20 +0100")
Message-ID: <87h6hk7aee.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marc Gonzalez <mgonzalez@freebox.fr> writes:

> On 05/03/2024 15:31, Kalle Valo wrote:
>
>> Thanks, this is exactly what I'm proposing.
>
> With your suggestions, the patch becomes much simpler:

Nice, looks good to me.

> I need to build a kernel + rootfs + FW to test the proposed solution,
> then I can spin a formal submission.

Yeah, please do test this to make sure we are not missing anything :)

> (I didn't understand why this patch requires Dmitry's series?)

Dmitry's patchset is needed so that we can have board specific
firmware-N.bin files. At the moment there can be only one firmware-N.bin
(ath10k/WCN3990/hw1.0/firmware-5.bin) for all boards with WCN3990.

Your patch can be applied to ath.git independently from Dmitry's
patchset but we need Dmitry's patchset applied before updating
linux-firmware.git.

> Do I need to submit a symmetric patch to linux-firmware to define bit 23?
> And also a patch to add the bit to some firmwares? (All msm8998 FWs?)

Me and Jeff can handle linux-firmware.git submission. We will also add
the new bit to ath10k-fwencoder.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

