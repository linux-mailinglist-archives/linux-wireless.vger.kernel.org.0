Return-Path: <linux-wireless+bounces-31216-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FfmNDiSeGmxrAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31216-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 11:23:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7720992BB5
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 11:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A40E3047039
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 10:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BC433B6EF;
	Tue, 27 Jan 2026 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0CBOsHD/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BDD2E8DEC
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769509088; cv=pass; b=rkF5tkLFL3w5wJvZ7VF8UdW+zXepsDz2xIswVQtm7r1P1gmfFbbxa4IhCrZ6hAxsCwghm1Ek+5phgEzxGDV8R7eXvnmO6v7QYfahKKFAZosSHcLkDB9XS3O8YMY57o85WHECUUOoYhsODWCjvGNxg5SlrCUjaThqXF4FEACKLbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769509088; c=relaxed/simple;
	bh=9eWZA1QTRdZDTddGYL8SlE552QBQW/sLGGoi37wJCfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNARuzBipIPQoSgg6BSUD8DxqS0Hh+PyPQeOBsG8KA2kcgwWbCcJJCYZrsD2iBoswV+FDHftF7KoGr6ltWGOykjiI19x0DQLotQw/RMoHN7W9MPDsH127C007/qQSHiCKtf/fAo57IrE7EMQn0XwGK82EBGeH4cPiOXxu3oEvvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0CBOsHD/; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12332910300so2129453c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 02:18:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769509082; cv=none;
        d=google.com; s=arc-20240605;
        b=EXx7K4BniqrI4JOat0qM3fu7qPbNDHYo/ZpKh8W6EgJiyp+UY9hFlG9kYmtFAE7B2U
         KNgy6T7nDCv9HEtGagafj0yVINq7ZdprrH6ToQXSKm9MnHm/pX+LX6izpIFlVXAitqja
         hPvdcTIkLFzS9Ydpfc3GkirktnxAvP9x+PfgkMBavfBJC8iVV47iGmlBVwrdbRKRbLsy
         MDEunvGNVOASnwn+Tf6zYrXvRqJt6xFmnl239GRmS7UZj0o4k3d261RtTL3F6ZgaKnRv
         jJG4Gw6J4chxqFqLpb6NCuKF7it9nHeCe3oDWyUwoCuiCzlxVL1Zmp94caGzNbDin+Vc
         f8vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9eWZA1QTRdZDTddGYL8SlE552QBQW/sLGGoi37wJCfo=;
        fh=lvqqvGNb+EcF2hfklkuXjnyiqeshY+AixLf+l2lTehs=;
        b=en5Jk/fkjTZGCiELCWmpegV+rDIyvowazblPZdTGDrwa3+qJ/tqpbQmpouvK9vGP7H
         by8I6WDtbCqykiT9NGibK9b79SnPZs7VCYsmwXcJm/LjO7WsbIn3U9Y+xbrsbFAgg4LO
         q6SUUnDQ8kxX91mT/rZo5eCWcOqKEglffvXnCk+9zt7JxZqwfKy37zFb0f7rQ6N1Bs0Q
         DPNewlJKWouzXF4s62dL8JRTl5RWPJigKGBA+MqMwMM/MbHL85AaDW3rnSWeFB8yvGzN
         sEd9hAO2NbE/ECDncRYI8iV1wASDb32ebbnOhazX0A84VeV7FllVth8H642I5kPtH+Zj
         i6xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769509082; x=1770113882; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9eWZA1QTRdZDTddGYL8SlE552QBQW/sLGGoi37wJCfo=;
        b=0CBOsHD/uKOv95aR8OTAbtRyWBxyLJ6N1fESKzC2veqVx9JPRAR/Gsg+n8VRUW2Hp3
         EG6v3t7dFFHmx4Qe9/enHqvAYc/MN+zbW34Q0dIEP/dBnHyBwmTXLN/s4AgkzfrYowyK
         TS9/3JGwU153BB0kkOIvZ5Xtjd+Bp8Z4TnxiAJfhMEvuCB4na3T6n77gyhHa/UDpEb0b
         IgALtOGmCw2o5+TNyDxryyFP5U2h1On49wPhmsdnKC83ra3MXi1Xx96djhullUZFhEEf
         Bu8bIyKcXqPDpnJ079sq0S/S0xkr66rrSYp7sxWe3EDfxUs2fpKiC1ykKYevzeLX0nO4
         YmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769509082; x=1770113882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eWZA1QTRdZDTddGYL8SlE552QBQW/sLGGoi37wJCfo=;
        b=v2AZv69SX3551/OA19Bl+8EOEy+HqK+A5Qv1GpI0aJCLZ50yMcspNFLi18jn6AW+YP
         6TMdPXyhmVwtdrGnWYLax1bXlxJ8CJ6YuSKXgO3jlvaAEkPU82fkjBNdjI8gt1wyhmXf
         dGId2023EptoVFNJFZBYAbN3RW2RQDxbHuqjkloNTPqmhB9l6XketC+yV/m6Sj27xWdY
         7ehfZET7tlMpFsm1Kz/a5Bw+bou2O+1z8AKCRpOr5Nt7LMTS6NxvqIhSw/MNB8iwRyGZ
         /8QI+CcdrDfDKi4kVF8bVPSPw10cS8R7dU/vtJ9bw0rYd5zw+i/JRzbE1wHVYnYTsbEn
         VanA==
X-Forwarded-Encrypted: i=1; AJvYcCUYA3kIbLmoIOr6PIxni5mqsxwc3DCn4m0Dlr3uw//L/QK0IxKRCBl3EWPcmRxgLLD2phhGttXYizXgM3eOwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDKCH21Ea7LAOEDkhYqkslmRA1UTf0QelcwQuoG8cyOIy68l8d
	4DZBEuxm0oaJ4vkrMgw+pTN8kR9a4qbh/w3HAUit62t7hRDrl6V4+SHqYRQmfSJkxBv68lJ0sdu
	z8uOEnUOnQ5aMYe4lAGkvcMZGwgrvunX4LiayjYCW
X-Gm-Gg: AZuq6aJLkT44NoTIyKYPUfW/4Eln4+X8/FV4ASsKw1GJnarKD9nxOBMsqwGkrZ5Rt77
	d49CL9fgtuIQxgfvUh+k2dyk6c4X81/aMFn9ZlgPKEyv3OvqzDInfaxHJmiZVXnGg20NZ9yYCUy
	yVE7jn5tQ03UNqi4D6vK7104E4L4sGls+6WOi00/a3ks59Qvw+4cIJ1xiAgXBV/PdeqeUjIODIn
	9jsTVoSwHiXS9AWzYaB4GLy82x4TSw1Kgx6EmT3/Cfpc9A0hrGAlF4e1PM7M+TZXTDtRI7q6gN2
	gaJ8IytldADAqYg5cgp4DZBOJg==
X-Received: by 2002:a05:7022:6985:b0:11e:f6ef:4988 with SMTP id
 a92af1059eb24-124a00cd55dmr806676c88.36.1769509081547; Tue, 27 Jan 2026
 02:18:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com> <20251219154418.3592607-7-elver@google.com>
 <0c2d9b69-c052-4075-8a4b-023d277b8509@lucifer.local>
In-Reply-To: <0c2d9b69-c052-4075-8a4b-023d277b8509@lucifer.local>
From: Marco Elver <elver@google.com>
Date: Tue, 27 Jan 2026 11:17:24 +0100
X-Gm-Features: AZwV_Qj2UVNnjgQTvKRMxq0N2rMz8K4yMXQyPWTkZbJrWul7iRYbem2vd2u4cZs
Message-ID: <CANpmjNNHmOzaCSc9hQJNuzNVHXA=LRgXB4Q69FNk6wBuuJGdAg@mail.gmail.com>
Subject: Re: [PATCH v5 06/36] cleanup: Basic compatibility with context analysis
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>, 
	Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,kernel.org,davemloft.net,chrisli.org,google.com,arndb.de,acm.org,lst.de,linuxfoundation.org,gondor.apana.org.au,nvidia.com,intel.com,lwn.net,joshtriplett.org,nttdata.co.jp,arm.com,efficios.com,goodmis.org,i-love.sakura.ne.jp,linutronix.de,suug.ch,redhat.com,googlegroups.com,vger.kernel.org,kvack.org,lists.linux.dev,oracle.com];
	TAGGED_FROM(0.00)[bounces-31216-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elver@google.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,lkml];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7720992BB5
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 at 11:14, Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> +cc Sid for awareness
>
> Hi,
>
> This patch breaks the radix tree and VMA userland tests. The next bots didn't
> catch it but it seems now they're building the userland VMA tests
> (e.g. https://lore.kernel.all/202601271308.b8d3fcb6-lkp@intel.com/) but maybe
> not caught up to the issue this one caused (fails build in tools/testing/vma and
> tools/testing/radix-tree).
>
> Anyway it's a really easy fix, just need to stub out __no_context_analysis in
> the tools/include copy of compiler_types.h, fix-patch provided below.
>
> To avoid bisection hazard it'd be nice if it could be folded into this series
> before this patch, but if we're too late in the cycle for that I can submit a
> fix separately.

Thanks, I saw. I have a more complete fix I'm about to send.

