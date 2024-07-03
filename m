Return-Path: <linux-wireless+bounces-9935-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4ED926638
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 18:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13C11C21666
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 16:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572421822CA;
	Wed,  3 Jul 2024 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyrOl+Sa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33238181B90
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720024523; cv=none; b=PYdilpEIuvQtQOBJ9LkkeVcSUgA9z8OL3b+npOvvUrC2dui9qf8Kqi5qvwDMtB03g51fW9JWisUbSmkVXLY0mk8nC3icxmEX8jHQumb8ifKO6lbq0TeQtW9nE/V5v0hUyik8ZqEu7CU/EUmUNSn2vtoLmxE+K6QhC2TLEZhIN54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720024523; c=relaxed/simple;
	bh=gphMZVvRgHchK7XILZC34t8RVBHPKE3MmWl7TbtczWU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ZBJd63EMJC/riPfyq0RY04ktvGt0ngI+n71lwHA53F7uIZY4lm14oaA28/BWpX55DaE/6u4CfSRn5GRUEPGa7Xes5GFvPTYUI9lHuoFpVKMzdFJ2cX15TYgVPDYJ6TgiJ761rTdgNV5biRwBZQmhdbrKh6XtUkQfzRw8BWycGWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyrOl+Sa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD742C2BD10;
	Wed,  3 Jul 2024 16:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720024522;
	bh=gphMZVvRgHchK7XILZC34t8RVBHPKE3MmWl7TbtczWU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=NyrOl+SaLysJQK9ocAK2sHMEXpdb1EPb3PMZFktRTcM8JZqNM9VuC078GHJvzWxZY
	 jvLqIQhKCNcM2cc7z7fPnHoD9nxryt2XPZRf/qygF5r0QYvWuh64oeIOKwIlmmZW6k
	 K1QgPhsUmkhpvTzFRkgE4Pnd2TQndbXodFIo4y0Qq/mHmTeWXA/JQsFaIVnONhdUEP
	 laMaTjAIEAzfNt8KMvlGzLUgY6GeK/9RX2kIxfIOKw7YEGMEOtEdav7iZYTTaXsShh
	 dAwQlB9AEwpocCwuh3x8TuVQqTjW98As+5ZaYTNG8eEZMXtv2vV81hH7FYgWZptmo4
	 3TXxMaphMsuTw==
From: Kalle Valo <kvalo@kernel.org>
To: Harshitha Prem <quic_hprem@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,  Jeff Johnson
 <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH v8 6/8] wifi: ath12k: Introduce device group abstraction
References: <20240531180411.1149605-1-quic_hprem@quicinc.com>
	<20240531180411.1149605-7-quic_hprem@quicinc.com>
	<87le3iqkbe.fsf@kernel.org>
	<e0ed9e43-a795-3e47-dcd1-15b43fa96ef0@quicinc.com>
Date: Wed, 03 Jul 2024 19:35:20 +0300
In-Reply-To: <e0ed9e43-a795-3e47-dcd1-15b43fa96ef0@quicinc.com> (Harshitha
	Prem's message of "Fri, 7 Jun 2024 18:59:09 +0530")
Message-ID: <87a5iye8mv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harshitha Prem <quic_hprem@quicinc.com> writes:

>> Like I have said before, for adding any new locks there needs to be
>> a
>> proper analysis for the locking and good justifications why new locks
>> are needed. I don't see any of that above.
>>
> Sure, Kalle. Will add the details for new locks. As grouping has to be
> done in synchronous manner lock was introduced.

The problem with Qualcomm code is that new locks seem to be always added
without any analysis. But if these new locks are being continuously
added the code will become so hard to maintain and convoluted.

I can understand adding ath12k_ag_list_lock (it's just badly named)
because there is not really any other way to do it. But this mutex_lock
looks so suspicious, has anyone analysed that?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

