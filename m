Return-Path: <linux-wireless+bounces-32466-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2F5CIpQeqGlQoQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32466-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 12:59:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 086341FF6E4
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 12:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1515301A718
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 11:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15831282F1D;
	Wed,  4 Mar 2026 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FIe+hwF8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5C13A6413
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772625424; cv=none; b=EXz8wXgjraeLlB4/gByQ26oJ1fKjocVCRB6iGJSA8WThKzIWcg0dj8yFLHEkLOS3nlpzJYImsTgsozfwvanxjh3mOMDIcdiLO6pTVrz7L/TB/F4NVeCDh8K+xP/zPUfVaxrP869QgO/9aO1fpYotd/8vUlQAxzQQIndCMiE8a54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772625424; c=relaxed/simple;
	bh=LaW29JZtZUyLilJSQbCAF5it1Nfx2R2Ed/PuPq22MVo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tas2YBU2hyx/3tdaxspgydYXuXf74w3m+vqJ8wH3uG7OXfyLWVBY6XEAjvRI46x8zxP/hB9tADuM21/sx5f5cgrMOSBY7gk/WDcVBtxC4PflPcOwQgLBE4xYbJVWC4cf75RtqFmfJ8FvVHZTrWP6aLOJENkJba4+QmbrgIdKS8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FIe+hwF8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LaW29JZtZUyLilJSQbCAF5it1Nfx2R2Ed/PuPq22MVo=;
	t=1772625421; x=1773835021; b=FIe+hwF8Vn8nB0iHwolB2r8TFCL579z0zGhZQPurQ/8iLhS
	ffcTgAurA4tXaEmIJu2+2k/6Dl5ZR4+1ixaW63mx0LhmWBJBxp4iLeTDYKjZvqnCEZIUf0w0ZtW7A
	K4qIK3hFoDSbaVQ9s5b8O/W+h/3ZDq4xn/4jI9QqXWUJhqG3QurkH51BDuh5vpln0JUcjhhKltqI2
	iIoowdV/Y40KFaTvt2D9x2oppnYSrnNOMebWzwoIksvLGzPxY/F2HlnrCo+qDa7e/QyyDGLsY4RBm
	CrJvoLoQwFZVlGSJpjCq32rbyDe7t8Y8h/xf5w1dEINksd8xQRSfCCmYayzrBjZg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxkqX-000000083fL-2uKs;
	Wed, 04 Mar 2026 12:56:57 +0100
Message-ID: <6800d54f38355fe2df248dab3da40dba4f892643.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 14/16] wifi: cfg80211: add MAC
 randomization support for PD requests
From: Johannes Berg <johannes@sipsolutions.net>
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Date: Wed, 04 Mar 2026 12:56:57 +0100
In-Reply-To: <20260304071538.3833062-15-peddolla.reddy@oss.qualcomm.com>
References: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
	 <20260304071538.3833062-15-peddolla.reddy@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Queue-Id: 086341FF6E4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-32466-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, 2026-03-04 at 12:45 +0530, Peddolla Harshavardhan Reddy wrote:
> Enable MAC address randomization for proximity detection requests to
> maintain privacy throughout the entire PD session workflow. When
> enabled, use the same randomized MAC address for discovery,
> authentication, and ranging measurements, ensuring consistent identity
> protection across all phases.
>=20
> Add a capability flag for devices to advertise PD MAC randomization
> support and validate that randomization is only requested when the
> device supports it. This ensures consistent MAC address usage across
> all phases of proximity detection while preventing invalid
> configurations where randomization is requested but not supported by
> hardware.

Doesn't this basically also require NL80211_EXT_FEATURE_ROC_ADDR_FILTER
for the setup? If so, maybe some check (core.c?) should validate that
you don't have PD MAC randomization without it?

johannes

