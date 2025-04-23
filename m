Return-Path: <linux-wireless+bounces-21934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40E2A9958B
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 18:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9CD718852AF
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 16:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CE62580EC;
	Wed, 23 Apr 2025 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xYnXpdjD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F74EEEAB
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426227; cv=none; b=EmvHz4A0SD2rZ4LEPFfjlPExStFc1N8iqvpq4zTMEKnQdOM9P0Fp+P8wx7DOHQPrTilLexS+goY3m6NPdeUKvnVpBcDopFSgUdBr30KJI3Nqp9hzkmSsJrJen/QWXzrYqGeN2u5/QmU5VHL5DTRnwNgD2slIBxHJZtc0R4SC7+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426227; c=relaxed/simple;
	bh=xrd1OUeH1kOOgaq18IzPSG5nE4BOBcw5kvgSgKDP524=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bVJ1c3B50PR3lLrXiW6lj/vcBen2JFxYdQXPPCwIM5IqVM8m3kgnq2RUmasnvEBdEAJIeAeVAAuq/EZ1rPEOW0W7BDuKroRhCIJQEDfjNMbisyD9FA2uM+nkIM8HXgcouc1gYcLqOz9Vf5kWPZGtjFkVbMo+DmXyx6MY+9mSsaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xYnXpdjD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xrd1OUeH1kOOgaq18IzPSG5nE4BOBcw5kvgSgKDP524=;
	t=1745426226; x=1746635826; b=xYnXpdjD4zwasQLiLkX1yjJ1a1jBk7y9aclFc+4UpQXNzML
	VVGGzMqyUOcbm5baJQBYS75fAxXFfol55DyL9Slaw8JP0+5DGR/ey4XppB/LKXHWZywa95E3YmvH3
	UMbQJmuxC23RdtC26oj8/1mxNBUoNJo7Ma4IHXh4G6AHlzCrdKA9HyMDtrt+oMyUGHSkgZn9cK4rf
	kXk59ROwNKeJGe1aIMy+b4kMQl0Sfdi0nd8BIA80rKZswuPpXgIMTTV/5WLnVEt5LkIIdsH7kxjTI
	6KiY32XKbOOAXeAt6iHC8dURYOzyB09coFua2VdXowgWQAAlgMM/YezP5+SnUZSg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7d5q-0000000EsE1-3SRv;
	Wed, 23 Apr 2025 18:37:03 +0200
Message-ID: <4e3289a9f15789c93e47ac469ccd910fe77765e4.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v6 03/11] wifi: cfg80211: refactoring
 nl80211_set_station() for link attributes towards MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 23 Apr 2025 18:37:01 +0200
In-Reply-To: <20250415042030.1246187-4-quic_sarishar@quicinc.com>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
	 <20250415042030.1246187-4-quic_sarishar@quicinc.com>
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

On Tue, 2025-04-15 at 09:50 +0530, Sarika Sharma wrote:
> Refactor nl80211_send_station() to fill link level NL attributes for

nit: subject should also say "refactor"

(also previous patch)

johannes

