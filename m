Return-Path: <linux-wireless+bounces-18428-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCD2A27778
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320C93A5808
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 16:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A1C2144CB;
	Tue,  4 Feb 2025 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IbT3YW0Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB98201027
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687464; cv=none; b=eUe0/wMzFZFr6rO716mrHTCCDayYes/VPvK50e4Gq1nQH4Gi5Y86RY0A1Q47whOXA0j2iroqy6X9nwwxEFZfA8xMjRZQKNQXx4AufwZ/TMfyy5oD8Vbg53r0BZF0QQWkb/ZwkNSMr0ArcGGypsoD+P1pmd5ZLHuJSNKyxq/e/CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687464; c=relaxed/simple;
	bh=cnSF+JLbyk/DOOiYOH6sRbtmsYXHLbilenvJSd2FfTg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RNbactoA29ZDIU9QZAQ5X3sxayVtTSZCAxJaBDlMUItITpj9Vuqf5TzKgEQ2FXbIalhakQGLzDbo67w3KH3xgx8oCP01PAPv5NqFqL9oj9Y8aAaj79jFM9v3jJ/p6RPtNIZCEr6kP9fVe2QBphHB6c/GwNzfyyD69yZOPt/9cKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IbT3YW0Y; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cnSF+JLbyk/DOOiYOH6sRbtmsYXHLbilenvJSd2FfTg=;
	t=1738687462; x=1739897062; b=IbT3YW0YVJYVtAcx24LabZrbd14ZhuWjZyP52OrLGJuUEI8
	NyjKsD8aAZIyktSvyBerCAMAwZYE21nq5LcGd8j1maOdZXo/CkN9GSHulF21rhevy/6ukNQ5Wliw0
	5QGNLtrsg3uEg+IRLnW07Y4/oHpIS6AAlJK39E+mJCxdUfDcLoftRKeqBeM9R5fqGJjpff6ml/u3H
	/TPnSCnn1QbBD8G2qfEvDb06hAP6IHhekiSCchIkoCpO0AwHmDaCPXbnYXtSyG76NPncjxqtcf0GE
	SrEdB1myrEDMCHtUcSeQcype44Fnv4R5keGRDZm2SqesanZ8t/PIfR6yMaWErubw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tfM27-00000002oMQ-2N1R;
	Tue, 04 Feb 2025 17:44:19 +0100
Message-ID: <3417bfd65ac7b6af970400961e77603eecb67ae5.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: remove debugfs dir for virtual monitor
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Wetzel <Alexander@wetzel-home.de>, 
	linux-wireless@vger.kernel.org
Date: Tue, 04 Feb 2025 17:44:18 +0100
In-Reply-To: <20250204164240.370153-1-Alexander@wetzel-home.de>
References: <20250204164240.370153-1-Alexander@wetzel-home.de>
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

On Tue, 2025-02-04 at 17:42 +0100, Alexander Wetzel wrote:
>=20
> My iwlmvm card is not taking it well when I bring down the monitor interf=
ace
> while TXing on it. The firmware crashes for my "Alder Lake-S PCH CNVi WiF=
i"
> card.
>=20
> But that also happens with unpatched kernels and so I don't care
> much about that. I can make a bug report, if that's news and want you to
> look into that.

If you have it now anyway, send it so we can take a look? But I guess
not the most important thing. If you want to reproduce with "trace-cmd
record -e iwlwifi" running that might help explain more, but I guess we
can anyway do the same if we want to.

johannes

