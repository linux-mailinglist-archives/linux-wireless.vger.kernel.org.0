Return-Path: <linux-wireless+bounces-31698-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBqHLk4/i2mfRwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31698-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 15:23:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8D811BD88
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 15:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65847300B46E
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 14:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E61436682B;
	Tue, 10 Feb 2026 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QcoqNT4d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE2E366827
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770733387; cv=pass; b=SR8NnGkk/vcE+UsW4Bo/gBtcO6DXaVxvB9ZoGjeZKmTgHT5N4z2t4i3ixrKOOLY/F8tCrXminrrkJCrZBcNY9/9+ggGj6Um19QQgNt3CO3I0rZZRLivgH13KQqz2YkzAXtEH1hum24pj0hfrQprQNBvVC02D4w8F8c5aJEGEFDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770733387; c=relaxed/simple;
	bh=KG4L2uSwjgDvB70aYFVXCIJbASqQXwAooo6C7MZ4qc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3Q8fptdkilH8/Sy1EL43XFAqLiehSDHqIMb8kDVNi+TDDB3Ij8e1vPj+QMDzw3dpYY7quv2vOac6rLilXB+eZn8E9nAHX6/CZQy/1YmWZXi+SQlRQQxXdNMkmDhZoFUyJ1MdpdG9eW/6FmSrGSW0VGyqxnCXZ8zdXcpmIURflc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QcoqNT4d; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59dd7bfeb8aso6737457e87.0
        for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 06:23:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770733384; cv=none;
        d=google.com; s=arc-20240605;
        b=aNxGvUNaYHNJlKnf5vGE+kDyEaVeDWBLtbDYsBbbuYyjfSGDxX983FSZiBm+A0qhWJ
         Wv9PFavMIfQZpIoQSEs1Sj9vKbHx2Kn0EXzvxCKJ4xlSvroqtrYDMjZjEc1VXxifG5mK
         VqeFN55nu0r/YCdJFG1jjQVZABkzAogQgBW0aBfo9g25KiXgdLc2g0z842AT9ys2T9Tu
         AP/witW78FBN+jTvWhF6F0QA+CJEJJ5zdHiz831+IGzqjBuQSGMBd8IUSRHHHxDOD6J+
         1vIGgX07DoPH6xNmVFDkYuWh0V9ydPHlvfq2ugaV0TQIoAAyhGK3bxN6C3F5KdppRLPv
         SDSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KG4L2uSwjgDvB70aYFVXCIJbASqQXwAooo6C7MZ4qc0=;
        fh=MG9vmGC1NMXQgXETVrKpzvaSHJcZI6uAsN2hAktG1Eo=;
        b=DWi9l+VWL40URty5dEE4gEuxHd6uppxNTI5QEAtAC+80A6CwIyw5CR1UYDj30V3hBf
         VYB1sdMML2AsdO1XY6zSOAqQRsgEfv7li2LZ/pH0LAwXDjlY8VqCZpjvJGqW8leq9Lup
         TWTddly3GAUMLIpMAMlKk3Olt8zf5yaX4a19aesG8yT5l4UWCbF1CZXywWWWeUeHYWQk
         mpxvKrZ5uyAYxe0bIHxe1dEbb4Ud3c7uWA9VssEhk8jxv8omc9fRLaQohl8svRZSKpYr
         0mgiw05zvhJg8OGkmLTP65NIQxNucwarbvD4myLZUWdck0k+BRMJo1JWINPygtXWmrZu
         hNQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770733384; x=1771338184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KG4L2uSwjgDvB70aYFVXCIJbASqQXwAooo6C7MZ4qc0=;
        b=QcoqNT4dOGJwyYL0pgY+9EcEI+Gwi8rR9dwVH5x1TnwfwZzfVV35oV+YOWkEVt/LQ+
         0SKLF1a4+8dVuHNU8J3nHEAyzwWtGpEjZZcB9xoGkm789LUJHiVtHAvEOYurUrm4LD2/
         NLO87C8DXXC5a8rLc/Apc+l3ryrNzUW43vUJHOlR0/S6NP+c6MZUVHFPnstvROLRVQbD
         j9R8M+hJggNR6zF6rsffLdaxKxvpwOYg2xa+NwJG62482GI7SI1E5voYX9mXXAR6XXW0
         39W3RV3fKSiKJPAJild+W/jMqJ2RVdf8fxR8cUc2vzhHFL3Wlc7ihzlPKzMMhTAu7L6N
         XcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770733384; x=1771338184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KG4L2uSwjgDvB70aYFVXCIJbASqQXwAooo6C7MZ4qc0=;
        b=RPZ9WHflTcYOVU3ZQ0lGThoN9Wwdhyz4r5JcNt6KQFpaHFLBqumqoWJzcGMmOGRkri
         FSw0Jn3W4kSwzJOlkWg417JRdP07oQvtwtweno297nCUbEXfibZ5pbORCJdcZlijzZDp
         40aionmDYXwTVkbqSReLn5Eahx/8HNv93g0ueZZQBTyY1kPfDPNnf2J3XfrYvOUARWC+
         rlFPBqGI7FRsxrplNDknboU40S54RsqAl+dUzcG6WOGjaUx+IGFBsXkraKd/+8/OAjxv
         tSiHBCRvFLEzxXORy9MfPnDxHRrkuaeaxknGSzE+fHBdx4t64D5om2muVcfnESHTwyzI
         NHkw==
X-Forwarded-Encrypted: i=1; AJvYcCXBHmk1s/XDBHqdv4bRfqIeUg8NRxz5ayZAGSHwpafs4f5C0fpqJcyI1DWvKfAaMO7oij6HQFDguG7rh7jqqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFnVSPdtTSg6SjF/xjQwrvkJwbQ43ZREFPE4jeq2L0hlVOE3Jg
	eXDsXC7e8HuQF8TmFXWKiwNYeFGdQSDB2g3NOPfsol9t3mzYlKGeong0rxlUNajuxXrzQFm0Nlq
	ImmNBm8AN6VhsrmOoKnK5hZiDizakOt7AhjD/T8+RJw==
X-Gm-Gg: AZuq6aId1+Fd1HL/PxVQErKg+q8Nsp1PZVi4wsomYr5QqhWKKCuvCecipyUnIybKi17
	p0/n4ngH9bKwd/0fulMsLUZv76g2at0gXVQaZU3tb6Hp+CByPtu9wbyHgwyDKU/3JrZLExGYEfm
	hdsum7GvYqTrHu5o9A4jYADBisB/yp6DBjRJEYWOh/sk0V7CS/GDdBtmmm5d9UP5g/WSCuKVjo3
	nnohoV1OgOZtUlS2wJCcIZBOUNCiuVdNAZNerggWuloIrg4slOach0tkpmeJUqo/u8BE1SYwAsr
	352iatHMyd109DYi3/7PxubXVWX4vTGzdRSe6tPh
X-Received: by 2002:a05:6512:2251:b0:59e:4d25:960a with SMTP id
 2adb3069b0e04-59e55bf4621mr765307e87.47.1770733384249; Tue, 10 Feb 2026
 06:23:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120100850.66192-1-marco.crivellari@suse.com>
 <20251120100850.66192-4-marco.crivellari@suse.com> <DM3PPF63A6024A95377F0E6D202095C3349A365A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF63A6024A95377F0E6D202095C3349A365A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 10 Feb 2026 15:22:52 +0100
X-Gm-Features: AZwV_Qgzi38N4L3JYn1SL0B16Ro7oXLjyx80cy11waREUbnhKyezeQs6IQdM-6A
Message-ID: <CAAofZF7KdqvceqEHUNJpK50X=omkzGD80L8e7vJQvmHy=aYSUQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] wifi: iwlwifi: nvm: replace use of system_wq with system_percpu_wq
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31698-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linutronix.de,suse.com,sipsolutions.net];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,mail.gmail.com:mid,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D8D811BD88
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 8:59=E2=80=AFAM Korenblit, Miriam Rachel
<miriam.rachel.korenblit@intel.com> wrote:
> Please change nvm->mvm.
> Otherwise looks good to me
> > system_percpu_wq

Hi,

Ouch, sure, I will do and submit a new version.

Thanks!
--=20

Marco Crivellari

L3 Support Engineer

