Return-Path: <linux-wireless+bounces-16029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E56D9E8F23
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 10:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94153163590
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 09:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D515A2163B6;
	Mon,  9 Dec 2024 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xn+qMvvb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779D83CD2;
	Mon,  9 Dec 2024 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737751; cv=none; b=jM3vuvPIlYrU1tlBhKGMV7mIvAfZKPFYywTwfjRScPiN1cHwufsSqa+9ILh11fmOMrG+zzP9YNiado79OGIxQ0UGHGDWW+0jO6ZApmxeVkrvs0pHeu2Vvi7LxwMQV8yJMFO1mWPnvaINxBFbxKGAt/Nm6VVGsyVIdJz44Hjm/Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737751; c=relaxed/simple;
	bh=qhrx3ojEXBzEaAfZ+IYNq03LjibZUpkxxO/wLrw5KxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tCXWSal8TGVvzeXXc/+XiS1doUPDwuzp85eWlRJstriMo0f+OkLYeThVQAeFqnDaEvnZpeJI9nKzCwKn8Q+iqCaSbnBaa/xdOiFCCnVllFYgtrDQh0LSePKPf7bj8nxcXYIz5efpPw/7idE9I5C6SI9Fsp49PBQBNOuLf5zt6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xn+qMvvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4738AC4CEDE;
	Mon,  9 Dec 2024 09:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733737751;
	bh=qhrx3ojEXBzEaAfZ+IYNq03LjibZUpkxxO/wLrw5KxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Xn+qMvvbUXfDiIJZ4474c8UVpIOt4pSffXzuVqUvjAIrPAzgJwmJ5K/gTXQKAvmEn
	 4TJKKTsIu3MrD7gIU2K//yTQzOk5EHiSR2Toyxp5u9FgB0ZJIVBTDycXnCiQKEROHq
	 Vxk07kmPKtt7JQhH6+6KpM7OpmJ58ANg1hkto1IdjPmSo6B2aNJsgTK7IGDOVNCCj3
	 k9dhto7AEeh9WzQrnegSkkSlDJS3VOt1SA5rOCZYXRZbSF3vN+bEJxOlrtRzwGBdEE
	 nxoAR3ZoaFuA9I1Pe5zZxwZOOLuK3r1uHEWFA58cIhhWdg0b6+ZVDppVuWyzHvWn8n
	 7O9Yvoqa8cTEg==
From: Kalle Valo <kvalo@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org,
  devicetree@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: net: wireless: Describe ath12k PCI
 module with WSI
In-Reply-To: <20241206-sugar-surely-9efffa93aa5c@spud> (Conor Dooley's message
	of "Fri, 6 Dec 2024 17:05:03 +0000")
References: <20241205203044.589499-1-kvalo@kernel.org>
	<20241205203044.589499-2-kvalo@kernel.org>
	<20241206-sugar-surely-9efffa93aa5c@spud>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Mon, 09 Dec 2024 11:49:08 +0200
Message-ID: <87zfl5rxt7.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Conor Dooley <conor@kernel.org> writes:

> On Thu, Dec 05, 2024 at 10:30:37PM +0200, Kalle Valo wrote:
>> +  qcom,wsi-controller:
>> +    type: boolean
>> +    description:
>> +      The WSI controller device in the WSI group aids (is capable) to
>> +      synchronize the Timing Synchronization Function (TSF) clock across
>> +      all devices in the WSI group.
>
> This should be type: flag btw.

Just so that I understand correctly, do you mean it should be like this:

  qcom,wsi-controller:
    $ref: /schemas/types.yaml#/definitions/flag
    description:
      The WSI controller device in the WSI group aids (is capable) to
      synchronize the Timing Synchronization Function (TSF) clock across
      all devices in the WSI group.

And no changes in the code?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

