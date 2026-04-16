Return-Path: <linux-wireless+bounces-34883-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MJVOn/D4Gm8lgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34883-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 13:09:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 636A640D2D1
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 13:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF456301412F
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 11:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A7D37CD29;
	Thu, 16 Apr 2026 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oJNoYTQc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E6238CFFB
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776337789; cv=none; b=cSuyglK2jFLDCBWNwLaDHD0Vplj3YBX/1X0IVstmkwwV/pAMtoKIylAt/CYFGjQb+ap3FzBpVnXTKTVTkpXRiwBY3PYRedEHPrM4G8NF4JELKVL0ItOtb88sFIcYfBgQQng74usRDgXUqPCPP2AueoJzRiDbtqP+MVT5QMRwxSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776337789; c=relaxed/simple;
	bh=dhwSJ8E4rJx7rF70sKZt5F5PzgEr3XpjDN0PTz3AnAI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sLtsDu2KElKUoo9s9vlli4AQTNIl1q1Il66C1oiCwynL69N1JJKcBlQBsiQUKmnmHlZHoVwrlVO4JmYw5er6yqM4mGuc0gJYzGHclHRdewimgUNz43VG/Ih3ojc97B2roDRjtCcpQ9uvFh0lVf8Q/vAaprNGlL9AhQ5/y9yvQD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oJNoYTQc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jDjpf0jAxRqIFAPIzyoNs5a4Fd8Q5S6uZ9jZ5xWPmXw=;
	t=1776337787; x=1777547387; b=oJNoYTQcejFn6sUgjwjAr6KsLm71z4DLVpc6ouNn6s6rpFN
	oFCtTKmKWbloUA8Vt6GVr5eG61N4V8IwJKsft+7vbz1W5zHZ5jn97nKv+Oq7jIuXnIYN4M7hILpvN
	riknHnlupuObJ0u6PkOFO6Sl/gjIJVoNEaBBr7ZL4anzmpOUn9kOzWDR+Tzx8AQO6SRHlCPq4o8VI
	KkttqENzyD7bdUT11LAcndfXylLb0ghSVsDOy3dMpD/7an+MNqKbO3hA7fjlNKBBjK9TDOR7A9PI7
	/B1YatoJt00oHkP3RJXJn+IbEVxjzc/18glx+E0FXkXWPGg0MIJ8O6pUKnJnvDKw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wDKbL-00000007OYm-0aPG;
	Thu, 16 Apr 2026 13:09:39 +0200
Message-ID: <ee6a0a4e735b3e97fbe96a25d2af59ee0f663fc9.camel@sipsolutions.net>
Subject: Re: Wi-Fi speeds degrade from 600Mps to 30Mps while using WPA2
 security, but not on open network, shortly after ISP firmware upgrade.
From: Johannes Berg <johannes@sipsolutions.net>
To: Benson Bear <benson.bear@gmail.com>, Pablo MARTIN-GOMEZ
 <pablomg@eskapa.be>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 16 Apr 2026 13:09:38 +0200
In-Reply-To: <CACM6vn6UXfSXw2WpYvzF+ODPGHw-LtsBMgtvc6n7s9iF9eaS6Q@mail.gmail.com>
References: 
	<CACM6vn7QGKQcR5Rs=wmzNA-SgMDZX4Hw=UiPQHfYkWgLURcbAA@mail.gmail.com>
	 <b1a7678d-8e87-444e-b38a-bb7aedcd4f30@eskapa.be>
	 <CACM6vn6UXfSXw2WpYvzF+ODPGHw-LtsBMgtvc6n7s9iF9eaS6Q@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34883-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,eskapa.be];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 636A640D2D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-04-16 at 07:03 -0400, Benson Bear wrote:
>=20
> (Sadly I think I might have an idea -- it's partly my fault.   The
> mac80211 module was disabling all HT and above because it
> felt it could not meet the BCS criteria laid down by the AP.
> Many people have thought these criteria were way too onerous.
> So I first had very low speeds because of that.  No HT even.
> I applied a patch to the module that ignored these requirements
> and got back to a high connection speed, and HE or VHT
> enabled, and got back a little of the lost speed.   Clearly very
> kludgy but seems a legitimate response to what the patch
> author called "aggressive basic MCS rates". But it may
> have opened up the room for misunderstandings.  I have my
> speed back in practice, but I wonder what the "correct" way
> of fixing this would be -- without the kludgy module patch).

I think what you're referring to here might be this?

https://lore.kernel.org/linux-wireless/99Mv9QEceyPrQhSP52MtAVmz0_kWJmzqotJj=
D9YW6LGLqk-AZloAueUyHCURilFkuqOh6Ecv8i2KKdSE1ujP3AnbU5QEouVisT1w_V3xdfc=3D@=
r26.me/

johannes

