Return-Path: <linux-wireless+bounces-5103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ADA885F08
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 18:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88081F231FB
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 17:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB578142651;
	Thu, 21 Mar 2024 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G81zQ6MD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E081428E1
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039978; cv=none; b=FpFcbb7XBz78G5YAXl2GQiSfCWLa09Taqw2QG9xy/IaUPJ7djNlGaVKxyRE6zgOVOm/Vkzf293NcGEZjN+6jGH7tnyzKIjqFe/fEPIFVLMCLJxZTpj7KoGij0BmTPoBOpw6apEHdD2xEeeFJtRKXk4b/k40gq04/DscNlK+uYwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039978; c=relaxed/simple;
	bh=MsrA7XiKs3c7x/GsarYSR+iS7sB0sU30tZufhfb/yzw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Lsb3Iaz7qfiwdz/eErYUD3IgbpIuSbX8ex24twTa9DSa7bjc7VPjGv93n+ZcFUqnFZBRJO7NtfFfclq72/n94l+h2H4qZsnjWNThv+Br/N84C0YKB57U94DlJqAFn9czRm2RfFT7zv98viyPBEohbxoL2n5QiNt/fovIi+cOU8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G81zQ6MD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C767C433F1;
	Thu, 21 Mar 2024 16:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711039978;
	bh=MsrA7XiKs3c7x/GsarYSR+iS7sB0sU30tZufhfb/yzw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=G81zQ6MDuKsUEGuOFRZYDtPCKjuuov6X698zwwLTXWch985x/Tx5yLxQpSuuSW0UM
	 Qt/y4+5hj+zF2DNr7orZSaAXX5mM41owioJkZIndl56znE5+QFt5cJD+GXa6u0dLdp
	 yn6/y4ax0O9y1yzGoet1zN463uNSpTW0PmIzagzDZhKPZmARvPOJ67FfN/ifBbN3gu
	 YYUiR9ZNxaBEmoWBq3PndwlaDIEPLmQkRf/wCTElUU3Wtaa6+tgKDWMe4LWzMVxfyO
	 Mk+y2mSJGWQnnyNpr9/uKHv+gJ0UhtNop5RDiRvvCps7G2WjAx5zSZe/iZi2f9BcQu
	 J6FS1aGar1jTQ==
From: Kalle Valo <kvalo@kernel.org>
To: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Cc: nbd@nbd.name,  lorenzo.bianconi@redhat.com,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: mt7915: workaround dubious x | !y warning
References: <20240321153437.403259-1-kvalo@kernel.org>
	<06508917-f7a0-4ea7-b9da-eb392da9171f@green-communications.fr>
Date: Thu, 21 Mar 2024 18:52:55 +0200
In-Reply-To: <06508917-f7a0-4ea7-b9da-eb392da9171f@green-communications.fr>
	(Nicolas Cavallari's message of "Thu, 21 Mar 2024 16:51:07 +0100")
Message-ID: <8734sja5nc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr> writes:

> On 21/03/2024 16:34, Kalle Valo wrote:
>> Sparse warns:
>> drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:526:9: warning:
>> dubious: x | !y
>> Workaround it by using the '?' operator. Compile tested only.
>> Signed-off-by: Kalle Valo <kvalo@kernel.org>
>> ---
>>   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
>> b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
>> index 450f4d221184..3f47aafb1a6c 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
>> @@ -523,7 +523,7 @@ mt7915_fw_debug_wm_set(void *data, u64 val)
>>     	/* WM CPU info record control */
>>   	mt76_clear(dev, MT_CPU_UTIL_CTRL, BIT(0));
>> -	mt76_wr(dev, MT_DIC_CMD_REG_CMD, BIT(2) | BIT(13) | !dev->fw.debug_wm);
>> +	mt76_wr(dev, MT_DIC_CMD_REG_CMD, BIT(2) | BIT(13) | dev->fw.debug_wm ? 0 : BIT(0));
>
> clang says "bitwise or with non-zero value always evaluates to true
> [-Wtautological-bitwise-compare]"
>
> It needs some parenthesis.

Thanks, I'll send v2.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

