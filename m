Return-Path: <linux-wireless+bounces-32370-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEBWB4lNpmlCNwAAu9opvQ
	(envelope-from <linux-wireless+bounces-32370-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 03:55:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FA91E83FC
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 03:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C279C3074E3B
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 02:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BF7379EF7;
	Tue,  3 Mar 2026 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="fcbEq2KA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FBA2F851;
	Tue,  3 Mar 2026 02:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772506501; cv=none; b=HR3MTjeGvpw3lBV3+lcEO8vOqVOd2R1cAWfZ2lBVl7Dfdbm7HaetPt/EQY+Ux0YnFWX0L4+GcrD5+D2pykDhId9hKmvDHpFcH75LzGOvYI6CBelJxrB+98xzC61XB/W/1T1i3U6ogjo9c8cbMdKduAAzrwQjTl1MIIQWfnWo0As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772506501; c=relaxed/simple;
	bh=U/WCRbNCR91eq+/hmEk12ZnmjiIab7lQb2TsmDyyqCQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=KFlVrRvCMllWZR8iZt26G8HWSuEa86Tt+pdT1kAvtHAfhd07OPx4OWFAX6bXpOlKj/7dU9rqF1ULKGlxYgLsRJeCWnOgLYYAXuMyNMOK5KKP+Ew/448l5qWYqGre50A9EuWieShKQHhXwkZ9esowNqWw4usWHAdJEzJuVdZrYd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=fcbEq2KA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6232sIT71280696, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1772506458; bh=kwOJpi4e3u308ce5BmRhUysObzDIJVxvPcmujZKUZWY=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=fcbEq2KA9KU+4mO4GEn7nLFCOYfIrTol04OgDaIfWVV8rR6qC6+2jgKs8oUnI3WIC
	 zSwYcXbYla5DQX0hL3Eb/3277IwfWyiiudv7/v2n7nBfSW11SA+S9Ail5h8XxvlQId
	 8vmXhrrkmX4u9bOt9gsLrxGBetc4DRK/7jnrwqqgGDreNddnk1dqF/ql+QVwsvNAg0
	 neFiVgQG6Q9MWsDrI2RG96zivy59OM6XlU5SDAMi9k5CI3ho17ngHXdJ0Dvod65viv
	 fMiiLsMdHSxVbeHlWLoXQmR1R5/qxWYk/VOpSA0ZNF37nvvOMV/X8OqFZWhNDOmKsj
	 GNFKVgg7seozQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6232sIT71280696
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 10:54:18 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 3 Mar 2026 10:54:18 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Mar 2026 10:54:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>, Ping-Ke Shih <pkshih@realtek.com>
CC: Fedor Pchelkin <pchelkin@ispras.ru>, Jian-Hong Pan <jhp@endlessos.org>,
        Kalle Valo <kvalo@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bitterblue
 Smith <rtl8821cerfe2@gmail.com>,
        Dmitry Antipov <dmantipov@yandex.ru>, <lvc-project@linuxtesting.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH rtw-next] wifi: rtw88: check for PCI upstream bridge existence
In-Reply-To: <20260220094730.49791-1-pchelkin@ispras.ru>
References: <20260220094730.49791-1-pchelkin@ispras.ru>
Message-ID: <f661e467-b745-4c78-9b6b-d7092188cf7b@RTKEXHMBS05.realtek.com.tw>
Date: Tue, 3 Mar 2026 10:54:13 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 58FA91E83FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[ispras.ru,endlessos.org,kernel.org,canonical.com,vger.kernel.org,gmail.com,yandex.ru,linuxtesting.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32370-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ispras.ru:email,RTKEXHMBS05.realtek.com.tw:mid,linuxtesting.org:url,realtek.com:dkim,realtek.com:email]
X-Rspamd-Action: no action

Fedor Pchelkin <pchelkin@ispras.ru> wrote:

> pci_upstream_bridge() returns NULL if the device is on a root bus.  If
> 8821CE is installed in the system with such a PCI topology, the probing
> routine will crash.  This has probably been unnoticed as 8821CE is mostly
> supplied in laptops where there is a PCI-to-PCI bridge located upstream
> from the device.  However the card might be installed on a system with
> different configuration.
> 
> Check if the bridge does exist for the specific workaround to be applied.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace static
> analysis tool.
> 
> Fixes: 24f5e38a13b5 ("rtw88: Disable PCIe ASPM while doing NAPI poll on 8821CE")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

eb101d2abdcc wifi: rtw88: check for PCI upstream bridge existence

---
https://github.com/pkshih/rtw.git


