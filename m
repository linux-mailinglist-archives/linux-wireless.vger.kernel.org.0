Return-Path: <linux-wireless+bounces-38399-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2Gz7G6sDRGodnQoAu9opvQ
	(envelope-from <linux-wireless+bounces-38399-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 19:58:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D59086E70F1
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 19:58:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Q0Fq3EFR;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38399-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38399-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC24A303F46E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 17:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7661D283142;
	Tue, 30 Jun 2026 17:57:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AD73DE421
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 17:57:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782842279; cv=none; b=C5xtUwiSAowEkQSWqOj72EZDJRB9b3GGqUTYdsQMeBDty3XYvlAv6PTpuqre/WjVGor/beW/Tts8tL1uP3n9VNhmEupnwDophu2ebtHeNdVhxihitsWIwQVObrL4wWuipCbo/bxr+WYE6+VTVpRwr9KCKMKLQ9Lv9wt8QTaY11g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782842279; c=relaxed/simple;
	bh=dSAsghsr/XxZ3ePCwTBF4qzA7JyxOpb258CV44sQt7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWfNm909zJDlegVPCtVkoIbISvnnhxN9FEMgfvolOC95JXohf7wCapcRObAB8O4qzQAufkR9JmvvFgJ4J/HedMUFdjMprmQnM9E+bnxJaF+IeB8hRL3WX9Lhmi9EyGjisxL+UQ2t2eLd56auCELhrvRa2HJCHKMNmL4H7A3nUF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q0Fq3EFR; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ca597093c0so4045ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782842277; x=1783447077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VyIfVGnZ0sh2KLem1hKY83p8JWJMsEwhGQIrsLY+Gds=;
        b=Q0Fq3EFR67bYmTnLavb43a6ttb4h4esvo2D7+rvI7GRjnK6OBMzhq13ehzFy+200pC
         mn1ylKmIHu2Z875S94MeYpjvYD6ApuWzPIelbrb4vVy0cMJffEaH7RgvUsT9bSD6H4fU
         VR3X6CivVt/ZWsEO21dEvZC7lx2ZC5d8M4ky09SJanOOAwt0gUiw0AZfcGYJi1oKUvRf
         pBuw7wta7waLZzWgQ3E/2jRRJGsz4u0ldjKedTQ/iUTN6wAEpc+sjtQEaAvCSx33ClEP
         zAlI29tlJukYELoS9EU7hGBLeKyyF63ydNu55cwPOyuswDs3Oz+ZJR2+DAMCtApWTXAU
         1d/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782842277; x=1783447077;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VyIfVGnZ0sh2KLem1hKY83p8JWJMsEwhGQIrsLY+Gds=;
        b=T2f97Twd/LT+S2PMVtha5cb9UfUc5G6YB1shRf1b5xD2BowJRYov2fVcz9cPG9iPRw
         QQeA2KlTNv4siROkNe7uzvhQzSzlh/lM5C0pDtTnEVCZmAHm3n+YooJ+BGKDhEAT+vQA
         IzEBbR3CmBlFC+P5KYWDsiVRG7ncQnCfwful5+iD6ncEuxCIo+MnjA9O9UL2nuJg1/1f
         KZHIrjjGqEqRTJbR6NGWWayroCmXzKkpqCJhmlsJ247rIF6CJq7h20aRRQvJSCvUEhgV
         uguaiouDeJkx46O6N4Uv5CVp6VXQkDTiJrz1Gi7QAVL4KP2OhgP+qcd/idQ8hhy+lFmx
         HHOw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9EjZlY5Vjzu/sLKJNxcvMwCG/zL4uOuyaFYHRVe5DTMZTHa4kfjTy4dWD+kkjHsBvaXF52hbr3R/RtrVkwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxP/s5aHdO8LmTCy50ujidV3YQUhG0Jn5J+D48sAmIeszI5mTGZ
	x320RD2eup5pMiiQLhJzqCwhZ9XcTaA0zDn3WZ3Ln/jK49dO2DJjULbjHZ/Cuq3jXA==
X-Gm-Gg: AfdE7cl+Wm9yDamIvFdG0oT1CsN18XkUaY7RLx49MAyXR5BYMrJmgvGYFHNB4v2Z/x2
	5nWUNDdFdFo1NDZMP3qIMLYPSbRMXATtriweQEqW3qvpcvRcJwEa2WXQdk41dac0sm9r6o9xIT9
	z1FTkAzURmgo32pm2lZl8yEkbgtq7VVDd34zRLJr04u/3lRDMnLtHkgEQ//druN/SkGV7yvKYzs
	JryKuhxOuORutaDyyeGmqKyG7JoUrBtOqI8Bl6Za8VkGIRbBoxrR/UYviFAetz4TIZ7WFA6zlsu
	zDOhaJj9nwZ7kseTkpLWOmFpvV8OkphBnEs7FooNK08taE836HpNPwDvNEy2Y1SkOoALOc+Yhr5
	OTvS6aPkRmYGi5GyB1KNQvn1FKwaMMELrqEmGs+4mxs66W8+h6+zL4rwxXH2xqQxPZ5zz1RYMK0
	oFdkfw3lTd4R8x2Yg0hI35kevIQ2/PHHWSLKnnqhqRpCn1ElpUY/3i29LM34jCIW+fkN9rrKn7a
	62LmVOrU7k09NcgQmLdsDefjUDajiQQ2YY=
X-Received: by 2002:a17:902:d58d:b0:2ba:73c3:49b0 with SMTP id d9443c01a7336-2ca68a350ecmr264315ad.14.1782842276793;
        Tue, 30 Jun 2026 10:57:56 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382ac8c7sm18415415ad.61.2026.06.30.10.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 10:57:55 -0700 (PDT)
Date: Tue, 30 Jun 2026 17:57:51 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless-next v2] wifi: cfg80211: fix regulatory.db async
 firmware request blocking __usermodehelper_disable()
Message-ID: <akQDnwSpBb-yTuLA@google.com>
References: <20260629063159.3288957-1-kavita.kavita@oss.qualcomm.com>
 <akP0mRFucE7p_P-S@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akP0mRFucE7p_P-S@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38399-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kavita.kavita@oss.qualcomm.com,m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cmllamas@google.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D59086E70F1

On Tue, Jun 30, 2026 at 04:53:45PM +0000, Carlos Llamas wrote:
> On Mon, Jun 29, 2026 at 12:01:59PM +0530, Kavita Kavita wrote:
> > cfg80211 schedules an asynchronous request_firmware() work item for
> > regulatory.db via request_firmware_work_func(). When the direct
> > firmware load fails, _request_firmware() falls back to the sysfs
> > fallback path via firmware_fallback_sysfs(), which blocks indefinitely
> > in wait_for_completion_killable_timeout() waiting for userspace to
> > supply the firmware through the sysfs interface.
> > 
> > While this work item is pending, any caller of
> > __usermodehelper_disable() will deadlock attempting to acquire the
> > usermodehelper rwsem for writing, since the sysfs firmware fallback
> > path holds the rwsem for reading and is blocked waiting for userspace
> > response that can never arrive while usermode helpers are being
> > disabled.
> > 
> > Observed call traces where system suspend blocked due to regulatory.db
> > async firmware request:
> > 
> >   kworker/6:3 (pid 194) holding usermodehelper rwsem read lock, blocked
> >    waiting for userspace firmware response:
> >      wait_for_completion_killable_timeout+0x48
> >      firmware_fallback_sysfs+0x270
> >      _request_firmware+0x790
> >      request_firmware_work_func+0x44
> >      process_one_work[jt]+0x59c
> >      worker_thread+0x260
> >      kthread+0x150
> >      ret_from_fork+0x10
> > 
> >   Caller blocked in __usermodehelper_disable() during system suspend:
> >      rwsem_down_write_slowpath+0x768
> >      down_write+0x98
> >      __usermodehelper_disable+0x3c
> >      freeze_processes+0x18
> >      pm_suspend+0x320
> >      state_store+0x104
> >      kernfs_fop_write_iter[jt]+0x168
> >      vfs_write+0x270
> >      ksys_write+0x78
> > 
> > Any service or kernel subsystem invoking __usermodehelper_disable() is
> > susceptible to this hang as long as the regulatory.db sysfs fallback
> > request remains outstanding.
> > 
> > Fix this by replacing the unconditional uevent-based load with a
> > two-step approach. First, attempt a synchronous load via
> > request_firmware_direct() at init time. This is fast and
> > non-blocking, if the file is present in standard paths it is loaded
> > immediately with no delay. If not found, the load is deferred to
> > wiphy_regulatory_register() and triggered via
> > firmware_request_nowait_nowarn() only when the first non-self-managed
> > wiphy registers.
> > 
> > For self-managed drivers (REGULATORY_WIPHY_SELF_MANAGED), the hang is
> > avoided because wiphy_regulatory_register() handles them separately
> > and the deferred load path is never reached, so the file load is not
> > attempted at all. For this case, regulatory information is obtained
> > from driver/firmware during wiphy registration. For non-self-managed
> > drivers, the file is required and is expected to be present. The
> > deferred load via firmware_request_nowait_nowarn() is triggered only
> > when the first such wiphy registers. This ensures the database is
> > loaded only when it is actually needed, avoiding the sysfs fallback
> > path on systems where the file is absent at init time.
> > 
> > Also refactor regdb_fw_cb() into two functions: regdb_load() which
> > validates and stores the firmware image, and regdb_fw_cb_restore()
> > which is the async callback that calls restore_regulatory_settings()
> > to replay all pending regulatory requests (country hints from core,
> > user, driver and country IE) that arrived while the database was not
> > yet available.
> > 
> > NOTE:
> > This issue was observed on Android platforms where regulatory.db is
> > absent.
> > Steps to reproduce on Android platforms:
> >   1. Power off the device completely.
> >   2. Connect the charger; the device enters off-mode charging.
> >   3. While in off-mode charging, short press the power key.
> 
> Can you confirm that you see this with !FW_LOADER_USER_HELPER_FALLBACK?
> IIUC, this is disabled in Android and shouldn't trigger this path?

Also, you mentioned this happend while on "off-mode charging". So maybe
don't set force_sysfs_fallback and attempt to load cfg8011 module here?

Anyway, this is orthogonal to this patch. It seems that holding the lock
(read) with a long timeout (60sec?) _and_ trigger a suspend right after
will fall under this trap as you mentioned. It seems a fairly easy thing
to reproduce on vanilla distros I would think?

--
Carlos Llamas

