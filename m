Return-Path: <linux-wireless+bounces-34325-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFzJGlGaz2lKxwYAu9opvQ
	(envelope-from <linux-wireless+bounces-34325-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 12:45:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CED39363C
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 12:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E48F3017C18
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2026 10:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44AB382F2C;
	Fri,  3 Apr 2026 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waelti.dev header.i=@waelti.dev header.b="MITlxjB3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E64B31F9B0
	for <linux-wireless@vger.kernel.org>; Fri,  3 Apr 2026 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775213016; cv=none; b=O5rtvQwSnSVOva5zohnmyo1t0zSe1ieGH1PyJztl7P5FOfY74+WIwDoBjSwvZm0Lmm2lMCH3XAOkoRg6YX0ZqelsE3/R+e85/iFTy6dGgZa8/nGrbwFchw/vmQOewAXpP95DBeglakaYi5dynkQd/bodVfXZiXA1E6sZCNqr0QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775213016; c=relaxed/simple;
	bh=xqZHY3V7itTFO+IX1Mj/dqhkV2SzEOHU2rfLnG3hASc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohYWClpPvJ76RsxdxhjDvsvNyZWHxvUfnsu021IQU/f0jKSl8kzFa8a5/9ng1NG0SxAg7PNIJIUD/M9u1MNUS/udClVrj2bRgw0SnKHH4JW0MdqViqOxujAlDXeWWSzSibBlCoSXlJBZAWsEP6QpDsaLgiSf52ZqlNkd1Oc09pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=waelti.dev; spf=pass smtp.mailfrom=waelti.dev; dkim=pass (2048-bit key) header.d=waelti.dev header.i=@waelti.dev header.b=MITlxjB3; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=waelti.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waelti.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=waelti.dev;
	s=protonmail; t=1775212999; x=1775472199;
	bh=FB7KSMdyVfXocN8g+BKAJyQ0ciIUy6vmUSrkAXSCxtQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MITlxjB3ljhopir2/MeRgi+28ClFnlN5+I998ULCN0j3IDTF7W5wYZpxaszLHou09
	 wR39/b4FK3wtDM1PVyk/tvNB+EGgJc/gIvaWvYi8xxYdaqyQnl3Es5mNnwwBATE6l2
	 NR5GnmywbkLJpNBeu7vbAhqBHFOBHHh4tSXiW3GgRmkLVrvaGkIKCQUaFNxwmVnMMS
	 5sywmydWWEOtgr909gIyP1qljtHkvYfNc3d0jACZzT4mJJChq9K2XQnNrR4SVKIpRw
	 YkKRHDCo3DB8TboTbnMRtaCnf7MGabYbntitbvXdsIrDBMG7NI0G+w9r7SQhY1C1pY
	 Qed8G6UjizrWw==
Date: Fri, 03 Apr 2026 10:43:16 +0000
To: Ping-Ke Shih <pkshih@realtek.com>
From: =?utf-8?Q?Jeffrey_W=C3=A4lti?= <jeffrey@waelti.dev>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: wifi: rtw89: rtw8922ae: HWSI bus lockup during RF recalibration on AP bandwidth change
Message-ID: <dFJeMTbWtJdpQXoZpQRv85Z8BumU9LW5xY5D4Hnuri6Zez_Gkk8XL6zNEuCFN1djAEqsTA9-mJb1ygNXX-V72HL4Q3Vit_1JY1-xBHBm5SQ=@waelti.dev>
In-Reply-To: <nPBjkph3lQo2eiuYIDyn7Mx8rg_pYRHNkQ-yyIVecS7isXyz4KC77Kud29sqnGKgCVgZS_IM1Jj28gx1RN4iaLuyKhS_MZVUnXhy-BVGCfQ=@waelti.dev>
References: <SnJ_b28_Uro9Xtlb2ew62uypaut_7wD44Qnmibm2Yj4FgSS7cayhZvqkK8-AXGNAc-xdwYST6E2GDCMcoZh33PjukvAsXwaqMzx8Z14_aA0=@waelti.dev> <8bf447cc627746cca6eb30ae283bbbe6@realtek.com> <uyjP590fzro7xuECRhUp6nlegi4hnWSBbrrFd-tcCcKeeKbDaoUThi7EkMNUMC2LYibyA0jaAqR7GrIchbJcGVh5CSgiGa39jMQkLq5F9QY=@waelti.dev> <f387614466ce497fb59d4ad98ef641f5@realtek.com> <JSFJ7Do8YsCSMLsXH6KLXADJ0-z0Dh-y99PpaSCHiCwp6aikxldPnTr9mXpEAifNezf2gFyPPiHIaobekBeqiM4XVpO8hYKyXvuei4lKVc0=@waelti.dev> <4b0f77fcdaf74da5a1c5e77b83f972df@realtek.com> <nPBjkph3lQo2eiuYIDyn7Mx8rg_pYRHNkQ-yyIVecS7isXyz4KC77Kud29sqnGKgCVgZS_IM1Jj28gx1RN4iaLuyKhS_MZVUnXhy-BVGCfQ=@waelti.dev>
Feedback-ID: 168448313:user:proton
X-Pm-Message-ID: 7bd4e5b07a186e990076b9762f002891577f682a
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[waelti.dev,quarantine];
	R_DKIM_ALLOW(-0.20)[waelti.dev:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34325-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrey@waelti.dev,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[waelti.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,waelti.dev:dkim,waelti.dev:email,waelti.dev:mid]
X-Rspamd-Queue-Id: A1CED39363C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jeffrey W=C3=A4lti <jeffrey@waelti.dev> wrote:

> Ping-Ke Shih <pkshih@realtek.com> wrote:
>=20
> > Jeffrey W=C3=A4lti <jeffrey@waelti.dev> wrote:
> > >
> > > Ping-Ke Shih <pkshih@realtek.com> wrote:
> > >
> > > > Jeffrey W=C3=A4lti <jeffrey@waelti.dev> wrote:
> > > > >
> > > > > <pkshih@realtek.com> wrote:
> > > > >
> > > > > >
> > > > > > Please try to disable power save and ASPM by
> > > > > > 1) iw wlan0 set power_save off
> > >
> > > I'm sorry, this is my first time interacting with the mailing list an=
d I overlooked the other instructions.
> > > It seems like disabling power save gets rid of the issue of Wi-Fi tim=
eouts. I haven't been able to
> > > reproduce the issue with `iw wlan0 set power_save off` yet, even with=
out any of the other fixes on kernel
> > > 6.19.10 and 7.0-rc6.
> > >
> > > > > > 2) reference and install
> > > > > https://github.com/lwfinger/rtw89/blob/main/70-rtw89.conf
> > > > > >    and then cold reboot.
> > > >
> > > > Have you tested with these conditions?
> > >
> > > Using this patch eliminates the issue of Bluetooth devices disconnect=
ing, when switching between
> > > networks.
> > >
> > > > [...]
> > > >
> > > > > >
> > > > > > Please help to test the latest kernel 7.0-rc with additional pa=
tch [1].
> > > > > >
> > > > > > [1]
> > > > > https://lore.kernel.org/linux-wireless/20260310080146.31113-4-pks=
hih@realtek
> > > > > .com/
> > > >
> > > > Have you also applied this patch?
> > >
> > > I tested kernel 7.0-rc6 with this patch applied on top for ~1 day now=
 and haven't been able to reproduce,
> > > even with power save enabled. However, it is a bit difficult to relia=
bly trigger the issue as it seems
> > > to trigger more on certain networks than others etc.
> > >
> > > > > >
> > > > > > Ping-Ke
> > > > > >
> > > > > >
> > > > >
> > > > > Thank you for coming back to me so quickly, I just encountered th=
e same thing
> > > > > with kernel 7.0-rc5.
> > > > >
> > > >
> > > > Please confirm my questions above.
> > > >
> > > > Ping-Ke
> > > >
> > > >
> > >
> > > In summary:
> > > - Disabling power save seems to stop the timeouts but Bluetooth issue=
s remain
> > > - Disabling ASPM features fixes the Bluetooth issue
> > > - kernel 7.0-rc6 with the additional patch fixes Wi-Fi timeouts but n=
ot the Bluetooth disconnects
> > >
> > > I hope that answers your questions.
> >
> > It looks like additional patch can fix the WiFi timeouts problem, and
> > disabling ASPM feature can fix Bluetooth issue. I think you can keep
> > (2) + (3) setting as workaround.
> >
> > I'd talk with BT coexistence team internally to figure out the cause
> > of Bluetooth disconnection.
>=20
> As always, thank you very much for coming back to me so quickly and worki=
ng on a fix. Please do let me know if there is any progress on the issue or=
 if you need any more help testing a patch.

Hi again,

I'm sorry for coming back to you so quickly once again, but I am sad to rep=
ort, that I just encountered the same issue again with kernel 7.0-rc6 and t=
he custom patch applied. After resume the Wi-Fi connection ran at less than=
 1/100 of the expected speed and wouldn't come back up, until I reconnected=
 to the same network. It seems like just the custom patch was not enough to=
 fix the underlying issue, but it did fix the HWSI lock up. This is what dm=
esg tells me.

[126462.035430] PM: suspend exit
[126465.615935] wlan0: authenticate with 68:67:c7:2a:20:43 (local address=
=3D7c:fa:80:c3:5b:f9)
[126465.615944] wlan0: send auth to 68:67:c7:2a:20:43 (try 1/3)
[126465.634818] wlan0: send auth to 68:67:c7:2a:20:43 (try 2/3)
[126465.654072] wlan0: send auth to 68:67:c7:2a:20:43 (try 3/3)
[126465.673115] wlan0: authentication with 68:67:c7:2a:20:43 timed out
[126466.065780] wlan0: authenticate with 68:67:c7:2a:20:42 (local address=
=3D7c:fa:80:c3:5b:f9)
[126466.065789] wlan0: send auth to 68:67:c7:2a:20:42 (try 1/3)
[126468.082718] wlan0: send auth to 68:67:c7:2a:20:42 (try 2/3)
[126470.107802] wlan0: send auth to 68:67:c7:2a:20:42 (try 3/3)
[126471.070743] wlan0: aborting authentication with 68:67:c7:2a:20:42 by lo=
cal choice (Reason: 3=3DDEAUTH_LEAVING)
[126474.858695] wlan0: authenticate with 68:67:c7:2a:20:43 (local address=
=3D7c:fa:80:c3:5b:f9)
[126474.858705] wlan0: send auth to 68:67:c7:2a:20:43 (try 1/3)
[126474.879430] wlan0: authenticate with 68:67:c7:2a:20:43 (local address=
=3D7c:fa:80:c3:5b:f9)
[126474.879439] wlan0: send auth to 68:67:c7:2a:20:43 (try 1/3)
[126474.884633] wlan0: authenticated
[126474.885578] wlan0: associate with 68:67:c7:2a:20:43 (try 1/3)
[126474.899521] wlan0: RX AssocResp from 68:67:c7:2a:20:43 (capab=3D0x1011 =
status=3D0 aid=3D20)
[126475.002744] wlan0: associated
[126475.002799] wlan0: Limiting TX power to 23 (23 - 0) dBm as advertised b=
y 68:67:c7:2a:20:43
[126490.802365] ideapad_acpi VPC2004:00: unexpected charge_types: both [Fas=
t] and [Long_Life] are enabled
[126627.760736] ideapad_acpi VPC2004:00: unexpected charge_types: both [Fas=
t] and [Long_Life] are enabled

(Here I decide to manually reconnect to the same network)

[126737.556015] wlan0: deauthenticating from 68:67:c7:2a:20:43 by local cho=
ice (Reason: 3=3DDEAUTH_LEAVING)
[126738.215678] wlan0: authenticate with 68:67:c7:2a:20:43 (local address=
=3D7c:fa:80:c3:5b:f9)
[126738.215697] wlan0: send auth to 68:67:c7:2a:20:43 (try 1/3)
[126740.272244] wlan0: send auth to 68:67:c7:2a:20:43 (try 2/3)
[126740.291264] wlan0: authenticate with 68:67:c7:2a:20:43 (local address=
=3D7c:fa:80:c3:5b:f9)
[126740.291271] wlan0: send auth to 68:67:c7:2a:20:43 (try 1/3)
[126740.293310] wlan0: authenticated
[126740.294214] wlan0: associate with 68:67:c7:2a:20:43 (try 1/3)
[126740.303679] wlan0: RX AssocResp from 68:67:c7:2a:20:43 (capab=3D0x1011 =
status=3D0 aid=3D21)
[126740.409430] wlan0: associated
[126740.409517] wlan0: Limiting TX power to 23 (23 - 0) dBm as advertised b=
y 68:67:c7:2a:20:43

I will resume testing with the power save function turned off, to check if =
that still is a working workaround for now.

Jeffrey

