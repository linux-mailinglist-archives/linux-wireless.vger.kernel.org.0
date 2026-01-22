Return-Path: <linux-wireless+bounces-31050-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBapJGBucWkPHAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31050-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 01:25:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E2F5FEC5
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 01:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 930EF4E234E
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 00:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2CF2BDC10;
	Thu, 22 Jan 2026 00:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="QtU06Ac2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A041A2BD586
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 00:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769041499; cv=none; b=FbPFQV6CiNkLW97sHFtKN23MLWdyXaIju/ZVGbptE6QQ6wJcsHUvvUwLDr/XaOEpuCLd7Ik4KegGhTTj8wLWA/e2Rl4p8RK1Tdr4FOXBERWI9dNBZRZox7orrmZjzLCeNXnTZ4k9rH+g/a2wa47yQism4+RZ/GbhrttM6R9GJlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769041499; c=relaxed/simple;
	bh=Wglkq1u1s7FZ508kj5lAspIyejU89dlcuGnK2Hm8wG4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=EfNlTgo6Ax/EyBbXmampGgkF63UpPede73LJv0U7HZwShKwsYJ7j7HGL6rPK0fKiW49jYqdgkS4PPurLmVf1DUtxUQcfJXh1NrNjicTIXXfMg9mb+n3hpgKkDVoF3fQjGSkITt4cg2u26WzKaC+7TsOs51S8ir2VUCIZyu8V+5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=QtU06Ac2; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B87DC8C0072
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 00:24:54 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 246E613C2B0
	for <linux-wireless@vger.kernel.org>; Wed, 21 Jan 2026 16:24:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 246E613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1769041492;
	bh=Wglkq1u1s7FZ508kj5lAspIyejU89dlcuGnK2Hm8wG4=;
	h=Date:To:From:Subject:From;
	b=QtU06Ac2ZAJTwTBGy0qHNIAhoMko0Cs+PdSG2A2tlZu8h9m+MBBo88OSSdfASAAWw
	 zUiJ0tM9RuqC0eC0LuAtkgGuO8g4fzbWzPcQNuAG6rYeQcRIMkoLUBhLhmweuFqgAS
	 QfWt61WGIgGWcyo3kcLkx3lLY6z7H8+C+xJny0P0=
Message-ID: <1f62904f-bf2d-68a8-c527-77a40c7b8145@candelatech.com>
Date: Wed, 21 Jan 2026 16:24:51 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: linux-wireless <linux-wireless@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Subject: Setting txpower and antenna with radio-idx is broken.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1769041495-sIFnXBuIjlLe
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1769041495;sIFnXBuIjlLe;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31050-lists,linux-wireless=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[candelatech.com,none];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: F2E2F5FEC5
X-Rspamd-Action: no action

I took a look at net/wireless/nl80211.c, and noticed that
radio_idx is only assigned in a branch of code that will return.

So trying to pass it on to the set_antenna or set_txpower logic
can never happen.  I'm not sure how this was supposed to work,
maybe just not return after nl80211_set_wiphy_radio(info, rdev, radio_idx); ?

This is in today's linus kernel...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


