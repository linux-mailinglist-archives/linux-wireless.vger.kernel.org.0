Return-Path: <linux-wireless+bounces-29712-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D833BCB8CC6
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 13:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B91DB308AE00
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 12:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5C33164DB;
	Fri, 12 Dec 2025 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="P2knXlnd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746332DF15B
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 12:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765542335; cv=none; b=gZgmPZN43JnTEWj3SaQ6BzQZEyIlIClASPXEM8ONOF6rLKi6Cm1YUlWfg3ZmutstVFwOqv1B+t1Pz4IUM7dP+NDmxU0lnBoLFa/8Es8Tf7lEFtpUPes7dx2acXEmOjshARGDdLKZcWT8XvUc3Unx0gcZSipam6kohJSpUIeF1G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765542335; c=relaxed/simple;
	bh=wufsSztnwZ+z1Pmhgc/JX7Hv34rNInIx+Hmj8k7o204=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sjtSMg7v5FIvY6lOaO/jnV5JCpBbWxwN3nrFmLD1hvByK+oOG9VZ7zRWUETI7wY4mDsBRyZ8annMRYOj8an1GzI8wGcuaF6k9FwRqdzRo+cu8j7XkXs1ZvGmIHokmk3leyqHtAWZZDZa54Qv3Fa8YW0WoReQcbTNV5ldF8RVsIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=P2knXlnd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wufsSztnwZ+z1Pmhgc/JX7Hv34rNInIx+Hmj8k7o204=;
	t=1765542333; x=1766751933; b=P2knXlndAVrPVumJz+izNA0RlbGUBCvFGzOHeOKFnuxUDUS
	7Lfo2ynEqwKS/MzAbA7oRePHJ5LlWSx2lR7wqcSh7aiS2sjfjPKGeruaxz/Kzy4CrGceiXyctu5MI
	n/gTtfNUa+Rn0gCEQwD/D8zRkMo8j5NfIG9taavYL9tNUsmsFGbWmX6rGCZ/IhJHPuqHgx1a0RIAU
	iFxtd3v41stKBzoOtzlmx928d/f7SpJp9Une1MIcqAi8vOD14sxZ8j00V/nG1qvcRpv1wdaHZY1zk
	EDcsYE9ch6H1pGDhyx5WAxjlE7S2vA7yaSt3hePMTmsSp6FMD3gf6EIJY3Rlfpag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vU2D6-00000003Saj-289w;
	Fri, 12 Dec 2025 13:25:24 +0100
Message-ID: <25c5f36465a587e053d8041a65683b3179cfb55e.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 02/14] wifi: cfg80211: add support for
 EPPKE Authentication Protocol
From: Johannes Berg <johannes@sipsolutions.net>
To: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com, 
	sai.magam@oss.qualcomm.com, quic_drohan@quicinc.com
Date: Fri, 12 Dec 2025 13:25:23 +0100
In-Reply-To: <20251211124051.3094878-3-kavita.kavita@oss.qualcomm.com>
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
	 <20251211124051.3094878-3-kavita.kavita@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-12-11 at 18:10 +0530, Kavita Kavita wrote:
> Add support to validate the EPPKE base AKM suite in RSNE and reject
> EPPKE Authentication frames if the base AKM suite is not present.

I'm not convinced we need all this complexity, plenty ways for userspace
to shoot itself in the foot anyway.


> +/**
> + * struct rsne - RSN element (RSNE)
> [...]
> + * Represents the RSN element defined in "IEEE Std 802.11-2020, 9.4.2.24=
"
> + * so that cfg80211/mac80211 can parse and access its fields.

This is totally misleading and I initially thought you were getting this
completely messed up, but I guess with the comment above we don't need
it.

But the struct right no isn't "so that ... can parse" but rather
"populated by the parser function" or something.

johannes

