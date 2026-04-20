Return-Path: <linux-wireless+bounces-35011-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPSiH1+65WmwnQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35011-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 07:32:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C566C426E12
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 07:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DC2130078F8
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5E22628D;
	Mon, 20 Apr 2026 05:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Vzkl07iV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3736040DFC4
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 05:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776663132; cv=none; b=PkTEqdV3qR38RbKDfWVFhC7QTJi74/FUCRTuH7enMebb1AUz2kMKogKLkMSUpDJ++ax9oqHF37UNKs+xhuBxFtmfC17C0ytF0LP3YiafTSk/otq1qwjSvAbJfNiJ+T0NcMqMZpZGEW1A3YB1aP4uehnZ1fboQSNNOql2ED1fsfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776663132; c=relaxed/simple;
	bh=vE9d1vspqjDuP0ABRo6RyAH8FVTLMMLod3PDy1acVc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kdcRo3itcufz888PPqN6Bt1GFikKxD+9oxq8xkiJixOO34ElJTu0L44d2k6vIVRXKNNziViPvcI8GbR3gv83hL5HRcVTpb4/Cr3HhG/XQYnnFHDeViS8j0UFDclErqH3sQGCLFgUoIqhpcTdgOnkHFXc9TV39sdOFdws8EYLO9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Vzkl07iV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K5W2K10589837, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776663122; bh=M3zRbiUEpnHgLfhXlVYBMKylHr52Jgoxmuh0QSerRqs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Vzkl07iVn/fBwOdait0t//+HmvaYbFTBCErVd9BrqOVZwFWPEaKTEL32b7zRFNGGv
	 tlgu3VBfj17Ck04IEnJgtHcuC0XTFD2PwWtJgIiiADmCWbs/rmVrzeCkY6n4BDJRSb
	 hLrjBAQdOF5INojk9W8xVUmVkmELNv4VGC/IwBYWAGHcwlRglILhJnI2uErKu4t+h7
	 0uDLmhwCre52iLD51lOxoRoYeyJi9BlJI2QDvRjs64fNXvOZ9m7uR986yemLvzg5bj
	 QO27vDmTfTIkTuarEyXx937XeUQF/fGK7TrrjlNChHQj9rKlwfH+sYpKMHWEXihffO
	 OSe++1F60yW/g==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K5W2K10589837
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 13:32:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 13:32:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Mon, 20 Apr 2026 13:32:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Tristan Madani <tristmd@gmail.com>
CC: Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: rtw89: add bounds check on firmware mac_id in
 link lookup
Thread-Topic: [PATCH v2] wifi: rtw89: add bounds check on firmware mac_id in
 link lookup
Thread-Index: AQHczSamfHmuypaigkWDd7GVrTdpGLXnc3uQ
Date: Mon, 20 Apr 2026 05:32:01 +0000
Message-ID: <28b787a929674c249edec3e2bdbf6872@realtek.com>
References: <20260415222433.1545305-1-tristmd@gmail.com>
In-Reply-To: <20260415222433.1545305-1-tristmd@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35011-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C566C426E12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tristan Madani <tristmd@gmail.com> wrote:
> drivers/net/wireless/realtek/rtw89/core.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wire=
less/realtek/rtw89/core.h
> index XXXXXXX..XXXXXXX 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.h
> +++ b/drivers/net/wireless/realtek/rtw89/core.h
> @@ -6435,6 +6435,9 @@ static inline struct rtw89_sta_link *
>  rtw89_assoc_link_rcu_dereference(struct rtw89_dev *rtwdev, u8 macid)
>  {
> +       if (macid >=3D RTW89_MAX_MAC_ID_NUM)

Since this is used by data path, I prefer 'unlikely(macid >=3D RTW89_MAX_MA=
C_ID_NUM'.

> +               return NULL;
> +
>         return rcu_dereference(rtwdev->assoc_link_on_macid[macid]);
>  }


