Return-Path: <linux-wireless+bounces-38398-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 19QHJNH1Q2qsmAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38398-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 18:58:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 037056E6B0B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 18:58:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=VZxIxu7i;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38398-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38398-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56A2830237C8
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 16:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2A63D75D1;
	Tue, 30 Jun 2026 16:53:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA73D1A98
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 16:53:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838432; cv=none; b=hTtGiWdMap/4aIK2DCJe71YmzdY/S9Oi9bwV2rd3yZH9Qu3DdKuI2PI4nerc5VvdQllc6ElGr9ymjlc4YFhLJKfmzWme9+vHruwVK8SNeDQsMwEB71ksF0MDlx1YrV9T66bhwYOkjF6BZ+PUAA+38EQVgVrAADzzVhiSnbOPxLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838432; c=relaxed/simple;
	bh=4cX60aAFpHSIylUr7tBHOHtlB3or0H1MO6CHMwJw11c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYZ4+xwW3BuQHt2iKtyPPj9Ht9+YoHn7OyNc7C/Bm6z+j4nKYpN2hEA7UmlkZ3Gz89wYeSzoj91k1kpw1QLqpimjzgYQP2c7+rsGgZ2HAVWCTLqlWq8gkUzsvLEFqvP/f+HdpyW3m2rSgm1SGaNrF00lEYdAKbejLcDH9R1JPAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VZxIxu7i; arc=none smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c9b2ac97cdso135ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 09:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782838430; x=1783443230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zrPBeTNRyLA3ooNpufO1eFc7tmIMjSyBAKOe+RAYTN8=;
        b=VZxIxu7i4mz4xfBB3cRpqrS6c/iWz/MJ7igksZYw+1Lt9vxZHVqjkGMg0VSjybEPiV
         nY4tN4om7paWuLDmv05OT2yvcdR4Fl63us+dReii59F46TlJqvo1mUlRmYnoz4oWbVpU
         ud+W4j+xFCDXm81O+bGQ2OVKXi322yRy1YsDGb7KFzEok7pGKsaSooS/rik3V+mmerIx
         q6Tz1/no3EWCAxF6KpiqGi7fSng98p7I9IY4dHdaxZMiWSw5BUmzLDGM/RqYNQSItCyk
         RCvzs8kwVzFlScSO0etuwUm8+1vDk2kFjkuLW0OHavqvKayLePYasTIq7xXiINhVDLM2
         dhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782838430; x=1783443230;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zrPBeTNRyLA3ooNpufO1eFc7tmIMjSyBAKOe+RAYTN8=;
        b=WcbN1sVhALtzJod5f3nCS564CFQX4O8Sgfb1wnrwHuXgmFxOgIiasCZ3RXeD81+k5+
         tN9ei1DoTDZcze2lUlt+8iCrbb6YMjQFDlD5bC1Hpxj3XGR1dEVG97ytF9yCFXvDDnjH
         5Hl3jD5u89cvLwSU+K93A3FidizzFn0g77tinKyNcfWNRKHTkCZ07lNfS+RjklNI9BhQ
         PtyqvNoO0/DH0XtzFb/Eo1VrULELdX5KHhg4K3cO6+YmjUi0lARm7CCTrMW0dgg1h2MN
         V3k/wvFmBH3GbtFPimPmzq4bXbdqe+T0EtyYUiZ6oKaJ1LSAIcjb5tN7yOSnZ8NzVeEF
         Gf/g==
X-Forwarded-Encrypted: i=1; AHgh+RqKPvwSbCZKicBNNPsBFUslMm5UTdHWM0tqP2BL8qTLNFj6NhsaFWP4S9LMza6Bt+cLwbkOMTwb/I8CvpZN4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxByt8gZRttvL9vbMeoc+AUM96Y9Sc8sBhDjtVg/c6Dprk79b71
	rXFOQ/tqe/BkcrFSqgpGW0Zp0An/0GjMC0yq/LEz9IkXgsXRqBLX24h+asY9VsUKmw==
X-Gm-Gg: AfdE7ckbSkhycofmXfPGPpIChnuxJXyRM45VFFDJBbRrgKBIZwcwpsEtwMB6yoOROe2
	zhPJ97rM5DwBd2wT06Tq9DvVNF9mfKCrb10sSlOOkCpGFlu8Nb4CrxnimiJkicgsMpA4soDSyar
	9UppOTj1ObBVrE57ExRCheuUroW8HKWZo+FxbXR+RKibZZDnGgbtPDmYhsCqMx7iwEd5wtUr7pN
	SILitj5NaiEUtdgol1EZ+h1ug4K8Ce9CDynZ9f+FGDM7+/UAL+i1Yo8hSyF+FSRb8pRpkbfNiV7
	M7yGZqxiChzusqToyd2VSnQ5UwVmkMpTxjkwKuYafx46nXhZV8siCSqTGhiJnZ8HSzYK0T0Ibx/
	pM0u5UYleBOyd4nZI/RmbZqe5iQj22o9iMq2SF8WcYW3JoqYOCZIa2ji1gF8TsI8njaPYEXaEkC
	TG4wLfxttjEgztPkRWfugzUz5pLrOknc5tzD46LzeqFY5jU74+G6gzUXqh+M3QvqZCWY+CXy5w5
	3pxyUVBW+ZRKdgleUCnf3V68CHHEJgV4Ag=
X-Received: by 2002:a17:902:fda5:b0:2c7:7c7d:fb8f with SMTP id d9443c01a7336-2ca5d8dbceemr738665ad.17.1782838429959;
        Tue, 30 Jun 2026 09:53:49 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbf95b8a4sm1910515a12.18.2026.06.30.09.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:53:49 -0700 (PDT)
Date: Tue, 30 Jun 2026 16:53:45 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless-next v2] wifi: cfg80211: fix regulatory.db async
 firmware request blocking __usermodehelper_disable()
Message-ID: <akP0mRFucE7p_P-S@google.com>
References: <20260629063159.3288957-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629063159.3288957-1-kavita.kavita@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38398-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kavita.kavita@oss.qualcomm.com,m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cmllamas@google.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmllamas@google.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 037056E6B0B

On Mon, Jun 29, 2026 at 12:01:59PM +0530, Kavita Kavita wrote:
> cfg80211 schedules an asynchronous request_firmware() work item for
> regulatory.db via request_firmware_work_func(). When the direct
> firmware load fails, _request_firmware() falls back to the sysfs
> fallback path via firmware_fallback_sysfs(), which blocks indefinitely
> in wait_for_completion_killable_timeout() waiting for userspace to
> supply the firmware through the sysfs interface.
> 
> While this work item is pending, any caller of
> __usermodehelper_disable() will deadlock attempting to acquire the
> usermodehelper rwsem for writing, since the sysfs firmware fallback
> path holds the rwsem for reading and is blocked waiting for userspace
> response that can never arrive while usermode helpers are being
> disabled.
> 
> Observed call traces where system suspend blocked due to regulatory.db
> async firmware request:
> 
>   kworker/6:3 (pid 194) holding usermodehelper rwsem read lock, blocked
>    waiting for userspace firmware response:
>      wait_for_completion_killable_timeout+0x48
>      firmware_fallback_sysfs+0x270
>      _request_firmware+0x790
>      request_firmware_work_func+0x44
>      process_one_work[jt]+0x59c
>      worker_thread+0x260
>      kthread+0x150
>      ret_from_fork+0x10
> 
>   Caller blocked in __usermodehelper_disable() during system suspend:
>      rwsem_down_write_slowpath+0x768
>      down_write+0x98
>      __usermodehelper_disable+0x3c
>      freeze_processes+0x18
>      pm_suspend+0x320
>      state_store+0x104
>      kernfs_fop_write_iter[jt]+0x168
>      vfs_write+0x270
>      ksys_write+0x78
> 
> Any service or kernel subsystem invoking __usermodehelper_disable() is
> susceptible to this hang as long as the regulatory.db sysfs fallback
> request remains outstanding.
> 
> Fix this by replacing the unconditional uevent-based load with a
> two-step approach. First, attempt a synchronous load via
> request_firmware_direct() at init time. This is fast and
> non-blocking, if the file is present in standard paths it is loaded
> immediately with no delay. If not found, the load is deferred to
> wiphy_regulatory_register() and triggered via
> firmware_request_nowait_nowarn() only when the first non-self-managed
> wiphy registers.
> 
> For self-managed drivers (REGULATORY_WIPHY_SELF_MANAGED), the hang is
> avoided because wiphy_regulatory_register() handles them separately
> and the deferred load path is never reached, so the file load is not
> attempted at all. For this case, regulatory information is obtained
> from driver/firmware during wiphy registration. For non-self-managed
> drivers, the file is required and is expected to be present. The
> deferred load via firmware_request_nowait_nowarn() is triggered only
> when the first such wiphy registers. This ensures the database is
> loaded only when it is actually needed, avoiding the sysfs fallback
> path on systems where the file is absent at init time.
> 
> Also refactor regdb_fw_cb() into two functions: regdb_load() which
> validates and stores the firmware image, and regdb_fw_cb_restore()
> which is the async callback that calls restore_regulatory_settings()
> to replay all pending regulatory requests (country hints from core,
> user, driver and country IE) that arrived while the database was not
> yet available.
> 
> NOTE:
> This issue was observed on Android platforms where regulatory.db is
> absent.
> Steps to reproduce on Android platforms:
>   1. Power off the device completely.
>   2. Connect the charger; the device enters off-mode charging.
>   3. While in off-mode charging, short press the power key.

Can you confirm that you see this with !FW_LOADER_USER_HELPER_FALLBACK?
IIUC, this is disabled in Android and shouldn't trigger this path?

> 
> Fixes: 007f6c5e6eb4 ("cfg80211: support loading regulatory database as firmware file")
> Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
> ---

