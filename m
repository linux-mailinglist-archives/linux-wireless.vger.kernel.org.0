Return-Path: <linux-wireless+bounces-28218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F8CC04BFC
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 09:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D39AF34F8C5
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 07:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD9A2E7178;
	Fri, 24 Oct 2025 07:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UlR6HSho"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9154F2E6CCE
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 07:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291403; cv=none; b=S4M6+DL0ra7Rsfb0iKfrhWTqCAfF/QnWGLD33gN68FssWVNVNVnJ9mpaBNn8ulNrZ8DllV0zuTcTvUV911i0OWn9wOLPNzoxMJ3BE+G7WLhUjupyJBmYI0vgfcafd72BOHOtAcYKu39O+XfCKqJLWIwuEkFzVGluq50iCSTo/sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291403; c=relaxed/simple;
	bh=bCqaM+5tMnrCNGM7zdEdZY1VsIMFr7ZwdzNUWWEH8kU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OyKAqw6nmFk2acyLCx26/Sa173w2/OccFQaqDpQK1zLtjRXuh3kkeC7Y9R/fWMuDdPGxuBo6azXx9ipGQo2owCnJOMu5TDPNPTCWJ87owbiTIHMMzDEXGFmaMr3vcsnWb8INHaUoG5WG8r6crwW0eWzd2ugNxYaQO4/n6QZ2hmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UlR6HSho; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bsEYSr4v5+VmX/FgprfPbXQhNMByRkluP/B9UxZgZGk=;
	t=1761291401; x=1762501001; b=UlR6HShoOXPrXFzdqCyMIaOI0UViCkXEFysr9SSFZffsIAx
	ea+7Dz7RJ7xxACPR48gTKnLUKRiPFQN6HZ0Moq/CSI+028Jp/1DlaMrMLHMf0jXT/m9wBvnHt/Sin
	ilFJphzNxvTMXPdd6Ssnq/m7PcOA0PvtHRvbVHTyaqvAMBLZEuaTmgHuA6g5ZaUOhqD8LKy3Vnfwt
	EAbRWPTWAB2Y6KZlxtEietiNYefvUDzGQy6/s2lGMjXBTrnaGmYgkSiHhnW168nnmeptoJPyhuAJF
	86CJsCRBFOsDEMaG7h6z5Sf+F3im/KxmSamkxzKy7nIrdTMsBB6NgRNYsrJ0PbOg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vCCLm-00000002Ij5-2r11;
	Fri, 24 Oct 2025 09:36:38 +0200
Message-ID: <ccef9238eaced219bf7526a30e8ee0acb54ea282.camel@sipsolutions.net>
Subject: Re: [PATCH RFC wireless-next] wifi: mac80211_hwsim: dont perform
 rate validation for S1G
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Fri, 24 Oct 2025 09:36:38 +0200
In-Reply-To: <e3fl4s2at6oz5rtvurivxormmndj22l3h2dkqovhnhj5u6fw2q@c65nw3shnxcl> (sfid-20251021_053610_768426_4DF09D77)
References: <20251008014006.219605-1-lachlan.hodges@morsemicro.com>
	 <0f82718459bc6e31238f1189f8f5bfc859b59a3e.camel@sipsolutions.net>
	 <e3fl4s2at6oz5rtvurivxormmndj22l3h2dkqovhnhj5u6fw2q@c65nw3shnxcl>
	 (sfid-20251021_053610_768426_4DF09D77)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-10-21 at 14:36 +1100, Lachlan Hodges wrote:
> > > If an S1G driver is submitted it
> > > would be considered a "modern" driver and would probably contain its =
own
> > > rate control. There has been some S1G hostap work recently submitted =
[1]
> > > though it's only STA side though this will need to be fixed in order =
for
> > > proper tests to be run.
> >=20
> > I'm not sure really to be considered "modern" you need driver/firmware
> > rate control, but I'd assume a new driver were to do that anyway :)
> >=20
> > So overall it seems reasonable to mostly ignore the rate control issue,
> > but maybe it'd make more sense to be "cleaner" about it, maybe
> > separating out something like HAS_RATE_CONTROL to be per station, i.e.
> > letting drivers somehow (not) set WLAN_STA_RATE_CONTROL?
>=20
> I do agree - I have some initial rough thoughts -
>=20
> Separating out HAS_RATE_CONTROL to be per station rather then per wiphy
> seems to be a major change for just this single case?=C2=A0

Yeah, that's true.

> Now Im not sure what
> Wi-Fi8 entails (heh) but I also understand it's best to do this properly =
rather
> then some S1G specific hack.

WiFi8/UHR isn't going to change anything in this area, it's not really
any different from WiFi7/EHT wrt. this.

> It seems that introducing a flags parameter into the ieee80211_link_sta w=
here
> drivers can apply the inverse i.e LINK_STA_NO_RATE_CONTROL or something s=
imilar
> that before drv_link_sta_rc_update() is called the flag can be tested, so=
mething
> like, for example within rate_control_rate_update():
>=20
> [...]
> 	if (sta->uploaded && !(link_sta->pub->flags & LINK_STA_NO_RC))
> 		drv_link_sta_rc_update(local, sta->sdata, link_sta->pub,
> 				       changed);
> [...]
>=20
> Then w.r.t setting the flag, we could introduce a new function that gets
> called within mac80211_hwsim_sta_add() called mac80211_hwsim_link_sta_set=
_flags()
> or something where it could enumerate the links of the ieee80211_sta and
> apply the flag to the link with an S1G band channel context?
>=20
> The reason for it being driver-facing is that any future upstream S1G dri=
vers
> may make use of the .sta_rc_update() callback.

But the .sta_rc_update() call is desired/needed either way (if
implemented) - the issue is about the _other_ side of this, "if (ref &&
ref->ops->rate_update)", no?

So I'd rather think we need something like

static int sta_prepare_rate_control(struct ieee80211_local *local,
                                    struct sta_info *sta, gfp_t gfp)
{
        if (ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL))
                return 0;

+	if (something new here)
+		return 0;
+
        sta->rate_ctrl =3D local->rate_ctrl;
        sta->rate_ctrl_priv =3D rate_control_alloc_sta(sta->rate_ctrl,
                                                     sta, gfp);
        if (!sta->rate_ctrl_priv)
                return -ENOMEM;

        return 0;
}


However, an issue is that the "something new here" can't check a per-STA
flag because this happens before the driver is actually told about the
station.

I suppose the easiest way, if a bit special to hwsim, would be to add a
specific flag for S1G, so that "something new here" becomes just

	on_s1g && ieee80211_hw_check(&local->hw, HAS_S1G_RATE_CONTROL)

(where on_s1g needs the sdata passed to the function and the chanctx
checked)

Then hwsim can sort it out or even just call rate_control_send_low() for
that all the time (which has a TODO for S1G buried, but that probably
needs addressing either way eventually.)

johannes

