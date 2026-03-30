Return-Path: <linux-wireless+bounces-34132-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LEAHufVyWmO2wUAu9opvQ
	(envelope-from <linux-wireless+bounces-34132-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 03:46:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9907354A3F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 03:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 274193008D08
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 01:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C3621771B;
	Mon, 30 Mar 2026 01:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Bz+xWtOb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A6E1E8320;
	Mon, 30 Mar 2026 01:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774835089; cv=none; b=hOh8l1brRfouNS8fPnGu1GSBLoRblLAXPwtvEZi5W0t6LW8YJVNVhi4x1/EBheNMo72s0lcq/F3LrEbUwwk78NCaljyx0ez64Ifgx01ADJd5OMeceXVoSUeNrPLSHbLrJSerzeyzWBgXjPWi6Y2tA8FDASqKRAm6hOPkw55nmjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774835089; c=relaxed/simple;
	bh=YwKFXyJIdB7x73K8gZrHbKPZ6HGYmpaoUwCG+gcv06Y=;
	h=From:To:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=BSElNI+5RbZumW3wDbYtj4VoTSFJAlIRXsbLDMlZWTFcWH47oMRfBPa7tqf/l4TyOwmd05F6mf562oBj+FAss0/4+4R6IB870vlYGVb6jQxKKw0lwksxnZrZlUpNkYeSNNvFXv/tGvZCaIqN7e56mbo01N6M6nrsGWR9QsUsryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Bz+xWtOb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U1ihSdB068335, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774835083; bh=Gq2uvplEJb3FjVhRqm4hGrcdqstxpPiAifLXEOZfwYc=;
	h=From:To:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=Bz+xWtObJ5x9jCru4xBxegyiEaAdI38qDPU2Uue4K2M6ZBuSKBUAxcYeP/D+KMyfT
	 lM4mPDTPCQDOyOTRoDuvvEM0I8OQ1zADM28zdBhnUxaQbVN5jRdQ9r2nUVYSzU6Y/T
	 tgFPS2Y0yWunobjjPMeUNVtBZpzviYKUQ4Kg+U/WLURaqP1Husg3Vkik8UfoUZfJQn
	 ip5ktBaHQPpYqW4ccqhpaGa+PrjIy4xufp8yGuPn4zZm5mKArZU7iOImwZ/WJ9DBeB
	 M6EEukQ+X7VxAcsXnV3afzONIjJ1vG4if8FV4mExIauh5b9htrdWLgNv/e7hLQpdv1
	 Qfxuw+PIRPNyQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U1ihSdB068335
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 09:44:43 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 09:44:43 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Mar 2026 09:44:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Christian Hewitt <christianshewitt@gmail.com>,
        Ping-Ke Shih
	<pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: rtw89: retry efuse physical map dump on transient failure
In-Reply-To: <20260317112155.1939569-1-christianshewitt@gmail.com>
References: <20260317112155.1939569-1-christianshewitt@gmail.com>
Message-ID: <a8a595ce-9795-4b78-938b-350cfbe26d6a@RTKEXHMBS04.realtek.com.tw>
Date: Mon, 30 Mar 2026 09:44:43 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34132-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim]
X-Rspamd-Queue-Id: D9907354A3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Christian Hewitt <christianshewitt@gmail.com> wrote:

> On Radxa Rock 5B with a RTL8852BE combo WiFi/BT card, the efuse
> physical map dump intermittently fails with -EBUSY during probe.
> The failure occurs in rtw89_dump_physical_efuse_map_ddv() where
> read_poll_timeout_atomic() times out waiting for the B_AX_EF_RDY
> bit after 1 second.
> 
> The root cause is a timing race during boot: the WiFi driver's
> chip initialization (firmware download via PCIe) overlaps with
> Bluetooth firmware download to the same combo chip via USB. This
> can leave the efuse controller temporarily unavailable when the
> WiFi driver attempts to read the efuse map.
> 
> The firmware download path retries up to 5 times, but the efuse
> read that follows has no similar logic. Address this by adding
> retry loop logic (also up to 5 attempts) around physical efuse
> map dump.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

d92f6ad6483e wifi: rtw89: retry efuse physical map dump on transient failure

---
https://github.com/pkshih/rtw.git


