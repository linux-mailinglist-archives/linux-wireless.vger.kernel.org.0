Return-Path: <linux-wireless+bounces-32922-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMyiEmhKsGnFhgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32922-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 17:44:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CC125502F
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 17:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 177BC3116D63
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 16:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B3B3A3E89;
	Tue, 10 Mar 2026 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JwR61AOh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA883C8723
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160668; cv=pass; b=QadKj/Ai22iMrqUiyJG7KHGz+i/+UgsC1mv7LHTroG8vFSI8h419ouC4Ncf60u7tQX6ChOW37SiAcvsoXr3tfvFxTSRS9REOU3nSGnuB/t/jXJW+/MMEtbQSJgNRINap3dosOQxTpWW6W0KDwVNciZQKOzWuUtcs5Hkdsf+0fcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160668; c=relaxed/simple;
	bh=USeTlHjcN+hpmtGAePOAUtwY5eeicRE/dC0KeU5h6l4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FURmy4LREWThxxpGGZBLpiiWIc7iP2OJST6JpiQ5YWvulHab2IUUTi5hxsG5H+Z/L+OqO8UlVkRarWvk+kfbSWMoQwbU4hN6u+J2c9Uj3SZxjpusHHeyEHZJurnF7W/aH9PDGrjtrZgnlIBqe0tWHJdiEOZ71mCiMycX9UXNnfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JwR61AOh; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a13323ba85so6846663e87.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 09:37:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773160664; cv=none;
        d=google.com; s=arc-20240605;
        b=jfDsyhIxhjUkZA0O4YOeF74JgA1tb63ZyUDq5XmeFw5aY1wtyvO+ur7tP4Q9pUsTtu
         taRxnfs3/o1S+ZXcajRnxak+7MxUxCktDgtd9ApRXE3mM9Kp3Eck1uXinJXQK37DDtPM
         4Kfy6VSosIR3JxjsD5u+QnUx8KadclshKRO4hv6hzROdMKKDmQA40868v5nH1ppTAixQ
         13aXQuDQH1K9w4npfkl8pMhXEtjf9PAdMO20hDAugHLvlEeddqhk79RZX+MWzz9yatSR
         n/9hDkEXeTg2RLq3rBPsntvSIn5/wER5LLAYrYv7PJgxqeWQ6yYhAf3S1KiEDl2buY+k
         4Itg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YmMR8bucxMvEYJ1fz2XzeVxryvxGO/SSYz2BEXMP4M8=;
        fh=GC3Ng4pCwDZ90ucBdwKteHcpq3zvBjQC72BuWsafdds=;
        b=BpfZgcfbcr3W9iq05+hgaq6G3kmozvueB/QodQf/HmkSqpu1ji8lDYP+BmH4R4+iaC
         WfGjO0ABa11WgD04zG9PiKCzMpQgTRYjhB36ABOhDVR6ULmXp810UPtqCJZ2X1ZYH0tN
         g56aZZkgMMLeFve6gr0SAkrVWNiESzZ1YJuaqZ9lyupVFVIGpNZYmkV6WjL7ufdeTNjZ
         OEdonXHvOFgeA9PBIMOlG5lAidKHF8DCBkUVveSuduKQDwUejK5TdZe6YKuMGJWPq+kS
         OEqK9hN1LUnmgAX8fADW8yRocFuEvmzxtu2oR5yO7b4dfXfU6+aep1HJOTsd14tMfNLy
         VKqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773160664; x=1773765464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmMR8bucxMvEYJ1fz2XzeVxryvxGO/SSYz2BEXMP4M8=;
        b=JwR61AOhgOtDifcNkwTj8cI7uveh8sI4DPUb9LMuFdphm3rCF0ExxlJMVUaD8jxckl
         njkWXBkUzmKCDqaC8+E+Cr1EUYQD395322vIbPGmVcEk5/Oh0cHzRJ3kuEFINfq5rtVb
         q4MKEgFzKCZ80eF2i2pU00hdAOoFds2uG0Ycp9GN11mzetcfdkiLivojEvF475avLQB5
         dIWpAEH3E4E/qBe3DiOhCQkaCFl6bp5P7J7pyuh5m6OQezdgkwthOxsHB2GTSM5WRE+z
         ngGNAjlAjp9Ljysa17npuhEb0A+22957aJyj+FhONnnD/p8+N+aq71mpncfxMuQ2Y37m
         juAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773160664; x=1773765464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YmMR8bucxMvEYJ1fz2XzeVxryvxGO/SSYz2BEXMP4M8=;
        b=VZmNwYq3h1/lNNz8gtOtM/5znYlpbhPFJ3J0nBAk7UzG21FTei5UZO1xtVU/V9PJBI
         XkzRgmCKSD4YF4Mo0Bp6bKPXCsl5iiEeQt2YkdKGPWnVAJeiofyeKWUHuDN/Vq/AqCxL
         Nvh3OrpCXJyC4wvDHAlDrnK2wW/vWcd8JpcdntWbhLUJM5p/zAIa/88kfca9x6LikaEP
         7jhmJpl4Q/J9qDP3ObemnTKtFv5RJzaUzvVaGx/mPRRz3UgE4lGGMKmOmBuKktsXeNg0
         TE72JxX3yqbxS7tpStrO0LNtxKd14Zl5xdHeX6mJvUFBuIZJCttYBvaamkajIklGKvqV
         aooQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXiIEcG9UpNM/7MGRBr8kFaou72d1Dv5qZgvLfPVgt2hKDls3korU8iyU0h6UbxouVDse8sDWYLuYVPhfSbw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5m1Wud84Ac3Casbx9bwTcjdQEemWV4qwknEvdwaWvkhuT3C4k
	KEH5A/sfoJnKwYm7Rs9NZRvQDdeFY4eRjEPV/1Xqlr7WW4C0MZsWdzhrLxmTzLsSgiIFYLwZSYW
	65TQzMXdqZw0FQ23lpgA3i8/Y9MVB2NS8v9Gj7hI7GA==
X-Gm-Gg: ATEYQzzvgM66ld7vg3xh33tQLGg+xiNEh6vb136ehpj2ie7F0etylEAmGbmwrL9EH4H
	oWjFmNetdoDSRZR9AxCvUq5m8h2WrUdnrBhzhrr1R98rGGgnqCYOw8n8MBIxPYok+ojJyWeR9LE
	PG90GIOHMZcMoacJZj7GJN/VBMXjOc+KmhebAWnqKt/NjNsOgx0Cx+JTKeuCmc2OVBmk1XkMdx7
	7bjesZmTVh0L/Wz6M++Qoyu4GNOIP/eON63QWkhv1tylkOFt582hxv/9xhLbe+lEqe+pjBDaCpQ
	odypQgC7zEirxBzqgaUWhPIz0/aSPQsMGz7sCyPd
X-Received: by 2002:a05:6512:286:b0:5a0:ff97:4374 with SMTP id
 2adb3069b0e04-5a13cac11c3mr3703326e87.7.1773160664327; Tue, 10 Mar 2026
 09:37:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210143332.206146-1-marco.crivellari@suse.com>
In-Reply-To: <20260210143332.206146-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 10 Mar 2026 17:37:33 +0100
X-Gm-Features: AaiRm52rHaydaJMfmYyKkAUdajg_LjXrdJ2SfgQSLE1ihsI8cqnRmRBZEBOXtcY
Message-ID: <CAAofZF6wUr1y-PKnJ8vPSNNNF8qDMv8NPRx=XPhfbrpoKiAUnw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Replace uses of system_wq and system_unbound_wq
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B8CC125502F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,intel.com,sipsolutions.net];
	TAGGED_FROM(0.00)[bounces-32922-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:dkim,suse.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 3:33=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> [...]
> Marco Crivellari (3):
>   wifi: iwlwifi: replace use of system_unbound_wq with system_dfl_wq
>   wifi: iwlwifi: fw: replace use of system_unbound_wq with system_dfl_wq
>   wifi: iwlwifi: mvm: replace use of system_wq with system_percpu_wq
>
>  drivers/net/wireless/intel/iwlwifi/fw/dbg.c    | 4 ++--
>  drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 2 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/tdls.c  | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)

Hi,

Gentle ping.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer

