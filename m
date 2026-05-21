Return-Path: <linux-wireless+bounces-36742-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BC5LDelDmpxAwYAu9opvQ
	(envelope-from <linux-wireless+bounces-36742-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 08:24:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C65059F619
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 08:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E65730465C6
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 06:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972362BE053;
	Thu, 21 May 2026 06:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tKbOehdT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7791A9F8D
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 06:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779344693; cv=none; b=KQV7KGbZtECRZrukAcq9SOtfbKMnDuF0LEnjaU8xP76F3BDdzU7AELSlm1IAAXw4np1uMSqU9cDBgvi24bkQfMCVyyY6omYkc9JCNtKMBXR8864afFIJGnYKMzK7/1jeefbJDBqc0x3fp5HuqTCDHSG4MhltZETfIkqF82fXfJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779344693; c=relaxed/simple;
	bh=Ej6Cz03GxKqXZSK8IInAfAOoxpzdFo3yqz6BX7IX6Fo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lAhfNPp+e3fAH+uKWFIDhwVASwvV1tLxZj05pDjp7kWGRliiBDiSLFEIP8Gaqxw7XH6C/0rHLmJVX9gGBcI96lOCrLy+drD8TIzoUS+XHQLDSqcw60+PSoOwXepLuws63jz4h1ENzHXq1wJUc71m2eddqTP035VVypYzvuNo6Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tKbOehdT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7fM7XIcEhf50qsZRPmbzZAUlBoutHvVtx9vhlfvwt1U=;
	t=1779344690; x=1780554290; b=tKbOehdTaT0SuzmOkIfQj2T9tucDEngogm0/QCQKbvrEj0Z
	Hc61bS+6CrFtXTAJFEbx0Doka+cDcmkrCAq0U0x1PmwCnHQnPndxVTskwfb5qUkVT34ln4mIR4az9
	ewL0nYTgeCNp9Kc4WjwpHnhJJaPlQSwE5q4DO0puwFkRYTQMKTJ2EnVGel18p8/wZxPjoYdEc98/5
	eRpmfsPc4wKbF5jWll3Jo61GEzBa7SFZnOAGIwUKHq7+MGseM4qiu+2HaEoVCpO8OAGQCDM76rkEK
	VOpq0impBvwqcrGuDTF4tID+2nkWP8xrTw9g0tayGg690NLZ/4TJ1XRjWXnjTYZQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wPwpr-0000000Bf8X-2Nig;
	Thu, 21 May 2026 08:24:47 +0200
Message-ID: <93ab81b4fb7130a4d4e1048581d886568086fe24.camel@sipsolutions.net>
Subject: Re: [PATCH v6 1/6] wifi: mac80211: Use struct instead of macro for
 PREQ frame
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, Masashi Honma
 <masashi.honma@gmail.com>,  "linux-wireless@vger.kernel.org"	
 <linux-wireless@vger.kernel.org>
Date: Thu, 21 May 2026 08:24:46 +0200
In-Reply-To: <d2c051127e384a918ff014da02e37e1e@realtek.com> (sfid-20260521_024301_935117_BC310192)
References: <20260515233839.86829-1-masashi.honma@gmail.com>
	 <965eff7ec3b928f093f7891e4307ec4e4a080ac4.camel@sipsolutions.net>
	 <d2c051127e384a918ff014da02e37e1e@realtek.com>
	 (sfid-20260521_024301_935117_BC310192)
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[realtek.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-36742-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3C65059F619
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-05-21 at 00:42 +0000, Ping-Ke Shih wrote:
> > > +             orig_addr =3D preq_elem_top->orig_addr;
> > > +             orig_sn =3D get_unaligned_le32(&preq_elem_top->orig_sn)=
;
> > > +             orig_lifetime =3D get_unaligned_le32(&preq_elem_bottom-=
>lifetime);
> > > +             orig_metric =3D get_unaligned_le32(&preq_elem_bottom->m=
etric);
> >=20
> > Ok, oops, I just realized my other thought on this was wrong - the
> > previous PREQ_IE_LIFETIME() was u32_field_get() which loaded an entirel=
y
> > u32 from there using get_unaligned_le32().
> >=20
> > However, another comment: You don't need get_unaligned_le32() here sinc=
e
> > the struct is __packed, so you can simplify all of these to just
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0orig_sn =3D le32_to_cpu=
(preq_elem_top->orig_sn);
> >=20
>=20
> I think the __packed can cause unaligned.

Of course.

> Not sure if the pointer preq_elem_top can adjust offset back to be aligne=
d?
> (But I think we don't make this assumption.)

No, that's not going to happen.

The point is that __packed forces the compiler to emit code that doesn't
rely on alignment.

So say e.g. you have

	__le32 *ptr =3D ...;

	u32 val =3D cpu_to_le32(*ptr);

In this case, the compiler can emit a load instruction that assumes
alignment, so if 'ptr' can be unaligned, we need to use

	u32 val =3D get_unaligned_le32(ptr);

instead.

However, if we have

	struct ieee80211_mesh_hwmp_preq_top *ptr =3D ...;

	u32 val =3D cpu_to_le32(ptr->preq_id);

then the compiler _cannot_ emit a load instruction that assumes
alignment because of the __packed, and so the compiler has to emit a
(perhaps sequence of) instruction(s) that load the 32-bit value without
relying on alignment. As a consequence, we don't have to explicitly
write it the more complicated way and can just write it the more natural
way.

johannes

