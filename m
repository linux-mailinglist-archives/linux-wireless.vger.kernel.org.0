Return-Path: <linux-wireless+bounces-34138-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG7QNKLhyWkd3QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34138-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 04:36:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EE9354D33
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 04:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6555300C5B5
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 02:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264139443;
	Mon, 30 Mar 2026 02:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GyuLSMuk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BBB40DFA0
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 02:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774838176; cv=none; b=suVa10JdDbtQuJox+ffGfQcpeA85V3HVqioq5Zhp5PbJNPHwTwuNCuZZ/CGM2G29sIUDQBIcxYcRz0MI/xIIKl3591qqigbDqEvj7iIZl3YNHGwJmT+kstvyqHJm3JxhQqNEiHHh+NUxqJ7QfTPqIYwK9gK66jLzzU+iS2CACuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774838176; c=relaxed/simple;
	bh=oKFuQmt+bfFeeQo4yBVY8yLD/ol/gctsDRNL7+mQEH4=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=qjpwSEEyZt3L/h5xef7rjJv3PjbI7m0rRUEHYC3Z1VUaW4JfXXZX7YLv02EJNQXKaz3DIoFKCicGH572LFiSQk8VbHFn7Kp6zZm2GBGAoQYb7H5hudzvmgw3EqHJvLZd6oDUzCcWUeab0xMawj/EV12qJo/XbKQ40RoqvRGo2NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GyuLSMuk; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U2aCfF5155500, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774838172; bh=trLZQKu4KHGw6O1Xx2LOSsIfp1U0s11gIlaf/0XZiRY=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=GyuLSMukE+yoSVFJV2SVXwrBdx5IC0dlM1q54GPdT/WoQfW1CSalNalob26J6zFKV
	 64cii+BpRDEIro+FpdAERnWq/Q0RptbFMqOXks71NbxS1HbsNjA4r/4gkjOA1/oMZi
	 lwFTsrNa1+kQBJBFjDU4e+VY9Chbf/yqXQpofj3MMIfDYlEp8gyGrb1/uwuhh53M4A
	 8fgM12H5ZYRMNIL/CJqiAz4DOtN4raYglukbeSSUCQySAi19dpS0gvM7rXutCsiumk
	 V6CuA21yqJmWK7mS9SGrOgcdV7cTmvqJO1wDisiKBjx+chGF7LnhawuRz0jtt5D8sr
	 l5487a5WnXeaQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U2aCfF5155500
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 10:36:12 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 10:35:36 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Mar 2026 10:35:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <echuang@realtek.com>, <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next 1/8] wifi: rtw89: wow: use struct style to fill WOW wakeup control H2C command
In-Reply-To: <20260325072130.41751-2-pkshih@realtek.com>
References: <20260325072130.41751-1-pkshih@realtek.com> <20260325072130.41751-2-pkshih@realtek.com>
Message-ID: <4cf3c8be-9742-476a-b859-dd4a9d2429c4@RTKEXHMBS04.realtek.com.tw>
Date: Mon, 30 Mar 2026 10:35:34 +0800
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34138-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 36EE9354D33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> The WOW wakeup control command is used to tell firmware the content
> of wakeup feature. Use struct instead of macros to fill the data.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patch(es) applied to rtw-next branch of rtw.git, thanks.

86a4c63c01e4 wifi: rtw89: wow: use struct style to fill WOW wakeup control H2C command
4e7a7f57718e wifi: rtw89: wow: enable MLD address for Magic packet wakeup
bdc607a67edf wifi: rtw89: pci: clear SER ISR when initial and leaving WoWLAN for WiFi 7 chips
ba42bb2813aa wifi: rtw89: mac: add specific case to dump mac memory for RTL8922D
ce945fb377ce wifi: rtw89: mac: disable pre-load function for RTL8922DE
e0b88e052e4c wifi: rtw89: phy: expand PHY page for RTL8922D
9c52ad439e6c wifi: rtw89: phy: load RF parameters relying on ACV for RTL8922D
e0da9859cfbc wifi: rtw89: fw: load TX power elements according to AID

---
https://github.com/pkshih/rtw.git


