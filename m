Return-Path: <linux-wireless+bounces-791-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC52812FB2
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 13:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F76A1C21796
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 12:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5244123C;
	Thu, 14 Dec 2023 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZtuI2qL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79A1BD
	for <linux-wireless@vger.kernel.org>; Thu, 14 Dec 2023 04:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702555704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1y2cmvWY5gvPwPDpJLMmtv3/ZlJBxa88AApdah1hxWA=;
	b=MZtuI2qLI3edAVngIU1yMfSdGNX7iDm3I+Ug3ykVVeN+/4a3P0po8QEESXB0HgcdQwcrYL
	CWQ10CGAGynb2bapZFQRGfOz15hsI2iC1d02xl4uX71TWMVgIaVF3vDWyGVScnyv/elQtd
	gaIhj+0y5oLF3jRWmzcxjnFprR63x+o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-jNXd4mO9PEGEV8mgqVREGw-1; Thu, 14 Dec 2023 07:08:22 -0500
X-MC-Unique: jNXd4mO9PEGEV8mgqVREGw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1f72871acdso131641066b.0
        for <linux-wireless@vger.kernel.org>; Thu, 14 Dec 2023 04:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702555701; x=1703160501;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1y2cmvWY5gvPwPDpJLMmtv3/ZlJBxa88AApdah1hxWA=;
        b=i4lTYfzZpQJBQXOzKgyD1tD4L8FaDg9Ym8cWexmiXKfMOeapMcJMNhDHGplifzD49W
         131gFn8mP9/isapl1+OnIMaZ+KrpVejLTVcMfeHHABkgHN7m1q+NtshHeWCbU8KU19IW
         vLv9gO/oNnWpnbfN4NbRtfUQlzGFq7fSde0xNz/cRsyQDXEXeExHQQfxJPC8oBNQ69gf
         TB5HKpkLqU0cPFkkEvmjKFCGx0YW8ltrq8WUatCtilb1cPXd53D94l6YFhf91WAFB0p5
         J+GSiL/5UljqhNYpjV19zSOaIpo7+WTj9vOUOCiHUXd2+akQIeVDGpx3rI4lrEZdoRzx
         YldA==
X-Gm-Message-State: AOJu0YwM2e2THWGHq1ItvKgfyjCwcQAHvon0PPjxPvJR1vx/DLc8dWFR
	CTxU6Wz3Yjg8+SLKaccd0Pl5zVNA7N9Qybntb70YqgH4a7flTwy+MwyIa0Xseo9rn1cFtgZ3axe
	JyuIA91CYVGIXsYFfv4f7kI9IHjg=
X-Received: by 2002:a17:907:d384:b0:a1b:1daf:8270 with SMTP id vh4-20020a170907d38400b00a1b1daf8270mr11068357ejc.5.1702555701370;
        Thu, 14 Dec 2023 04:08:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IER93kqIZMl/9SIkh3e/L0WU7al8sQEVUM46FFqeX9HwlX60gab5ecN6wfToYqOaCErUHb7mw==
X-Received: by 2002:a17:907:d384:b0:a1b:1daf:8270 with SMTP id vh4-20020a170907d38400b00a1b1daf8270mr11068339ejc.5.1702555700997;
        Thu, 14 Dec 2023 04:08:20 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-36.dyn.eolo.it. [146.241.252.36])
        by smtp.gmail.com with ESMTPSA id re14-20020a170907a2ce00b00a1f751d2ba4sm8615825ejc.99.2023.12.14.04.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:08:20 -0800 (PST)
Message-ID: <ddb0d6217b333c3f025760b5b704342a989f2094.camel@redhat.com>
Subject: Re: pull-request: wireless-2023-12-14
From: Paolo Abeni <pabeni@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Date: Thu, 14 Dec 2023 13:08:19 +0100
In-Reply-To: <20231214111515.60626-3-johannes@sipsolutions.net>
References: <20231214111515.60626-3-johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-14 at 12:13 +0100, Johannes Berg wrote:
> So more stragglers than I'd like, perhaps, but here we are.
> A bunch of these escaped Intel's vault late though, and we're
> now rewriting our tooling so should get better at that...
>=20
> Please pull and let us know if there's any problem.

whoops, this will not enter today's PR, as I'm finalizing it right now.

Unless you scream very hard, very soon, for good reasons, and I'll
restart my work from scratch ;) (well not really all the PR work, but
some ...)

Please let me know!

Cheers,

Paolo


