Return-Path: <linux-wireless+bounces-10730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A9A942D0D
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 13:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF761C22F81
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 11:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E6E1A4B34;
	Wed, 31 Jul 2024 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKl2B+Q3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1631518DF9F
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424667; cv=none; b=YAAga/aOd6DdPr/TonRUH4vp+mV8Jamev5CzgZFH6CBpswmw9xzyfBLcb6zNs3as3SKHruLKHwMfRbAo9mOjSEf/gMEYxkFZ9RJ9ehDapb5rY19fX14xKOmX44R1v+Dh1qonXhqJbAtCFtXdJVN+rEuHk2JsCwfFFfzaL5wzbQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424667; c=relaxed/simple;
	bh=DTQTgoWxZvK8RJ9XSayQaAZYAsA0HP8BXtkfqrTKbcI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gJDhJ6TH5n7gUBpjCFcKQUsP4VglAMrnyrhoYy8mSJ27TwOcbF1U83QGvGTNOFWaFVZwLFs6nuM92Nhz9UZpTY3wRObFkfknt/ad2kNvHMzT5yqSmBA4idya9sjGey0GXliPsQAN3ES4gN4UBXrVhSq5dxxHokGLsjdUyQO3cPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKl2B+Q3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A906AC116B1;
	Wed, 31 Jul 2024 11:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722424666;
	bh=DTQTgoWxZvK8RJ9XSayQaAZYAsA0HP8BXtkfqrTKbcI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=KKl2B+Q3qQ+25lL3TXbx7rcuBG5Q4THHwdmW5lyB79GOOn4sdqYqmqGjYC0FHrxkq
	 kn/wM6RrtTiwT7gFYM8BJfZglt79UvSyBCn3hm64zHX1A5Jgd1MFsAQ6+O9+aXQoKr
	 ANWdwSpoEZ8aq68dYFy4RUOjCrgIklvT0hFcJweA4Gw/Ib8umpynjmIMLDco0Q1P2t
	 WvljoUph5W/EzqotjucweW8VNezNCwZzsDr9W3vocADkIvfh8tqSCUVMqlKk9rRbia
	 3LvzYr5YTjWnfuPfFGD/ai5myWtS4RTicDaayeMe2376DD47GYpMthby7pjk1lIT0S
	 ZteDAZ9qh0b6Q==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: kangyang <quic_kangyang@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 04/11] wifi: ath12k: fix struct hal_rx_ppdu_start
References: <20240725120035.493-1-quic_kangyang@quicinc.com>
	<20240725120035.493-5-quic_kangyang@quicinc.com>
	<aa2b6791-9d18-479b-a80d-722b99592cb8@quicinc.com>
Date: Wed, 31 Jul 2024 14:17:44 +0300
In-Reply-To: <aa2b6791-9d18-479b-a80d-722b99592cb8@quicinc.com> (Jeff
	Johnson's message of "Thu, 25 Jul 2024 17:17:49 -0700")
Message-ID: <87y15hkdyf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 7/25/2024 5:00 AM, kangyang wrote:
>> From: Kang Yang <quic_kangyang@quicinc.com>
>> 
>> Current struct hal_rx_ppdu_start in hal_rx.h is not matched with
>> hardware descriptor definition.
>> 
>> So update this structure and related code.
>> 
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>> 
>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
>
>

Jeff, your reply was empty.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

