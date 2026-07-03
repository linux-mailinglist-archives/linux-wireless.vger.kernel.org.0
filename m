Return-Path: <linux-wireless+bounces-38549-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /f1BHioxR2p4UAAAu9opvQ
	(envelope-from <linux-wireless+bounces-38549-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 05:48:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7366FE42A
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 05:48:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=SZyOQN0z;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38549-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38549-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3753A303EF77
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 03:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E0B315D3E;
	Fri,  3 Jul 2026 03:48:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D0D3164C7
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 03:48:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783050534; cv=none; b=LiijdmNhWrOydAyeKsK0yFIlOMUnqcuYRpjHyjDQf6j9trLK5yvmaIW6Qyw1k5OjHvY49stg33G0NiwdA4Mlmr4MnIQ4Y4aFZ4c/WF4HxUxXMLJm6db8UC0iomKCJOANRJQO4RoXXZAgamgb3dqkUknqQfJFuwMFQEy+WpGh+RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783050534; c=relaxed/simple;
	bh=vxAdLMBwnG2IQO8QLPtFhpXihhvG9HVfKm6BZrhRN7I=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=J0GV30DcjzCENpd+oERcYiI9LVPhuFIlNZS4U1d8C1jHajxfSqXAz/+0bChsvPikhbV6AwcPu7yoN++Of1Y9/f7FAbncdE3rZXzgX7S6Ydq5rj3QZVdEenlF7BgHCyIGAC5/Qtr9+/AAgLQus+6sIAZzjZWHUPPyMvhXhD2oGoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=SZyOQN0z; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6633mgvlF2425059, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783050522; bh=Mn6DmuJCabgd8NfztDdqUFVJE+LaLvgjeC5ppO2LcY8=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=SZyOQN0znfCKM76XDb7Tl7BaT38MclZ9mEx/pZeunEZtfXo/kLo3zkj+RbF3+NN/b
	 Q4oonkmj8X7d5oSDlUBTVVx2oi5tDwMXJsnkpCalM0SH8VDT9gcLeoRSH1YIYl7pkV
	 WnkoByhyNBmw+u3cfV9A2rYGfigq/FSy11BcSwY/JZPAWOcWCRWtA++IM8AGrpo8uA
	 3RPdaQamZcSC9xLUQxhpNEG5N9q72dmEEvBnEiGeNpk0UBz5YX+uGbgylBZtF/TfST
	 XzOcwAVK9jH6X7YeFxi5yo98yAj5T9Qo5Ex5Vku198AJW1+6B0Zlq/9T80SMN0AXKQ
	 UEWbjj7Zn+1MA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6633mgvlF2425059
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 11:48:42 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 11:48:42 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 11:48:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
	<dian_syuan0116@realtek.com>, <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next 01/10] wifi: rtw89: mac: finish active TX immediately without waiting for DMAC
In-Reply-To: <20260625061545.44808-2-pkshih@realtek.com>
References: <20260625061545.44808-1-pkshih@realtek.com> <20260625061545.44808-2-pkshih@realtek.com>
Message-ID: <2dcee9e5-4621-43d3-b432-78868562b71f@RTKEXHMBS03.realtek.com.tw>
Date: Fri, 3 Jul 2026 11:48:42 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38549-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:gary.chang@realtek.com,m:timlee@realtek.com,m:dian_syuan0116@realtek.com,m:kevin_yang@realtek.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD7366FE42A

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Currently active TX only finishes after ensuring PCIE and DMAC become idle.
> However, the waiting time might be long. Since the packet is already
> transmitted over the air, update the registers to finish active TX
> immediately, regardless of the PCIE/DMAC status.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

10 patch(es) applied to rtw-next branch of rtw.git, thanks.

0819de0fd290 wifi: rtw89: mac: finish active TX immediately without waiting for DMAC
14dfbfeba17b wifi: rtw89: mac: pass chip version to firmware
e50c0fb7867e wifi: rtw89: fw: lower debug level for UDM1 debug register
c99498b4cbd7 wifi: rtw89: drop packet offload entry on H2C addition failure to avoid scan issue
b993046234fc wifi: rtw89: disable sniffer mode in RX filter when initialization for Wi-Fi 7 chips
0ec249ffc060 wifi: rtw89: pci: disable phy error flag related to refclk
c1eabaaa088d wifi: rtw89: fw: fix link ID filling for LPS MLO common info
76edcedda643 wifi: rtw89: wow: use MLD address in WoWLAN ARP replies for MLO stations
03a963f4aeda wifi: rtw89: wow: add QoS control field to WoWLAN ARP response for MLO
dbff9040587e wifi: rtw89: wow: only WiFi 6 chips initialize RF registers in WoWLAN mode

---
https://github.com/pkshih/rtw.git


