Return-Path: <linux-wireless+bounces-7111-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4797E8B98E9
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 12:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F0F1F2249D
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 10:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA43481B4;
	Thu,  2 May 2024 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iehlM8l7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592FF2E633
	for <linux-wireless@vger.kernel.org>; Thu,  2 May 2024 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714646196; cv=none; b=h4j4Ldqwz45Am3kcBpPfI10oihH2hTuxQaw4THS5VQNf5g+x39FGyfYtrPGsEQReos6xsd9AOgrXGb0jMfU66dYLVrBowb20p1+LHjz1bOZ/AXoTv7c5Aq3gJvbq6QgNwQtp5QRulSSEy02ZmEyqe6D4A3QaF+tTAUCMK/1aFZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714646196; c=relaxed/simple;
	bh=VAmRD8JkQq8NXu53lxFc2/nblIlrbXLg9NxlMjfq5hk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=YUuj9N70EeXf9le4fkcNbNi5+pOnSmc97PfLAnxgNl3NwSSmkvPdhbNEmh4xfrI3GXWu/2Oqdg7kysbde8V3WNHLaVpoh/h0DmrafQ1+Ve5F0mq65KQOkompoG21FuZd7JCKOqNHgO0yXg0Y3jPyuUIsbu9y9HKBXMVcDSK7Lcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iehlM8l7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CCEC113CC;
	Thu,  2 May 2024 10:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714646195;
	bh=VAmRD8JkQq8NXu53lxFc2/nblIlrbXLg9NxlMjfq5hk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=iehlM8l7ARqTjs/HKOkY72UsfktK12OQrhoCIWwqoOL0t2uzVw3LomiytuFJ4gQ3h
	 f3Bu9nXrtM0hmgZgU8dJvIWpKKYZpr2PDpuzNAp2kIYwKmYegaqg53i8MQbm88ncNh
	 7v80Skuo212JgfMIJySMIFr6dgB6m/MWDXTB7zfBdRF50Hxe0LawMw9JpE4iDBSsSs
	 f04QwqdjZYhJDHIPVcsXvNqveu7eFHsZXA8YrqJz2LcBYvjFUcxxpAdlJpNZZANk0s
	 c48j5T9MRQMl3tMTuglZ4ne/w8ZUrt6JwYgkyCxNStEUK0NdvxJGsh3+/iufBbLkuV
	 fMNBL/D/OuSIg==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
  <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] wifi: ath12k: Replace "chip" with "device" in
 hal Rx return buffer manager
References: <20240430165811.1377182-1-quic_periyasa@quicinc.com>
	<20240430165811.1377182-2-quic_periyasa@quicinc.com>
	<26854263-0a16-4b27-9de3-be3d159b8e40@quicinc.com>
Date: Thu, 02 May 2024 13:36:32 +0300
In-Reply-To: <26854263-0a16-4b27-9de3-be3d159b8e40@quicinc.com> (Jeff
	Johnson's message of "Tue, 30 Apr 2024 11:42:34 -0700")
Message-ID: <878r0spkjz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 4/30/2024 9:58 AM, Karthikeyan Periyasamy wrote:
>> Prefer the term "device" over "chip". Therefore, modify the relavant terms
>
> Kalle, can you fix in pending (if there isn't a respin):
>
> s/relavant /relevant /

Yup, did that now.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

