Return-Path: <linux-wireless+bounces-12788-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2D2974EE6
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 11:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E631F212C5
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 09:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF3113C67E;
	Wed, 11 Sep 2024 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QN1vn71G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE9A45C18
	for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2024 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047769; cv=none; b=PABJO/ZPiDvJM+Pkf9utXkpIBd/Darpsq27VFav4snhxDNUexYi8Kqvz0BdVryepk2qMlqVCY927GMzbK21+ow6InpEzB5vsghEhRec7MSjRPRSP9mC7lOTBfNydblkEU9yuZTkDd60Ytp8dG23MRt/KUwrwjjccNfOSRjteq60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047769; c=relaxed/simple;
	bh=u3FCtHiQtxHhKjsgR0ZUIaeWbBf6q+7gW/IemQhBpKc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qoTGicXVKhgurEGZIhVVTC76gOLoCOzXwTjWVFWiv2XZn0bIFFWyAVJ26Uzg7/0aFFo2Scd195R4K+pqoapszioopJd97sv8vZ0Wtw94w+mXuBpf62GdPydrGOi+ZiBCqBzbWZnzGgxQtuFMIYnUAnHQO43cxATHdxvhxCNAPDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QN1vn71G; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=u3FCtHiQtxHhKjsgR0ZUIaeWbBf6q+7gW/IemQhBpKc=;
	t=1726047767; x=1727257367; b=QN1vn71GzGKC8BupPNb7NNBNBrkyFtuww9f+Esa7eRdONLm
	lfDo+59bvKaOwtmFI27HgWy22zfiDwVeNF5+u9NyzuuZE3eqJF4+iFeEeR+K1T4J2pTvTUnxNHAzd
	dcselC5q5JNPLqxvtWVQaUEo+wowJibEpYTP7DGnT7qvywlVg5bNqP3jyVUfz7/n+bMugXTm12kf+
	5RDhvdzUZIW24bz9JA+YBK/A6SBy2T1ORJXRd8NXleR9TfrL+q2AULonENfv82UxCEivZcD46onin
	7qNq+08W35HcII7IjsDSPUwTBShMJ9l2S8Z+pqAdCphi+WYWJ24T6aVbf55XviFA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1soJs4-00000008c59-1LX2;
	Wed, 11 Sep 2024 11:42:44 +0200
Message-ID: <e77b379d48db796d199030ce904f8ed44ed679e5.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: cfg80211: check radio iface combination for
 multi radio per wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 11 Sep 2024 11:42:43 +0200
In-Reply-To: <20240904112928.2924508-1-quic_periyasa@quicinc.com>
References: <20240904112928.2924508-1-quic_periyasa@quicinc.com>
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

On Wed, 2024-09-04 at 16:59 +0530, Karthikeyan Periyasamy wrote:
> Currently, wiphy_verify_combinations() fails for the multi-radio per wiph=
y
> due to the condition check on global interface combination that DFS only
> works on one channel.

As it should, really.

> In a multi-radio scenario, global interface
> combination encompasses the capabilities of all radio combinations, so it
> supports more than one channel with DFS.

No, that's not correct, it doesn't.

> For multi-radio per wiphy,
> interface combination verification needs to be performed for radio specif=
ic
> interface combinations.

Agree, but it shouldn't make an exception for DFS.


> This is necessary as the global interface
> combination combines the capabilities of all radio combinations.

No, it doesn't.

johannes

