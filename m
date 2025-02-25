Return-Path: <linux-wireless+bounces-19427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B55A44421
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 16:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3DDB1899F78
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 15:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18C426BDAD;
	Tue, 25 Feb 2025 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U39ei3bt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E724526BDA1
	for <linux-wireless@vger.kernel.org>; Tue, 25 Feb 2025 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496680; cv=none; b=UHiTYt5xEgV7FtaN0TOkLL/UYATW5S/YkqhKn4zm2GgYJH60lWPClitIDEMG+OyFZ+TrtPxa4oIrgygEcFLuZDWYHsCx7FFCjqLgnEuxef7t0nH7uiXMSbnHfyJQVC1PciX4CSLw/vPfEoEsRxIkLZTf83zNKtYXuIATBLw9fqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496680; c=relaxed/simple;
	bh=rALszVeWffksEsP/Rrj6WAtB7agsaUXOmR/msDwji8U=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=X49nCBSekph2bgFl9vJHxiMBJCFqh9rXc9RMOi5X76gBHxdHCvVid3a4Djx0qLRvWwQC41TkUwWetCt+ScJRBB+IoIJ2RXvrq5txst7WaHCf267otwbcdHCqwRYoaZlIu0uyO4qELxC6RgfocBB9i3C/ATnar8nVmxWd23UI/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U39ei3bt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740496676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+QyH+Q7MigOrd7puvdyRTTPCeyR6wog0WvQSvTNgWAg=;
	b=U39ei3btKwBOAStLAO777Q6YylssBQ9Gerr3F/4z2TNV3j4txdMYdXs/MqECCbyKLA9aSn
	mrscj8ffHp7wI87UJ7f3gebmsm0qeIIlghsvdlmPWRwuQOehLZ762H2nn6LbT/9D+R8Icq
	rFzU/hzB7IPSWVPri8ITBQK3Jp5jH58=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-q8YtqpU0OC6xToOGXJ3YDQ-1; Tue,
 25 Feb 2025 10:17:53 -0500
X-MC-Unique: q8YtqpU0OC6xToOGXJ3YDQ-1
X-Mimecast-MFC-AGG-ID: q8YtqpU0OC6xToOGXJ3YDQ_1740496667
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1840F1A24789;
	Tue, 25 Feb 2025 15:16:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A8A29180194B;
	Tue, 25 Feb 2025 15:16:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <8f36be7c-6052-4c5d-85ff-0eed27cf1456@icloud.com>
References: <8f36be7c-6052-4c5d-85ff-0eed27cf1456@icloud.com> <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com> <20250221-rmv_return-v1-1-cc8dff275827@quicinc.com> <20250221200137.GH7373@noisy.programming.kicks-ass.net>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Will Deacon <will@kernel.org>,
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
    Andrew Morton <akpm@linux-foundation.org>,
    Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
    Thomas Gleixner <tglx@linutronix.de>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    "David S. Miller" <davem@davemloft.net>,
    "Rafael J. Wysocki" <rafael@kernel.org>,
    Danilo Krummrich <dakr@kernel.org>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Johannes Berg <johannes@sipsolutions.net>,
    Jamal Hadi Salim <jhs@mojatatu.com>,
    Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
    Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
    Linus Walleij <linus.walleij@linaro.org>,
    Bartosz Golaszewski <brgl@bgdev.pl>, Lee Jones <lee@kernel.org>,
    Thomas Graf <tgraf@suug.ch>, Christoph Hellwig <hch@lst.de>,
    Marek Szyprowski <m.szyprowski@samsung.com>,
    Robin Murphy <robin.murphy@arm.com>,
    Miquel Raynal <miquel.raynal@bootlin.com>,
    Richard Weinberger <richard@nod.at>,
    Vignesh Raghavendra <vigneshr@ti.com>, linux-arch@vger.kernel.org,
    linux-mm@kvack.org, linux-kernel@vger.kernel.org,
    linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
    linux-wireless@vger.kernel.org, linux-rdma@vger.kernel.org,
    linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
    iommu@lists.linux.dev, linux-mtd@lists.infradead.org
Subject: Re: [PATCH *-next 01/18] mm/mmu_gather: Remove needless return in void API tlb_remove_page()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2298250.1740496596.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Feb 2025 15:16:36 +0000
Message-ID: <2298251.1740496596@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Zijun Hu <zijun_hu@icloud.com> wrote:

> >>  static inline void tlb_remove_page(struct mmu_gather *tlb, struct pa=
ge *page)
> >>  {
> >> -	return tlb_remove_page_size(tlb, page, PAGE_SIZE);
> >> +	tlb_remove_page_size(tlb, page, PAGE_SIZE);
> >>  }
> > So I don't mind removing it, but note that that return enforces
> > tlb_remove_page_size() has void return type.
> >
> =

> tlb_remove_page_size() is void function already. (^^)

That may be true... for now.  But if that is changed in the future, then y=
ou
will get an error indicating something you need to go and look at... so in
that regard, it's *better* to do this ;-)

David


