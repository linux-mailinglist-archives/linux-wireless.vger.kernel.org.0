Return-Path: <linux-wireless+bounces-32725-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKSqG8cdrmnv/gEAu9opvQ
	(envelope-from <linux-wireless+bounces-32725-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 02:09:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF70A2330A3
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 02:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 789AC300B9B6
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 01:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D7D23A984;
	Mon,  9 Mar 2026 01:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Hg8ad5cK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90002264A9;
	Mon,  9 Mar 2026 01:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773018562; cv=none; b=gP2Q/IcCVdfC0k5XXDDo744rboBQyl5Nulc4IEaVZhJDptiU32A0nON2f4BcwveiKEeekQLTR/fyU7VWG1U78Ro6YU4zBYVpgdiUQ4AI98J7PA3MB04n3Mrd0NyVw+c3Ra8Qn9qFPeFrkijh/Lc0RvHyq+Yd0YebW0DQwsrrq6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773018562; c=relaxed/simple;
	bh=v7G+2m+37TO+tMCbM7G3VYZnQn6wZQ8fkiorzeUf9yc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vz5N+BiFghTtbMYvIleweEv+Wk9FP2MyEKVptAuV74IbnqbQ2SNtaJ9Uo51NME+iNBa1YImHi4rJZS9USVQsPz744sjaksYKcs0IkiODgxToiMhCqmAzJ6KZ1d26cS7jrTQWV9di4NrqbG8G8sYqzUed2mB96M2Dye4e0F/Tbok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Hg8ad5cK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62919GkB43712993, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773018556; bh=v7G+2m+37TO+tMCbM7G3VYZnQn6wZQ8fkiorzeUf9yc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Hg8ad5cK0rezTFIH7zhucJfVJMT5bTM+CzipjmiG88ogtbTXKylSFnUzwUPtT7sqY
	 y/Q3n5qofxdx5mPSA+Q6XIFF3wA07kU0JihlaZErO7jlaz5w6rrG5af9LMSDjmPDum
	 Lhyc4TWku+PMYMv0WT/lIu0F8HlTBCwD3NjqtPAmeM3rV5+7pEHzF+R0+hiQSd298e
	 mAOHxkK6RplH9fNTa6d2GQzCUciEF4u26Ax+Gu7HXi7hkjpbeOBUJehmAOxlU1A3f1
	 nHkIsRJiZOwjzq/xB120b2P5ubuGFC3u3iwnSImjzBxyVUzBdfot0je7AYXcXm/Kzh
	 sZ+vGOBm84lmw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62919GkB43712993
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 09:09:16 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 9 Mar 2026 09:09:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 9 Mar 2026 09:09:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jaime Saguillo Revilla <jaime.saguillo@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtlwifi: rtl8192d: fix typo in H2C wait counter
 names
Thread-Topic: [PATCH] wifi: rtlwifi: rtl8192d: fix typo in H2C wait counter
 names
Thread-Index: AQHcru1tPqw2KRazf0it4W8n2mMnobWlZKoA
Date: Mon, 9 Mar 2026 01:09:17 +0000
Message-ID: <31f178b62efc4316b32fb8dc888cbe98@realtek.com>
References: <20260308111850.20420-1-jaime.saguillo@gmail.com>
In-Reply-To: <20260308111850.20420-1-jaime.saguillo@gmail.com>
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
X-Rspamd-Queue-Id: DF70A2330A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[realtek.com:server fail,tor.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-32725-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-0.950];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Jaime Saguillo Revilla <jaime.saguillo@gmail.com> wrote:
> Rename local variables in rtl92d_fill_h2c_cmd()
> from wait_writeh2c_limmit/wait_h2c_limmit
> to wait_writeh2c_limit/wait_h2c_limit.
>=20
> No functional change.
>=20
> Signed-off-by: Jaime Saguillo Revilla <jaime.saguillo@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


