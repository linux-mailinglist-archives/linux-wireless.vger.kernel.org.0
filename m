Return-Path: <linux-wireless+bounces-23008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F091AB8519
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 13:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F24D3AB65A
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 11:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FAD28DEE6;
	Thu, 15 May 2025 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vdiKIrzR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E45819
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 11:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309306; cv=none; b=ecgFfrNoW8v3La3h+e02ZuPFWUHgg9F2e6sap86gan+3LrA/1dbQAXT/oKXLdQvGU7FdKEzM7zU2g7ECyBujkamDczgz76UJXbfAPy8QROpipVmSnq3DB4z6G/rkfUSDbawMDewB+c3dg4OsUNNK94PqqvJYlSjyeA+kvqrt29k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309306; c=relaxed/simple;
	bh=sqvWoLPdzNHrCcLK4dRKKT15qkLwxgPvfpuxAfDy4zY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VSp0IJAhPwf/Ggfzk+GqeGkBBzU54+vXQ549yewLpvUNubBlmaYtTY76U3Atj9eho4L9a7Kk2PuskvbOfFoCwsXW+27S4jAZfbphhOSl4Zjv7WuVD/0IueLWqjR4FQe+ih+7YsNaRttiOHOGZNtaiQ9EyNgaSEZHm2HHjW5eITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vdiKIrzR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QB51XqoE4ehEy1x+9PM3cHvyqUflWIwzsPcLQchH1a8=;
	t=1747309304; x=1748518904; b=vdiKIrzRUnAuO8inRZ6B+o7pkkwoC0YUE8HDwDDxAPwVPvp
	RHLXLHu9wcj/ShTYHXAD1o84wu+TJFVEUlmLScOgKzPHv6rgNKVafdBPuZqirqTn9IerrVDecjXvk
	qZHp4D3MhON013Ui4Exx8L1IHNMXvwEcd9Kb7hnbONZprUtVl6K7K32JrSlLvuIyPjHJptWmjMSrc
	jQrv3qWKVn2mb1eU88IjCn1M+SY+ijpXZtw85iy9OE+8jDqMANPHSwFBDO/D/6zSDuYnfEXNhEbFH
	3gJCJw88K1ZMzOsZyqD2ouLQxyeG6G09LDo62vAIsBdRAP5BAgQZgD5A+LeAk8Fg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFWy0-0000000B8MJ-3DrR;
	Thu, 15 May 2025 13:41:37 +0200
Message-ID: <7930179174c97d598a40b789abc43cb36c947dde.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 06/10] wifi: mac80211: add support to
 accumulate removed link statistics
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 15 May 2025 13:41:36 +0200
In-Reply-To: <20250515054904.1214096-7-quic_sarishar@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
	 <20250515054904.1214096-7-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Also,

On Thu, 2025-05-15 at 11:19 +0530, Sarika Sharma wrote:
>=20
> +static void sta_accumulate_removed_link_stats(struct sta_info *sta, int =
link_id)
> +{
> +	struct link_sta_info *link_sta =3D wiphy_dereference(sta->local->hw.wip=
hy,
> +							   sta->link[link_id]);
> +	int ac;
> +
> +	for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++) {
> +		sta->rem_link_stats.tx_packets +=3D
> +			link_sta->tx_stats.packets[ac];
> +		sta->rem_link_stats.tx_bytes +=3D link_sta->tx_stats.bytes[ac];

It seems odd to take per-AC values and flatten them in this case? How do
they even get reported, as overall values only? Then you get the same
inconsistency again on per-AC values since those are (or at least
could/should be) summed up over all links, but aren't kept post removal?

johannes

