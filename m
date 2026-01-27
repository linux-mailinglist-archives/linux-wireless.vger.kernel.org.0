Return-Path: <linux-wireless+bounces-31204-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDAJNwhyeGnEpwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31204-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 09:06:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6010090EB8
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 09:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 594923060BC0
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 08:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347C325F988;
	Tue, 27 Jan 2026 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IiQl1Lpv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD29222575
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769501044; cv=none; b=q3/TPKT1HAlFILMDZPlT+/B/LlelulxRHWPgI4qPdRsVJqWjBHy5Z8J7yYA0u1Ap16ZrvMz8f6i6+UG9lbfv4t437UCGg6yH76saR7GbARrO5gMsIdW7NELQjdveB7/b7/kfekjoV3PNf+w6zsb6+uelhF+fTPUWPWx+dRt55/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769501044; c=relaxed/simple;
	bh=KTxBaMxVH5HcFrUxJ94xCY6FhDwss8FZi2VkC4Tq77E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rn+wvmFLxq7rHTL/uYaEBsXFKkKnyovyyLMGOLESWV6p2PfzUmppkP0Nn5ukyIiWa9Oo63yMXka+TQGOhHB+LAE4nE9mgyqV8DUAXx8nxPbBzJd7zgxy1FP5fYCYFtHH1hM/t+LkSdjo2OKcs9bLQJRxZx3EQVehLrCOsBNeL4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IiQl1Lpv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=h+1+uhzaNgtaSPXCQF2LP7SSvxe54i1i/2urVLgEc/g=;
	t=1769501042; x=1770710642; b=IiQl1Lpv4tuBqhPs/AAd791SLk5G2GFJvP6/RVE3TczjOlA
	gcxy5qmuRbksWSHKs7HSR2HHdj9inBQe7Fi/xbnQgRmflKiVu3dX6I6A4TSs9P0RN+YtEov7JcJmQ
	Pobt4T515wxX43SVxEeI6RVPBA8FKe1N9T4qxVkMqybVvuah8tCt/kdWoXlI9keZcB6tJwmXm4ysM
	7vH6CkbfFSGLNFyU5SLboROJ+RVYklS095x0y9Tx7TNCXwWPKNu7yjMrJCimHEsFplZP4CRadstt1
	pAnDccIwOMky57Xf5p5rUkZQgIymW4WvPGiZoESf9xJrb7dWYNY+IplNtNPMvoxA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vke3I-00000004tNs-02NE;
	Tue, 27 Jan 2026 09:03:56 +0100
Message-ID: <b592a6c9a8f59f112b2221b9a46568769b1e9dcd.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 1/2] wifi: mac80211: Add eMLSR/eMLMR
 action frame parsing support
From: Johannes Berg <johannes@sipsolutions.net>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, 	linux-wireless@vger.kernel.org,
 Felix Fietkau <nbd@nbd.name>, Shayne Chen	 <shayne.chen@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Date: Tue, 27 Jan 2026 09:02:28 +0100
In-Reply-To: <aXftjdCtqnQk69ys@lore-desk> (sfid-20260126_234123_580390_07BE70DF)
References: <20260125-mac80211-emlsr-v2-0-466329d61c88@kernel.org>
	 <20260125-mac80211-emlsr-v2-1-466329d61c88@kernel.org>
	 <01e62344994a34daae0666b3873aa98e72fb5850.camel@sipsolutions.net>
	 <aXftjdCtqnQk69ys@lore-desk> (sfid-20260126_234123_580390_07BE70DF)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mediatek.com,gmail.com,collabora.com,vger.kernel.org,nbd.name,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-31204-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 6010090EB8
X-Rspamd-Action: no action

On Mon, 2026-01-26 at 23:41 +0100, Lorenzo Bianconi wrote:
>=20
> > Per spec I'm also not sure what the MCS map should be when it's not
> > included in the frame?
>=20
> IIUC the mcs map value are supposed to be in Operation mode notification =
frame
> just for eMLMR. I think the driver should check if the bit is set in
> ieee80211_eml_params control field to verify if mcs_map_bw values are val=
id.

Yeah you're right, the MCS Map is always present if EMLMR Mode is set to
1. I thought it was also optional and then what values should you use?

Can't mac80211 validate the values?

> Reading the standard, it is not clear to me if mcs map values are suppose=
d to be
> added in the Notification frame sent by the AP. What do you think?

Hmm. I thought no, but then the language says it's present when the
EMLMR Mode is set to 1, so ... it would have to be? Strange, because
it's not really defined (well) in this direction.

OK, I guess the memcpy was right after all:

   An AP affiliated with the AP MLD that receives an EML Operating Mode
   Notification frame from a non-AP STA affiliated with the non-AP MLD
   should send an EML Operating Mode Notification frame to confirm the
   mode switch at the AP MLD to the non-AP STA with EML Control field
   set to the same value as EML Control field in the received EML
   Operating Mode Notification frame from the non-AP STA before the
   transition timeout expires.

But I think better restrict memcpy() then to just the EML Control field
and build the action header etc. directly.

johannes

