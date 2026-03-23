Return-Path: <linux-wireless+bounces-33683-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOXiKtvNwGm2LQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33683-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 06:21:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 065FA2EC9FD
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 06:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4533300B46E
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 05:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5891A9B24;
	Mon, 23 Mar 2026 05:21:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7D3158535
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 05:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.112.30.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774243289; cv=none; b=TbA2ng1DhUnHh9noHzQmPDZrRfB/QZ6IfUR3KwQTxy4ErqDVZHRImpGb07W/2FcE6synfqv9Ovw+L9EKWqjQcC34bTgXEXECeNv9LPmhvwC3N1DBdIb9e7tl3q4P8CLq2fMNfHEIoAZXr8iB+PV3do2KvX/+hNUjouD3rKOk88w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774243289; c=relaxed/simple;
	bh=/VZnn8djpX+dd5nxqqCDeB4gEgYhbWiFp8fYksq1M/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8m4UdVHm8Yoloo4tSVv7oofi2i7aYgL3myBUDR8NZBt3NEqfOWsY3TeFSLQ98k5S0q0voM05UyuuKBB0C1PW2mS3/sW3IHHTZm+gr1ke1SK8bhlqJ4pVcgIULip/NSDQ6tiZpvrVakvUDCPqzd3RdeFZRnCVKegKgxNa52+j3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=wens.tw; arc=none smtp.client-ip=140.112.30.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wens.tw
Received: by wens.tw (Postfix, from userid 1000)
	id 486865FBB2; Mon, 23 Mar 2026 13:12:44 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: druth@google.com,
	Ping-Ke Shih <pkshih@realtek.com>,
	wireless-regdb@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Gaurav Kansal <gaurav.kansal@nic.gov.in>,
	Degrader Snehil <degradersnehil@gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for India (IN) on 6GHz
Date: Mon, 23 Mar 2026 13:12:40 +0800
Message-ID: <177424269386.1094638.13596680362967400436.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311085141.1634383-1-wens@kernel.org>
References: <20260311085141.1634383-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,realtek.com,lists.infradead.org,vger.kernel.org,sipsolutions.net,nic.gov.in,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33683-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 065FA2EC9FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 16:51:40 +0800, Chen-Yu Tsai wrote:
> The Government of India has officially opened this band for licence-exempt
> use via Gazette Notification G.S.R. 47(E), dated January 20, 2026,
> published January 21, 2026, issued by the Ministry of Communications
> under the Indian Telegraph Act, 1885 and the Indian Wireless Telegraphy
> Act, 1933.
> 
> Gazette details:
>   Title   : Use of Low Power and Very Low Power Wireless Access System
>             including Radio Local Area Network in Lower 6 GHz Band
>             (Exemption from Licensing Requirement) Rules, 2026
>   File No : 24-04/2025-UBB
>   Gazette : No. 47, CG-DL-E-21012026-269488
>   Signed  : Devendra Kumar Rai, Joint Secretary, Ministry of Communications
>   URL : https://www.dot.gov.in/static/uploads/2026/02/88f0ac8c74eb6f6907934d17d0015ab5.pdf
> 
> [...]

Late notification.

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory rules for India (IN) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/5db6ce73e616

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

