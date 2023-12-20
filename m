Return-Path: <linux-wireless+bounces-1101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A291381A2E8
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 16:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E955283BAC
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 15:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1453741206;
	Wed, 20 Dec 2023 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F6LGtRol";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lNULCViz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F6LGtRol";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lNULCViz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F43540BFA
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BDF11F838
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 15:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703086970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Lt84uzYKMClfMYnrjQajLygvkJUg34stoKUbByEnYtk=;
	b=F6LGtRolyIqmivkIYjb5bpbkuFSWGcdMT5c15nDHss7tMosjCV87XEaxWnTkQp9x9mZpwe
	YCSWeBdTZE8eFRzq3K8wtAVb5qCOeyzMjpmO9AmACNjxNrZB1v2+HNfWc/LuvZWGeSgYX0
	hs+dv4pTn1pXXrYXaVXYOtZv0l5fCNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703086970;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Lt84uzYKMClfMYnrjQajLygvkJUg34stoKUbByEnYtk=;
	b=lNULCVizVN9BuVumG8zz8iAy9M2y2Bx5GBCeoVLIC2Voo2wKsH8gN7AsWOlF2VcK1kUHqd
	3ZSunHIFNd1EfPAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703086970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Lt84uzYKMClfMYnrjQajLygvkJUg34stoKUbByEnYtk=;
	b=F6LGtRolyIqmivkIYjb5bpbkuFSWGcdMT5c15nDHss7tMosjCV87XEaxWnTkQp9x9mZpwe
	YCSWeBdTZE8eFRzq3K8wtAVb5qCOeyzMjpmO9AmACNjxNrZB1v2+HNfWc/LuvZWGeSgYX0
	hs+dv4pTn1pXXrYXaVXYOtZv0l5fCNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703086970;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Lt84uzYKMClfMYnrjQajLygvkJUg34stoKUbByEnYtk=;
	b=lNULCVizVN9BuVumG8zz8iAy9M2y2Bx5GBCeoVLIC2Voo2wKsH8gN7AsWOlF2VcK1kUHqd
	3ZSunHIFNd1EfPAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DDD613A08
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 15:42:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ZUZqBHoLg2V8NgAAn2gu4w
	(envelope-from <pperego@suse.de>)
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 15:42:50 +0000
Date: Wed, 20 Dec 2023 16:42:49 +0100
From: Paolo Perego <pperego@suse.de>
To: linux-wireless@vger.kernel.org
Subject: Interested in helping maintaining cypress wifi
Message-ID: <2quekdwievucb5nit6ryan3hnpqax2sgvj4i5xmt44o6fsfmul@otnkywddp2be>
X-Responsible-Disclosure: https://en.opensuse.org/openSUSE:Security_disclosure_policy
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6h5tf7ghiphcrno2"
Content-Disposition: inline
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=F6LGtRol;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lNULCViz
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.72 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-wireless@vger.kernel.org];
	 TO_DN_NONE(0.00)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.61)[81.95%]
X-Spam-Score: -5.72
X-Rspamd-Queue-Id: 3BDF11F838
X-Spam-Flag: NO


--6h5tf7ghiphcrno2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi list, I read on LinkedIN, Eric Curtin talking about the opportunity
to become an upstream maintainer for Cypress Wifi.

I'm really interested in joining and taking care of this.

Please tell me how to procede.
Regards,
--
(*_  Paolo Perego                           @thesp0nge
//\  Software security engineer               suse.com
V_/_ 0A1A 2003 9AE0 B09C 51A4 7ACD FC0D CEA6 0806 294B

--6h5tf7ghiphcrno2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEChogA5rgsJxRpHrN/A3OpggGKUsFAmWDC3gACgkQ/A3OpggG
KUvFMg//fgBmbEHBIJPsEZnsGqGxxJcmunTevjf3MOHs/EUqxr2OXj1o7LPo26Cr
9XXlq4nz13lFQ+eOnfEQa7y3djyFQDlB3JuJa7m/pGPNVOgMAuI1YtHTvG18+G0O
Dqmfl8vD+R3dtWSSg2gL3LRIGPSxhA/HYc4RUQnVnZph7wFS0euB5h5cC8m3cTrq
6u1lIwbthR32KmCUiUdxZpu2hLUB7hJmB83MFUa6glXuuvOk+AQh0KsGUl5eRjWP
JcjRnVyWJkSexlBy4N/1FDnnE2ABVXl8mTx6Xw/se9ev+L6bTKiPTzlY+/A7XFph
CEvdVDoIbK9l8/krdNXvdd6FGeuuzbJaEMoxOswA+cD3NTXEW6IViBTiUNXC/98N
Hrf956M9jw0GTYX9cIsYkaW5nwdgdI6SUlCei2+frFb/viON+BH87z1SZwY+gZK4
Eq0t1WUtR+a5B/+U+TcZldvSZcHUWWOUdFzacce2TjTi8nfuSqJKfQfwMxslPMrQ
w1OkLxtKGpoyUa+dO6mw5nmkwhT58Hv4dj7PRbsl6u0Fv4dj0ZJzzgFUlU3UjFyb
tcjVb+5wbiSMGiDDP6R9Ee2HgguHId+2JdF5OMQTjtmuPqOvEiXdS/8I2flug9mb
PhFxnT84vvfYB0P61n+23UH66Y0q9HHdPVwzyoQ9XbaCSTHW/yg=
=Z8wr
-----END PGP SIGNATURE-----

--6h5tf7ghiphcrno2--

