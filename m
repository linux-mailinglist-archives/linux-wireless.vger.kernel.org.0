Return-Path: <linux-wireless+bounces-34756-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wERCDlVc32meSAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34756-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 11:37:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBCE402AB0
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 11:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB9BF31909DB
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 09:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3968433986F;
	Wed, 15 Apr 2026 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="t2BXUmFa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE259337BB0;
	Wed, 15 Apr 2026 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245330; cv=none; b=GR4Nwesb6C/EOQdXFpDOEZvN10iiHt8OOIIq9uwLdOPVI75lz+B6HLsMVvfPKcYlcBhZb/iEPHMF1n494zp3B59HH5lPMrVwW3oSpkrktZaIUm/+uL1GsKaTVwHdoUXKH2VV54rHYutBR3npGOGL1yMjpksscBzh8gz4mE8KwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245330; c=relaxed/simple;
	bh=f5nVI6s0iwS3WCMiabcwlxELeXuyBCaiT01JZxLL+4A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=abcQ7/AEQwMNxiFAxPFP5ClQbV1OZLMjK19dnmxmZvDqzTu+Dzi2xvtuHuxcnpD5qdNo4qtNCQ7iHisHPoC+mupFpfwBBgIv+0SuFo8sNdZBhbCve7JH/yJRiIs3Rcoe/pLMXyQz8lY/MToJ+rZM2XYlLONuYhTJnf6aXZn2t+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=t2BXUmFa; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7cue5BZUnGmarpnAWsViMhA2LBsUFx5lY6vWAOtm9mY=;
	t=1776245328; x=1777454928; b=t2BXUmFaQBFLq2FRpZAu0nEUa9WXOP8pZzkoQsDhNKtAlW4
	MEa+ATyYde4OHjGFSqmYQf9O5ZEOTxtdcy0SDehS9e4RNEvotChAmAJzL+3AytDppwbHhbsefd6+7
	sk00AbScyM0FR7wNsx+dYT3CVSoqWlKkWsUoxs3d5QUTkv4b9xOsZ57wdgsqZwBjg7+uvx2hqFp/i
	bDtbHDO4rfhwYIr+acQz2q08tbzpXQ/AsaYsRFYCmVYjLcGdjAeL5hKccJ3WE8Tw0C69Vy+NbUgE8
	aUZoxoLJMNuTh4TzzmpRuZ7WICuq5CoQ1+J/L5oXYnlHILEY6tGQ+SB9tdDFxJQA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCwY3-00000006JGi-2N9S;
	Wed, 15 Apr 2026 11:28:39 +0200
Message-ID: <093e01e4f79f9922f1220f38ceaea4f8448a6d72.camel@sipsolutions.net>
Subject: Re: [PATCH] Skip ieee80211_verify_sta_ht_mcs_support check in
 non-strict mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Rio Liu <rio@r26.me>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
 "benjamin.berg@intel.com"
	 <benjamin.berg@intel.com>
Date: Wed, 15 Apr 2026 11:28:38 +0200
In-Reply-To: <AKVRf_yEu2mRCJekCJpre5xXMuHa_3_dO7_H1UU8fiKZRjJUf96ZKepiR999NwpiVwmzWBYoKipBpx1rqZatVihMYOCvANUnbeoyI2U7ct0=@r26.me>
References: 
	<7h5kwW8K-FIgMb5P9VQ1BwuECi1JtpQP3RNBytb3F0k2g6DtBAnz65o1smDvWOr2ag9Kla-YpMSGyN1NsU7yYslLU-K9NCyTAxjyx-PEEF8=@r26.me>
	 <AKVRf_yEu2mRCJekCJpre5xXMuHa_3_dO7_H1UU8fiKZRjJUf96ZKepiR999NwpiVwmzWBYoKipBpx1rqZatVihMYOCvANUnbeoyI2U7ct0=@r26.me>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34756-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,reddit.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,archlinux.org:url,r26.me:email,linuxcommunity.io:url]
X-Rspamd-Queue-Id: 8DBCE402AB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-04-14 at 05:02 +0000, Rio Liu wrote:
> Some AP advertise 3 or 4 spatial stream MCS indexes in their basic
> HT-MCS set. On cards with lower (2x2) spatial streams, the check would
> fail, and we'd be stuck with no HT when it in fact work fine with
> 2-stream rate. This change makes it so the check is only performed in
> strict mode.
>=20
> Signed-off-by: Rio Liu <rio@r26.me>
> ---

Should probably have a Fixes tag for this?

> Link: https://linuxcommunity.io/t/intel-ax210-speeds-capped-at-20-mbps-on=
-multiple-distros/6708/28
> Link: https://bbs.archlinux.org/viewtopic.php?id=3D312952
> Link: https://bbs.archlinux.org/viewtopic.php?id=3D313033
> Link: https://www.reddit.com/r/Rogers/comments/1s89j9f/xb8_5ghz_dfs_chann=
el_broadcasting_at_54_mbps/
> Link: https://www.reddit.com/r/Comcast_Xfinity/comments/1s7fc3f/recent_fi=
rmware_update_to_wifi_gateway_breaking/
> Link: https://www.reddit.com/r/Comcast_Xfinity/comments/1sg9r6z/slow_inte=
rnet_for_linux_computers/

> +	/*
> +	 * Some AP advertise 3 or 4 spatial stream MCS indexes in their basic H=
T-MCS
> +	 * set. On cards with lower (2x2) spatial streams, the check would fail=
, and
> +	 * we'd be stuck with no HT when it in fact work fine with 2-stream rat=
e. So
> +	 * check it only in strict mode.
> +	 */
> +	if (!ieee80211_hw_check(&sdata->local->hw, STRICT))
> +		return true;

And generally we prefer to have some indication in the comment which APs
were affected (though I see the VHT one also didn't have that), such as
in ieee80211_verify_peer_he_mcs_support().

johannes

