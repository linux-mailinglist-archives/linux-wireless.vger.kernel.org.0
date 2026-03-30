Return-Path: <linux-wireless+bounces-34139-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDSdOsriyWk13QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34139-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 04:41:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D93C354D57
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 04:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 145EE300D315
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 02:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F016E9443;
	Mon, 30 Mar 2026 02:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="acpJzPeg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74F31EFFB7
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 02:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774838442; cv=none; b=Dju6Fp+iDhAdr0gnOYfKGMnsflkVueNrSgsOf/k6KVCCKNr0crVRqXUsg2XYpfN85EJne8mQd2Nc2S/V3WY7hDcR67OB1S6Fwrwa8u7PBNq9ZdTLzOIQ5GluYwXmQSvNMhIg0S8ecO2Roc5rJ4PlL4yr2T5TNEsT+h2c7BBCksM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774838442; c=relaxed/simple;
	bh=2yvZiusLpYJCU23PrexNpO8E1wvDzbrgOUaruvK3jQU=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=LiZVr0ndtBdKCEzgUIxfUL0KqQ4JmOO5pamZW0186CEb9SlijXVELkfMz6IfAVbRqJFjCqctQC7JgGLesTwqfta/gQT1XuYOH3snbS6Yueb2a2d52eGd+sWDfIqN7H2paTjgGcnAwBHhaxQW84Osc2EDSE7p/rzO56l8MWJPQZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=acpJzPeg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U2eccI7161556, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774838438; bh=29hQFrFJozKFmKC57mWQH/LsKZd9i5k8e8C2WIaHPtY=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=acpJzPegSNo/shOe51AyXkmSR4tKxrPQ8vKaVrKEt7DIEbJImEpHr9m8V3cooiSw6
	 rLpUSOzY0djam+ptNQtfMiOLOoPJMQqJoE5+xEiKkW1vOox8feW+ThHqUCdNBJP1MV
	 8HS/CJWOWYF3Il+gqmsnqmV0IYFDrrbuB2e7iql8N41VFVYiMO6TfY2FgxKEoAXckj
	 nK6XW6Gh+BBvaZqA6mUamFbiGKmX/t87CspiX0iQ7iSgDSSg1YWfeXd5rgL8/sJ1dg
	 oVwN/eJsZN8ZQazxeR6a2ocjXYUaljsXowa89dMJRVVLJ3z7tJ3ky/PTcTyZ0Kcw0a
	 SWTgSQoAEDAuA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U2eccI7161556
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 10:40:38 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 10:40:38 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 10:40:33 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Mar 2026 10:40:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next] wifi: rtw88: coex: Ignore BT info byte 5 from RTL8821A
In-Reply-To: <bbf06c83-d2ee-4205-8fbb-829e2347586f@gmail.com>
References: <bbf06c83-d2ee-4205-8fbb-829e2347586f@gmail.com>
Message-ID: <fbe8ff3e-e7c3-4617-be85-fbce4b7e53d0@RTKEXHMBS03.realtek.com.tw>
Date: Mon, 30 Mar 2026 10:40:33 +0800
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34139-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6D93C354D57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Sometimes while watching a Youtube video with Bluetooth headphones the
> audio has a lot of interruptions, because the 5th byte of the BT info
> sent by RTL8821AU has strange values, which result in
> coex_stat->bt_hid_pair_num being 2 or 3. When this happens
> rtw_coex_freerun_check() returns true, which causes
> rtw_coex_action_wl_connected() to call rtw_coex_action_freerun() instead
> of rtw_coex_action_bt_a2dp().
> 
> The RTL8821AU vendor driver doesn't do anything with the 5th byte of the
> BT info, so ignore it here as well.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

658e3c836969 wifi: rtw88: coex: Ignore BT info byte 5 from RTL8821A

---
https://github.com/pkshih/rtw.git


