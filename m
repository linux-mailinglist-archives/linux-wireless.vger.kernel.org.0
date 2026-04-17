Return-Path: <linux-wireless+bounces-34913-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BhMIOV74WlDtwAAu9opvQ
	(envelope-from <linux-wireless+bounces-34913-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 02:16:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC21A415CAA
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 02:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FE0D303EE95
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 00:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506D79463;
	Fri, 17 Apr 2026 00:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QMU+xTHD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068F763CB
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 00:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776384981; cv=none; b=PAZ3Ex6X3b3VdUEPnId4ANG9upndH3szLEmBCkVPScV7lnadFzLPbWyLkqNIfg41AXgxQWvt1PKjd7yOZ8tNyaSCrszuclDms1gJSh86LFDuXS/+kBIfmAu6DPfRdInAjhvHlsndjfDYQgzdzG1upPqwKldG7OdnPRxP8KIuycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776384981; c=relaxed/simple;
	bh=fhZ7ivcIhbQqdlLL/5UudWze43SbzqePQ1SVbUPEUwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPRa54EAJobie9ul1GAGkpYI4aAqyOQVtBRyFUta58Ipr1HSJLnFjfVSsGzcZIfm3OMmn8d2E9u92LWw+WLa6OzOe3gprT7InbiAZIA6u4UevIN/BQygy0+aajfxCqMwjOAjATg9X9CXUevGiK9sA7Y5gzeGtVv8u5vBB/JxdgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QMU+xTHD; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c55e3858cso342150c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 17:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776384979; x=1776989779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1TWtEQzY5BC/s4xEANMMXADMCvmVpd07XkDBvJp6pOY=;
        b=QMU+xTHD0kpGCygDnF6IUI8oyGlbfN74dsnMsah/yFNxnQERLmTZqw1wXb0yuVsxIG
         cxAby7eBGtzyGRARxZ/0hdsdWggpO/5J4gFl904LEfQ2ZuD7naChwRSjpLMPhvAYBfqV
         JL6ssOUaZx6kPgSNxNlDS4gyWge1oj29b/Pag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776384979; x=1776989779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TWtEQzY5BC/s4xEANMMXADMCvmVpd07XkDBvJp6pOY=;
        b=koe7tEa4xxIpw800eBZjNMkTrxaA9JxMP5invyTQVcnRetyE4XG5PrP7utW9Zl9+hj
         hIgH5iyiuJrbWZ9Ep3lGvR/RB9ZaRFZ7xQGqe43XNl2n44Vv1cEmmCjhsheVGSFCMdGx
         M8FFulTnrrXtM4naPGXIajzNEqJrFAI2vmeXItRrqZQoWQRUt62+8ECZySStXW2R8/3T
         iAA2E1ItdgDxtk5QM4eza2CeKXkEbFc0mMY3A35s/w3UENGMTfKXc1Axhit/261kOiQk
         fODARIVy7ZXdcFdwokM9tldGWLJ9aJ9tRZgvRC0WxUD9gPcPRVPPQAjOLkIBpGwPFzNr
         PzWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+rxZ3/wJ5Ahtu1+4xsVzHV/rvaV3Vy4gl3P5lxdV+eutWhWslQ3HE9/K1R4x2lFZo+vlIdO9mJgtU1vJbzoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEoQN7M5vTeRNJ4keDPYmPTXw7gSjhWQfElNXm9beyGXdUfwWg
	5KXNkQ4v7N8Yq5kbknKfB2aD1rsnoQbn/dayIuV/jtblOSZ61YEGG/fvGE8BxSYM3w==
X-Gm-Gg: AeBDiessg0rHqRVY4JWgNjd+QHyKIB9OtOEcfnLYEg+KF9ngO/R5OIbW0rqnxbYCvjq
	Vvu3ODWlZhZKtdSuqidcDJmZ8Lt+m6SXUSU5VLhG2RHN6CwMaIJtSuW8UKFrLe6+3YpgXhLY0Jv
	w1ZzVWFmHtYdtcofMHVBWZdHr5GtGF2i6/GG4nHzuUTfNsdLgF5hGST8HWKqYrfyvnTk+H1cbti
	Js5aFB2hzc9A8ae1TRmM3ZXwJzOQKsWYOtjbadFejGDdXSPOBlw7fOM4qYfQCHGbl8eavAHB/XR
	FrawIxcCcfuQqgsrF8G5DxwI/lNtmq6rOpknY7RZjVTqZM216F0EIKXGEo1zD2je4mEGem+6J6w
	jaVULHtvmKFpO8PgVctgk51zUEDh9MjVhOUMH8qfCvC+rwyWf95K3U0UrbDPm0kiPA+uD4TnR6j
	o7pOCjaXGtBzqRQaVK4ptoyhSca/gupamTLLNdHu4rW6wgmCYZRGWCRgERc6/OuFPXE53NgQ==
X-Received: by 2002:a05:7022:ea2c:b0:128:dbbf:fd35 with SMTP id a92af1059eb24-12c73fa3c01mr261286c88.28.1776384979103;
        Thu, 16 Apr 2026 17:16:19 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:804:58f7:217:62b3])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-12c7491d921sm9233c88.9.2026.04.16.17.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 17:16:18 -0700 (PDT)
Date: Thu, 16 Apr 2026 17:16:16 -0700
From: Brian Norris <briannorris@chromium.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] wifi: mwifiex: fix OOB reads and writes from
 firmware response fields
Message-ID: <aeF70EJja3dbTyVw@google.com>
References: <20260415222327.1539269-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415222327.1539269-1-tristmd@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34913-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[briannorris@chromium.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[chromium.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chromium.org:dkim]
X-Rspamd-Queue-Id: EC21A415CAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 10:23:21PM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> Hi Brian,
> 
> Note: this is a v2 resubmission. The original was sent via Gmail which
> caused HTML rendering issues. This version uses git send-email for
> proper plain-text formatting.

You also sent it privately / directly to me, and I don't think you even
sent the whole thing. You've fixed some of that now, thanks.

> Six issues in mwifiex where firmware-controlled fields are used as array
> indices or loop bounds without validation. Two are OOB writes, four are
> OOB reads:
> 
> Proposed fixes in the following patches.

Several of these don't actually apply to wireless/for-next correctly, so
I can't actually review them. On at least one, I think you seem to have
stripped a line or two somehow.

Please confirm you can apply your series to
git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git
for-next with 'git am', and then resend.

Brian

