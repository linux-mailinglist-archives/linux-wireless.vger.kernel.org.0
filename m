Return-Path: <linux-wireless+bounces-31926-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCaLH0lRlGktCQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31926-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:30:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5B114B5DD
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 843BE300DEC1
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 11:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D134A333732;
	Tue, 17 Feb 2026 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="e2opKpaw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D49B333451;
	Tue, 17 Feb 2026 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327813; cv=none; b=JW8jN3ptg9rYG6H/r8b868iMb+ct+7J9hYVGXlulapDgkBUu4bAzIGvxeXwbbyKefP95RwzMTGoEeTnzjTyNwaV9H4rpmfCGcsuWnLzkK7bxqu/Ed2+7llNNTdlMFfzmqGLZhIXJ425pzxEDaeey+rg/fC1TwwZ6trY8NEQzC0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327813; c=relaxed/simple;
	bh=s5gTHzJS4ZkvAIZo/pnV2eSzjkSXP7QJmPwkLQ7dlNU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WcOmN8Nebj5MvScy1S8mgTyEhF2rMBvGIhhpOAnu8R326mmbQdsRNB9p8UxURK5SNOavTsKps/bT6E4ohYVBwcXHfxvV/Zmhhvnv0DvOXeiCvtWCu/FF0cyTFhfJ6LLUNCZiXe5Abd+AlylMSvmpCZ4mb/YhJNUbl1fhmNRzDK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=e2opKpaw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LWQZN1sc3uNl027SKJpZP5bHdGEpLmDtsOVKdhh9rd4=;
	t=1771327812; x=1772537412; b=e2opKpawfG8hBWtASaQyPKjGpB83pQ08t39LrFVFpKzX4dh
	01TrTCfSu/+Eab9x1ekmo2bZaOaQDbW+NKI4oYNCrR/GSabtbXBgtIrmfklIFHJ0mELM4BvFeb7mm
	y/mTFKelbIuTSm/Ny9rdttVmnH8+nqfevfm563ZC34jLly17/Vgp2VYtmeMxO2YxrgWamQI/BESZs
	QDodRP8auLf4I52moTarj12Ji1Y3lzVxfcxA9vkge4srn0WkQ2QHHAhsA4BrboqxO7QPEqacYHWqi
	l+wwHWQ+7chg1zS7aSYqRwi0cV7RySprVnOLr8ADEx3sHfqPhJvIpH24XQagmeNQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vsJHN-0000000BMWU-3A6u;
	Tue, 17 Feb 2026 12:30:09 +0100
Message-ID: <f1243e86eea72999581d33c6f97ff9015ce71542.camel@sipsolutions.net>
Subject: Re: [PATCH wireless] wifi: mac80211: Fix ADDBA update when HW
 supports reordering
From: Johannes Berg <johannes@sipsolutions.net>
To: Remi Pommarel <repk@triplefau.lt>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 17 Feb 2026 12:30:08 +0100
In-Reply-To: <5806bab7e46506d3c300ab4eb66989d42936aeb0.1771323902.git.repk@triplefau.lt>
References: 
	<5806bab7e46506d3c300ab4eb66989d42936aeb0.1771323902.git.repk@triplefau.lt>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31926-lists,linux-wireless=lfdr.de];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+]
X-Rspamd-Queue-Id: 1F5B114B5DD
X-Rspamd-Action: no action

On Tue, 2026-02-17 at 11:36 +0100, Remi Pommarel wrote:
> Commit f89e07d4cf26 ("mac80211: agg-rx: refuse ADDBA Request with timeout
> update") added a check to fail when ADDBA update would change the
> timeout param.
>=20
> This param is kept in tid_ampdu_rx context which is only allocated on HW
> that do not set SUPPORTS_REORDERING_BUFFER. Because the timeout check
> was done regardless of this param, ADDBA update always failed on those
> HW.

Seems like a legit problem, but

> Fix this by only checking tid_ampdu_rx->timeout only when
> SUPPORTS_REORDERING_BUFFER is not set.

that doesn't seem right? Especially the way you implemented it, it won't
even respond at all when it's an update and SUPPORTS_REORDERING_BUFFER
is set.

Seems we perhaps just need to store the timeout elsewhere?

> @@ -374,14 +383,6 @@ void __ieee80211_start_rx_ba_session(struct sta_info=
 *sta,
>  			goto end;
>  		}
> =20
> -		ht_dbg_ratelimited(sta->sdata,
> -				   "unexpected AddBA Req from %pM on tid %u\n",
> -				   sta->sta.addr, tid);
> -
> -		/* delete existing Rx BA session on the same tid */
> -		__ieee80211_stop_rx_ba_session(sta, tid, WLAN_BACK_RECIPIENT,
> -					       WLAN_STATUS_UNSPECIFIED_QOS,
> -					       false);
>  	}

Also, nit, but this leaves a blank line at the end of the block.

johannes

