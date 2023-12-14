Return-Path: <linux-wireless+bounces-795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C43813067
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 13:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B111F22093
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 12:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35974CE1C;
	Thu, 14 Dec 2023 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRscTEVF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0A0124
	for <linux-wireless@vger.kernel.org>; Thu, 14 Dec 2023 04:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702557764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=odMDeThQ3POlCN3WICGaUi3nWoYHxa0pyC3xPvYi8Io=;
	b=SRscTEVFyjTSVYvsJw5li1R/2T1LDm1H3gmNhIaSOAgsmPq4tpz3t4aW+wKKROfbRu4bFM
	5Juh5YLEjC92plF3VOTur4KRivF65ewKY2EFpsmJJMp/VBUIunjQq9nMWhpBiU7zRtR8Mk
	OLrZUDxG/PdfVXBxXwmlxtaL4rCxWWk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-l7BzDGQVMYK6LuTRWZ2pLQ-1; Thu, 14 Dec 2023 07:42:43 -0500
X-MC-Unique: l7BzDGQVMYK6LuTRWZ2pLQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50d1a0eed90so1247697e87.1
        for <linux-wireless@vger.kernel.org>; Thu, 14 Dec 2023 04:42:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702557762; x=1703162562;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=odMDeThQ3POlCN3WICGaUi3nWoYHxa0pyC3xPvYi8Io=;
        b=KTAl991wcGEHeZaEWhtkCr/Yv/pITJlD1jDKELSdZV+ABYveerhzlT/D5CE2T3AE6X
         giFL7P/obqIKSriU7K+mUjpHYt0mGz2BIXeyvyoi6nU61Ru8JSD56ErhGPjoWsYWFcmJ
         C5zQu8mEsV7YRVdQl43acwSC1tumjNZdid8d8uo+BTXEs5NQf18OX1tWZMWKMcabVqcQ
         44GtESarzKc3UsFC7Z6qug/dFjc7e0TRqZkg0aD04VItk4ZkCx4F7JWIaCHqOikueOAY
         vWqKhg4eQZt/VCGToWKK8dCW3ljvUn/Rz22EQ3rPHAHe4b7yAUwQKAZoL+jzh6mBZcoS
         4xag==
X-Gm-Message-State: AOJu0Yz6t0NcVQlGMDwg5d/hYllkMWBrdEOmbdNsBOeRe6+1VUINrYNW
	25K7Z5BxioZDx24FXSvV5nGqp90AiEX/MT3tfgmjIhbaetqckGrRAx5ITxIKu1/HzhNFxwk7buT
	gToYE6cyybrFbyvL6iOFuwXoCC6s=
X-Received: by 2002:ac2:4c43:0:b0:50e:a92:7983 with SMTP id o3-20020ac24c43000000b0050e0a927983mr5648123lfk.2.1702557761916;
        Thu, 14 Dec 2023 04:42:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWL+BPctFqS883vEp68aj+Sybet9QzQ4ZLju3jHRNFTYDWRkNuJA8SENH+LGYpkrqldhlDXQ==
X-Received: by 2002:ac2:4c43:0:b0:50e:a92:7983 with SMTP id o3-20020ac24c43000000b0050e0a927983mr5648111lfk.2.1702557761554;
        Thu, 14 Dec 2023 04:42:41 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-36.dyn.eolo.it. [146.241.252.36])
        by smtp.gmail.com with ESMTPSA id t16-20020a056402241000b00552743342c8sm570560eda.59.2023.12.14.04.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:42:41 -0800 (PST)
Message-ID: <3ab51b1645aadc2db5aef9fb53872be3da436249.camel@redhat.com>
Subject: Re: pull-request: wireless-2023-12-14
From: Paolo Abeni <pabeni@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Date: Thu, 14 Dec 2023 13:42:40 +0100
In-Reply-To: <d8667c83111b70144b40a3b7c457c7a2dd440e09.camel@sipsolutions.net>
References: <20231214111515.60626-3-johannes@sipsolutions.net>
	 <ddb0d6217b333c3f025760b5b704342a989f2094.camel@redhat.com>
	 <d8667c83111b70144b40a3b7c457c7a2dd440e09.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-14 at 13:11 +0100, Johannes Berg wrote:
> On Thu, 2023-12-14 at 13:08 +0100, Paolo Abeni wrote:
> > On Thu, 2023-12-14 at 12:13 +0100, Johannes Berg wrote:
> > > So more stragglers than I'd like, perhaps, but here we are.
> > > A bunch of these escaped Intel's vault late though, and we're
> > > now rewriting our tooling so should get better at that...
> > >=20
> > > Please pull and let us know if there's any problem.
> >=20
> > whoops, this will not enter today's PR, as I'm finalizing it right now.
>=20
> Yeah I kind of expected that.
>=20
> > Unless you scream very hard, very soon, for good reasons, and I'll
> > restart my work from scratch ;) (well not really all the PR work, but
> > some ...)
> >=20
> > Please let me know!
>=20
> There'll be another chance next week, hopefully?

Yes it should.

> Anyway, I don't see anything super critical and likely to affect
> everyone badly. Even if it doesn't make it at all, that wouldn't be a
> huge problem, we'd just have to do some creative merging on our end (or
> reset the tree) :)

Ok, let me take the easy path then - with the next week PR should be
easy for all.

Cheers,

Paolo


