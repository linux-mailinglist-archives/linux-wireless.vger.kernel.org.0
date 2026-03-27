Return-Path: <linux-wireless+bounces-34092-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOBgL7usxmmiNgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34092-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 17:13:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C906347449
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 17:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70B4A30E03F6
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 16:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85C226C3B0;
	Fri, 27 Mar 2026 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Pfug5zYV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727772EB87B
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627781; cv=pass; b=HPTZ5PZDunDrLEnOOhbjcSP0S12XbaKLPb9HfaEetHAvYwgxvEAua5OuzEXd7k1Jvv+PmsNrcdeKUxcFGFy1WOcdCIREyf4OdwI3wpGDb3sraedBA0gU6tlYAZ/S0Ua+jBgMdUDm2UzUvtlMnDrdFSQsGQQ0LrztsyLr0OMqj88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627781; c=relaxed/simple;
	bh=vInfiQ8M2ehY9q7qwH7+CiFq9FVUcmtishiOCXSIfC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i81B7Q/zXHSH8d24JsRl87OVVY21qjwC28l958m22YLbiQTMZ9j5F3KWqcQNjpgWwD9MxKw1We0g2BMFuqaW1wRmWx5dUK0pj2wSmHOsU1f3K9XgInycYIlzXl2aQVD29gqpi7m/QHlK4CnYkd9bYIbMGFbjyRTZUgdTmN+R+jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Pfug5zYV; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a126c8aab9so2905531e87.0
        for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 09:09:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774627778; cv=none;
        d=google.com; s=arc-20240605;
        b=Qo5dJhKyRydDPDJa1cK3rsyfbQe3QJ1Q6B6qvENhldKmOsRL6I3vbJzH3vbQkI0/Ix
         qjPDwPsTzkDpfHd23OBsTmCqgYl6vmQHAOAGVyR+ra3DcS9SMlFO/GcuKLzTtZCdOHEX
         FlsGBC9miZwErL6nWLBLgm2NBCtr04K9/QuLf0GTTZNf+SK0MT+PGjekbLOZRAq/sL6y
         ZnGF0eZKIes1zK5Z3/KjUY+hVqn9eooHOtibmH8ynYuZuLiS5hkBS3xaX5/8fHlwPnIO
         PKbH70rYNAX+jK9ms8MkUYaTkfQ59y8DRxeHU9uuuVhHydNXvPqJCpww7FT9dJdwfSzP
         d80A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RZD6HAVfjrroRZROuE5F2NCIC0/dTTOWGyCk4S7z7Ic=;
        fh=gt8bjE3dJwnr4mJmkjkkrtMqvAajuoHS7BCCBJX3bHs=;
        b=IgXGi5PhUOr4SiIPWULbAmbUoflXw2LHgMAjqY1lQirhXZzR5MlDvMw41iuWE+4SlO
         K+BAQ6pp8Vyn/j8ZcSWSNnJqcV7/+nNbQ3H2UBl4wBSyMThdUO9Zz6ERCgKBub4koUJs
         WiTcJwYsFgxnWzT4OoP3RRUmUKFrfH8yxxIIAP8sREyyGZ4wlYpb15woTu5NeyWkWdfu
         rlrRNeAKThgp0DIfN4yOYz7sfd1sCB41Up9NYsv983pZjE0TNlBHqXVVw8tq9Wevh0UJ
         K3482NxrDILSNkR02cWDRuqd65rkf/DeYJpQKesKivfuZiHTSWo/7PsJ0QuxI5KOJEf2
         K3vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774627778; x=1775232578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZD6HAVfjrroRZROuE5F2NCIC0/dTTOWGyCk4S7z7Ic=;
        b=Pfug5zYVc4VTkXWSSIu/fpdHsHehq8Kggmr1Y66htliPlWWtuBcUZwW/N1Ac95/QEW
         jy6Dt/e1BqiiDjL73dA7z+ZXeY1CEyJRbP0YjTBLBvmbbTrVQCM5/jI+sLKy9sCAiJcp
         iCrelS4R8ao5nzgfgOP1gpgmJZroUlJCVPENNQs1B17R9qOfuLf6PwUxl9h1aG24DiF4
         YpAzHpGv+NOV43Vpyl382lBSlsvqgP3EtuMG+Fr7TvCO2wxnAFgl2LGdYxeI6HG6yiuO
         4Z27gVZeOj7RJxA5aoHILqyXy6/nbYwA9DVN0gy8z7gNpxT5qmZkqb+cZ7xIl4EEgf84
         +QoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774627778; x=1775232578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RZD6HAVfjrroRZROuE5F2NCIC0/dTTOWGyCk4S7z7Ic=;
        b=PnsyUldr+YNo7OO3Fak1SKOBREQ+9F7Ce37d34J6phfSGLXQBovqwNYbasfBz5U/m6
         0468uyOYl6eHAilbLXf8p7lzsQVuoatttlPr5CfpomI0mKUysFbYgyk/IYTNgK2hvNbF
         bDZq/fAIqsMXWE+lPzS7PvfMneaJdlQ/VTEf0SbatBkVy1hcYU9iIBxVj1hZ7sUod+vp
         7vz5Wbl0hfLzV8iYyjO43jdXUm1InyAKGas3eOrdnabAxhDEzPNOe8ZTqWf0tXiFeulI
         ev7GmZhCiNIfJXOnLfheJHMLKmkcPsycQGJymvU3pO//V9QktPrVqEOtZVd4uVJRrRjL
         Ud2A==
X-Forwarded-Encrypted: i=1; AJvYcCXrQTAI4OW4LTD+aLpUMlymwxcEnsC4B7Z5Yc86crPRPpd0XmxDri7iZSMNKe0wtcahbfyJZCVsfhTeos8PIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMBBXzHIvZSjQ9MIf4EyiL9JtSZIMyLgln/w+EHrOyWFKmvQ83
	ewS8zerIahNSGmF5ZP7k64QxdMYCLcDIlB+mv5aioaGQM98B9YWHOIHfdDB5hClb1g5x4wX0/c6
	KzL4QpDbOjGc9lsp46E7OQMcKoeO/JHXBMDRrQujofw==
X-Gm-Gg: ATEYQzzzypTQ8kZDpt2S9qvp9Dtjz5rFa9tbutBmtQ5BQKOvBmsYklp99iwkFdRiUHH
	aHtzVQukkNVN+zMFu7tEV08kckpLG3QHmXUGW/vVZEZ3z7/jJ2EKaFI6jCdJRG1cypj0eDl2Yca
	2FAPLTHVslacJH28cfp2UUOpRhr51iAbludD70CG6GqOVkBhbZeHUL2yi0y6NN5M412dGLuenOj
	igrhxHl3ptP8IXyF11Pg2DX1Ibf9GToToHeYuR6+jQg64YXeZbButOwuNXbO9sEPeghO3uufD+u
	vt/jGI8u
X-Received: by 2002:a05:6512:ad4:b0:5a2:a1d7:9cf0 with SMTP id
 2adb3069b0e04-5a2ab92d98fmr1111538e87.31.1774627778491; Fri, 27 Mar 2026
 09:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210143332.206146-1-marco.crivellari@suse.com>
In-Reply-To: <20260210143332.206146-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 27 Mar 2026 17:09:26 +0100
X-Gm-Features: AQROBzAkFW_Kr084Kz14IOAxxdjj8cNKMOvdWwAIfQl4MVCwkIg9g-npkPfbl7s
Message-ID: <CAAofZF7o5vvnJ=_s2Bi2Onn4tuXOq6uqHCrJ=wp44FfTkqRegQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Replace uses of system_wq and system_unbound_wq
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,intel.com,sipsolutions.net];
	TAGGED_FROM(0.00)[bounces-34092-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim,suse.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4C906347449
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Feb 10, 2026 at 3:33=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
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

