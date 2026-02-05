Return-Path: <linux-wireless+bounces-31602-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AByWAljWhGlo5gMAu9opvQ
	(envelope-from <linux-wireless+bounces-31602-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 18:41:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46435F6104
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 18:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97DCD3038F71
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 17:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A570D2F0678;
	Thu,  5 Feb 2026 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b="PLgnULgz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.w13.tutanota.de (mail.w13.tutanota.de [185.205.69.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AA22D8390
	for <linux-wireless@vger.kernel.org>; Thu,  5 Feb 2026 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313088; cv=none; b=Gdiw0kVnANwtbiBoJez4ZPR45YQ9084Uc05hf7fGvWdmt69UMhWuFAJhZ0ZAIx8+QRXH1d5tJF0cenvuNlg0w1QSIB9PCLXEfNpz0XTvlgWQ0hLPCAos2pDYOnDsPLmFZthVudAk+g8f+3G9OBz2lR6PkasaXzXwHy9yFeFwnSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313088; c=relaxed/simple;
	bh=/vqNbfQgD2OSWBUxJq7iVsQUDj/FXcCyr6vstcJ69mQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=OaXsOE7ES20DY13w4lo8FjrL5hrNThWHCH7U5QdkZ35UdX92rqYij5mfGViQOqCroG2YJsSngnRTNDuZOvGjcPq22Gymhquv4iL2m04lu85dN4jVeIx5vF+wPIiIppE789Mt9V3n1nU5FVu8JhTENQKmx/dazfuP4lu+/GL9Qzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com; spf=pass smtp.mailfrom=tutamail.com; dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b=PLgnULgz; arc=none smtp.client-ip=185.205.69.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tutamail.com
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w13.tutanota.de (Postfix) with ESMTP id 90687108EE382
	for <linux-wireless@vger.kernel.org>; Thu,  5 Feb 2026 18:38:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770313086;
	s=s1; d=tutamail.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=/vqNbfQgD2OSWBUxJq7iVsQUDj/FXcCyr6vstcJ69mQ=;
	b=PLgnULgz1j9wSExHqe1EPx5tVIRHLipm0GBkWW7nYJuolMFHUWN3IjcVMR7pIOIQ
	mRCgenffbxBM61o5UAcOzeKgtT13VD+8O7h5tdLOWLwP3SPhNEw8t1IhpUBrNot7Z5o
	eEdkJg0urI99nSfHUDv+g8vWxh2Ib3kZPSnJNoy+biQkD4ezaeqBLt+yJhopPE4so7G
	bF5cv2Tt9F+vv0SlNlLelzIwHtZ2uL8mFFRHScqnOMid3r4YYKFMt3QqaOWiWKdNNV4
	VCaeBvPvLq7CPHzdL3+xnL4iF9wnaBgJ0EN/sEIpRHI81dn70DsvrlDhB26LvWQbuu+
	Gnly1HPLdw==
Date: Thu, 5 Feb 2026 18:38:06 +0100 (CET)
From: bubupersonal@tutamail.com
To: Linux Staging <linux-staging@lists.linux.dev>
Cc: Linux Wireless <linux-wireless@vger.kernel.org>
Message-ID: <OkisUHh--F-9@tutamail.com>
In-Reply-To: <2026020533-commotion-surfacing-e9ea@gregkh>
References: <OkiaM3C--F-9@tutamail.com> <2026020541-pectin-jujitsu-0c63@gregkh> <OkipX2h--N-9@tutamail.com> <2026020533-commotion-surfacing-e9ea@gregkh>
Subject: Re: [PATCH] rtw: btcoex: clean up style and documentation
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Feedback-ID: 01470318e6ae3d62ce10645c2cc9fb44f1577512d95fbeeead39fa860176f5cc81ee6f18345bf13b029110000d075436f39689f8ca8c644a41fe76e87399436d27:TurnOnPrivacy!:tutamail
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tutamail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tutamail.com:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31602-lists,linux-wireless=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bubupersonal@tutamail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tutamail.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46435F6104
X-Rspamd-Action: no action

Here's the correct patch.
// SPDX-License-Identifier: GPL-2.0
/**************************************************************************=
****
*
* Copyright(c) 2013 Realtek Corporation. All rights reserved.
*
***************************************************************************=
***/
#include <drv_types.h>
#include <rtw_btcoex.h>
#include <hal_btcoex.h>

#define BTCOEX_LPS_RF_ON_TIMEOUT=09100

/**
* rtw_btcoex_media_status_notify() - Notify BT coexistence of media status
* @adpt: driver private adapter
* @media_status: connection state
*
* Context: process context
* Locking: caller ensures MLME state is stable
*/
void rtw_btcoex_media_status_notify(struct adapter *adpt, u8 media_status)
{
if (media_status =3D=3D RT_MEDIA_CONNECT &&
=C2=A0=C2=A0=C2=A0 check_fwstate(&adpt->mlmepriv, WIFI_AP_STATE))
rtw_hal_set_hwreg(adpt, HW_VAR_DL_RSVD_PAGE, NULL);

hal_btcoex_MediaStatusNotify(adpt, media_status);
}

/**
* rtw_btcoex_halt_notify() - Notify BT coexistence of device halt
* @adpt: driver private adapter
*
* Context: process context
* Locking: device teardown serialization handled by caller
*/
void rtw_btcoex_halt_notify(struct adapter *adpt)
{
if (!adpt->bup || adpt->bSurpriseRemoved)
return;

hal_btcoex_HaltNotify(adpt);
}

/**
* rtw_btcoex_reject_ap_aggregated_packet() - Control AP-side AMPDU handling
* @adpt: driver private adapter
* @enable: reject aggregation when true
*
* Used by BT coexistence logic to reduce interference by disabling
* AP-side AMPDU negotiation.
*
* Context: process context
* Locking: caller holds appropriate MLME/STA protection
*/
void rtw_btcoex_reject_ap_aggregated_packet(struct adapter *adpt, bool enab=
le)
{
struct mlme_ext_info *mlmeinfo;
struct mlme_priv *mlme;
struct sta_info *sta;

mlme =3D &adpt->mlmepriv;
mlmeinfo =3D &adpt->mlmeextpriv.mlmext_info;

if (!enable) {
mlmeinfo->accept_addba_req =3D true;
return;
}

mlmeinfo->accept_addba_req =3D false;

sta =3D rtw_get_stainfo(&adpt->stapriv, get_bssid(mlme));
if (sta)
send_delba(adpt, 0, sta->hwaddr);
}

/**
* rtw_btcoex_lps_enter() - Enter low power state for BT coexistence
* @adpt: driver private adapter
*
* Context: process context
* Locking: power control serialized by caller
*
* This function transitions firmware into LPS mode. State flags are
* updated only after the transition request is issued.
*/
void rtw_btcoex_lps_enter(struct adapter *adpt)
{
struct pwrctrl_priv *pwrpriv;
u8 lps_val;

pwrpriv =3D adapter_to_pwrctl(adpt);

lps_val =3D hal_btcoex_LpsVal(adpt);
rtw_set_ps_mode(adpt, PS_MODE_MIN, 0, lps_val, "BTCOEX");

pwrpriv->bpower_saving =3D true;
}

/**
* rtw_btcoex_lps_leave() - Leave low power state for BT coexistence
* @adpt: driver private adapter
*
* Context: process context
* Locking: power control serialized by caller
*
* Ensures RF is fully powered before clearing power-saving state.
*/
void rtw_btcoex_lps_leave(struct adapter *adpt)
{
struct pwrctrl_priv *pwrpriv;

pwrpriv =3D adapter_to_pwrctl(adpt);

if (pwrpriv->pwr_mode !=3D PS_MODE_ACTIVE) {
rtw_set_ps_mode(adpt, PS_MODE_ACTIVE, 0, 0,
"BTCOEX");
LPS_RF_ON_check(adpt, BTCOEX_LPS_RF_ON_TIMEOUT);
}

pwrpriv->bpower_saving =3D false;
}

