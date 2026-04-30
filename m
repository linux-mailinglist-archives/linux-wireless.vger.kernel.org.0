Return-Path: <linux-wireless+bounces-35682-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG0RMh3s8mltvgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35682-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:43:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE3349DA94
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE14130086CB
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 05:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A864136672;
	Thu, 30 Apr 2026 05:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="pGLDcTNF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010B129CE1
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 05:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777527835; cv=none; b=WhZrqnyaY8pbNlPAH1i2ydOYNHK4OxmWKr3ustWps9CCrXUgwuHSzjYi5Ms6MiiE261I91z0A94E4oFJhdu1nvrkJRL1qgBrKai2goZxjMdtmck0zVQq1RHNf3yfgcEw2OeDPHVS6YoAoRBoxLrLqcHVIIWBI0NI4oIM2VAYpao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777527835; c=relaxed/simple;
	bh=ls2d8XiDX85v1JPo2n/1AGd3CFLRz+ejbutehgOP44k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4Jrn50esc2kZBEmNEKkVYMzKugcTfGkVBLiT3KSbGlqzJXdZJl4wljPnGPGSssywFspti39k+oU1UFSdcS7IPYxspicreF9iHaQPrwP/HJypO4KvTO71jujBBRFO5B9k6QsAYexwVI/vsIBaKbloXod58k6u6cJdq8kw8g6KvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=pGLDcTNF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ad617d5b80so3200355ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 22:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1777527833; x=1778132633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ls2d8XiDX85v1JPo2n/1AGd3CFLRz+ejbutehgOP44k=;
        b=pGLDcTNFeyQgo4y57hjrn/aZCTgSIqc0MhTInWrdq3qWibEAMk6wYJjXz2wK5B/Uem
         6hMSRs8tWgXt7Kn6AtXFVbibdzRPmjilXb70T6zEJv5eV+jGMIN+nMxKbYfmGbDU0NX4
         C5r/KOtmIXaRlDot3vzTMBEKmecZgDupaXoJ5UmUmgrSm+Di2Df9LFI5w6VWH2zOdhcW
         2x1oImTsyNT1aeYlPG1pEy8GKf9xccpqHJ1WlNE/ivbPCQB8tcMb1oHr5LDrQKtK+rtE
         KELzNCi7DHY0w6X6JrwdE+ETds7RCAr7wN31qJmCC8wcXJynaDSPYsRDTcv4ZCywRlqJ
         s1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777527833; x=1778132633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ls2d8XiDX85v1JPo2n/1AGd3CFLRz+ejbutehgOP44k=;
        b=KBU0SqLcCK8yX9DnsGn/5Ax6BkjeXLzGPe0IXfK8pIv1LheI9RlhPBjnjHOoniN4ao
         JGBdwbITAM2eobcrXMojOvwVQ73wezXja4JQxDIHhTuzJEkq2FzOUWClH9KPJCjxNORj
         Z0qtvlwEcxgUVQy4KCsb0W4mf0aPE7xNK7Pk+F1Yw9djVbETPXx8YkYHuxI6avezNW8e
         0W2p/bJfSwCGAuKcUTZKxsLo0CTSczuziaerNU2SZgQt3YKiFfKhtGymgEzddg2RPkYm
         7SEaBwvmAGAdCpCEdx/46+M8hVxZM9UuRSgAL7e3EzGMLhyzcKQ00tdxeU1f6akwf/4S
         LhXA==
X-Forwarded-Encrypted: i=1; AFNElJ+8sLFUG57X5KXB4S47w9ewvROJ7uZ2pKlTDFolTraGUm0aXTr5IKI+q9vad7vJOb1sekYW5cibsLbWqRrFTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzho0SSvoYr51xC2n3xxDAO5zDgUFvvxXvGPxgWeFlQYEvnTVzE
	PSGzzMU1dgjjjhFPXcn9hmi9N7i1X0K+Q+D6UffLRNF2i2SJyU0WkeJBhIKpuOwQpyA=
X-Gm-Gg: AeBDiev5DeMf3vShZeldtGz0d6ABcqJYZkNAGiWaKFLWUdqoEi0//Rf4FqV1OVN0m3x
	y6akMBWX+R3MKYcxEV/OARJS9d97RjqlvuvYoNM2twY1FAoV0j7gjxoCp+SCOPxeq7LtdSzNtDu
	5O0phQCVXaqTeaF7FC+JgYXbIWRjxK/JdcUB7l0f+4TWgZStjzWlW/FCznn7CLjFcNe9n1nm240
	rbnAqKfBWzLGl4oATN9UBNLIJabmNXzVlCzAMv8mIjl78w6h2NcblXuXpGRftmhQJSJka+PWDYm
	8AYwYk844a6jYdh8l5l3NKUiFO8wCt2TBYU10CtpEkJ/d3ut787OBQ+RXAM2mDBSfIfSiu2wEp+
	vEvSXBg94lmebDIVmj8WqNF2aY+1yzezTCp3tyQL4YnvRMkkJ+GKRi38j2f/qrP2L6TEMnny19+
	kSg/ebv5Ry4vkWqATrLACb8+h3AjJYeHjX7QULMjupZveq3etusCi+zBd99KoVwbMWiCbF9Uupt
	LTS+t8o6bV8kGQmNVfy6VqcqFDj0wRPQEak6Uck0LW5
X-Received: by 2002:a17:902:b208:b0:2b0:5ec1:97c1 with SMTP id d9443c01a7336-2b9a231a62bmr10061415ad.7.1777527833111;
        Wed, 29 Apr 2026 22:43:53 -0700 (PDT)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98859f629sm40665495ad.0.2026.04.29.22.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 22:43:52 -0700 (PDT)
Date: Thu, 30 Apr 2026 15:43:48 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: arien.judge@morsemicro.com, dan.callaghan@morsemicro.com, 
	ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless-next v2 00/31] wifi: mm81x: add mm81x driver
Message-ID: <ggbwslzjowets5nq76nkws74hekllwpza4jie4m65edjk22l4s@rv7cbk6vlrgw>
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
X-Rspamd-Queue-Id: 2CE3349DA94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35682-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro-com.20251104.gappssmtp.com:dkim]

Johannes, this version was auto delegated to my patchwork due to the
new rules, but since this is still under review I have delegated them
back to you (I hope I've done that right :))

lachlan

