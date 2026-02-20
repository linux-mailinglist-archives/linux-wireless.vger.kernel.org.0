Return-Path: <linux-wireless+bounces-32072-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBMfC10CmWkVPAMAu9opvQ
	(envelope-from <linux-wireless+bounces-32072-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Feb 2026 01:54:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C4916B9F4
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Feb 2026 01:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB5E2302EE87
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Feb 2026 00:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E10430FF20;
	Sat, 21 Feb 2026 00:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="e6k1me0I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F2B2BD01B
	for <linux-wireless@vger.kernel.org>; Sat, 21 Feb 2026 00:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771635288; cv=none; b=QrqCpEOaXf1TcWURIqapVBRVwm8vQ+jHjJ9fsNMniQ32LFb4WPQ/1t14CfaM6JiHRq2xzTfH3JNAQXpmcDz9fPacZ4fvgfHRCoQ7Gp49x4XIVowMUxD0JcE6n0IXQySZgIsRZ5+Wzfl1d05FJ6wl6kJFyzTqibxh1SealwYQovI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771635288; c=relaxed/simple;
	bh=Rk1vOl7cC1QEB1mXWViEHcEX7NFIEaRG3DmtgoZjEG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snlVwbNZCEO2G9DIUQj1u8WlpgNgbCfYvfYfJLgJESQwajOZrkIn9kR/ld1vFGm+6/dmloW+kuFkAr0fYJ4Eq55WeRTWnC+OarRK9s08vKPznFd1JoOuQR/KnsNMfGpX52Ln0CbozgH/GGp5ezoppKGL1ZNBsuAlBzLeK3VTku8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=e6k1me0I; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id tZTevPBr3KjfotbGbv9Mby; Sat, 21 Feb 2026 00:54:41 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id tbGZvNDBbN3K1tbGavnh5a; Sat, 21 Feb 2026 00:54:40 +0000
X-Authority-Analysis: v=2.4 cv=UdRRSLSN c=1 sm=1 tr=0 ts=69990250
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=7T7KSl7uo7wA:10
 a=D3g81HRkPwipA-K-4bMA:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7ZekGKnfsHBBe6ha8psPApNc9SjZR4naB0905oyMxRY=; b=e6k1me0IUQrERP0YsnlawDeJFG
	3g2lhHhnedv5tOyXiIXkTctx70gn+tT8chxHXlmdSsiNcPpOqRcnLfik9q/N8PDGvM2mzhh6ShsGl
	EAA26zeX/jZ33n2xyxmmAs1Xcz34b2WqgW35qHI5aHLd2YjFyvlkoA7nbnNkWnFEL8Wadej8FZIcj
	olCj1c6ajxbXgKX68vIlDUUACMFZ/pAgTLOJTKoxZ1d+6JFp9CNuY7xiFlZr+h4h+x89jn56GWjbR
	qANs7jGtILQGe9gbnWliph+uSkAGQATHuD8UNj5bsUvI8YNCj/m5pP0F6tK/nRSfx1bjKI/7dKYPO
	PXLtaSPw==;
Received: from [177.238.16.13] (port=54430 helo=[192.168.0.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vtbGZ-00000002WIs-1ffu;
	Fri, 20 Feb 2026 18:54:39 -0600
Message-ID: <161c2bda-7511-4a39-b600-8bc8788c6782@embeddedor.com>
Date: Fri, 20 Feb 2026 18:54:03 +0900
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] wifi: ath6kl: wmi: Avoid
 -Wflex-array-member-not-at-end warning
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aZP4RI-uN2001cBh@kspp>
 <d2a02b4c-5f69-4f5e-bc0e-428b64e99d36@oss.qualcomm.com>
 <6305fbc7-8210-4f4d-b719-30ba038611af@embeddedor.com>
 <c2060e50-0e36-422f-bfe3-44a81fb96c59@oss.qualcomm.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <c2060e50-0e36-422f-bfe3-44a81fb96c59@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.13
X-Source-L: No
X-Exim-ID: 1vtbGZ-00000002WIs-1ffu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.104]) [177.238.16.13]:54430
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOk1DI4XMMBAIJDtgnytZ4E2uEKh4IQYG1OgBleEX6XzctyxnNP1L4/m+Js6KQPeooeH2FvGL6z2hUMHn7j3KIB/unoWie4bdlMNjVGoLOuN4ZOb22X3
 Go5phxL8RS8cbm4VZ+1gewL9wgA0Dr9HQNYtfFSr1HiB0mdoa8cLxH0CGvr9gZU3zt7WkdvXCq9AKXAyh7akeG8o85ze6IjFp5SAeyEKZf25LQ+26une1nIn
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[embeddedor.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32072-lists,linux-wireless=lfdr.de];
	DMARC_NA(0.00)[embeddedor.com];
	HAS_X_SOURCE(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[embeddedor.com:-];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gustavo@embeddedor.com,linux-wireless@vger.kernel.org];
	HAS_X_ANTIABUSE(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,embeddedor.com:mid]
X-Rspamd-Queue-Id: 13C4916B9F4
X-Rspamd-Action: no action

[..]

> yes, it defines a hardware interface. But note the 'info' is a union, and each
> member of the union is there to support a specific value of roam_ctrl. And
> since the WMI_SET_HOST_BIAS roam_ctrl is not used, the only important thing to
> consider with your patch is that the location of the roam_ctrl field must not
> change, and hence the size of union info must not change.
> 

[..]

> So the size of the message and the location of roam_ctrl is unchanged.

Perfect! With that confirmation, I can proceed with v3. :)

Thanks!
-Gustavo



