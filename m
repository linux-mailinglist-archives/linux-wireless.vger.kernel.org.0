Return-Path: <linux-wireless+bounces-20898-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3CBA74076
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 22:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D5C189A08F
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 21:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A3D1DE2B7;
	Thu, 27 Mar 2025 21:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJN7psxH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2221DDC2E;
	Thu, 27 Mar 2025 21:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743112670; cv=none; b=Fe+sXZHobJa6+1P7H+6FJvh+BH2ugMwZjdHZ3ERgs+2FrzGwuDTfJf4XnMWguE0Og1erRd2JAOjgHdJGSRdyJttVgx9q+E+UIvOSIQMs6zSbQZwzl/4JMhTx/5TVF9SCBXaGpjQ0BU8Z8lMJROz+ckrh/ZChNYf8mMOE+7K8g7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743112670; c=relaxed/simple;
	bh=yrJ82et3mj4de5bHGMGo8C0V7xBVxSQ6fqTazodMdsM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oGN5Oy3SB5t/MqX1BE+B9n5JpEMQcpdX9uZVK/J+36Hdu+WcBwb611r22xpZeAu8e7PNUtv+CQy8E9cgCreh1ovA70f9g6KxIYEmkRg8dZHRHq7BtdSK1FOCp7CozLvM1+QK4upSGAP2uLqsqKLJ3WPyiO5W88/RaeP4a52wJAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJN7psxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3B8C4CEDD;
	Thu, 27 Mar 2025 21:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743112669;
	bh=yrJ82et3mj4de5bHGMGo8C0V7xBVxSQ6fqTazodMdsM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XJN7psxHDpp4GXjsNfkTOLtqTVZ25oYnkuVwp26YN2Zc14nkLj5oolvFlHVpgw/Hf
	 2+QLJBavHNVCJHD7dNlv/nUwJSiFEoZxKh13Ck6po89Wfc+HDJGmn9ZCLT/2nEYTsn
	 ZCNqmMwiknbXVoIe1BVly3J35P4V2Ues6kHiWw7T/Fbp5HKRM8q2FU4VtZns+Pl4M4
	 iMKo5wPw9kFkOHrWNUkZaYpS1oQOs32jeUUbxnOzcHugglnQBemyiVO1AxMnmoGzkX
	 E7T7NMIUxYyEjZnIJyzqBg6e0wnITTul1cNUAOFb7EnVC5oIvRGtGM4SfWjAFzSVOr
	 Sc84sNn3gBiSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEBB380AAFD;
	Thu, 27 Mar 2025 21:58:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH RFC 00/10] Improve ABI documentation generation
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174311270549.2230226.7159828218594723399.git-patchwork-notify@kernel.org>
Date: Thu, 27 Mar 2025 21:58:25 +0000
References: <cover.1737135484.git.mchehab+huawei@kernel.org>
In-Reply-To: <cover.1737135484.git.mchehab+huawei@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, corbet@lwn.net, gregkh@linuxfoundation.org,
 suzuki.poulose@arm.com, james.clark@linaro.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, johannes@sipsolutions.net,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 mike.leach@linaro.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jonathan Corbet <corbet@lwn.net>:

On Fri, 17 Jan 2025 18:59:29 +0100 you wrote:
> Hi Jon/Greg,
> 
> The main goal of this RFC is to give a heads up of a work I've been doing to
> replace the get_abi.pl script with a python version.
> 
> Patches 1-6 are OK to be applied:
> - Patch 1 changes the sort criteria of the ABI generation to use alphabetic order:
>   currently, it is *almost* alphabetic, but, on some cases, it orders on a different
>   way. No changes at the content, just at the order.
>   I wrote it mainly to use the same sort criteria as the new tool, but IMO it is
>   worth applying even before we switch to the python version.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,RFC,05/10] ABI: sysfs-fs-f2fs: fix date tags
    https://git.kernel.org/jaegeuk/f2fs/c/90800df0da78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



