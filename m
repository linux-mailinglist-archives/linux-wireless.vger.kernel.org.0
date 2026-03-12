Return-Path: <linux-wireless+bounces-33102-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGjeJk6tsmlGOwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33102-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 13:10:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3906D271773
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 13:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2B3831122C6
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 12:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E428636DA09;
	Thu, 12 Mar 2026 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="svQHp9c7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD51F3A381A;
	Thu, 12 Mar 2026 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317430; cv=none; b=V2yhP7+sIOo0q2nAYDoL6ck01ujGUo33c+Q5Un4UF4dXakH6fku9KowyJ47NuTx+g4yyVAqO6zzSBJm6E4LMglXmI0hS9hqJHsKFwvaSp7dvZk3nF6Syq09rIdfF+O2V2qfU4oEdtW0iHFlXOHZkYtxoQHZ20wlJF3DbPJohdNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317430; c=relaxed/simple;
	bh=bZwnoqdhT6xUAGlEJqzB0JMBJljeuWhnnUv6SSGJaP4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aRnGCh6itkS7iT/y24LCr9HklrJxf9KJ223OfLH7Op929TYHGHPhPtXhXz5XBEYhE1aS1YWN8Xnp+rxdq64BYMalnf5SpdGoTr4QwgChqt7P+58kEB42wsZDlEPW4JzvnLrk/rndnoWm2Ly1Hr+mDqhOpKyMmX7jS9GJWkQVURA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=svQHp9c7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nIvP4MBs3pIkVDcI62tjt2naMEia4i4a0qMpSIQlY5Y=;
	t=1773317425; x=1774527025; b=svQHp9c7lJ1KeUCArL1LyTjjD8vkpyvRh5bbPJwa0lT8Kns
	CtktfcRrcfevd34xPCi/pc9vZRjoiSePjzimSUp1etckjllqP3Nkqd3RAK9BFwVX2Q6RkDItjMzXj
	Ht3pFRUl/XrqWU5BzIpzP5f8tNno1c173fdbbK+nDgDk6AwTDGxJFky2DlmRtLpRBKd52ieuOavgy
	30yKPU2kK1LW4Jnz3OHMPr2CzPGA9FSMC0GqBfh5LA9xD6OMZB29uSAyTqosLHaT/d3bVdnz1r8pr
	ybrclS0USUb9X/kuBwUpW2Ndcxch65hjTQWW2SMrDYngCnuyvri4Ag4T37uAzc/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w0eru-0000000Fq0Q-04U7;
	Thu, 12 Mar 2026 13:10:22 +0100
Message-ID: <e8960517faf04ed4f1bf331e23a95c477113309f.camel@sipsolutions.net>
Subject: Re: ath12k: handling of HE and EHT capabilities
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Mar 2026 13:10:21 +0100
In-Reply-To: <40b4b959b2ea5afd55381e6ae2d0c1908456734c.camel@sipsolutions.net>
References: <abKBOp8Jc7f7U0T8@FUE-ALEWI-WINX>
		 <b7f4c8f1a251ea9cccb32f021828896371953143.camel@sipsolutions.net>
		 <abKbLNK0YrT6dr96@FUE-ALEWI-WINX>
	 <40b4b959b2ea5afd55381e6ae2d0c1908456734c.camel@sipsolutions.net>
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
	TAGGED_FROM(0.00)[bounces-33102-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 3906D271773
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wait ...

> > I don=E2=80=99t see this in the function. For example, the MAC capabili=
ties are a
> > `u16 *` in CPU endianness, which is simply memcpy=E2=80=99d from the pa=
rsed
> > `NL80211_BAND_IFTYPE_ATTR_HE_CAP_MAC`. Later, they are treated as `u16 =
*`,
> > as shown in the following code:
> >=20
> >     printf("%s\t\tHE MAC Capabilities (0x", pre);
> >     for (i =3D 0; i < 3; i++)
> >         printf("%04x", mac_cap[i]);
> >     printf("):\n");

That's incorrect for sure. But iw code now actually reads

        printf("%s\t\tHE MAC Capabilities (0x", pre);
        for (i =3D 0; i < 3; i++)
                printf("%04x", le16toh(mac_cap[i]));
        printf("):\n");


which is correct. HE PHY capabilities are printed as

        printf("%s\t\tHE PHY Capabilities: (0x", pre);
        for (i =3D 0; i < 11; i++)
                printf("%02x", ((__u8 *)phy_cap)[i + 1]);

in my version of the code, and it seems to me the +1 is incorrect either
way?

>         printf("%s\t\tEHT MAC Capabilities (0x", pre);
>         for (i =3D 0; i < 2; i++)
>                 printf("%02x", mac_cap[i]);

This was also correct, not incorrect as I stated, since mac_cap is u8 *,
and EHT PHY capabilities are cast to u8 * first.

Maybe your iw is just really old?

johannes

