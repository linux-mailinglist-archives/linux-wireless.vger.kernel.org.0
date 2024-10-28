Return-Path: <linux-wireless+bounces-14583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3380F9B288F
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 08:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA3228248F
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 07:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB3F19047F;
	Mon, 28 Oct 2024 07:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6bOOBlm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AFF19006F
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 07:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099588; cv=none; b=HD09IubWIq9siajBp7Lkb/vJycuGlsV/onTIDz6Qbfw48fcrumkfMnTzCNSLHpGB2Xhyuzo+nKdIcsje4ExH6/3p51QY42zgQQmFGhCYqGm2GdSHO9BPJIMCW+tLgyVaOMwf9tZSKkCYYePHPiDuHkSQSD9oKdBlHODTJKcsJcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099588; c=relaxed/simple;
	bh=dgAVDT6Vy5fKwsG0YhvrZR5x3z6l+4Zs1cbZfEruAe8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Kv5kdjI8f1cf4pemiBnHW/1SvNp/jl0I3nDRM46iMS9LXVDhEj99R47exmrmDe4u5qa8o8uoz0nseCNTn5BxI6kjZ0mDPA2d5p+/5hkDgx9KcdYFqY0FmdpdkOmaazY1UZd2O9q1mGNYnUgN6mTZPJiJWQitISeN34hwFr5TOLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6bOOBlm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39660C4CEC3;
	Mon, 28 Oct 2024 07:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730099588;
	bh=dgAVDT6Vy5fKwsG0YhvrZR5x3z6l+4Zs1cbZfEruAe8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=G6bOOBlmoG3qwvjs7wR8dyuQtkzLIw93t78OYh12hImyQdaWvdkDbi5e81k65gMvW
	 s/q2+DfqjR40fAFkelgC0PZMETYBVLAhoSAYMHOg7iH+o6e5R571fn/yNU5V+l1ih3
	 jbTgbQHZ11tK6tETC0u7509iLSqVkbIMaDNVLDUgcDU9ZHPbxcB1JySsGmNrSkrHxW
	 N3yI4XqsU13h5QzuDnadbIyPf+ysSbhwxZm0TOHc9RjWcXHP1a19EV2t5Ta+5JYht3
	 tuE3lQ7kjtn/cSeQgZuMI7jvZ7gaepc7ZtyOqtqaofig+WU0CVsy6H4vwJR54nsry5
	 PEmdpnj4rGWAg==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 08/11] wifi: ath12k: delete NSS and TX power setting
 for monitor vdev
References: <20241016065700.1090-1-quic_kangyang@quicinc.com>
	<20241016065700.1090-9-quic_kangyang@quicinc.com>
	<871q09rgg8.fsf@kernel.org>
	<f605fb9a-28ad-4aa8-a66a-085a7229f629@quicinc.com>
Date: Mon, 28 Oct 2024 09:13:04 +0200
In-Reply-To: <f605fb9a-28ad-4aa8-a66a-085a7229f629@quicinc.com> (Kang Yang's
	message of "Mon, 21 Oct 2024 17:21:11 +0800")
Message-ID: <87h68w3dkv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kang Yang <quic_kangyang@quicinc.com> writes:

> On 10/21/2024 4:46 PM, Kalle Valo wrote:
>> Kang Yang <quic_kangyang@quicinc.com> writes:
>> 
>>> ath12k_mac_monitor_vdev_create() will set NSS and TX power for monitor
>>> vdev. But this is not needed for monitor vdev.
>>>
>>> So delete them.
>>>
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
>> Does this fix any known issues? Or is just cleanup?
>
> Clean up

Ok, please always mention this in the commit message. In essence you
need to answer to the question 'why are we doing this?'.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

