Return-Path: <linux-wireless+bounces-38188-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kwOSCYiSPmr/IAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38188-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 16:54:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C9A6CE29D
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 16:53:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=makB+MTz;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38188-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38188-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B758F309BECB
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 14:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B572F7F11;
	Fri, 26 Jun 2026 14:46:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C33288C3D
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 14:46:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485187; cv=none; b=bHt7hzqj6aIbV52Mz1uAEfdJHroNHpEyRdfD8T+U9rIYpeW3Me0fy+7PjMsVhEHyWsy7RL0QVkDxaBzZDvE31TDVdAiNO5V5AdXpqyF1zNwzYRpU28z4SmvmD6WLEI6TeV78BtDt8Ksazx+8ipCv5Va1iFp4LKJrH9srbWulz64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485187; c=relaxed/simple;
	bh=ZIeMT+n0RkOB8oaaTu4E9qXgJfSz++ky/BGId1Sa5PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbktB1xdI7P6YpUDtaycqeQKCDypMms7MQoOZShoqWyj35IR++K3rua1OtcrfW+5q9LjsRI7TMX/WhtSOwAePr6ZOnS0om6rDuVzTDtIGLgI3fPjkoBV+rk/tfmPSIW2kKZ4U6XJdHZ43RGHCdydBgrNt58bTN12jyLpdKXzXGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=makB+MTz; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c6b7bd4e8dso60095ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 07:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782485186; x=1783089986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8xMobHXgYc/DTjg9J1LZqrk8OVUxnJ4l6jelhtWEYy8=;
        b=makB+MTzZrrY485DUbOvro8muvLKVzBXyKjbgpihZCw37OmH+PKx5yIBAJaY4hHePN
         G7hGJquEuQuQ6NGb58SeURYZQYVyFL3WVGxx3w4liyjys6Ria35YlFfMOgVwDyeBJtw+
         8TNoEhtvs2NSGO+3bNTdaLD1/FYjBWi924LL+DPSvkJFS3B8nBCll4S2Yx95cLOw/cHn
         ypPwh5/aFwxV10yMhRASDKYNYcfG4W+Nc4FGZze92W4AHoDmXSl4h/hThSjzzbPqNV8F
         2mz1D3GeRSdmCJ/bGVPWvVPPonLWKQVCRHu20w/JO+5MgD2MAdXkdmj/o9CB0N9VzBql
         50UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782485186; x=1783089986;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8xMobHXgYc/DTjg9J1LZqrk8OVUxnJ4l6jelhtWEYy8=;
        b=rr0ysh3oruuonLlSpA9a/YrR2drqOMofuH+CzVDqUdXm3RtA8scrH3euxps/AnusMC
         iOYdZTPGNgkVbZWig8Eq05BN7cpZ/tCSOttxgG05z07l0rrSNTDE6qhYnQZyu0jtdVjT
         0geAljSdDySMiSgfa1l1Z6kVa6bOLRpvogfrA1zIP0Q9VVeRgnDg5mCX25Kmy/6aWcp1
         zS/Wo1bQUmaXQZxWk5qSgsUqeYQ0qQJzH02trPPRuHmgMQIVTmLp+ZsKKyWVie533oyK
         4I1cTT2S8iU1l+BjkWtCvdfpQ/IhhMn4P4E4wSuMuX3V6BqL5jpnfRrLNnxmTqf25yuf
         6oYw==
X-Forwarded-Encrypted: i=1; AHgh+RpqCd5/aPjC0+ChbkreSRw5lZj3I4h1Gwk5gcH0yoXvVdOkRR3Jx6dU0n0cN8ipLx0iLandRysaQ+vraFM7gQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7gF4KJKSn8P5v34VZchqJ+nAuincn45+G/drCTuPTP7rW2LwH
	B9EsjONEH0lbDQhpnM7FuXz0RNDsoO6BcaFc1S2vjfO3jd5kFTRwV2BKAmG6DZYhCV8UwrWKK6V
	tUyfo/JB/
X-Gm-Gg: AfdE7cnO5VGoAQCG3ijoU5bDFOvdx72zyuEoIie9x2XefQlWjdskSD84RE36IlBebVx
	hARuk+MuCQbrSHVWug8PtFDjz1X3JBvSS6ObzpSM8SycdBEJzLtX7xRSCeKem6V+pLmM93jSZq5
	XLbbgBw0SbUpf5e41msdAVm9tKYXTvH6shS89NyRfT6Vbnq4i2UZcZHKpDhIq4kPKuYE3n+T7XR
	vupFingKXMk6BqLp78NLCBJcD6K9jJUbeLrsnbvMDS0Kl9hZeH0Mikk4WeTwKoHXLcKflyowvTl
	3h2FLOQjLe3lSo7w7m7Z/IrE0QdsIU2KX7MltbGOccAKHzs9vskPOSXGG9eDWD3MYTQN8bYrHvI
	kBbOxZb25AGJMbNo9tJBZ7ISFfoKs6TL/fayWvv6KK+UY7pbMBuF13rkm8DhreDqxD9E6bbZf8O
	3ATmOWV9rfJ3lf1vp+1os6LhymLvJCC0Jo35NRhWbMfMIrSMepawaHSkZDEA9Lo7ujNCw2VqiMs
	LOlqKJoCv96ihvt39j3hvLQMuvqFZAnJvw=
X-Received: by 2002:a17:902:f543:b0:2bd:7e8e:ad56 with SMTP id d9443c01a7336-2c9854aa915mr266945ad.6.1782485185053;
        Fri, 26 Jun 2026 07:46:25 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a41474cfsm6675222b3a.61.2026.06.26.07.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 07:46:24 -0700 (PDT)
Date: Fri, 26 Jun 2026 14:46:20 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless-next] wifi: cfg80211: fix regulatory.db async
 firmware request blocking __usermodehelper_disable()
Message-ID: <aj6QvBdf3hGzDQig@google.com>
References: <20260625092904.2097371-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625092904.2097371-1-kavita.kavita@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38188-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kavita.kavita@oss.qualcomm.com,m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cmllamas@google.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8C9A6CE29D

On Thu, Jun 25, 2026 at 02:59:04PM +0530, Kavita Kavita wrote:
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
> 
> Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>

Are you missing a `Fixes:` tag for this?


