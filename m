Return-Path: <linux-wireless+bounces-36856-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOgHO9vsE2pCHgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36856-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 08:31:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F1E5C678A
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 08:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D910E3028B14
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 06:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C8639A06B;
	Mon, 25 May 2026 06:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="W4HXcvJK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C4039B97B
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 06:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690585; cv=none; b=E3TrtpJKg1LIkVspLMTS7t8OPIkoVn7cQ7ow7jvokRqC9MiuaJsVxxmOcWNVw1weovRAZgIzH0poq7MUHI8oRAktsVYFWVt3mm6U94RUGF+ICaNZ1aLsXHFvhmTTFypkN8bwwNs6V8QpXFUo94w3HOS3wInisbg8xyXo1WUUKvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690585; c=relaxed/simple;
	bh=GxRyxYFbxbALiHn1o3mYv+5DCcm9JWlD3/uidf35P84=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=a48aA2kxF3HbkFi6Ye5E7nXFpQr9zaZyTgh3GnM4BiISL8MuMfothnAq8pn23pVxlfkB4i1/18XtmI3rDuOi1RMJ8AqTZ8zZXF0pwQPbc3X2P3IbzpuM/nRVkyUed+LBY9oiKV6i2MAwfg2PfZ/2CCmjJ24mQOh8qERr2OH3/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=W4HXcvJK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64P6TdXqA849677, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779690579; bh=IFnO07eTGZLzc1fEQuJWISNdemy4poaowik36idj8w8=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=W4HXcvJKDCYVdotWkHHP+4Wq5ZaWgJIszoPZ4QA/JUHrtoPt1F7+9RvDX0A6eNDuF
	 GYOBHZklHMTI+ZjpUT2AV4AQCwmOX8Kymg6MtQPpRwFWA03g9k5wFyelxwctX4LIld
	 B4ajn47CLQSjFLoU1pQA9zQvCyBwallZRk3w8fIiNGxCkNimU9se6ghGyM5XfrnbPM
	 uX+512sMOsJEo+UVKhpWBXyaJ6DM/HUvzgJoo4/IJQfPe/wvpWoGNQU/G7GDGFW5rn
	 BkA1KY4lBxl3ExU33OPfhn4sabKXBcrxrsZu6oLYawZCrv9VMIFHXZxfVjH3b/fNQ5
	 QfuzwOmmmL3Ww==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64P6TdXqA849677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 May 2026 14:29:39 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 May 2026 14:29:39 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 25 May 2026 14:29:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next] wifi: rtw89: Add missing TX queue mappings for RTL8922AU
In-Reply-To: <0c8e0cf1-13e9-4c67-a67f-5f6f79fd0658@gmail.com>
References: <0c8e0cf1-13e9-4c67-a67f-5f6f79fd0658@gmail.com>
Message-ID: <48e025ca-d90d-4c53-9f5b-d4001f4d1943@RTKEXHMBS05.realtek.com.tw>
Date: Mon, 25 May 2026 14:29:39 +0800
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
	TAGGED_FROM(0.00)[bounces-36856-lists,linux-wireless=lfdr.de];
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
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 58F1E5C678A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> A user with MLO-capable router reports:
> 
> [ 753.080409] rtw89_8922au_git 2-2:1.0: Cannot map qsel to dma v2: 26
> [ 753.080417] rtw89_8922au_git 2-2:1.0: Cannot map qsel to dma v2: 26
> [ 813.649426] rtw89_8922au_git 2-2:1.0: Cannot map qsel to dma v2: 26
> [ 813.649445] rtw89_8922au_git 2-2:1.0: Cannot map qsel to dma v2: 26
> [ 813.855983] rtw89_8922au_git 2-2:1.0: Cannot map qsel to dma v2: 26
> 
> Map RTW89_TX_QSEL_B1_MGMT and RTW89_TX_QSEL_B1_HI to RTW89_TXCH_CH10.
> This is probably the right channel for these queues.
> 
> This function is also used for RTL8852AU and RTL8852CU, but those
> currently aren't used in DBCC mode with rtw89 so it makes no difference
> for them.
> 
> Link: https://github.com/morrownr/rtw89/issues/83#issuecomment-4314735734
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

cc9cdac80099 wifi: rtw89: Add missing TX queue mappings for RTL8922AU

---
https://github.com/pkshih/rtw.git


