Return-Path: <linux-wireless+bounces-20400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ECEA6286B
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Mar 2025 08:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC752189FAAA
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Mar 2025 07:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6524A19340D;
	Sat, 15 Mar 2025 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="m1rnKBnb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03262AF07
	for <linux-wireless@vger.kernel.org>; Sat, 15 Mar 2025 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742024985; cv=none; b=YNEVoU6LCMsgylOPLW68xRaTViU2Nn6pqO8IlLtRZEYK89kWUo9LmKTfHF4aa5mCKjRM8n7sV3KkyqJA2GrV6rVfck+LbKATx6/PpN310/rCuDCrgdfsyyrKHzVXO2dxclRpz07liHGwoe9d9aZkOgMcRZkjowFVvbA2G+F7aCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742024985; c=relaxed/simple;
	bh=R0Gg5Jt7lqUVrBZPRV6z1e75dkugdVy+iodMgGgZx0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkLMdvWXMO1VYS6Tq4fTAkE6r8oYddaUjc9py3eUAO1HssLWWuRRRiCtkPOHyaUZ6KWBGGGaE3A11E+V+uFQD+79ZpoGImpQov+xAAF4TqExbCjAWQFr4cuJ84CCJ2HdGHgJjV3vH7279ArzIE+qZuZnMfMon/lf2hO9WYDWyi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=m1rnKBnb; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id tKcltGG5lMETltMH9tLm0D; Sat, 15 Mar 2025 07:49:43 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id tMH7t2JPAq3CNtMH8t4QlU; Sat, 15 Mar 2025 07:49:42 +0000
X-Authority-Analysis: v=2.4 cv=VpfoAP2n c=1 sm=1 tr=0 ts=67d53116
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=6Vi/Wpy7sgpXGMLew8oZcg==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=7T7KSl7uo7wA:10
 a=7XQe7QQrGAp21atFurkA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UNKnXi0eqTGn5Iah8wJgR3gA8aNMiLmiP3z2WLfLaC8=; b=m1rnKBnbBQ//eMuv0LxYb7I4Xw
	ulNkhmExLpXwVYxLPD1SBPrzthmE12QPN6TM0Xb25KW4355+q9+QDfPRVOE+ysemb7+dN6M159l+t
	udPmqNR6s5kHVEKoXxL3DR82usEFr32OMEb5MerN2MvZgYb5dYFu9zBahTFfyR5Qd64fjc7xan3LR
	ohWhHkrZBnkBTcaVNNS0ASO/PDRO1DY2uTWCszGx+xOEdQAznjdca28fKerEakgNZOlfOa8gBwR9F
	XEpoEbPKg8RFAflC889nOUqQyeeWtNpG8YabA10QaJ6QzJfjj7Jls8FNavaR8kQLQcdHHpdmGQBcU
	yuIWwJwg==;
Received: from [45.124.203.140] (port=53936 helo=[192.168.0.160])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1ttMH5-00000003ubx-3aqH;
	Sat, 15 Mar 2025 02:49:41 -0500
Message-ID: <b6dd5eff-581f-41e0-a121-8d0614b1a469@embeddedor.com>
Date: Sat, 15 Mar 2025 18:19:25 +1030
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: iwlwifi: dvm: Avoid
 -Wflex-array-member-not-at-end warnings
To: Johannes Berg <johannes@sipsolutions.net>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Zr5QR03+wyw571zd@elsanto>
 <b0f25000-396c-4a83-abc1-1a07b3065c10@embeddedor.com>
 <75551003-17c7-450a-89b0-818b6a01051c@embeddedor.com>
 <af8e60b46567a0612b71d4cd198b07dc93b046e4.camel@sipsolutions.net>
 <c058eedc7fe0d6b58dba376140291a0ba048a6d5.camel@sipsolutions.net>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <c058eedc7fe0d6b58dba376140291a0ba048a6d5.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 45.124.203.140
X-Source-L: No
X-Exim-ID: 1ttMH5-00000003ubx-3aqH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.160]) [45.124.203.140]:53936
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMMgW81Vl6jAOl/vcqgKJe2eFGQ/Izm94Je3bfzkxKfOIT68s+P8MBcBKijnXqiOJm5SlQMfqZrQD4mZcyBESUZmSrqtcUwIYP4YEHemEtMsnpfbO5er
 yAIwdAwhRSfZGSGcuB1m4iJlzOE4fmGTXk4+vW6dXGpE54AaTP0cRj80dG9O4p5C8gO+teyreTJAk5tU/Y+ZY2xI6zl8koxkyTTASSWjnIjv583rJtO8+cVL



On 11/03/25 21:12, Johannes Berg wrote:
> On Tue, 2025-03-11 at 11:40 +0100, Johannes Berg wrote:
>> On Mon, 2025-03-10 at 14:17 +1030, Gustavo A. R. Silva wrote:
>>> Hi all,
>>>
>>> I wonder who can take this patch, please. :)
>>>
>>
>> At the very least you're going to have to resend, I don't have the patch
>> in patchwork any more.
>>
> 
> Oh, no, sorry, it's still there but assigned to Miri.

I see.

It's been months. I wonder what can we do to move it to -next. :)

Thanks
--
Gustavo

