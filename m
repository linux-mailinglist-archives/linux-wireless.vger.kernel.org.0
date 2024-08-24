Return-Path: <linux-wireless+bounces-11885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E1B95DDBA
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 14:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D202832EA
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 12:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7E316A395;
	Sat, 24 Aug 2024 12:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQt3YPfG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035FE15D5D9
	for <linux-wireless@vger.kernel.org>; Sat, 24 Aug 2024 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724501230; cv=none; b=GGqLgWrpfAjpdfGMa3QVkf1fwOUfHD/VAe0rl/9+sA/tRCG4706fIyDyl9D9pOSHq9dtofRHcjS1/lF2BGB5Xf7z4uLHf5Xv4/smockpjRtiwopLK9YI15Wb+C7Fd4I5Wyuy10I0BxcY/FpaU7YFa12U1YeKudr0GhZQnIyLCW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724501230; c=relaxed/simple;
	bh=wh2+8yuwCwCztdr8QUKx7gWE0HfjkgMuVTK/8Ktjyq0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=tzhL1XrK24kMJfxOId2pmu3JIk/33r+KCSXhmiI4HEeOvahrKF88Z2Zl7st12C8ULCTKSoufqZAMSY71ZsJCRs5sAzFpliEQWmVhwuu3QYkFewF5wk5oBk40cjaIGiDXZKJ07xVFSNe0fsm3IjRWjJbsM88eVH3XvVblhrdTVUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gQt3YPfG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724501227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a1bEMmhYWPcc5WPaVCBGyBfQe+5Fop9dOF/SHjPvxFk=;
	b=gQt3YPfGe9mHKZPqF0mTQjq2VKBQ1YUaDhNFXuAIgBQ+6mIlFpbofz9zJ/pXlcnJS0dzUo
	kgRzvXeCPNR4bnTnQOuGmH1zRwiaVqfx8Ay2KXFSmyNVSL9YpEmFVXniSbXeqHgUGuNZ5P
	nPVWVy9e6mF1Z4ypwbyJti0/jRGemx4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-nFmxqG7ZOOixq3NNP-L_GQ-1; Sat,
 24 Aug 2024 08:07:04 -0400
X-MC-Unique: nFmxqG7ZOOixq3NNP-L_GQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B28721955D47;
	Sat, 24 Aug 2024 12:07:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DF8BA3001FF9;
	Sat, 24 Aug 2024 12:06:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240824074033.2134514-8-lihongbo22@huawei.com>
References: <20240824074033.2134514-8-lihongbo22@huawei.com> <20240824074033.2134514-1-lihongbo22@huawei.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: dhowells@redhat.com, johannes@sipsolutions.net, davem@davemloft.net,
    edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
    allison.henderson@oracle.com, dsahern@kernel.org, pshelar@ovn.org,
    linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
    rds-devel@oss.oracle.com, dccp@vger.kernel.org, dev@openvswitch.org,
    linux-afs@lists.infradead.org
Subject: Re: [PATCH net-next 7/8] net/rxrpc: Use min() to simplify the code
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <563922.1724501215.1@warthog.procyon.org.uk>
Date: Sat, 24 Aug 2024 13:06:55 +0100
Message-ID: <563923.1724501215@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hongbo Li <lihongbo22@huawei.com> wrote:

> -	summary.ack_reason = (sp->ack.reason < RXRPC_ACK__INVALID ?
> -			      sp->ack.reason : RXRPC_ACK__INVALID);
> +	summary.ack_reason = min(sp->ack.reason, RXRPC_ACK__INVALID);

Can you use umin() rather than min(), please?

Thanks,
David


