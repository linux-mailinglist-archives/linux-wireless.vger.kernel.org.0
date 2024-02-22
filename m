Return-Path: <linux-wireless+bounces-3893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B992085F0BC
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 06:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B5A2B23B6B
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 05:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCA56FB5;
	Thu, 22 Feb 2024 05:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inhKv/ym"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FEE5CB5;
	Thu, 22 Feb 2024 05:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708578689; cv=none; b=TlZqJSlFFILBZml/mVg6461FVWz+JfdjjAiJFiY0SaGsdZ/5PEZ7fKk5XV/o/zLdsGlFwT6NAS1dl0ajrZqTBKE9/IXATcz5cghltJnsoQLl/911FsnNybnkgB+acJNfYY80MBeLanvmBI5MuekZZXh1LerEOUJNzPfAkr+Lyyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708578689; c=relaxed/simple;
	bh=m3go9PyXkUEaWcrp2di/xWPzCxW/M2MoaEZgItIDZJk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Z3Ob4Dkau3tcBy6rSdwyvD5j4PqQHJUhJxhC5OenGQVe8GJvduqT68R3ix5J1ltgjQVvXXE/h3Uxj0KANcq05OwgaA7MWQtpzBvvQ9h8/tf7oOLhQJ7ADHOsgnUEAcXZOBpIsaI/I+SCo4AR4+6fogyxxNYVBiKJlTLmpydQPec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inhKv/ym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020D9C433F1;
	Thu, 22 Feb 2024 05:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708578689;
	bh=m3go9PyXkUEaWcrp2di/xWPzCxW/M2MoaEZgItIDZJk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=inhKv/ymSz9YT7XMzN+wxtGu6stgBOPiSURtbbU4dPY2ZZwZAwjKfJyDFrdHB30MP
	 ITRdfcNj2+dVWd1RkmN0SaV4tj0xlnaLplzbiyjbobG6XoLFFCIYXjiUHLWdIBQzht
	 GHFcehyHsjaaCPKyydOG+xzRD31Cqfg72hfI4dxpNJRVa6lV3A4T9HjHgfWUfEaPNp
	 B37ue+hOJWofjbTLIyu6sY6speTW3JtPXdHVr9yLA7z3KyRZUK95s6hcHiCNC9Jasy
	 DQToMHIAIDBDaiRFtgaJ+3uLV545TznrTjjjX/aOi/rsXULxj/XNk5OPFsUFtfO06c
	 Dgjl0+uKOi55w==
From: Kalle Valo <kvalo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  Karthikeyan Periyasamy
 <quic_periyasa@quicinc.com>,  <netdev@vger.kernel.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: pull-request: wireless-next-2024-02-20
References: <20240220165842.917CDC433F1@smtp.kernel.org>
	<20240221143531.56942c6e@kernel.org>
	<2dbb3ca4-78fd-4125-b13f-4ad440923291@quicinc.com>
	<b25a5783-a9ca-4356-ae17-bbda1340b522@quicinc.com>
	<20240221172521.4dcb382c@kernel.org>
Date: Thu, 22 Feb 2024 07:11:25 +0200
In-Reply-To: <20240221172521.4dcb382c@kernel.org> (Jakub Kicinski's message of
	"Wed, 21 Feb 2024 17:25:21 -0800")
Message-ID: <875xyhaxs2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 21 Feb 2024 17:18:41 -0800 Jeff Johnson wrote:
>> > definitely a flaw in 6db6e70a17f6 ("wifi: ath12k: Introduce the
>> > container for mac80211 hw")
>> > 
>> > my setup is using gcc which isn't flagging this :(
>> > 
>> > Karthikeyan, can you submit a patch?
>>
>> I see this was already fixed by:
>> 04edb5dc68f4 ("wifi: ath12k: Fix uninitialized use of ret in
>> ath12k_mac_allocate()")
>
> In wireless-next? Could you do a quick follow up PR so that
> it gets into net-next before the warning propagates into more
> of the networking sub-trees?

The fix is in ath-next but I'll pull ath-next into wireless-next and
then send a wireless-next pull request. So you should have the pull
request in few hours.

Sorry about this, I somehow understood this was a W=1 warning and didn't
prioritise the fix. After re-reading the commit message I can't
understand why I made that assumption, my bad.

What worries me is that the kbuild bot didn't warn this at all (or I
missed that as well). Is it using older clang version or what?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

