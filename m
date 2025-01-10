Return-Path: <linux-wireless+bounces-17303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76258A08B59
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 10:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73AA3A9D44
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 09:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7555920E03A;
	Fri, 10 Jan 2025 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="R7yGsjr9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AAE20E00D
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500545; cv=none; b=AxAgAE/+PsmdZZujEi1rST865+D+sXKrrZWOHZ8ep110rlKUlGIh9G4DjqZbR4edrdF9X3YoCDwZ+bXC0SYfdKRtYe6a4My6CgBDmmZgb09TzeepqyI1/h89TB6vj4lrIEjVRbO+Mt2UyWlw+OuNqiKIGvKHlLe0+9/YzofyVT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500545; c=relaxed/simple;
	bh=nFFbQw9YFezoVgcxEUh/c9d3CD7uMMYh+b5QPqn1K38=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i1asaMT6nhjYlVBtnsxd5j2RHIVod3BP9ZCJSfma0ysXFzunYMWqx4gs3BehjTJaFuWJsUbljDzbuI12bJZNldt5M5v3uc+OCUrTA733Rq6hUytDaaLoGFMJo/jkT93WTrn1RfiYlB8zrLth/sGPy3oSZOJ5OosdbjMEJF9YVlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=R7yGsjr9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NawsiF4t7zkYxNzdBVZyId0hD6HeNHrt3+QKNCiBxCM=;
	t=1736500543; x=1737710143; b=R7yGsjr96MpBtLlK+mnya2H7kREcvUXQ6zPzXPfFKH7B2eP
	ZhVDHSyEsBG+G3UvEmqtTpuKChk87rEpKpcon1YTmrkuor0FPe6BxbToq1VAb7TfPITlvr2zM0BvK
	/APJXF+vl5Bq9+tNN54Rtr39sH5sQd+m5dswAoHbx45jXNW7cLp0JfG9BRyyfnZWIznY/9glGGNh5
	rjx/qv7Kp2zhRCajFxbywjTwMvp0QwMxQwmveAL3t+oB2TK4ZL1wDoDg96R99YgJP8RQ6SQVaBt9f
	Yu9o6el0Q7S2uaxhUB7brQpUl0r2PCFmUBSC0Db4bBbLLNIZbl0SG8o47sn2b+mw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tWB7E-0000000ASSX-0pE6;
	Fri, 10 Jan 2025 10:15:40 +0100
Message-ID: <5e7eb3236768d8e3fe4eee984fc799070aabd30a.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 1/7] wifi: cfg80211: reorg sinfo structure elements
 for mesh
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 10 Jan 2025 10:15:39 +0100
In-Reply-To: <20250110042449.1158789-2-quic_sarishar@quicinc.com>
References: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
	 <20250110042449.1158789-2-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned


>  include/net/cfg80211.h  | 43 ++++++++++++++-------------
>  net/mac80211/sta_info.c | 64 ++++++++++++++++++++++-------------------
>  net/wireless/nl80211.c  | 11 +++----

That should be two or three patches, I suppose.

johannes

