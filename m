Return-Path: <linux-wireless+bounces-34275-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIBeLQIezWnOaAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34275-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 15:30:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3732037B41B
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 15:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F597300A32F
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2026 13:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFD542EEDE;
	Wed,  1 Apr 2026 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="t5e8U/1x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E7A42EECF
	for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2026 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775050239; cv=pass; b=UC/tMx3CJxg0sLIcHcbtEu2+AoZ4XSxLPml5eNAzfBJ8UKoSSmxMtV/Re6KVcQ7xdvFCw4fRcR7v6/9BQVV206uyQCZFAYwJIzXUq/tAtiRtLGLn5QdYwcfH+O12EBRiNrVXOEwz84WbjEYGfPSx2w0qJxS7eCo6NuSe6FbaOGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775050239; c=relaxed/simple;
	bh=BRfaxlgXcaC4MwKGbrVI1gU9LqJpM6bbpHxRtdhQuco=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Axz50gzc2YpthM4Nx+cL0y2zL5Tpc50WnceGTnlXH4xxBJphNFLheqjO8RgF3Y+TU0cR5tPuTWY8pFz/co8GZjIPW5w7UJKz10CMxiZ0Laul+5OK51N4i6SAvh2CfHxETKloq66lWGYTQD6l71zoLFdPw/fOcIKbucve2NkQeoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=t5e8U/1x; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82cdb4ab547so881592b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 06:30:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775050237; cv=none;
        d=google.com; s=arc-20240605;
        b=I3+jiAi2kvE6GB9Wr7MlirQN0ZJDgEoL/e/PW2i3m7mCnC0aazS6oT/lGGuSjdnk30
         8aAVAQoYBHSgYm+X6HS9UXaSU94kHqEagiXJMwXQQSumSjrdG3YNrGO5UOpch9ScgNS4
         oNDCn832MENhWwHRkSRocEFtskuv81ZKyIMiczqhvuxHkfmrgW62lcGQVxqzaczTaD1X
         rowNDIBHzsGWnEwks0sfzKEvJmDxszaeXFhfaFplsTJ5Pds9YaEk999VnpLXyyySHLB5
         8yXbqBvFp2yqChh+lMyqHF/7gicvWwwj5fJ2iLVWQT931zt5ffEfs38ECtAMF0OrOl6K
         nv6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=T7NuR3Bw6Qb5rckRbbyyN8y03wjGHotEoDAqQmFwpLY=;
        fh=ZOlIOAWLmVH41JYIFDNXnajIDloJeC4KxN/YvJ+SaD4=;
        b=gFPkV6qvlf1FpxA3Z0HoDdgiXbXE61cuSPqXW+BmkJ19+J9HdqTUrJRNvmtxuhNCx1
         KS3zDuj6+od0TCWA3syWHvtqfdC//bhaY7hXanSz9H5bejf18o6RPUDStiUug9rc6RsC
         DRv0mbB+ZOetBwWQxc17UnHmNRQXL4sgFzjTGrk4ozjkFefu2Gf5WYEGG3lv4oQ7zlQf
         QMeUDDWjUc+9g6G3i1rRngyzvB6RIPu+S+n9DjdEGPJ3UBhWMP5NiPHV+C8NrQJGc4uy
         ayJaT+qq5YosnpgSxbqoqgFr8ZCpkF4bHNysB8srD7RkMlcbky8l+08LphtCDIa9ZKUZ
         6+Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1775050237; x=1775655037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T7NuR3Bw6Qb5rckRbbyyN8y03wjGHotEoDAqQmFwpLY=;
        b=t5e8U/1xZ4c5uGBTHMld6TI1/QXjnvmHNjvQ5T+Jm2n39tqyd2cm+XRC/80ktQlpci
         rwYTXq4DFcshYjfrqCJrDMj7zKqNVcRhYEJ0ST2CEoenxEAV1nrUCTi6hfNPCGOjsBWY
         wIdGs9CmL/nTTFTkF99PGhOOiRuv4PmMOV8aZSTeI/QZNOqNQHIdJXIpJNW+uDoNpMoL
         IY8oqXyEEcjjIkvCzGTz7nRBahav/GlZI56TXRYFujav9hD9j4mSoQboUXjii6XL8kJq
         w/vVdsMnZ5whhHNYoj/VFtZkdMrewKh+LctrfAVHRW+2qX15m5iy3e7Eg1yuXFfLPl9I
         V3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775050237; x=1775655037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7NuR3Bw6Qb5rckRbbyyN8y03wjGHotEoDAqQmFwpLY=;
        b=iOgWpvKFJ9GN+t4rrKpl40Tp3Arpb+TuRPwjL2weSMj2LRvnuJT2g4Zt9h6fBb40Rl
         c35IXtn/+IS0ppda7R5bSvrVFgEf6w1nEhVay0zEpjT3yyxpaOeYxc764yIOqoQMhOFG
         1Um1a9aKvx3pn1RH26bw41/HBeaqbf6vrxxF4FH3reb3UGu3JvaEkFHn3vlKiK9MnP5H
         lftZ8PZHqx6/4Mk/3nWkJxMOOmiadIPaO81rRMfK/PCxB4dGSRFCycYx1ZXNaQgzslXP
         wbFbEBx2TB5LE0doSu/jOkySu4y5H18dsK+o+v8J+oSDd+e8qjnzl8e+kfOGU7V9wRqU
         RoKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB7vDqX2cBzkyY2tmmXNOG9NTpujD8lGjopEtqnGjyu2zl54eqLpPSahpS5lNn/iuInq2vh+1XqY/gkpeY/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YypUu09KnO76LU1Y4S5VzOyrh2v7MKwnFkWgAxpdCfpVaptu1fx
	xipgbkoBA320anee5P73QOWbLw80X81qdD8fJc5unWv2CBLf9lw1CEAs+6TaFmqAUdC6uouzQRT
	QkzA3UQsQP2oxxu5ptuqbKX1ku3CXZEUHrOwsx9Ae
X-Gm-Gg: ATEYQzyC4hXfkdOcVi8QR8fJYeCX29dhgpGV9jYPE9t0VedjJN7hmjln80rHF4AHNO/
	lFTlEkXXDdGM5vnYonw7XGnWJerXZ4RNxaHlkCzV5xK9EDwNpPP9oDtZD7NPvB4QaaZEKZGFmgV
	g5YC6EzUN3pA3+1qIA1aM07CR8Ti3IXp7/ttZnZf0SYmoXH5pcnHxRfwM9dEEYgiB9OW/KF+tNT
	RiGVIYkGKxK8RIb9ZNfIeslrGvzjtTiJ4LMUQWjYWp8lC4tybQVl4eMYlv4osrW7zjjdaN5+R/z
	R+fh5p23PMfSHHN6cDI20UkgiJp1gQ==
X-Received: by 2002:aa7:908f:0:b0:82c:ebbd:9eca with SMTP id
 d2e1a72fcca58-82cebbdba6cmr2579095b3a.11.1775050236598; Wed, 01 Apr 2026
 06:30:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 1 Apr 2026 09:30:24 -0400
X-Gm-Features: AQROBzBVzmwXdf2WGM_n4Zy09fnWYZkggVAvYshhunotULUmqQbgAETJrZK1gAM
Message-ID: <CAM0EoMkHo-e5Smq2yi7c4HxA1dJWzXRYkOo0A6NmbF-HkzaAgQ@mail.gmail.com>
Subject: 0x1A: Dates And Location for upcoming conference
To: people <people@netdevconf.info>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, Christie Geldart <christie@ambedia.com>, 
	Kimberley Jeffries <kimberleyjeffries@gmail.com>, LWN <lwn@lwn.net>, 
	"board@netdevconf.org" <board@netdevconf.info>, linux-wireless <linux-wireless@vger.kernel.org>, 
	netfilter-devel@vger.kernel.org, lartc@vger.kernel.org, 
	Stefano Salsano <stefano.salsano@uniroma2.it>, Andrea Mayer <andrea.mayer@uniroma2.it>, 
	Carlo Filippi <carlo@common-net.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34275-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,ambedia.com,gmail.com,lwn.net,netdevconf.info,uniroma2.it,common-net.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,netdevconf.info:url]
X-Rspamd-Queue-Id: 3732037B41B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This is a pre-announcement so folks can plan travel etc.

Netdev conf 0x1A will be a hybrid conference.  We will update you with
the exact coordinates in the near future.
Either watch https://netdevconf.info/0x1A/ or join people@ mailing
list[1] for more frequent updates.

Netdev 0x1A is scheduled to be in Rome - Italy July 13th-16th.
Location: Universit=C3=A0 Roma TRE - Via Ostiense, 236, 00144 Rome RM, Ital=
y

Be ready to share your work with the community. CFS coming soon.

sincerely,
Netdev Society Board:
PJ, Roopa Prabhu, Shrijeet Mukherjee, Tom Herbert, Jamal Hadi Salim

[1] https://lists.netdevconf.info/postorius/lists/people.netdevconf.info/

