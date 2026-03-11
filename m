Return-Path: <linux-wireless+bounces-32989-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBKOAZ54sWk2vgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32989-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 15:13:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E76C2652D8
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 15:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB1EC305E827
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 14:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E24368269;
	Wed, 11 Mar 2026 14:11:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFB736C9FF
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238313; cv=none; b=IoThVUiR9jDocgpVEb4kgu7MpvbQ79UuBPK4WQLiljvoHVV4djquYsyYKK8iCvJNq7e9EGlDmmPXywnc/okRBBWop1AsrkCXQxbUrrOqVkluHOOnnGYLv7LmFx70nLuFpDuTYVVbzYf+xZAe7n3Ca8DtGynSKb+UUqHV7VzFKOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238313; c=relaxed/simple;
	bh=POUJjzeRhBIXfPGojdZfC417KH92loTKx1KmDpRcfoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXyDOq5BYbQiWKhnMePfJ463YeIYcfA0+j5X3tot2IQ4BGF4HKwjPBOk2OZDdtsw5jZIJhnzPNKZbJ2xy4n8zDP/UMXkKRPIPVZ/F+LYQlhjVEWQ27c2NWEN1XbMUTJuqYnPVJY7ClAoF5XG9fMy/8vAVOxTNXbY/lh8W31U1lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b93698bb57aso170110666b.0
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 07:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238310; x=1773843110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIz9Fr5w5J45ZN4rxwvT/0kjXMGfLP1VpB2aKPOax7k=;
        b=R6W4HVdnsOmsxEjfomPt4+pDI7QxzdEfF/oc6EkSfQaxgsHFvPvl4TzeQCMyr7KYI5
         VrqWN7t1Hq+ASQ6got89bhoj1nTFoTyZ7u2fq3/1H/5gsjzhViat0C/GSzyO9V0eOXuB
         gtiTbxMc/gFSD+eDFH/OIVO/n0gHhaxXlLXlY3j3BPzQGnWySf2B0d4ZusmJ8dQ+5Sfi
         TD3XhQuqtNsCI9EGLORrucunZ+bfPvtVjcAhoxpKhNBBXTzqRf3EeT+Y2Wnb3Ca7/QDm
         VTbRIaLqYYe6ZJDAQT8JH9L2Zn56NZQIsHM5v0bKdkIK6bMqn5Zh5HYFXyOuew9Pgnz8
         71ww==
X-Forwarded-Encrypted: i=1; AJvYcCXqU4esaYkG/dROweIETZuNAhJReA8SAWKlW8XwzFKbxwhEdZWh1NJWmFes4thVi7fNhQePNXa/G0VS8203Yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKx7bWSpr3/S4/+F9hTeBE3RzFjrX2gU45IGyLislnk6J4pSdr
	Yz6hMivrSlmOOJ7MToceCiln/uzjQ2V+ek7cR7ToEsOYbN6cY0VEg5z8yY7FNiq/P43vMA==
X-Gm-Gg: ATEYQzy2zxAk6MnLQKFBBmub/Z2rLODV6Ck8eLbsv7/0cJG3BUwOyXgofSt+ly4roFg
	8zx70b2XQc/Edokse/g+ynpKAwZZV4W300xYavqo+YIiAOExJHUfpBVESc0UxHEoayKehaf8yAz
	hXxpPrqJ0N6vOxorBaw4/a/cPukQTlSxF60tmVe3M4Nmca7/M1b9ZRN5c7axJJZ6kc2yOLOJT9g
	K7Jt0GktAeWQUNdfOMNhBRcXRv80hppb9Rl6Z23EJ1m/sbpBZ35ys8Jl8z3X/SuLlNnLTzXP3k2
	pa3PGJ5Cq1YtpAU/8JF5faLAoLPHokEm8s1xv38l9QTEg+gqDqL9VW2YcIaoxxjIqemmnJDrx0P
	fmAhvT8l+PtjOGznD7HECOyJ00IBaA9YIeBFsdkjucCF2735C1YZ6mPds6C8JENtiHLoGXDr/hh
	G/xFpiDkcK/LqlsCFjgpwpnA+DEWEhi6vt7LssoRvzW/PeCfUR0+Xvg3MnPT3/
X-Received: by 2002:a17:906:dc92:b0:b90:bd3f:7c0d with SMTP id a640c23a62f3a-b9711a78478mr395331666b.27.1773238309505;
        Wed, 11 Mar 2026 07:11:49 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972e14c2d6sm58587566b.32.2026.03.11.07.11.49
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:11:49 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66325f30570so981493a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 07:11:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWeONILM6d9yL3k4LcRK0v2Ixs0nGY+kjEjguRpDhUafN8/aDb9tpEPb/ZDe0IAxHKbH6QXau+Q4Mvi2PrvgA==@vger.kernel.org
X-Received: by 2002:a17:907:6d16:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b97113ff0b9mr462021166b.0.1773237981235; Wed, 11 Mar 2026
 07:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de> <20260310100750.303af303@gandalf.local.home>
 <20260311141332.b611237d36b61b2409e66cb3@kernel.org> <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311100332.6a2ce4b1@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 15:06:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
X-Gm-Features: AaiRm53WEGMMLW4z34e7P-lM1qFvsCJGZ_o4JNL5NPWbhJPKmcqz6k9bJcyL--8
Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org, 
	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6E76C2652D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32989-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_GT_50(0.00)[57];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,goodmis.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Steven,

On Wed, 11 Mar 2026 at 15:03, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Mar 2026 14:13:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> > But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> >
> > node = rhashtable_walk_next(&iter);
> > while (!IS_ERR_OR_NULL(node)) {
> >       fprobe_remove_node_in_module(mod, node, &alist);
> >       node = rhashtable_walk_next(&iter);
> > }
>
> But now you need to have a duplicate code in order to acquire "node"
>
> I think the patch just makes the code worse.

Obviously we need a new for_each_*() helper hiding all the gory internals?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

