Return-Path: <linux-wireless+bounces-15548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDC39D4B41
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 12:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315B9B24AD3
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 11:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287E01D0DE6;
	Thu, 21 Nov 2024 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRD2Xue4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F397815C120;
	Thu, 21 Nov 2024 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732187126; cv=none; b=cz8jxg6zFI9xhYVqmVqTYpyYoXjT+TOVqh7YFVPdRWsritMqKK6kdPTzc9WnRd2XayeUW9SJ8t+1zOdMQttUkOt/g2GaQTuhovPP6Le/0XHfi0Od3qUzNzmDH9l3aSywxbHGDWCwf17cT9XKbX1dwZxlAmCPjqdcH2WZ402d4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732187126; c=relaxed/simple;
	bh=AGvZ1bo3QHRClGESY5fZrGfulh5ci0G55GUsSOsJW/0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=nsboL5AI+H75JR3pf5dbt//oM4jmshNDbZhpAXaPwS/9dea6rg3ZZn1QPG/kuFdxht4IZhWExX1p21kFACO+506pdoyIZesFtfD9uDbswve8+OQ+UH91ywFpt81624Qyk7SgPJ4NO7dB/zm9Cy6W6wCs9EeOAR6sZNz69g5B3RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRD2Xue4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50339C4CECC;
	Thu, 21 Nov 2024 11:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732187125;
	bh=AGvZ1bo3QHRClGESY5fZrGfulh5ci0G55GUsSOsJW/0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=fRD2Xue4Xe8kLpjImXWNySN6VFB4vwlhRNmaIIzFG+J/AmjGSi1XkwyVCSBYY7Ftr
	 m8QOCcdySMJY8jQMPNm0BmdfVHoUjxpw2VIqwKgde/502FfxjuVRkxwzxDCmfPLiTx
	 OJ+dixkc6BMlkbaTtVgtYCQ5YqzjQ66omikQn6JXQDlvQ/29yclCpwsPlirPT2Tjj3
	 eTUjYrXNeIiRvK3pR6UstKtSa9GR04SRqs7oA7KVpCFowTW1o7Oh/U0E0hAGafUCCk
	 cH5+V6co5+86F4u/ot/RsrO7ber5Faii9f4FQIrLJ+0lfghC/CxrazN1+KpjxH51jQ
	 3STOPPNMBveJQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,  <ath11k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath11k: add support for QCA6698AQ
References: <20241031000541.3331606-1-quic_miaoqing@quicinc.com>
	<bb1c77cb-7efc-4c85-a946-5394b9105416@quicinc.com>
	<87o72k4hxk.fsf@kernel.org>
Date: Thu, 21 Nov 2024 13:05:22 +0200
In-Reply-To: <87o72k4hxk.fsf@kernel.org> (Kalle Valo's message of "Tue, 12 Nov
	2024 16:59:03 +0200")
Message-ID: <8734jkyhhp.fsf@kernel.org>
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
>> On 10/30/2024 5:05 PM, Miaoqing Pan wrote:
>>> QCA6698AQ IP core is the same as WCN6855 hw2.1, they share the same
>>> PCI device ID, the same major and minor version numbers, the same
>>> register address, and same HAL descriptors, etc. The most significant
>>> difference is that QCA6698AQ has different RF, IPA, thermal, etc.
>>> 
>>> Follow the approach done in commit 5dc9d1a55e95 ("wifi: ath11k: add
>>> support for QCA2066"), enumerate the subversion number to identify the
>>> specific card.
>>> 
>>> Tested-on: QCA6698AQ hw2.1 PCI WLAN.HSP.1.1-04479-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
>>> 
>>> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
>>
>> Am I correct that this satisfies at least a subset of the devices you were
>> trying to support with the following?
>> https://lore.kernel.org/all/20241024002514.92290-1-quic_miaoqing@quicinc.com/
>>
>> If so, can you reply to that thread, pointing to this new patch, and elaborate
>> on what is now supported and what still requires ath11k to support
>> board-specific firmware overrides?
>
> That question is still open but otherwise this patch looks good to me.
> But I'll give an Acked-by only after I understand what's that "NFA765
> m.2 card for IoT platforms" mentioned in the other thread is.

Miaoqing provided the info offlist so:

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

