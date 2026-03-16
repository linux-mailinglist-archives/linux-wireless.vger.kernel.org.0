Return-Path: <linux-wireless+bounces-33280-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB9mOaWgt2n9TgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33280-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 07:18:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A7229508A
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 07:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3CF433005323
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 06:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0049334A783;
	Mon, 16 Mar 2026 06:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="fhXlnZBU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D891B808;
	Mon, 16 Mar 2026 06:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773641888; cv=none; b=aAeqWgqYhRRPktPYpn8CKlivgUwbIwF0WvclZ6miaTMbZI6qX2kX/Vt4U9NOwK0wxbD+PjqEWOxpg7btZRIZv1fgluxfAyVZdcXOXuzSexvTm9MRcwgHL9XxTf2irni/vg8qb4twgnShLUkOA9KIEs7RDYg9v7gaSwf4j+BHC+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773641888; c=relaxed/simple;
	bh=CBzKXPENQYTQTVLniTzisHcMqhvievQfFGJaUYpU/Q0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NuDxePhkaVjmZ4Ofk7vPOli/B/qZg0yxbXBHG76pSQxyllWPWNSq1vTvV9Mp3TzbFDtggaQR/mJRD53BX4JSWhXPaAeCCKqIYac/UDwdVU0kBFyVdEEK1O/Shh/i7UQ1oM5OFn7n6WukznMJXBPOMDwGMlxEnvoNbzRgr0LLfNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=fhXlnZBU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62G6HwMB21352538, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773641878; bh=CBzKXPENQYTQTVLniTzisHcMqhvievQfFGJaUYpU/Q0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=fhXlnZBUq2rj2+9MYlLZKGLMR7SQQ14NJugQwzRQyRbRpeB810LUTM41ClVWio6Hi
	 lH5JfX724aAiPuz3RkBio2Jjxp4+ES9/81qCDPoUBCrSh++q2XEVRbuwJdF+f6t0Wy
	 h9mdQeA+8BQoiAQGxc39TnXMvmAQelg3kTf+/VE5KhYlnMxEGrjAz8efV0BJ6a2S9p
	 68WRxS4wEq3a+oegqB31b+111C374uiTzL8HCboj6itGYbZZYxDj3Ngu4gNIu0hZJa
	 BhJGqYumxKgnrUtA32rab/ufj/ORWnwx9Lu8BuKyTVK9uuWJCCEi+7JSqMA7nigf9u
	 GSjVpMMuRNrxw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62G6HwMB21352538
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 14:17:58 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Mar 2026 14:17:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Mar 2026 14:17:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 16 Mar 2026 14:17:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?iso-8859-1?Q?Georg_M=FCller?= <georgmueller@gmx.net>,
        "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v3 1/4] wifi: rtl8xxxu: move
 dynamic_tx_rpt_timing_counter from ra_info to priv
Thread-Topic: [RFC PATCH v3 1/4] wifi: rtl8xxxu: move
 dynamic_tx_rpt_timing_counter from ra_info to priv
Thread-Index: AQHcsvKN7nlD0qqX6kuVFEnvPxtmwLWwsvLg
Date: Mon, 16 Mar 2026 06:17:58 +0000
Message-ID: <fbd2420985544f858374468d25e848f5@realtek.com>
References: <20260313135321.3196688-1-georgmueller@gmx.net>
 <20260313135321.3196688-2-georgmueller@gmx.net>
In-Reply-To: <20260313135321.3196688-2-georgmueller@gmx.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="iso-8859-1"
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33280-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 19A7229508A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Georg M=FCller <georgmueller@gmx.net> wrote:
> dynamic_tx_rpt_timing_counter is not per mac_id, but used across all
> mac_ids.

I don't know the purpose of dynamic_tx_rpt_timing_counter. Could you
share your study?

Ping-Ke


