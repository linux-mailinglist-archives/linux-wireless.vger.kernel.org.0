Return-Path: <linux-wireless+bounces-38554-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dT7XEK01R2ohUQAAu9opvQ
	(envelope-from <linux-wireless+bounces-38554-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 06:08:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D546FE4E7
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 06:08:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=h1+TqFnw;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38554-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38554-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 486A930055AF
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 04:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C5F31F980;
	Fri,  3 Jul 2026 04:07:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750392F87B;
	Fri,  3 Jul 2026 04:07:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051657; cv=none; b=eXxYB1qRQ/nt4+xJuc5B8iQbarPn56NwnalMzV6zQXPxFk2/RyyN/EVqxk4jKafTdJqUd5QJ5KdaHYJ3+ui5RnaOYXcSNDu8oLgOAw0F3WFoca3BvkXf7GlFIqQ64WkEXK3q24cUxr/zfhW6WTEiih2QUuaGwbPPtvbw0kynNRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051657; c=relaxed/simple;
	bh=U3bbPkprEj4AE+nLVJNR6745Yv+oK91MOeSUhQVOhjE=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=fxuiwonoOuPJNRx3oEjow10qHrTvFOvXMo6KiRs//uFarP2QsmCd1zcC8tcLE4SDOEmmypdkljNZpW4s67VEHKoCvLUhCyO/0Wib2asKEnjSGbuFVRe5PLVfIcbeGNV4ZEaz8uAGbvt/eA95C6YVUHiyWidliQfng4WQvY0g6yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=h1+TqFnw; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66347MkbC2432564, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783051642; bh=qWTQ+WCjDbi0tmp//dLIX/gfuwxYliZaprvetgxxpiw=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=h1+TqFnw5SjxDL9DjCqjZPE06WI3IiCxf5TpKE+JF/ZUqD5SWLOiChc6Nl1zRoZ6w
	 ckkMLK/NQpPcjnqbH1uNh2CoQPf2Y9xd3dthh216w566P4osnBZRr6PxyLRM1xQnrN
	 92K5wCHh1gaCpZriZ+5K9PeIz6UBds2wJmAJvRcQVWeKGyT/H3zPINbrWkvNHUaNIa
	 lNC8y+2BYsMvlOEH/CH4qvOvawKDHCW++dfKkXVxG/7m68dmdVLxKsYgwahZp72fai
	 U6OrhVRFKio+Uk5W77wzHuEo0gXokOu2ID0qgaF6Be+mWBJF1Pz+0vmrxFwYeyqNPg
	 nUXEnU/63xkeg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66347MkbC2432564
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 12:07:22 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 12:07:23 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 12:07:23 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 12:07:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: William Hansen-Baird <william.hansen.baird@gmail.com>,
	<pkshih@realtek.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "William
 Hansen-Baird" <william.hansen.baird@gmail.com>
Subject: Re: [PATCH rtw-next v4 1/3] wifi: rtlwifi: fix disabling of ASPM for RTL8723BE with AER flooding
In-Reply-To: <20260630141553.785769-2-william.hansen.baird@gmail.com>
References: <20260626095648.1124924-1-william.hansen.baird@gmail.com> <20260630141553.785769-1-william.hansen.baird@gmail.com> <20260630141553.785769-2-william.hansen.baird@gmail.com>
Message-ID: <266211ce-3c89-4d1b-8207-60af8bc58f73@RTKEXHMBS03.realtek.com.tw>
Date: Fri, 3 Jul 2026 12:07:18 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38554-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:william.hansen.baird@gmail.com,m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:williamhansenbaird@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3D546FE4E7

William Hansen-Baird <william.hansen.baird@gmail.com> wrote:

> commit 77a6407c6ab2 ("wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723")
> adds code which sets ppsc->support_aspm to false in
> _rtl_pci_update_default_setting() in order to disable ASPM.
> This does not, however, disable ASPM. Rather, it disables driver
> control of ASPM, and blocks calls to rtl_pci_enable_aspm()
> and rtl_pci_disable_aspm().
> 
> In some cases, the pci device supplied to the probe function has
> ASPM enabled. The code would therefore not disable ASPM, as it means to,
> but rather just leave it enabled.
> This was discovered through testing on a Razer Blade 14 2017.
> 
> Implement a new __rtl_pci_disable_aspm(hw) function which does not check
> ppsc->support_aspm before disabling and call it from
> rtl_pci_disable_aspm().
> 
> Then move the code added in the previous commit to rtl_pci_init_aspm() to
> allow adding a call to __rtl_pci_disable_aspm(hw).
> This makes sure ASPM is disabled while still disabling
> driver control of ASPM to block it from being enabled later.
> 
> Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

3 patch(es) applied to rtw-next branch of rtw.git, thanks.

04a46c2dbf3b wifi: rtlwifi: fix disabling of ASPM for RTL8723BE with AER flooding
676e59a3825c wifi: rtlwifi: convert pci if-statement to ID table
2b7858891b10 wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 17aa:b736

---
https://github.com/pkshih/rtw.git


