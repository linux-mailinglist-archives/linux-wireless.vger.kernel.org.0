Return-Path: <linux-wireless+bounces-30103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86294CDCB41
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Dec 2025 16:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 338B23015A99
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Dec 2025 15:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CEA33859B;
	Wed, 24 Dec 2025 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ESM6CCAu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D6034BA2E
	for <linux-wireless@vger.kernel.org>; Wed, 24 Dec 2025 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766590062; cv=none; b=bqBSzRM08rX6/FJdlfzWTnRDhHNlJOm1NXiz5+kVb4U6HY5tPjTO8qXM4t/Nl4ELxyVREgHqDGP0l4v6Tr/UHk22Fb7epXP5j6fCTo9DhT5ScGnRAEpJJO71ToAuek1lCcE/ECSKLim2lkjVME4LweOCuRW4p3rzQmZOgV8+2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766590062; c=relaxed/simple;
	bh=+JOgQ4mhm9JtvIXCKRcWVUKSXyvY3NuCIq+GtgvwCG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fo1cSEHwl2O4valTMbZrKqPxfW2h+J2GBpkur7/KQB4EslREAyu9v+JwYHGmIYhSYi9BTrO+zJf/Q2a2+fjoJ7mbGcXpWzyP6wp6R5juZ01duEa5EG5sAeA5BD0gazBaJdGG8qAjx4JDe0MzADLu2ruaS68+sx+eeSlzm+Zss3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ESM6CCAu; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5943d20f352so6569547e87.0
        for <linux-wireless@vger.kernel.org>; Wed, 24 Dec 2025 07:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766590059; x=1767194859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXkYlJW1xUshL7WfbQFczMKT07UfyeJWClXZ0leX3z0=;
        b=ESM6CCAuLRVkymiyluoA83OvSROt6ShdmiTbvmx3wNrZvNp4eBPTbtUCYFKKr2hEBx
         dpsiWXOtwyQQRKWkAwjl1+2ySSriOf0K5ClCDjVE+0eiI0ljx43uM5xTpAABwMkGNR3h
         J/ka0LmdXv9V7NRzlZIY/lHH9WFqFxoIMVRGOGmmAjLw/USjIqP+B7Fr3R5RQGoT5iA5
         7T8C21jtH0vB+udHkEyn5V4GTbHFdeB56aDCSmZPMW+8y5r3h7J+onlOKRxjPy6xplkP
         4MEegxzupwsqp20h55tsK9AdXg5VnpeeVlEiCQNl0D5ZfNnHp9O0Swprizv6XFphyusp
         U2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766590059; x=1767194859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EXkYlJW1xUshL7WfbQFczMKT07UfyeJWClXZ0leX3z0=;
        b=xGQoAdHYtxYqOEph4ylecWg2g6dvtOUXcvYwF7/riVL4GfvGuiSMTJjj+D042RY/Gs
         wiKMcItYRGzXeb3uRJWY24N5UWnQ6Od+ggbIfhjlpWNcybh0SSp3gNjO286K8yjBKrCB
         GpN7bhj4SgBbym64kVcwcnzWh63Rnu8DbgKI7XRrU5jHo8GjobnERGbIbr+dIHGIA92S
         XyY/cJN0MiVb54g2AB9vNvR3+lJQt9BM8YF32xHhSbBN2fYSbHCLC98VrD5bFfmNUm+l
         2PUFh2165k+dxmnCtnp5WYj9kqIEy1JiGwCOejcYgiXPkKnAI3uB/tXUeZ9RFiHO4EZW
         mBuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0iybjcoSemtDE9JH159QlrGw3y6NMtvnvwrlw8oJFEnTO9Cjo+atWYDKC9MktIMniZvsDWKjgwWIYLRaqnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhQxfoW5PZ0/lhMjhkCnu5eZ9zLrxM862pjzw/PAdMjwlQA5WX
	fp8/tkHfZh2c3EmFBChZP6D4CV8GoQLb1l2h088eCb8VYTZA/MyPx9zhYWFch1WtJ6RoydkK8sh
	wKCmFWipzKHiZGzX5qBomkN6oloSJxU3b1zNSQhkqNw==
X-Gm-Gg: AY/fxX5Pfrl2gtnWsL7Mk33foKuG4RXAWxtyuHhWFAT+fAna4T6JWZ+8UcCVHTsgBf4
	Z9QU6DFYKb40bwiVgwsIXfelTmoUH/2bNW34llhaOmu+OjSGZrlDLWT7E4tRt41BuU82BI3GZTF
	8jKSLIvXH1lLCkeC+Ws4O83PFGTrcXBBCW4/MUXYkJJuTx+y9g49AQpFdXX7dFkgq1e9mg3OoSl
	o9s9BL5bOg6HTT9yVkfuZ404MvNC9Q+fCvhJJBqwD/oY+1Mz486ug9jaaxvbwY9Eh4c8h+Rtu2W
	zEPLewH8jwv4XybtrnKLBUSR4kwyoLbN6KfbrDZPNjBlszBsoA==
X-Google-Smtp-Source: AGHT+IExofbCzFvKfNdwHXe/1HJP5q5aAZqwB3lB9Bvmf3cZ5WMYtTCG4xaoMgZpi1++vxfh8AXL2h1b1uch3851okI=
X-Received: by 2002:a05:6512:2216:b0:599:108f:95f6 with SMTP id
 2adb3069b0e04-59a17df3ed8mr6589652e87.49.1766590058789; Wed, 24 Dec 2025
 07:27:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120100850.66192-1-marco.crivellari@suse.com>
In-Reply-To: <20251120100850.66192-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 24 Dec 2025 16:27:28 +0100
X-Gm-Features: AQt7F2oVObdoiuAXIVBw5K3uGh4HZBvy6ghuruCZEmUKxGxRhcxiZr3TLjtq7BI
Message-ID: <CAAofZF7hFFH+pqojfrpgw2L8G9eLXxo1jO4kHxs9mtzbxboAMQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Replace uses of system_wq and system_unbound_wq
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 11:08=E2=80=AFAM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> [...]
> Marco Crivellari (3):
>   wifi: iwlwifi: replace use of system_unbound_wq with system_dfl_wq
>   wifi: iwlwifi: fw: replace use of system_unbound_wq with system_dfl_wq
>   wifi: iwlwifi: nvm: replace use of system_wq with system_percpu_wq
>
>  drivers/net/wireless/intel/iwlwifi/fw/dbg.c    | 4 ++--
>  drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 2 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/tdls.c  | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)

Gentle ping.

Thanks!


--=20

Marco Crivellari

L3 Support Engineer

