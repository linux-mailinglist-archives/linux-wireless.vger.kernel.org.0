Return-Path: <linux-wireless+bounces-35378-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WO5cETVz72ktBgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35378-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 16:31:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFA0474676
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 16:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3386B304EDFE
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 14:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FEDF9C0;
	Mon, 27 Apr 2026 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="em55Gxru"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3293D3D1E
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299867; cv=none; b=hGQ0+jx7GI9/+7WKfBKqcXhBnWTPpPQSKHUNE/9v2pZKa9v2Vu5lI9zfJ65Byv+5M55XAdxC/g+VrQSYcwQGdTzW18tIvVwYVkFbFSjqt5LZa6HRPWgFgoFYrXhxJJ5pvmgcZuu4W57eZusVG3Yqy3iWWjKyJKA04rspBHXmmGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299867; c=relaxed/simple;
	bh=dqeUPJwxq2KbefSl44uraeybXW3BYsba7aAykopv958=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pv13JLzESV/NfBXKgYBsp6EyGbCq8p4K0ZNzdlk7C3qBtV3FnHy/GCNCoUEPvmHHw62xaF62fkFELKgYW4SUk2X0XdsNvZ0GmtVAs6ekXyU+OQ7+oqgooO/g6FNcxI59jlGiacM6GSPsa2Crzlfdw3UXqwCYGZ2N9qEJnP0+/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=em55Gxru; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dqeUPJwxq2KbefSl44uraeybXW3BYsba7aAykopv958=;
	t=1777299866; x=1778509466; b=em55GxrurqjaX6HOhDZ7zbnNKhWp0ZD/L4ool+FXghqDEIz
	tPrNbF17CUSSBuEUjnOaw3/LTz9KbvaAY906eDUjduPUz/8ciaZ0gl5pCmC3e5lVu5HkAsgeff1j6
	4/4kGLI9r5Wk2HoyXkjbaMzGYrk1Fc1VeE85qKg1l/8UDwFKaWTHnPO7P0tTakpeHRti81t3gk/uu
	pniE6G8JexBsoseajs71ZPbUdOtXatM2+dU/Kdbyl+O0G1YPoUh78ab1ye/NW0VEZSdR2gNW9fj3K
	ONmvwZ0xRGEN4dJXJqkdLTjeV3oBbC1j1w2rvlRrvcKAOH9GmXg3J62EybXsqQ5Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHMsm-0000000F2Xj-2e3a;
	Mon, 27 Apr 2026 16:24:20 +0200
Message-ID: <e8f6a95273cd9d968883daa010743792b547f2e6.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 0/8] Adding NO_STA flag and reworking RX link
 resolution
From: Johannes Berg <johannes@sipsolutions.net>
To: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>, Benjamin Berg
	 <benjamin@sipsolutions.net>, linux-wireless@vger.kernel.org, Jouni Malinen
	 <jouni.malinen@oss.qualcomm.com>
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>, Benjamin
 Berg <benjamin.berg@intel.com>
Date: Mon, 27 Apr 2026 16:24:19 +0200
In-Reply-To: <01295135-6bcf-4567-869b-75597649d11c@oss.qualcomm.com>
References: <20260223123818.384184-10-benjamin@sipsolutions.net>
	 <01295135-6bcf-4567-869b-75597649d11c@oss.qualcomm.com>
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
X-Rspamd-Queue-Id: 4AFA0474676
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35378-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]

On Mon, 2026-04-27 at 15:32 +0530, Ramasamy Kaliappan wrote:
>=20
> To simplify this handling, we would like to explore an alternative=20
> approach that avoids address translation for management frames=20
> (authentication, association, and reassociation),
> regardless of whether the STA already exists.

I'm not convinced that making one specific case a little bit easier is
worth the trade-off for making *all* (other) cases handle link addresses
throughout the entire wifi stack.

> However, this approach may introduce backward compatibility concerns
> when either the driver or hostapd is not updated.
> To address this, we propose introducing a capability indication
> mechanism between the driver and user space (driver =E2=86=94 hostapd).

Even assuming we make the (IMHO misleading) effort of not translating
and having it handled throughout the stack, this also can't really work,
unless we suddenly start translating (or not) for each individual
application that may be using action frame registration _separately_.

I don't believe this approach makes more sense than translating and
sorting out the corner cases.

johannes

