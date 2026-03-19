Return-Path: <linux-wireless+bounces-33514-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAznBRRjvGmLxwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33514-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 21:56:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 869952D26DB
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 21:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D15AA300A119
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 20:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDD43F881A;
	Thu, 19 Mar 2026 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSilnVDj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B133FA5D2
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773953792; cv=pass; b=CANK8VuD8znI8UxGSvS39kd9OeUaoFO1aabVBGdwkqSDQ4jp7XILD6gEsgOJ6QOvqtC+yW21JHpucgykwtzz8MWjmyDwI4VcJNxxEIr/qJ8kn04lDbO7kMyhNo8x5G/Jzc9Ow8THYrSsVZw+pr3bb4u/jq6JPus5V7sfQsP9NDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773953792; c=relaxed/simple;
	bh=nnwi/n0HAzGljndkxV8Wi2UVawJJ53xEcu15iCONSJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzwviKgO5Y8t4yhYAv5yU0jDR0Kq0/oddlix8dFNJoNUJW5+kWKD3/jKiQNRdPjCNDK/lHWtAPRJRmeayj1R61UiPZrntiNp/c13J7Rq2m/H4wJ2mVcBoPYszJ1llqYYqvJvlRN77zHVtpHQP/F1I/YYpvd9xzcxo/wk2ycIr+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSilnVDj; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bd801b4078so95505eec.2
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 13:56:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773953789; cv=none;
        d=google.com; s=arc-20240605;
        b=frue3/eAkC75VV5NiLtn+hxuEj2ms4s3GxE6/hdgg/SUJf7ZrJ55WH13swM2ClPs35
         E3fuxX4miILcgiwqPQVlFP7ljeicL99K+wiEjn273bBOSSCiyolMELf7LFUTbMbdE/Q9
         IV3Vf1hhvHMzUEdqN2CrUuIpkwQpMEMXgt0+XBjBkhYukQsk3v9JE0Utg/KF8G//m+Nu
         7sCV6i5Yr2Vj9Vbtz6FNmaBnLg0YEx2rUpWatn7nz+ALsBRU5KC+o6Z5S0PHL26ePYyf
         9A1MP+sOs4YdKajpRt3Ob1WWM1mlaWkqRc2AZ9FYL7UlPEPyp9FniZJB6dioigSWwVyr
         QDvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zRZd+ALsgt+xzHl4OWoFhkmMJU5AICNZrtfANOezrtk=;
        fh=VJ9Tu69qqk1Gq2ejxVPdVh6r9JG0KgpHsSfe19+brY0=;
        b=MuNVO4nlO+LiVAzEkRRrU9j4p/NPjrV8WT9SnOX29TOr5Uk5uL/SFRYVhsxvkTk5/m
         bLiWZneY/UttY/4roE3oh3ZfCXfnb9fYUYRYspjmK0bKBM39KF1LL14jG0OsCAiJ50+4
         yufhC9jro/1rGzheKeFnOhF2luP+JX4DQtqa+OJrZDSEehTEEjJQaK3DSpn/M9O5Lj3t
         VHVn39Zawrxp/lBnj9I/rlQgqBHQlbI5+lHcf77J4YzQJuGE2Xvmgs6lMiuZVQc/f/As
         OjsHjnHCDwcSFIkyasIyjfwEDgPaCTmz2f3iYxGo4VsZnuGM5t4GvDHr7RLTh1HmfVSe
         GbCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773953789; x=1774558589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRZd+ALsgt+xzHl4OWoFhkmMJU5AICNZrtfANOezrtk=;
        b=HSilnVDjDBqYLc09Vu7wpKachaj+0Eb6bsHee92f9IDtNTSJZizqpUgEX0jfqk+7n1
         hxJeX82GafLBoTONPQxzcJHCAEJtnb9+iqsnxbCZRg2CU/Jnq0DLf/DPjOzHbHMclFkT
         7HKLftUzsGzBpmsjbp3S+mmmOEitO1sXQc0ns7/Vy+iqaKmfKgSPC3vlKtINQmGbDy4x
         zYoPdpEAO9WeVY5N9QGdhwYJnSpE3YYhiQqMkMvEMYurUf9OMnEB2uWvZ76lcszxnDEk
         bTLfa12xmOFMp7XwLQfIFrdapaC74tFA+2Sofn5askCrmYZiGcbl31tKAOH6zKrjA246
         Qqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773953789; x=1774558589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zRZd+ALsgt+xzHl4OWoFhkmMJU5AICNZrtfANOezrtk=;
        b=T6ZnmeFL/PugELIlK0WF41o6kPx+JUgz5LSqC7dTMLsJLeDZjHob3ornyq6JT9elgD
         hydfv9FpD6zqGMpkdK2tTBh0UvLqQKO+hvtBUCvLmEyyAtuNr8cH5S7vChHMCCURGG3v
         lHymVBzFO9AJu3hIUUxvrlFgmElW60tDhkAiapLzNbm1/+YwB4yM2qiaDuaYNWiOJpen
         +8mmJee0dVDfkxJb2Qrv7KFi/zr9wllihZSYuSIi4kPAxxYdYU7t34xp3ooayPv+zhRH
         ErUZurbNj4CR/gRpRJDKQ8OrB2ST6v3RWKqgTwcHSIqLwqYgsdn+AG0CO5O+l6Ykfq+z
         SDrw==
X-Forwarded-Encrypted: i=1; AJvYcCWP/wI+T3asA/BIMpxz//or0TVLFKjlWcb1OmoIgZeUmYfb/TOyBuVXdiaUI/pZIrkSL3RkdttN9BjuH7OaJA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz2gKAuEcDnE30976aLBU/rBCkkQXmQUlYAlmeKejk4fj1uKxZ
	4pyQSOHqKSW1U4g27zAlLZTz9qyzFkoO2O1HyD5T7Cd2j2TVmoSZrvhRmdB9pWlQtLXNr6WhrNF
	/CnDStWaLIdmvNiYplFM+90cIGifu3Wc=
X-Gm-Gg: ATEYQzxWh2pPlCwW75hUiGz8hScZASxvKlr11SjdgG5aoqmMvd85Z8VuRJYIlBFh3vC
	5vEqupajWgySU6utboOXKUYGtpcip5KgRvl2/YZYw++NvY59PDMfxRX/Km2hH2aaN8mFJ0VajU/
	R5IOfCZT82VsjZrcoqM04qAFy3EMu9bvY/dt40LeYqWQgYmZmShozBM4YXgn3dZCmqOKVdy8cWj
	34OK1ZB3+CTPXEETIPp4Rixiv9bKMs9V1EpuT6hOtRnQFZiTAspTf3Z0z43VkOI2eYASD06sHZt
	VDMrcIu8nk63wN4UPIqMaziFTXlAshwn134EZVXUKmT4EyFVltMLk1KuoBKu3a8C60EFRMXFbwd
	ikQuwsVPtbHHNKEyxs+b19qQ=
X-Received: by 2002:a05:7300:230f:b0:2bd:fa8f:77f4 with SMTP id
 5a478bee46e88-2c109839ec0mr230844eec.4.1773953788625; Thu, 19 Mar 2026
 13:56:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319204728.24836-1-adriangarciacasado42@gmail.com>
In-Reply-To: <20260319204728.24836-1-adriangarciacasado42@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 19 Mar 2026 21:56:16 +0100
X-Gm-Features: AaiRm53g6enClk8P9HAJc-ysEebw4dbz_P9B6UWpDj5s3J__77auM5cyskUF84E
Message-ID: <CANiq72k_Kn2xwLkdddwcsJONJbAJKu5iTyvTPGD41pggHwVs7g@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] wifi: iwlwifi: pcie: migrate to modern
 pci_alloc_irq_vectors API
To: =?UTF-8?Q?Adri=C3=A1n_Garc=C3=ADa_Casado?= <adriangarciacasado42@gmail.com>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33514-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.956];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 869952D26DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 9:47=E2=80=AFPM Adri=C3=A1n Garc=C3=ADa Casado
<adriangarciacasado42@gmail.com> wrote:
>
> The iwlwifi driver currently uses the deprecated pci_enable_msix_range()
> API and implements a manual loop for interrupt affinity distribution.
> This manual approach is less robust than the kernel's core affinity
> management and increases maintenance complexity.
>
> Migrate the driver to the modern pci_alloc_irq_vectors() API. Use the
> PCI_IRQ_AFFINITY flag to delegate MSI-X affinity distribution to the
> kernel core. Remove the manual iwl_pcie_irq_set_affinity() loop as it
> is now redundant.
>
> Additionally, remove the unused 'offset' variable to resolve a
> previously reported kbuild warning.
>
> Signed-off-by: Adri=C3=A1n Garc=C3=ADa Casado <adriangarciacasado42@gmail=
.com>

As it was mentioned before, please reply or acknowledge the feedback
you are receiving, instead of sending new versions immediately:

  https://docs.kernel.org/process/submitting-patches.html#don-t-get-discour=
aged-or-impatient

In addition, please use `scripts/get_maintainer.pl` to pick the right
list of Cc's, e.g. I am not sure why I am in the Cc list for this
patch.

Finally, if this happens to be assisted by an LLM or similar, please
disclose that fact:

  https://docs.kernel.org/process/generated-content.html
  https://docs.kernel.org/process/coding-assistants.html

Thanks!

Cheers,
Miguel

