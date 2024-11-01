Return-Path: <linux-wireless+bounces-14805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5219B8BDE
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 08:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B034B20F95
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 07:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102571527B1;
	Fri,  1 Nov 2024 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSzyzB5O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE155D8F0;
	Fri,  1 Nov 2024 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730445210; cv=none; b=S3mukAsZnjsegBP2wtie+wyEhSEnuts3UrRwOx4XLf+yMT6gjywcvECLw6o+7VSj2C+7m8at/902gk5MpYndFqy4ig5K2FB359eGx2CbQs9FaSe1fc8f4BLJWmxjN1A5/UXYxLFkqoF6FJ/sa4KLWIH2MhyNhJG6qRN+wHK63+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730445210; c=relaxed/simple;
	bh=65mHG/gQbO0bghA/+3XcpkV95y69tpUKZd+HIYkrOok=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=HljWahQmJi90Gu+aV6z3/IvgLxYtm3LgnOrNWx6BB/DoKtXjLcvMR3zq9ZN0pwyYPMDLWvL3gfoJUSeW4RsxdXpeSKohqCzoLO7yab3tHwdFpLcIH5xJ3Ms6UjDYEV/HKc7BuvOWwbRFd53nkd42SHGFMRvmkJfDEvkpCupnuDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSzyzB5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8D7C4CECD;
	Fri,  1 Nov 2024 07:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730445209;
	bh=65mHG/gQbO0bghA/+3XcpkV95y69tpUKZd+HIYkrOok=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=SSzyzB5OX1M+33pEQuecASDiljhV/QgVGMlb432OkRP1ep9t59GDc+zR+EHSSyHca
	 4hpXd0WtbmPM2ut5ZQpM6HzNWfZnQJpQANkvox3uLEitXdHb35KnP5LYwC205NVGO1
	 4rJdstSsRQOsaEw8DOB5aU+Jz7tZ6/HlyQTiqKfnP3JTQ2sBySJEcc9pCKDKRQR3ZS
	 ByWWs7XlJpKSvD2tJA3n9GcjXjjDKfxy9BgiSkhQgqBHFeyqnvC5II5BICVi6s58ZH
	 G2WG3+7tNE8cgyoyHRJZ5BXkxSdGyKzyaneibIcMDRZWIX/f2ohIgqd3SgO3P7v0wG
	 5fsYRFTZIQQrw==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
  "stas.yakovlev@gmail.com" <stas.yakovlev@gmail.com>,
  "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,  Abaci
 Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2 -next] wifi: ipw2x00: fix bad alignments
References: <20241101022215.6667-1-jiapeng.chong@linux.alibaba.com>
	<85f5348dd18949f5a4033dad982882ec@realtek.com>
Date: Fri, 01 Nov 2024 09:13:26 +0200
In-Reply-To: <85f5348dd18949f5a4033dad982882ec@realtek.com> (Ping-Ke Shih's
	message of "Fri, 1 Nov 2024 02:43:52 +0000")
Message-ID: <878qu3zasp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:
>> This patch fixes incorrect code alignment.
>> 
>> ./drivers/net/wireless/intel/ipw2x00/libipw_rx.c:871:2-3: code
>> aligned with following code on line 882.
>> ./drivers/net/wireless/intel/ipw2x00/libipw_rx.c:886:2-3: code
>> aligned with following code on line 900.
>> 
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11381
>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>> ---
>> Changes in v2:
>>   -Replace the & in the if statement with &&.
>
> I feel what Kalle meant is like this:
>
> if (ether_addr_equal(hdr->addr3, ieee->bssid) &&
>     (fc & (IEEE80211_FCTL_TODS + IEEE80211_FCTL_FROMDS)) == 0)

Exactly, thanks Ping.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

