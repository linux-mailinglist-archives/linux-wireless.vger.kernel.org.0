Return-Path: <linux-wireless+bounces-36990-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UP02Jn2vFmokogcAu9opvQ
	(envelope-from <linux-wireless+bounces-36990-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 10:46:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D405E148E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 10:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0482F3008C35
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 08:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCA23E2ACA;
	Wed, 27 May 2026 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pK1UntcJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A803E2AB9
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871610; cv=none; b=YljIsv03CWIsBd1MGmgL/yKpZ/uFTs5LOZa/4L5/hgzuZx0qjObthWb5i9V9L7UhlUZf26WjFtx5n99H4HIZcncBm91fxxgQ3WnxI/TXmAHqx95J04YqDxwsKQGnbIB0gGemXT5MQS4h6JUVHtU+rjUpj3HpXWTWpliEJ3ySS50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871610; c=relaxed/simple;
	bh=vnDR63bmLrdaCCOoMvCmhrAYtf6rBGa2ShdGOB1jeGI=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=U41Q8RJc6waTTCvG/YVdSnejzZ1s6gYTVoFLNSdUDiwh82T8mj1CTk2qHzGI4yKxXItkj96S6ykvXeFEVQXfk3XRIIQ/N6QA0d3Bttm2q5VzwzvS9sJHwfdnZNdoBOdfhuEVqR1g08rxv0DGxnTWAZpRiAoRP+puNGJsDP5MVoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pK1UntcJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64R8k9G012303500, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779871569; bh=AasMmoD9nx1VoqeFML5mgv6TLiHNc8fqbRMdsY1aHn4=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=pK1UntcJcpYkWtJ30Nho7uLF0JP0s7umSRtn6pWvdrf3jeG5xgFqVWPIMdZNmlXuD
	 ldXQdrcNO0duqNMWQ7j0ZuVrD0Nuxsx/SrF+Op+Wdo/YLoIX6cJ+6eLLCOSUmOjwee
	 NxoqwNIc+G5uYBDdXmtGWbimPbIRHdRHAobXoKZLzNxLgIYJXChgDQuNITcpAQAlar
	 cykEnSdjl255jbbO3Xahp01xD5AQ2RrIKCU+ia5guV8K3ATvUPqTO8//kHQV8dR4+E
	 m9/1GdiE+YIJHqyd3YjWMx3IIw51whx8Mz0VXvXRbzM6Z63HPitvXKLf/35Z8rlFUi
	 F9ZH0OKFJHF5g==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64R8k9G012303500
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 16:46:09 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 May 2026 16:46:10 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 May 2026 16:46:09 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 27 May 2026 16:46:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, LB F <goainwo@gmail.com>, "Martin
 Blumenstingl" <martin.blumenstingl@googlemail.com>, Fiona Klute
	<fiona.klute@gmx.de>, <andrej.skvortzov@gmail.com>, <anarsoul@gmail.com>,
	Zhen XIN <zhen.xin@nokia-sbell.com>
Subject: Re: [PATCH rtw-next v2] wifi: rtw88: Add more validation for the RX descriptor
In-Reply-To: <5bfecba3-8a90-4e0f-9558-af5cd8a14975@gmail.com>
References: <5bfecba3-8a90-4e0f-9558-af5cd8a14975@gmail.com>
Message-ID: <45375e28-d30d-46e1-97a8-af3146703579@RTKEXHMBS03.realtek.com.tw>
Date: Wed, 27 May 2026 16:46:09 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,googlemail.com,gmx.de,nokia-sbell.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36990-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,realtek.com:email,realtek.com:dkim,RTKEXHMBS03.realtek.com.tw:mid];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 36D405E148E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Some RTL8821CE cards can return frames with corrupted RX descriptor,
> causing warnings and crashes if they are passed to the upper layers.
> 
> The PHY status size field is 4 bits wide, but in rtw88 its value should
> only be 0 or 4. Checking this catches most of the corrupt frames.
> 
> If a PHY status is present, the PHY status size should not be 0.
> 
> The frame size should not be less than or equal to 4 and should not
> exceed 11454.
> 
> The rate should not exceed 4SS MCS9.
> 
> Discard the frame if any of these checks fail.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221286
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Tested-by: Oleksandr Havrylov <goainwo@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

aa7d92e83811 wifi: rtw88: Add more validation for the RX descriptor

---
https://github.com/pkshih/rtw.git


