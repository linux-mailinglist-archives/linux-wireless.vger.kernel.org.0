Return-Path: <linux-wireless+bounces-32389-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGL4CRjSpmnHWgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32389-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 13:20:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 810DD1EF48A
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 13:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96DE23416B42
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 11:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40BC375F6F;
	Tue,  3 Mar 2026 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PiH5YxaU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA2937CD5B
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772538271; cv=none; b=jV58ORat3KiyJw2HzV0P2XrmiAkSS7Kelvvchu+wRmNqjEXVRlK1Ua8rlHdas+DwFEjwWV3WHJfVFq+WalxM1ZA2c3e+R6v6iitaUWpR7pDZAkIVtIsqhzM3DvZxN36U8abqk9uG4OtkQ1bMTPcKRKtzpqimda+uREHZdH5neWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772538271; c=relaxed/simple;
	bh=SghpSl6WTTnFqJZo0uRVa+z3rkXHx8QaaoqRG9gLVXk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R0X8jB3x9YjpcktOhvfaU7rQRn2oHTK1d7tKnrrj26DgpvgBjjv2rYWvNnguH7vRwnSGQsRKhRz+aO6PL+A1r79pCmsTLTSG/0E0/MeIu2nq00oSmlZS8C4qMJRv4AsM7voG1+ogkGFWSKI/MSKt+f8xRHXJXtbH5HVe2Duj2NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PiH5YxaU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sANG3WimobWLRM22SiDtmZU3m5NPrQ5WoDvzNGZnOUw=;
	t=1772538270; x=1773747870; b=PiH5YxaUEzksPRZANE4J7RwZuqridbbzb4ITuwmOnvsKXGJ
	DR9uSPQq+0oazXPLdfbz1IlQyA0mCaU4tRMX4GOQFqRl9lCAMGEc/fjf1MEbB/Ftk4gFjXojtMf4P
	dPMl5TNS7V2rck6mO4XPbGkRmYzs8AiQhNj06WcExoczosSOcU+Anfrc/ur0EQpGC7Z0424V/l+rc
	SAOgTnJJNAQ3jG1XhkoGHXbWONPUbLOeNPi90KYIOgBwFnACluJ+r4JQWHtKr1gChI+q+a38rHpyN
	kAfOGSwKhTN/G6BrK01h2o0SyLrr9fguSLcGxZQfIoUa/y2m3Vs/qpF7+SJncRqw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxOAs-0000000755l-1W44;
	Tue, 03 Mar 2026 12:44:26 +0100
Message-ID: <042df19bd62ca0f8044c3da496319c8b5fb79bdf.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v4 2/2] wifi: mac80211_hwsim: Add UHR
 capabilities to the driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Date: Tue, 03 Mar 2026 12:44:25 +0100
In-Reply-To: <a882918a-0d6f-4eac-ada9-5d4bd748b33c@oss.qualcomm.com>
References: 
	<20260217054731.3667600-1-karthikeyan.kathirvel@oss.qualcomm.com>
	 <20260217054731.3667600-3-karthikeyan.kathirvel@oss.qualcomm.com>
	 <d52fdbe5d9a483b5746b7253b512958d1460a9a1.camel@sipsolutions.net>
	 <a882918a-0d6f-4eac-ada9-5d4bd748b33c@oss.qualcomm.com>
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
X-Rspamd-Queue-Id: 810DD1EF48A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32389-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Action: no action

On Tue, 2026-03-03 at 17:11 +0530, Karthikeyan Kathirvel wrote:
> Got it. It looks like this requires a deeper feature-level understanding=
=20
> or a review of the full spec document for each feature.
>=20

Certainly some understanding, but I don't think you have to necessarily
deeply understand each feature - it's specified in the table of
capabilities which are reserved where (though one notable exception is
missing in the table, the update timeout.)

> Instead, I used=20
> AI to simplify this. Below, I=E2=80=99ve pasted the AI output, categorize=
d by=20
> AP/non-AP STA and by bands. Is this approach fine? Shall I go ahead and=
=20
> make the changes based on this?

I can't really say anything on that unless I go cross-check this with
9.4.2.354 UHR Capabilities Element, which you can do just as well as I
can? :)

>    ### UHR MAC capabilities
>=20
>    |              Macro              |         Role tag      | Band tag |
>    |---------------------------------|-----------------------|----------|
>    | IEEE80211_UHR_MAC_CAP0_DPS_SUPP | Both (AP + non=E2=80=91AP STA) | A=
ll |
>    | IEEE80211_UHR_MAC_CAP0_DPS_ASSIST_SUPP | Both | All |

Also the table is pretty unreadable anyway.

johannes

