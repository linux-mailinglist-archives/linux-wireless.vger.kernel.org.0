Return-Path: <linux-wireless+bounces-34502-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJrWJMq01Wn78wcAu9opvQ
	(envelope-from <linux-wireless+bounces-34502-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 03:52:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCA33B61D9
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 03:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 017A43042D3D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 01:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D67346E58;
	Wed,  8 Apr 2026 01:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ngMvSYaA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A2F7261A
	for <linux-wireless@vger.kernel.org>; Wed,  8 Apr 2026 01:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775613107; cv=none; b=MrYD1gYf/NtJ5/EvDZd3dEfcJX2MxtF7Z7kXpTr4NE9OERuh8cIDOiSiN+8V/dT4w13m3viK7w68OyaUb0Tc3lOjRMWSfejaLXDVBEd8sK2di2I5sEMf2GhskqFXf/X5wegOfoNqu3GvQfBJVKtmTCYY+3Qg3FOfyMCyUU5DPCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775613107; c=relaxed/simple;
	bh=EIdcxUD6TDXFFcjNgjwtQGY1LaZbUn0OLIabH3FfXVc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mbOApDwBP8XI2+kb57NoHvzn24F6XjLgZMggAyeeeJ9AcucUS7FFMAz+gfKNnzap99U5xBaso+UiuVY38+MW3vfImn5uO6RfXeaelzD4x6CFuQ8bF8NFuusfKsgmQWUFr0WhHaQ2GMWqvoRkaD10Ckj+ABEPuvEs5XVhZEHpm68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ngMvSYaA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6381pT8X12239392, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775613089; bh=EIdcxUD6TDXFFcjNgjwtQGY1LaZbUn0OLIabH3FfXVc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ngMvSYaAKD20W2JMXAX4Hai0H41KWXfdFQ6kZHAtjm6bMiLiyUsoTbIv6vWAcSGNM
	 kcO1Yy4uJv97DwPCHCV7ssGRgdE3z6NCLKCVF6T98JHIoUXHsVgf50yzNTMjoRwww+
	 UYWWW4hBre7ixw8+vvvEjqudw/vqyM2p71ypW44Ao4AoL1e/xYtXuRxiAx2SF+HCz5
	 fjKyTuDxi7P35lf3Deks+hSzoQfthEVyFNhagPFC/+rWeFnmJytYr6OzEpyHL8rWjN
	 j5vjF7DfpJcYkfkb0W/MXtk59Poz6dOMQfXPzY2ZrGVPN/cz8RrLlemG6zRm757TG2
	 VQm3wZoye41DA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 6381pT8X12239392
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 09:51:29 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 8 Apr 2026 09:47:35 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Wed, 8 Apr 2026 09:47:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
CC: "colin.i.king@gmail.com" <colin.i.king@gmail.com>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>,
        "bhelgaas@google.com"
	<bhelgaas@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2] rtlwifi: rtl8821ae: Remove dead code in
 rtl8821ae_update_hal_rate_table()
Thread-Topic: [PATCH v2] rtlwifi: rtl8821ae: Remove dead code in
 rtl8821ae_update_hal_rate_table()
Thread-Index: AQHcxoruI49Od4zxEkWwwprKfDUi5bXUZisg
Date: Wed, 8 Apr 2026 01:47:35 +0000
Message-ID: <afdf238598d347bba11f8eaae1ff0a98@realtek.com>
References: <20260407123427.14612-1-chelsyratnawat2001@gmail.com>
In-Reply-To: <20260407123427.14612-1-chelsyratnawat2001@gmail.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34502-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,google.com,arndb.de,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0CCA33B61D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Chelsy Ratnawat <chelsyratnawat2001@gmail.com> wrote:
> The variable 'mimo_ps' is initialized to IEEE80211_SMPS_OFF and never
> modified throughout the function. This makes the condition checking for
> IEEE80211_SMPS_STATIC always evaluate to false, rendering the entire
> if-branch unreachable dead code.
>=20
> The error was reported by Coverity Scan.
>=20
> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


