Return-Path: <linux-wireless+bounces-13424-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A082698D3D9
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 14:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2DE41C20D8E
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 12:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C771D0156;
	Wed,  2 Oct 2024 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="d0hqK4RU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAF71D017A
	for <linux-wireless@vger.kernel.org>; Wed,  2 Oct 2024 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873905; cv=none; b=U9oJDoQGJChsPmPNvtn3N8b+vhLazKi4/79XKCg4iTEZXd61Szy0sLCQdsp515tjDkvAPeFM/1ZpjJwnwhNJO1pqhmHAL2Fm+fs+HP/9HqHuZbf80g8kmPAl+RFSEDTOYgv/GcrtgUHQibOYx0qANQ/Z7EA5gNOPcq89nlePOE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873905; c=relaxed/simple;
	bh=5HPAm88LQ1dEGusWY39tu+Gcgz4wn3tKXxI+Yw7MTng=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XWTZ/papCXoDoUE/yxFJJ+LWe7dAij/r8bxUHKoRtbHaQIi0V9cyuvo1PBQ9t1ttZwssts0zxEJgZMcK7KiTJGsFICELv+/zjD5YbuJRaubZ0c1ww6BkUnNNO7Cu1CjKJYyv/nmOtjl3NtdoPfcCmGa3fXGahMnSeu5FBOYWo6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=d0hqK4RU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5HPAm88LQ1dEGusWY39tu+Gcgz4wn3tKXxI+Yw7MTng=;
	t=1727873903; x=1729083503; b=d0hqK4RUeFrmIjTSYJ91Z5PuvAG3BfP5duEFv3jbEHk2D9z
	Sx+lc/q6F9owJVtvsgkMv1hX9d+vYAhTqBZA8LiT30/cVzExd+vptjIQNRuQQ/VyMSi8jDvuPfFVi
	hU/JZsh8pKBDEJNgmrSMTabPp4wqd4pyRwmWLCnsXryrKR+G5MD5xpA58gTeZTShAQ02Ryvf6GQdp
	4d8eQW2kv+HG2oeM52WO2saojhpLKRHtLQaNYmzcABFqeAY4V7URjYpQ4OJSw1+E6zzOqitEbwLmd
	VrF+YiYCzJkN5FL75ipvnmdyZs+u3g7CL7Z2EHfWp4R/z8J/pTn0pdYYGEVqpo6A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1svyvs-0000000FdiR-435G;
	Wed, 02 Oct 2024 14:58:21 +0200
Message-ID: <8e92b7b0252d5e02799d175518a898c015885e15.camel@sipsolutions.net>
Subject: Re: [PATCH 03/11] wifi: mac80211: use vif radio mask to limit
 chanctx and remain-on-channel
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date: Wed, 02 Oct 2024 14:58:20 +0200
In-Reply-To: <264dd8d0e80aa8edb3530b6f81b34dd1655a0f12.1727869380.git-series.nbd@nbd.name>
References: 
	<cover.cb088351ab8df44310eee259bf2dbec858702463.1727869380.git-series.nbd@nbd.name>
	 <264dd8d0e80aa8edb3530b6f81b34dd1655a0f12.1727869380.git-series.nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-10-02 at 13:45 +0200, Felix Fietkau wrote:
> Reject frequencies not supported by any radio that the vif is allowed to =
use.
>=20

Not sure how this does anything for remain-on-channel?

But arguably remain-on-channel also should/can be in cfg80211?

johannes

