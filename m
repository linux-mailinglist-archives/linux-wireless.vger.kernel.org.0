Return-Path: <linux-wireless+bounces-35549-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNz0KQJ48WkxhAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35549-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 05:16:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 311AF48EA39
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 05:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D790306DE98
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 03:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB27346FC4;
	Wed, 29 Apr 2026 03:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Hn1ncbII"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84425377551;
	Wed, 29 Apr 2026 03:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777432526; cv=none; b=QXLcODuJg9WkRC+kCkrS8MVveYvmLTtjnx0RqWc0D8BU07XOq4lMER7TL3lhx1Ll6QbqvzafFsAfR0H9tOpPBTCQh32EN8cRgxOVJO4aZG5vN1x0wP3YDZ+P0z/oXyLQvT3zKsCPmIQXd03WLdDFKUwRqc46hgWpmqFoS4knHH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777432526; c=relaxed/simple;
	bh=JhbEX+OcEukPgaWeXW+bzn54n5MIH97WRhbF+aCBfaY=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=J1ph89/RdHoMx3moCMsJyl3JV/6Tt8Brz73+GZjxS0MMQ2R3NxCNai9VXprLKOrHFLV01xQXdqb3guaGQEuwqSxRVyf+w21TmqcJYOLP5ldgQvYsgac8h7ac2iAmAzCKpKC30D/QIH0Lie/oKk4s60rBv/yT9N/lHjpgePMRrtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Hn1ncbII; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63T3F80M0920986, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777432508; bh=Xh2/aN5E4w/2PO17Xa0hF4NnlwO5dRJwQ20JfsvEW+8=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=Hn1ncbIItk46e8VJmlqoGt6PmVd0CPaGHeZvrUsBhTcj6usgnQ2NP/6437tT59C+/
	 apN65eBSHIaNGfO7FODFVPTSYYK6CyjTPIjK4zzNw4Bp3LSNm3y/GU+nCgYT/4zZn0
	 TWkH7y7F8NCMrh/7slEiuOpSj9yirK3FVXjVHqNJCkqnDhrOMgsJ/j0FUyYlktuTAC
	 3TZ3hr3hgSuufsqU0lJC8rDLez8gjE0IWh84Co2Cp2iQw3rP1L3ElTOJRKRIYKdyvN
	 qs2iC/vl0QpSkqU0kUndTuNrkonT0QfPCWSXqC26vC6cHA4DZozgw53o3+JQibbffn
	 2zHqXuQkjcNfQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63T3F80M0920986
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 11:15:08 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 11:15:06 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 29 Apr 2026 11:15:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Hugo Villeneuve <hugo@hugovil.com>, Ping-Ke Shih <pkshih@realtek.com>
CC: <hugo@hugovil.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtlwifi: fix typos in comments
In-Reply-To: <20260417200520.3919437-1-hugo@hugovil.com>
References: <20260417200520.3919437-1-hugo@hugovil.com>
Message-ID: <370c0372-68cc-479f-a132-17677c5849c1@RTKEXHMBS03.realtek.com.tw>
Date: Wed, 29 Apr 2026 11:15:01 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 311AF48EA39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-35549-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[RTKEXHMBS03.realtek.com.tw:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dimonoff.com:email,realtek.com:dkim,realtek.com:email,hugovil.com:email]

Hugo Villeneuve <hugo@hugovil.com> wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Fix typos in rtl8821ae_card_disable() comments.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

718c023ffe41 wifi: rtlwifi: fix typos in comments in rtl8821ae_card_disable()

---
https://github.com/pkshih/rtw.git


