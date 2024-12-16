Return-Path: <linux-wireless+bounces-16432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4069F3DFD
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 00:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F39B1884228
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 23:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA311D31A8;
	Mon, 16 Dec 2024 23:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KO0mtwzx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454561C2443
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 23:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734390180; cv=none; b=iX8n48eD0bKqy4W7ZEEzeUrPLsDLMSYJZkGIm3xP9MFYHcOf6CimcykmTntBGX+eo03ngfzbmgkSjYAmMBq0hPXPfWCI3wEu8rllrWMThmc6Vw6HH/aAXekXl+P51h12W/U2efg6OcWwycCcblQTPT7xUYh7FaeUo9vCokPMQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734390180; c=relaxed/simple;
	bh=dNpEYIyEEiuL5B3Q9Wf2beKGcqDDezzwhblK7pmzQkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sno7kz0QqEUfRWEexx7bmUOIbYmfM0t4/8yPBF3T1ePm0DV9K5mOVmnAKtf/2VsvS4dAiXtgsUzUi6SH4T2ehIP6Ng0DNxz9p/sGFHGCAp7RqlfHU6ov0RrXmJdtGppIL7fIzBEqqCVP3NXsh4M3u8GmYyiwxnrsjKPjPqIkTTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KO0mtwzx; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6eff8289d0eso47572577b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 15:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734390178; x=1734994978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kgbUCS6yRX96lOYmbdxrGaaVnG1rWgKUlUa61iIjIk=;
        b=KO0mtwzxPnvUBSSMgE2Qhf4vWAHZEWYpMrC4HI8/aXVn7GlkDsN+13ifovbR+PvgYx
         GV5CT1kXQSpsm+qbVJHyEQM8np+uLs6NgntI2TrD86RPCIPRmq3u/NHlwLTVzgioJ2pT
         Q4KWca6d+rOYbcC667kDPEHh7qcJPj4zUeP7dPis64j82XHmRrnCF/OeVs1988dK11no
         fhhsZdu7s1lIFdFFt8jNsZm9Vn/ndrd4owVj/BFL7juE6d8jnnKa8ubP8UGNOBr2R6Ch
         EW0KwamWsTbIxdnWm6XH/OOSmO2fV5KHPzu0Tpt6c4JxE0zDy7zkwrhfvGRhFY34vnvT
         iDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734390178; x=1734994978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kgbUCS6yRX96lOYmbdxrGaaVnG1rWgKUlUa61iIjIk=;
        b=WAF7UmD+6MHDcqhE3Cgn0XNMF8dffFeRvhJ63HgG2hWzME8Uh4YBTN+4CPFVJfWdAY
         ogpHblcEP+UyL2hPvOnJUZmYzBJXx1ht4UOuQ5DGr7mMEQxF2AVLPB65ZWmsgpW8SMXR
         VQdHddZynrPz3jxtiVHg64fGqml2XSc+91hSeC+jpRBnITo0o7n4naNEecfwo5N60m0Y
         kRs/HZrM+MvzMsCzmCeewWDxWiSGcM9RcszVwbVEwYJh6Wt3LQ2w/LsaZD6sVipKs4xG
         uDG961EFXl90Lrw7lmOqtiS2U2HOunfEuO2xe3iBI4YNuZn9e4jWkvq5GZ/mPHJ+UMs/
         sPow==
X-Forwarded-Encrypted: i=1; AJvYcCU+jVJMEt2ZYu3oO+9tyQaK3yXYOLL1KAd6f+kSvGeaaUGUjcBkzEVAds0qhrOA6FGyB7D0BGbxmtRZ9xkcBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzL1Gb+rkFJTtJ9/RPCbV8ypUh02jiO84b69alafW6FSGASaz3X
	RKnzpqygI3vHmubHQ51R2i//hPWGkhDBfo3B2Y6TkB2UV2e8KrG6k94hCJ9q9ghOZSr2xx8rSRU
	YOaOue+NKq3/eDNe0O+IH+hJnrlNHC9gQLoVv
X-Gm-Gg: ASbGncta2o4LWpWZ6l6rwgU76TF6uJ04rFXd5ENFjNvMKsRkrkVcpzJKXOYPrPDcJr5
	Rz8hMdMVjLVZRmJIV2CmCPzLNwbIpSOeSYnez
X-Google-Smtp-Source: AGHT+IHrwagCDxh86JudR61ERsEoZaOO+nNF5gGHxdmt+LQ6ru1sGeudHuNKonCIKj4X7Au1PNG0jPlYUBpASW7wnTk=
X-Received: by 2002:a05:690c:690c:b0:6ee:c338:9d4a with SMTP id
 00721157ae682-6f279bb01d6mr139492107b3.28.1734390178273; Mon, 16 Dec 2024
 15:02:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213054610.55843-1-laoar.shao@gmail.com> <20241213054610.55843-6-laoar.shao@gmail.com>
In-Reply-To: <20241213054610.55843-6-laoar.shao@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Dec 2024 18:02:47 -0500
Message-ID: <CAHC9VhSHP4zt-GtOWgjzC+vVJriJh32_T+7dt0uBtTLXuoYvnQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] security: Replace get_task_comm() with %pTN
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	x86@kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-wireless@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, ocfs2-devel@lists.linux.dev, 
	Kees Cook <kees@kernel.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 12:47=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> Since task->comm is guaranteed to be NUL-terminated, we can print it
> directly without the need to copy it into a separate buffer. This
> simplifies the code and avoids unnecessary operations.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> ---
>  security/yama/yama_lsm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

You need to wait for Kees' ACK, but this looks okay to me.

Reviewed-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index e1a5e13ea269..4bdfa51ea6fd 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -76,7 +76,6 @@ static void report_access(const char *access, struct ta=
sk_struct *target,
>                                 struct task_struct *agent)
>  {
>         struct access_report_info *info;
> -       char agent_comm[sizeof(agent->comm)];
>
>         assert_spin_locked(&target->alloc_lock); /* for target->comm */
>
> @@ -85,9 +84,8 @@ static void report_access(const char *access, struct ta=
sk_struct *target,
>                  * Imagine angry ranting about procfs here.
>                  */
>                 pr_notice_ratelimited(
> -                   "ptrace %s of \"%s\"[%d] was attempted by \"%s\"[%d]\=
n",
> -                   access, target->comm, target->pid,
> -                   get_task_comm(agent_comm, agent), agent->pid);
> +                   "ptrace %s of \"%pTN\"[%d] was attempted by \"%pTN\"[=
%d]\n",
> +                   access, target, target->pid, agent, agent->pid);
>                 return;
>         }
>
> --
> 2.43.5

--=20
paul-moore.com

