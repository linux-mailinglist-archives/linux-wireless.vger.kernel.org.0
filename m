Return-Path: <linux-wireless+bounces-33282-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAEBE/Got2lrUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33282-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 07:53:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4508F295485
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 07:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 481B73004601
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 06:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEAE347539;
	Mon, 16 Mar 2026 06:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="SKhrAIW4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6DD346E54
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 06:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644011; cv=none; b=sSBKRNul3uvDhXuOo1YR5XGzIf29rJ2y8DZJiRhj2HD/N/3OBaqqKc7y67j2AZNsNsSOEmCg3Pw3y86TqMeFM1x4HSrN2gtIFf0jOc0BATel2rTfTQIFMTi1Vpwh4WSfOO/m4Np3Drc6IPcGAZJzNaxQms4fjjmfwXXhLGh+iP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644011; c=relaxed/simple;
	bh=w6Agu/yl4IbwGpGfm+6ipUsOShQGR09DT2SkIMRRVsc=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=eaUgxnkyzzfzMFTCjVshI1p11oEN8RyDYBIpuffbi96g8iPzOJiSBnkrJEspH4B5ld0ZsuOFK6d0hJnNCMVyDgMT+umn3ztnSPVgiASJn+4qvOT6Jq1BAwaYdrY7BJLcwtjiChI/3MCkOCGBDJQFjIbKZV7VHRK0S5VkgH+5LTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=SKhrAIW4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62G6rRjoD1406785, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773644007; bh=njGfYldK5oiIvUct8CPCzKpPjbAeCbPn2a1Ld0YAOtc=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=SKhrAIW4endpSfc+bAHjRg31c2ruQbQA8sQWaEmo3yvbOFUzOZIVPnFmlxynNXj4K
	 K3VkQiD+AemwwGRhjO/MI1Jj4aS7HgIA2TLouj7bfH5ncld6jLZdIjxFALMp60FDPC
	 GI0A84E2VXGvRztiWxaGAjfmM/seWD8BNOSUiUu41tDo5AJYX1QqtcUFUpdKUzK9zV
	 dzGi1EjJmOWO6nY2C4BS38bA79/d0Eh5vDvGIDpXj9ZigVz1gwkzHRCoekIiIOnGft
	 vWPqRSUug8GOKBfT+6N1XZXPiWZNoADsfBnMrlTOg8HJcTkdftnVY80z+2EQVlQb3u
	 +afSDLTVOniUA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62G6rRjoD1406785
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 14:53:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Mar 2026 14:53:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Mar 2026 14:53:25 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 16 Mar 2026 14:53:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next 02/13] wifi: rtw89: pci: update SER parameters for suspend/resume
In-Reply-To: <20260310080146.31113-3-pkshih@realtek.com>
References: <20260310080146.31113-1-pkshih@realtek.com> <20260310080146.31113-3-pkshih@realtek.com>
Message-ID: <16f915ca-71e7-4e7a-9da8-c56a79e14c05@RTKEXHMBS06.realtek.com.tw>
Date: Mon, 16 Mar 2026 14:53:25 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33282-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,RTKEXHMBS06.realtek.com.tw:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4508F295485
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:

> In suspend mode, SER timer unit is different from normal mode. Set proper
> value to prevent expected SER happened during suspend.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

12 patch(es) applied to rtw-next branch of rtw.git, thanks.

177520960c01 wifi: rtw89: pci: update SER parameters for suspend/resume
9a38ef92aaa2 wifi: rtw89: mac: remove A-die off setting for RTL8852C and RTL8922A
84f5e0eaf84e wifi: rtw89: phy: limit AMPDU number for RA try rate
be28b2c4eed4 wifi: rtw89: move disabling dynamic mechanism functions to core
4516621686cb wifi: rtw89: tweak settings of TX power and channel for Wi-Fi 7
2fed8de4eb98 wifi: rtw89: chan: simplify link handling related to ROC
cf3cd3687d8a wifi: rtw89: chan: recalc MLO DBCC mode based on current entity mode
72dbc78594a1 wifi: rtw89: wow: add retry for ensuring packet are processed
829b89c2b08f wifi: rtw89: replace RF mutex with wiphy lock assertion
bda294ed0ed0 wifi: rtw89: Drop malformed AMPDU frames with abnormal PN
45ba9226b108 wifi: rtw89: Recalculate station aggregates when AMSDU length changes for MLO links
a1488456f706 wifi: rtw89: debug: simulate Wi-Fi 7 SER L0/L1 without PS mode

---
https://github.com/pkshih/rtw.git


