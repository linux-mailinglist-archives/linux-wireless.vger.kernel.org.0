Return-Path: <linux-wireless+bounces-6442-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFDB8A81E3
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 13:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8F6DB24487
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 11:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C8E13C80B;
	Wed, 17 Apr 2024 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vbzjlZ+W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014BC13BC00
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352688; cv=none; b=izcxql+asApHyO/aqyxVubZfVxPy0FxxI3/plhQo0STTs7KtdpqEK25GugFgsfFMnf6pkbi6JSkTW2fAWtEmZq7uqSPQazohogKndzzmxgKZaR8RTSODEgj6lHkFl6X8OBLSAtGWYdT6kah38V0PMjpwKtJFhQvH3fJGL6NTGVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352688; c=relaxed/simple;
	bh=PbFTxdXpY7GzbzvB2nZazZXs0kU8w/HploreA7Tbj5k=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=HIroVefky9Q6j1EUiM5hseKqUWG+7U156OzABPlcKeFX5THXiZYTZ7YyVZewxiQ8RKUBwNGU2lgpojfy8JuOMNP0N+awMheRCKfNcW0FxwWTzxs2bus38yvOLxptB4mYOHFsvtdsSU217MXbE+kkkmVCpSf7Qt72PANd1/2o1Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vbzjlZ+W; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=PbFTxdXpY7GzbzvB2nZazZXs0kU8w/HploreA7Tbj5k=; t=1713352687; x=1714562287; 
	b=vbzjlZ+WFyyQFs04doPYOpXWgJo12qxz3PTOf+FD1vPUyQ7Lt83Pdb7nRzNBmXD/Je1yL8Lgyr3
	BH1z04/y1qJjbdG+nXsmi6bSeKNZhxSaEW2sXSRlrUCAeSBJBetStjnKt6T+LdUVIvgVEsMsi01KO
	deNaNk4F2lbLAGRpFrQ6LfoB6KQFrS6v0F5L6PKWWMCpImWLNKZYloUXr/TLdlzocvUEMJ4GdMbLa
	cQwfxRrwegtboxw82iArO/1+V+YMsbSloZb+6eVtHQB0nibahWnrB52kk2PrAvZezEBb2BUrJES4A
	F2O/LkdIluA1c/gwF74qD8B2jMeR80chshnA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rx3Ii-0000000Au0N-0M0W;
	Wed, 17 Apr 2024 13:18:04 +0200
Message-ID: <fec30176f437d565d4c1dfc4944373f117d75a64.camel@sipsolutions.net>
Subject: putting future iwlwifi firmware into intel/ ?
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, miriam.rachel.korenblit@intel.com
Date: Wed, 17 Apr 2024 13:18:03 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

Since I was just looking at some firmware related thing (files for the
hardware that might be shared between Intel BT and WiFi), I noticed that
just over 30% of the files/dirs in the top-level firmware tree are
iwlwifi-* files.

While we can't move the files that older drivers might consume, we could
e.g. change the driver to look up future versions/future hardware under
intel/ instead? Would that be worth doing?

johannes

