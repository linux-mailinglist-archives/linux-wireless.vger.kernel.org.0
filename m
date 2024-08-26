Return-Path: <linux-wireless+bounces-12006-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAFE95FBEE
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 23:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC99F283A1A
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 21:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737F619B3C7;
	Mon, 26 Aug 2024 21:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hx5unrv2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4718B13C9A9;
	Mon, 26 Aug 2024 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708646; cv=none; b=a0LBddsh4edgWSRoFGVLDkAfirhwRPiwynWXKIb5Fko7WbmWGna4SrI8TVrnT5wbHG5R5U10ksVCpac8uscv+rjW1D90nFOTZwCcWin+g5S8jBFGAs11f7DgoKjtB6y8FA3DBxyo5CVH3nYGjgYZjh123gKaaVO7rhEMJvgsE0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708646; c=relaxed/simple;
	bh=lvSnHqOQR3Na/gepx7JGPz+s2JJfy4XjDTN+5qhOtDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8jqb79gwImPVBoY1Afnu4CyIC5TOOuwVCUviEH9Lwnh53meq3SAsSx7NThoCIZSpyQ13HLkub5epF9WwxVT8JJoXylds52ICS+PhK0yAF0jJTxrpmHomkzHbbHXpT5DPkwC7DDjMQA/JglHDKTmKiLG/LO/9VE14OWoOSt4934=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hx5unrv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FA6C4DE1A;
	Mon, 26 Aug 2024 21:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724708645;
	bh=lvSnHqOQR3Na/gepx7JGPz+s2JJfy4XjDTN+5qhOtDs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hx5unrv2zBVCo0jIq7yYg2HVT0e8ybrwCJ3JmWDMV4i8cQPiS6ssOXSZOrPNCjcmW
	 XL03cV3uqPEjNx1jlhEXYYYyisja5nVMWzzAiMUxrxyvzeQYyuzTZY0jVSJfqJJKWf
	 sRMleZC1lTp6rPEa31brv/6XaqJPCPCWYvsmKrVoNaKIgR7tL8BpVcgqlX3jRHK8RP
	 UrC7Yls6Vs1FAOZVszwANjrqSrCFBzrShqGEXa7wxOb7Rh6jRb2P8K79I7qA4E6W3L
	 OUQobniq02IFwAuyX1kuAh1zLjGdAYokqtLPkYPUEEk+gzpW1E/CTEjDybtKN7CYPF
	 6HlXJkBDK0BBQ==
Date: Mon, 26 Aug 2024 14:44:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: <johannes@sipsolutions.net>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <allison.henderson@oracle.com>,
 <dsahern@kernel.org>, <pshelar@ovn.org>, <linux-wireless@vger.kernel.org>,
 <netdev@vger.kernel.org>, <rds-devel@oss.oracle.com>,
 <dccp@vger.kernel.org>, <dev@openvswitch.org>,
 <linux-afs@lists.infradead.org>
Subject: Re: [PATCH net-next 0/8] Use max/min to simplify the code
Message-ID: <20240826144404.03fce39c@kernel.org>
In-Reply-To: <20240824074033.2134514-1-lihongbo22@huawei.com>
References: <20240824074033.2134514-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Aug 2024 15:40:25 +0800 Hongbo Li wrote:
> Many Coccinelle/coccicheck warning reported by minmax.cocci
> in net module, such as:
>         WARNING opportunity for max()
>         WARNING opportunity for min()
> 
> Let's use max/min to simplify the code and fix these warnings.
> These patch have passed compilation test.

This set does not build.

