Return-Path: <linux-wireless+bounces-34639-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDDeDL9c2Wm9owgAu9opvQ
	(envelope-from <linux-wireless+bounces-34639-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 22:25:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A09393DC76D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 22:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E24130104A3
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 20:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209BB365A14;
	Fri, 10 Apr 2026 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="otOFn4U5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDD329D26B
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775852731; cv=none; b=q3M1S+VAVlfMejSua5Gl0LYvfPsPYVpqxOAayU01Ejrev6QFaFgYp5dadIGPTrOj7/mNY3pYUAXVgDY1Ny3mrdXFi7eymW7s9T1w48HSqjxIcAtNc3QWjJdLWCfnAFEG5tdLf8i/yJcdiTjNjOBnBjMzFYl/+Urqo6vcMK0glGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775852731; c=relaxed/simple;
	bh=Loi8eNIgsRCmYspKxVppdMDt+6EwwFnWDKUInYqwe6E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OVcGX1FiMBxy9Uft7XPo2ML4WAPZx2S3NYLYVQlgTK/I1uf7GHGqS4rsOmIPc2eVXR4H7/0Wimfv12R5e1O+307O121tp+I4kIbqATJtlyqVUVzM3N5KuxFzD0G2KwzxXWjDjDq9QlUZMW9+moKz0oP1JL+JQ0IKaysnUt4K8ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=otOFn4U5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Loi8eNIgsRCmYspKxVppdMDt+6EwwFnWDKUInYqwe6E=;
	t=1775852729; x=1777062329; b=otOFn4U5iUIvpt2hAsai62kqS6NkN6fnE5O37Co/VzBQ3pS
	eD9+CIPmW8NViIyGIQNFhwez/HNWNCSNSNinFf0s+qd7TY+cuNWfxNpO2v6CAzW4cyBtGpIMt1n8N
	GkEnyLelyI9xWWtsMIOhLSYJyNfuLtak7AlMXI2Ftw6f6TjqMeGWfV9ocbwpzEl2LcrGbgSlw5O6a
	blrMVMc/iqzD72nOB3/9FKFPjJiBeOWDdCy5rjmtQoKU/A3i2T41wNH6VFD8/xU/dkqts0J8MeOdW
	x2fAAjh/5LBb9Eez5eZ+8KZTAxNCZuTDZZh8A/+eT9m/mnH41tUy9jE0A7ecFgSA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wBIPp-00000000s8h-0v3c;
	Fri, 10 Apr 2026 22:25:21 +0200
Message-ID: <4573490cc064212381ff88dcc9d891c77e7a94eb.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 1/7] wifi: nl80211: remove EHT IE size validation
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 10 Apr 2026 22:25:20 +0200
In-Reply-To: <20260410190354.394742-2-pmartin-gomez@freebox.fr> (sfid-20260410_210401_795150_2EF97458)
References: <20260410190354.394742-1-pmartin-gomez@freebox.fr>
	 <20260410190354.394742-2-pmartin-gomez@freebox.fr>
	 (sfid-20260410_210401_795150_2EF97458)
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34639-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A09393DC76D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-04-10 at 21:03 +0200, Pablo Martin-Gomez wrote:
> Remove ieee802_eht_capa_size_ok() calls from the middle of nl80211
> packet processing paths. There is no reason why EHT Capabilities elem
> size should be checked here while HE & UHR are not.

That's not right: NL80211_ATTR_HE_CAPABILITY and
NL80211_ATTR_UHR_CAPABILITY have policy validation functions. It's just
that NL80211_ATTR_EHT_CAPABILITY doesn't, because it cannot, because it
depends on the HE capability (validating EHT requires access to HE data,
and policy validation functions can't do that.)

johannes

