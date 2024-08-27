Return-Path: <linux-wireless+bounces-12069-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFDB960D9E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 16:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC296284E72
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 14:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD951C4ED8;
	Tue, 27 Aug 2024 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR51SEQW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC781A08A3;
	Tue, 27 Aug 2024 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769102; cv=none; b=gotq42/p2NtE3fEa96vbou3GzMt35nzUfRHdqcWBX+ZcGTERO09MUrYE6jJ0Y868Qroj2Coppehxcc4NVFvB88VNaTd+qtZfXDWNDGD1sY9YkMH4OkwkaDBgaU4nC9HD4vwsVAhLY0KsvnaQETqHgmv7RBbWqo2sFH1ZyWP6HQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769102; c=relaxed/simple;
	bh=jPW5CeXWol8SdzTNVQSXpa6WgMRABIvFBwXD85nKydg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=LbQnSIObUHasqwrxMU6AFCHdh09TCkYtUuYCyT8dzla04D+Run4d/gCBfnCLzxgMG/FhRe18CJF0qQMVdTQSBId8ROXYoC6SsNc+I97zh3WlEmMIMFZP1fh9U9sYrN75oXXgQ0Mo6ThP5WvyEXyNmsR9TKSejDKZjljG1bt/wd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR51SEQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F5CC4AF52;
	Tue, 27 Aug 2024 14:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724769102;
	bh=jPW5CeXWol8SdzTNVQSXpa6WgMRABIvFBwXD85nKydg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=CR51SEQWCzFdwGlPxDcKz4Gl7UMMKEEG6+xV2kZ/5VauRsdfO+JTGHDUHETVbfW+v
	 i7L5nPZ+DUfQqhSNvi9vzmGZk70RBURcEZy+ITaXI/ZF8fBnzpuUXEQKJg5Vk3JgDb
	 ehz4JBvE/vSkz/jdrDyVG5PoEui1xGj8QeywqRwn1cHcEhmfdfYvnVWPEO4lBkmH/a
	 j0A1ML67VcwUcpyw3JPUVbJL0/kgVFaXOFi8O0ZdAag2pr5IXzAfxQidwM+UlT/Uw2
	 /s2MST3G9tntcOySE8nfddON9s9TxQlvCD5VV3Q4gUWX5AMs7SjCVIC7jmFFREq8VY
	 Hu3Zm4NvCDhsw==
From: Kalle Valo <kvalo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hongbo Li <lihongbo22@huawei.com>,  <johannes@sipsolutions.net>,
  <davem@davemloft.net>,  <edumazet@google.com>,  <pabeni@redhat.com>,
  <allison.henderson@oracle.com>,  <dsahern@kernel.org>,
  <pshelar@ovn.org>,  <linux-wireless@vger.kernel.org>,
  <netdev@vger.kernel.org>,  <rds-devel@oss.oracle.com>,
  <dccp@vger.kernel.org>,  <dev@openvswitch.org>,
  <linux-afs@lists.infradead.org>
Subject: Re: [PATCH net-next 0/8] Use max/min to simplify the code
References: <20240824074033.2134514-1-lihongbo22@huawei.com>
	<20240826144404.03fce39c@kernel.org>
	<4a92bb68-7fe7-4bf2-885f-e07b06ea82aa@huawei.com>
	<878qwifub5.fsf@kernel.org> <20240827070347.4bf3a284@kernel.org>
Date: Tue, 27 Aug 2024 17:31:36 +0300
In-Reply-To: <20240827070347.4bf3a284@kernel.org> (Jakub Kicinski's message of
	"Tue, 27 Aug 2024 07:03:47 -0700")
Message-ID: <877cc2ujef.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 27 Aug 2024 07:45:02 +0300 Kalle Valo wrote:
>> > Do you mean some patches will go to other branches (such as mac80211)?  
>> 
>> Jakub means that your patchset had compilation errors, see the red on
>> patchwork:
>> 
>> https://patchwork.kernel.org/project/netdevbpf/list/?series=882901&state=*&order=date
>
> FWIW I prefer not to point noobs to the patchwork checks, lest they
> think it's a public CI and they can fling broken code at the list :(

Good point, that's definitely what we do not want. I'll keep this in
mind.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html

