Return-Path: <linux-wireless+bounces-35901-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBTkA/Tl+Wn2EwMAu9opvQ
	(envelope-from <linux-wireless+bounces-35901-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 14:43:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A539D4CDC7A
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 14:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3CD93071BFD
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 12:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684AB4279FC;
	Tue,  5 May 2026 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GUL4hhGV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920A341B36D
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984672; cv=none; b=dcoc9QgeXskxhu6zJgLr7L04wyvA1U6fRE8tEKd62jyvvQZ8aS+1pBTCzVG8TBbj2aoCwJHXGdAjo94wuCGgUDtTrR17oGBjp8EluBelBZSSvo5RiWsI1RJV5MS/Z1G85KL7bhvxzXZxlKnBA37lF9lwmtKxqDE+JDsEe2c3Cic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984672; c=relaxed/simple;
	bh=vEs8CU2hvrCyXPEp4jUfxheYCQWV8l5I04xabMIIyjs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SlmeBPgJ4VnNiUKwGm/+ENT4EQaejLz5xwczr2GRojYKEY7Na51usgLRW99az/WbCfUNcf4BNW1mbiWG2eosj78f9idmWgdSK1N+Qnew1W8SQeVOrr88zScr9y0r1VRccxOBmelPSiizgBu4+dHGAq3W1usnHWOlV7McRj1/nWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GUL4hhGV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vEs8CU2hvrCyXPEp4jUfxheYCQWV8l5I04xabMIIyjs=;
	t=1777984669; x=1779194269; b=GUL4hhGVRQ4hxQXANUgwEBNm8kLWSBWs+7NBrR1dkI6Tagm
	RkkPPsifkwm9hNmyNRQ7a8hxeaWNnMUckRaY+0NHUO7gqaz4ClTa6Mop+3RHYSzxju1rmHU3Ne9po
	cHMnMnJEOorZlQECz2l5Vnf3TnxA5qgzWDw7zEz7/6glcCtDr0m8x2fBfJXi8SgpAC1xbCL8a5eho
	diP7Ji0wnOnl/8djg094i66jpkZhJdMxQ9dvZHTd/STRN75zTlFEVkV6HEW+erElnJCn5QK2QxY8N
	gdvNvx0rlNfHGvArISx/7B2mTaqRlrOrilS92Zrmu8Ctl4QJZhGGe0PbT4bYvLng==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wKF22-0000000GBB3-0mg9;
	Tue, 05 May 2026 14:37:46 +0200
Message-ID: <1b429333026f4c9f8cafde32205e4b26a37fd326.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 1/4] wifi: nl80211: rename PROBE_CLIENT
 to PROBE_PEER and add STA-side probing support
From: Johannes Berg <johannes@sipsolutions.net>
To: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Date: Tue, 05 May 2026 14:37:45 +0200
In-Reply-To: <20260417133124.3412752-2-pritiwa@qti.qualcomm.com>
References: <20260417133124.3412752-1-pritiwa@qti.qualcomm.com>
	 <20260417133124.3412752-2-pritiwa@qti.qualcomm.com>
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
X-Rspamd-Queue-Id: A539D4CDC7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35901-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sipsolutions.net:dkim,sipsolutions.net:mid]

On Fri, 2026-04-17 at 19:01 +0530, Priyansha Tiwari wrote:
> From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
>=20
> Rename NL80211_CMD_PROBE_CLIENT to NL80211_CMD_PROBE_PEER to generalize
> peer probing, AP/GO continue to probe associated STAs (legacy PROBE_CLIEN=
T
> behavior) while, when the driver advertises NL80211_EXT_FEATURE_PROBE_AP,
> a STA/P2P-client may probe its currently associated AP to quickly verify =
link
> responsiveness without waiting for traffic or long timeouts.
>=20
> Userspace and cfg80211 rely on this feature flag to determine whether
> STA-mode probing is supported. The command returns a cookie in the direct
> reply and delivers an event that indicates ACK (and, if available,
> signed-dBm ACK_SIGNAL).
>=20
> For MLO connections the event carries MLO_LINK_ID identifying the link on
> which the probe was ACKed. In AP/GO mode the peer MAC is required, while =
in
> STA/P2P-client mode the MAC is omitted (AP implied).
> NL80211_CMD_PROBE_CLIENT is retained as a compatibility alias.

This doesn't actually do what the subject says. You also don't need to
describe the existing behaviour like MLO stuff.

johannes

