Return-Path: <linux-wireless+bounces-19914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC49A54A4D
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 13:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A7216A052
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 12:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9470420AF71;
	Thu,  6 Mar 2025 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="K9QipeIU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13877201022
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741262807; cv=none; b=Yenkps6lAMJbBIgUZJW+KWfQNXtoRZiHQBDfK4AAXf/wlbN/RwPib1Wo3f1CXVI3Yu4PEcd9Gqq6ubsDMR+P/fJpLRZT5YkI+RKevJQBafxgOylmAZ1vuw+7Wj+rQW3zng5qrueO5XdwnG8GUW8gs+pS4CCZfG6zDcTCxAzWZCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741262807; c=relaxed/simple;
	bh=I+s3cmRTIcvL9hV05rJjmYVgGWzJXnQVQ6s/lkrjW60=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CsyqDVY2NjjBCd0bD0G5czUC0Ed5CmPGw8renZA1XORX8AI6bnBzpVJobd9q5TexzqrQ7jjwNX6EqvUcrddt5dVm5Xn2ij+16v0/e+Wf3o8km9P5PT3CGccxNW7brDqophdQYExGW79JNc1754T8VeT1XDbitPgyiRwjKxj7pOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=K9QipeIU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=I+s3cmRTIcvL9hV05rJjmYVgGWzJXnQVQ6s/lkrjW60=;
	t=1741262806; x=1742472406; b=K9QipeIU5F+LXSEkf/hw1d5JXuOMOgIh7DpzfJd4oKv43r9
	dBbenFGe9VW5xgVJ+yVlWjc0QC7IBEp0bqt5QBXzx7yyu30ialFhqwwqRHsCNpGzIvDIjJBNjvOkD
	Adsw5B6C/3K9MbEP9kz62w840gxz5C80t5dDLS+vNMGHycxLPieaQSVVAXR/23RkdTZotnfxXO4uJ
	RLYPErkF6fdvQ9ZyQXmxYUgurj11bBC6H7AK8pKvVWFvh3iU7U0MsMLaERZmrnmUBGhKZs3omsHKd
	zpes4qDdgUahGByaWT99C9QoIWcX2hNSxWqEs1DHHRUka3BX1N51sOe6Z7XvhhXw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tq9zu-00000002pW3-0z9U;
	Thu, 06 Mar 2025 13:06:42 +0100
Message-ID: <0e95c126b5f273ae437c218f825f7761a5edc395.camel@sipsolutions.net>
Subject: Re: [PATCH v3 03/12] wifi: mac80211: add support towards MLO
 handling of station statistics
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 06 Mar 2025 13:06:41 +0100
In-Reply-To: <5fc1136a-811c-4d1f-8d8c-8cc27b697c01@quicinc.com>
References: <20250213171632.1646538-1-quic_sarishar@quicinc.com>
	 <20250213171632.1646538-4-quic_sarishar@quicinc.com>
	 <38d1d5f8be439e8553cddd2df03bf3553bafb82f.camel@sipsolutions.net>
	 <c3c5fc43-9140-4793-9e61-279b7176150d@quicinc.com>
	 <5fc1136a-811c-4d1f-8d8c-8cc27b697c01@quicinc.com>
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

On Mon, 2025-03-03 at 21:38 +0530, Sarika Sharma wrote:
>=20
> I checked, looks like link_sta_dereference_protected() uses=20
> ieee80211_sta structure and here sta_info structure is used.

Oh.

> Can we declare one more macro related to sta_info structure here or let=
=20
> use rcu_dereference_protected() itself?
>=20

Not sure it's worth adding one, but you can use e.g. sdata_derefrence()
or something like that, so you don't need to spell out *everything*

johannes

