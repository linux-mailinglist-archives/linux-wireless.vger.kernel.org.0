Return-Path: <linux-wireless+bounces-32215-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM3ZL8CHoGlvkgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32215-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 18:49:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E341ACE0F
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 18:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 959A330B9959
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 17:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A55368955;
	Thu, 26 Feb 2026 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BRmB5w6Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72A36896A
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772125800; cv=none; b=b5EaKnbjEgwS2xzdbBA+huEAxFDIlouBncGXGW3mmXQTYx7QHQBl2sg7HSizB3h6cfAWnoAYHcoHwZLncjtMhFnGpugGdrWYjWAQJ0FoQCovfUx5oixH/VsP2b2DunKBIT189ZNM0PmEFsamwwMyMkkYmXd8sPNYzd6V5Ien83I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772125800; c=relaxed/simple;
	bh=T/16ZUcKDAmOYFFJDS0ESrijk/ysXwmsI+JU0hSpiII=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L7r6HyHVmJ295lXjSAamNeSp6Rh6/owQFuWyZHetBn+O1A/2SyNLXIxbnwTagr1rhDuorB7BOrMFjL3G8HRBluoymAQDFTFOIuFL6C5t7/uytTDIcZADcAzft+zouwLmEkqpcCSlrMsQWWPcXLM6kTcWRKFw6Fmv6eZQvcGcdRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BRmB5w6Z; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=D6/9iK5hF7SwnfdYRzNGKgaFFGeGSovd9eT1g8UuAm0=;
	t=1772125799; x=1773335399; b=BRmB5w6Z+1Y76iXb53Su5mznAoiWMmcSC89uc87pXPpYv3E
	WRRhPiqCRZ4vGz5EcpslXxbVG3jq2dB87WABq79rNGwleZCKmvKn1dhCdnmWZgxPF/BnDp5azKDU7
	Ao6Q639SxoTC40CdTVsLd8P6FqfPaHSL98OPU4uCfBTWoatbx5X0lv4/WfwOpMRfE/dqSVK7T6cd/
	Sr9F9+t/Ki2uCCLhXnJhfA60KOmkurHgpTluzaTy73axAaKdOCqzag/b006SEmhQRaLg4/8d+ZC9S
	CbU4CV4y9yvdfWrFtXI/v9P48XXT4EqbkZgULP7Epge2knJ3eqNT3W/jZ4m0v7Zg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vves1-00000002VLf-1YoP;
	Thu, 26 Feb 2026 18:09:49 +0100
Message-ID: <7fa9af36361bea13b0aab325687486c990c666df.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 3/3] wifi: mac80211_hwsim: Advertise
 support for IEEE 802.1X authentication protocol
From: Johannes Berg <johannes@sipsolutions.net>
To: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 26 Feb 2026 18:09:48 +0100
In-Reply-To: <67e9955a-1287-4467-9b52-be89144effbc@oss.qualcomm.com>
References: <20260226065442.4182232-1-kavita.kavita@oss.qualcomm.com>
	 <20260226065442.4182232-4-kavita.kavita@oss.qualcomm.com>
	 <3ecb3d440ed3ab4fe4cd3765e0c8457ef58fd6b6.camel@sipsolutions.net>
	 <af15a01f-93eb-4c0f-b13d-8cea41f82703@oss.qualcomm.com>
	 <e96a1d08ab71bb75bd7a65278b04d29c609904bf.camel@sipsolutions.net>
	 <15cd54d4-a663-423b-b4c5-9a058f5bc73d@oss.qualcomm.com>
	 <916b0969c559f1faeba94bdef792da646b9b0c21.camel@sipsolutions.net>
	 <67e9955a-1287-4467-9b52-be89144effbc@oss.qualcomm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32215-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40E341ACE0F
X-Rspamd-Action: no action

On Thu, 2026-02-26 at 22:28 +0530, Kavita Kavita wrote:
>=20
> On 2/26/2026 10:20 PM, Johannes Berg wrote:
> > On Thu, 2026-02-26 at 22:19 +0530, Kavita Kavita wrote:
> > >=20
> > > Sorry, I missed one case earlier. EPPKE mandates (Re)Association fram=
e
> > > encryption support, so we should only advertise EPPKE when the driver=
 indicates
> > > support for (Re)Association frame encryption in mac80211.
> >=20
> > Oh, OK, but we could also check that in mac80211, in register_hw(), I
> > think?
>=20
> For EPPKE, I will handle it like this:
>=20
> @@ -1598,6 +1598,15 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
>                 local->sband_allocated |=3D BIT(band);
>         }
> =20
> +       /*
> +        * mac80211 supports EPPKE, if the driver supports (Re)Associatio=
n
> +        * frame encryption
> +        */
> +       if (wiphy_ext_feature_isset(local->hw.wiphy,
> +                                   NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRY=
PTION))
> +               wiphy_ext_feature_set(local->hw.wiphy,
> +                                     NL80211_EXT_FEATURE_EPPKE);
>=20
> For IEEE 802.1X Authentication, I am thinking to advertise its support di=
rectly
> from mac80211, in ieee80211_alloc_hw_nm, without checking for (Re)Associa=
tion encryption
> support from the driver.
>=20

Both Makes sense, thanks!

johannes

