Return-Path: <linux-wireless+bounces-15862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 231E29E2AC5
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 19:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50CA5B372CE
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 15:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C736C1F7550;
	Tue,  3 Dec 2024 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OGKq0dUt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228CE1F75A4;
	Tue,  3 Dec 2024 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239523; cv=none; b=T0909a2FXQuB9uDjh4whCtREWhSFvwjomZgLjBS0MYHTuo0jPSY0aucgSm0uHBDWGdN7OpN16LdYMPLcReeiWOVuB2HnQTGhdS/nnboF7MFBVoDdTgKRWDbgaF4qmcLdE7pEMb1P+4KB7UGlmvsUpf75P8irgNeMRJXOVJC/Oeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239523; c=relaxed/simple;
	bh=fWNeeQROkHmrEG9lJBRTC9Irz8hGQ5YkTUuprEV0bQU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HqTwOvugLuvpe/IBTaoG28bci9ENAhOkanuU9MrAPN/okSc0KrzNQTm07KuqyG6UqwLMBaXIF8CSRizxHZwTMJF4cu2klIJoKnX05oxFENKWES9ORr+h5AkRrxp0jnzBu3gNb8xZX6kV+vgtLNl+IZen7jZe2wbBs+NIJv8pZlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OGKq0dUt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fWNeeQROkHmrEG9lJBRTC9Irz8hGQ5YkTUuprEV0bQU=;
	t=1733239522; x=1734449122; b=OGKq0dUtz3vEtUCR7unmYV0E9Yr6SPOyc/+p4U/gf9j5Hz1
	HC8Z4F3AGMs94RKEjmBJMa2rrHY66UT6ciFpnB10oa+c8An8tYFhSjRxsyTqoOA9IWNNPl/Ynv/na
	4bNoeSB363ndezRVfj3otDFVUJJtRZP0M0QNCfRwTagRdBi88BHTcm3HM5ScpsmkCrnRSnwOQcYBR
	RDoqrQ6MC6FJjGPlP6SIaN4O/tYsdomouWxDK8jIQNyJd03BeDoMwfnozYighQB3MZEbOevxCRCP8
	dyYo4KYVZu4N3tgXtr0y+1UpZiZdObpLkPu4HZc9R8ehFC1lUQE5MbiVVRl+h7Ww==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tIUm6-00000002qIH-2vrF;
	Tue, 03 Dec 2024 16:25:18 +0100
Message-ID: <fa9ef37903db0f81654451104b1407f60f85ce5d.camel@sipsolutions.net>
Subject: Re: [PATCH] net: wireless: sme: Initialize n_channels before
 accessing channels in cfg80211_conn_scan
From: Johannes Berg <johannes@sipsolutions.net>
To: Haoyu Li <lihaoyu499@gmail.com>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A . R . Silva"
 <gustavoars@kernel.org>,  Jeff Johnson <quic_jjohnson@quicinc.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 03 Dec 2024 16:25:17 +0100
In-Reply-To: <20241203152049.348806-1-lihaoyu499@gmail.com>
References: <20241203152049.348806-1-lihaoyu499@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-12-03 at 23:20 +0800, Haoyu Li wrote:
> With the new __counted_by annocation in cfg80211_scan_request struct,
> the "n_channels" struct member must be set before accessing the
> "channels" array. Failing to do so will trigger a runtime warning
> when enabling CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.
>=20
> Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct cfg80211_scan_reque=
st with __counted_by")
>=20
> Signed-off-by: Haoyu Li <lihaoyu499@gmail.com>

nit: there should be no newline between these

My tolerance for this is going WAY down, it seems it's all just busy-
work, and then everyone complains and I need to handle "urgent fixes"
because of it etc.

I'm having severe second thoughts about ever having accepted the
__counted_by annotations, I think we should just revert it. Experiment
failed, we found ... that the code is fine but constantly needs changes
to make the checkers happy.

johannes

