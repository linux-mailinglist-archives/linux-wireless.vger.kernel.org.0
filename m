Return-Path: <linux-wireless+bounces-14262-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BBC9A64FE
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 12:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D06281800
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 10:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF5D1EF09F;
	Mon, 21 Oct 2024 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TAJYxx03"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8271E3DF3
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507634; cv=none; b=En1iVUqkELSRvG5f9o0OfdsdNNUOQUIzteATCWttTIpRcY8lLYYn/QRi/MxW6OWhWBhnuX4HLoyMnvCD/VJBTFdxFcLlJ8XW3P2jw3oboOdkWieFEEdn7f/nVQ6T5MKxx/iBS55imOLT6kabDZ/q628AlIt3ApBMrd+QBVaBS6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507634; c=relaxed/simple;
	bh=Pu41kxkkNUs8tNS+NJCxOO+pO0LSrBemmeovTOKs91o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sUmXFAF+wxgcKIAa73S1gp8nw/VvIm45lsOBgVAPQXl677WWlAC9U8o+e05rVRJwlIR/JpYyEwPwnVg54J2Y9Cj/S3+YG/yqn7JvsVAL4kLYbh6ou4HbKIBAFGm0JbZUZaYpjdNEbPgVArS9ofdyDzL1DaXjab2ARXrh53e/8Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TAJYxx03; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Pu41kxkkNUs8tNS+NJCxOO+pO0LSrBemmeovTOKs91o=;
	t=1729507632; x=1730717232; b=TAJYxx033q3R6zva5l1liAxRJp6xxhxbQFuNynvIwPwVe2R
	f63iuqrySr36otvxsJYubMqmMuWs4b/usqhpMDN01y0lKrK9QgVjbIQi0zAfXutkrIILI6HGwjTKW
	DtD1F8Y62JJTagmhF4r2Pjno/9q2pzp9WTG9C94a3zH84TG4BfPcANmLWov/rsRFurF3dBsweAd7N
	pzqW/PHM33eBitCVltq4Wp4mPwmrQTgqSryWgq5lhTHCfX+7Jt+bsdj36jPkTkr9ED7RH5BgS6+WD
	cmqOA16HRO2Xn3k+PKw8vClgF90c38wh5IGHnS0DJGTyDRm+Y+Sv9jpCijrd31/A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t2pwL-00000000krT-3iGd;
	Mon, 21 Oct 2024 12:47:10 +0200
Message-ID: <1619411006183a296ebe74872d63c407923d1b5e.camel@sipsolutions.net>
Subject: Re: [PATCH 2/9] wifi: iwlwifi: allow fast resume on ax200
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, Emmanuel Grumbach
	 <emmanuel.grumbach@intel.com>
Date: Mon, 21 Oct 2024 12:47:09 +0200
In-Reply-To: <20241010140328.a60d6303c027.I60061277526302a75cadbba10452e94c54763f13@changeid>
References: <20241010110507.1006209-1-miriam.rachel.korenblit@intel.com>
	 <20241010140328.a60d6303c027.I60061277526302a75cadbba10452e94c54763f13@changeid>
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

On Thu, 2024-10-10 at 14:05 +0300, Miri Korenblit wrote:
> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
>=20
> This feature can be used on ax200 as well. It'll avoid to restart the
> firmware upon suspend / resume flow. Doing so also avoids releasing and
> re-allocating all the device related memory which makes the memory's
> subsystem task easier.
>=20

This might've been a bugfix as far as the customer was concerned, but I
don't think we can consider it a bugfix upstream?

johannes

