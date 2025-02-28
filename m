Return-Path: <linux-wireless+bounces-19585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03596A49A5C
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 14:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A6C1892880
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 13:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D431F1D555;
	Fri, 28 Feb 2025 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="L5rrjusN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0981D554
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748631; cv=none; b=JYsw7UOO9OH+yghxVkHBYR4TBSsNLJj0X8H2erAT0n+lz8JP5oQa7yxFm+uBx+OJshyxryxriUqchAnm/G5UaO1mP2+W9QsmG1JTCPLg1E3DdSvh+G4egnD6xpU5V9OtJ33PmlyPldvvbe6icw8u7jXncphopQQFwhc9AlVlNb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748631; c=relaxed/simple;
	bh=p1EiEMhfjvC3f6oHEobjctt6sAS/b7TzFmtjwE9i6z0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U6wT1Usiwg4/SVv3yPa0s9uoOqx8AejlftgvJVHFhS/LdGfDBjKpu5cADfaotH0t9XdaofoVHy2y4X/08mzd8M4UrinlRYSai8N35GIDI2jbmb8pK6iW7Dcvdp+6COM9Geq1yh59YbgT+H2UiQKwBj6mLsy/RPBoIkryr++LzGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=L5rrjusN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=p1EiEMhfjvC3f6oHEobjctt6sAS/b7TzFmtjwE9i6z0=;
	t=1740748630; x=1741958230; b=L5rrjusN9sTZ8+l862Usj36SGtejLtUxgpVjRNQjruDGpHO
	iEzWutgyhD+tgD2orbSDkzF1n6dHYZKa5PlSmhpRRRqFln7uDZBvMRLMbFux9LsbNnTt1yemyb9WU
	mV+sr7rl8l+ZnE3rtvwyabBsSEtiWSl+U5o/ueNmo4C1u0snQ0Rsj1Aa8DYRePiQGv6n84hAvjdOP
	vAgAHimTR0Wn1a7M7zhCsDhDY9Cbbs3UdPwhAN2/I0c6V6EssE/sVmjVDTZiSJFeuw5kTcqPf1Bvd
	PblOhHoR+Xo7UF/R+B8oot+22YNqdyiZYZMfasKR9tp3i+vFaswn25qR421GfukA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1to0El-0000000DkxA-0WGX;
	Fri, 28 Feb 2025 14:17:07 +0100
Message-ID: <9514ee27ef444c754bf97e348d6f06399b159f07.camel@sipsolutions.net>
Subject: Re: [PATCH v3 04/12] wifi: mac80211: introduce sta_set_link_sinfo
 API to add support towards MLO statistics
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 28 Feb 2025 14:17:06 +0100
In-Reply-To: <20250213171632.1646538-5-quic_sarishar@quicinc.com>
References: <20250213171632.1646538-1-quic_sarishar@quicinc.com>
	 <20250213171632.1646538-5-quic_sarishar@quicinc.com>
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

On Thu, 2025-02-13 at 22:46 +0530, Sarika Sharma wrote:
> Introduce sta_set_link_sinfo() API to fill fields in sinfo structure
> for station statistics.

I don't think you should call this an "API", it's within mac80211 and
doesn't really constitute an API boundary of any sorts. Call it a
refactoring?

johannes


