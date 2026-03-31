Return-Path: <linux-wireless+bounces-34209-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8C1aAOKCy2l4IgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34209-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 10:16:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6196B365F5A
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 10:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5D123023058
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 08:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1162239D6F9;
	Tue, 31 Mar 2026 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freifunk-aachen.de header.i=@freifunk-aachen.de header.b="ah89LX72"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vm007.relaix.net (vm007.relaix.net [46.183.100.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B2C27F754
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.183.100.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944609; cv=none; b=AvgoucxGnNLuzAt9owAgwtbImJGhzQAdWr/BpzzntuxAQAc38pOMcYdM4SmmF1QrgoN6tGHHt7YkD2HocGX+wYhwdxHhADuPSKnKRRU5gM6meSNNCz8bi0p5ct6Q1dAFut3dWCjUHOzE0RUx4ohbbLpX/7bu8E+x4LoxjyD+9pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944609; c=relaxed/simple;
	bh=UfIjsbZZ2huPf5QQyZ5B+DC+AKYHsx7WJ8Zd+jvmzYY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=nEqryP/nUM/lM4jQm+LphnxklVP1uLBkJWqZq8uYB2U1IwoG2dH0BY2nsLIrXaVWBAf/E0AcWLXlibKc8Rhum+QGAnlDzoKp33j56kUP7+xcFjzKmM/eH9DbJWHpK+TZhYYkSoq40ttT0igRtz0hD8M7fbbUJeT+1IYFGC6HL6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freifunk-aachen.de; spf=pass smtp.mailfrom=freifunk-aachen.de; dkim=pass (2048-bit key) header.d=freifunk-aachen.de header.i=@freifunk-aachen.de header.b=ah89LX72; arc=none smtp.client-ip=46.183.100.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freifunk-aachen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freifunk-aachen.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 578C054D7DB;
	Tue, 31 Mar 2026 09:59:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freifunk-aachen.de;
	s=dkim; t=1774943966;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
	bh=xf3baQcdCPT0xFW7ni7rVWBaUQV2OoiDultSu0Aff8k=;
	b=ah89LX72H/Ci2jMUilNQGOcs9GjmgWJuHtpIo67jflsErH9yAXwYfKHz/89K0F3QhFsdCo
	jd8Osi078DSNGkJv2IFRpIaKCV2wy3Up05RdOxxxE/E9O6ePJgdWbJgYPnmc0JpJFhqwgP
	PLBkSbE1kLoTxUw5fS8FHovSjY68N+8GPsCVDGzdB1XZqIKl7adSM8b3pw8qrNJz0s+IQE
	T9TNKGKoSTMadnOeIT9vjx7IlhzNCakL68owIS8iBH/6dnCV5qvlwNqLVXrycOWcYob6my
	quyiBLjavZzl5FqTB7R/fmzbFAn1Glm4B0eQgeyrooba6e0xd9elqWggCOyG2g==
Message-ID: <3f4103d9-4871-4ae8-93a7-d286fce37443@freifunk-aachen.de>
Date: Tue, 31 Mar 2026 09:59:22 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: lucid_duck@justthetip.ca
Cc: linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
 lorenzo.bianconi@redhat.com, morrownr@gmail.com, nbd@nbd.name,
 satadru@gmail.com, sean.wang@kernel.org
References: <20260327021534.448552-1-lucid_duck@justthetip.ca>
Subject: Re: [PATCH 1/3] wifi: mt76: connac: use a helper to cache txpower_cur
Content-Language: en-US
From: Felix Baumann <felix.baumann@freifunk-aachen.de>
Autocrypt: addr=felix.baumann@freifunk-aachen.de; keydata=
 xjMEaXlalxYJKwYBBAHaRw8BAQdAy2mf6IX/aorkYHujfexbrrHPZ9evkUR6MjkWqzxM1l3N
 MEZlbGl4IEJhdW1hbm4gPGZlbGl4LmJhdW1hbm5AZnJlaWZ1bmstYWFjaGVuLmRlPsKPBBMW
 CAA3FiEE0nprspF4aDRw7fLJVcWHRzGzREoFAml5WpcFCQDtTgACGwMECwkIBwUVCAkKCwUW
 AgMBAAAKCRBVxYdHMbNESpb0AP9bpO2TOFuA56gBS38TbOtiOBTqhzvxHSnxn3JIa9opEQEA
 mOLrjuD5DJdaW56g4X1l4oOSwEcH43qrcLRI6KtjZw/OOARpeVqXEgorBgEEAZdVAQUBAQdA
 bnuRly36kpIJPY7TufU6iEseKtyERyKniKQY15AYY0kDAQgHwn4EGBYIACYWIQTSemuykXho
 NHDt8slVxYdHMbNESgUCaXlalwUJAO1OAAIbDAAKCRBVxYdHMbNESv3UAP9/rR+UtikbtAul
 X83a5sNYdTxJoMISGpEIGFBtWApGEAEAkMUNQHnFv+L7IkZEjBcOS6eUzOMmu6/Bg+BkZjCy HAU=
In-Reply-To: <20260327021534.448552-1-lucid_duck@justthetip.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[freifunk-aachen.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[freifunk-aachen.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,redhat.com,gmail.com,nbd.name,kernel.org];
	TAGGED_FROM(0.00)[bounces-34209-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[freifunk-aachen.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[felix.baumann@freifunk-aachen.de,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.987];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,freifunk-aachen.de:dkim,freifunk-aachen.de:mid]
X-Rspamd-Queue-Id: 6196B365F5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Lucid Duck,

thanks a lot for your contribution. Very much appreciated :)
The kernel has a strict policy for contributions: real names only.
https://www.kernel.org/doc/html/v4.11/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

May I kindly ask whether it would be okay for Sean to use your real name?
https://github.com/Lucid-Duck

-- 
Regards
Felix Baumann


