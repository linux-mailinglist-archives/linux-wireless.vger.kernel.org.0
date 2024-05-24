Return-Path: <linux-wireless+bounces-8038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CE08CE1BA
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 09:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4369E1F21D5D
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 07:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B234839EB;
	Fri, 24 May 2024 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D+4fGya2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9CC82892;
	Fri, 24 May 2024 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536906; cv=none; b=bow0UEbznEc3KIzPKeQ9ySZvT74/StyXcBW6zQWz96Vg4ZU1fLXHWXL/dcMZDjzZAwE2dWirP5d7LrJb/GV76zoxJ5qPEBeYJT+bNvB5nr3XYHuXPEXHn69z/w2O113BNtO+x9eYnpBcd7oF9whvaswyYxhAyubaTdKHt/mxviI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536906; c=relaxed/simple;
	bh=G9of7yjWCLy7s/7xrTDLYwVEPLTdCopPiEDSzmy57yM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jP+w6cMEpf43skuVjxU9m1FmcwsD6b3kKY05ubiA09eKexDdME4dRXIDBH2Qs7i+MBjs8q8tbqvDHkFkJCBzNv6jw96ML8iKqhm63AtZgGmki7JibxM/DGakUJaZ9D+kv5zwuwggimhvN9HiOfdCJgajiWCm19wNS+8G5v6YvvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=D+4fGya2; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O7mCIU109969;
	Fri, 24 May 2024 02:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716536892;
	bh=G9of7yjWCLy7s/7xrTDLYwVEPLTdCopPiEDSzmy57yM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=D+4fGya28lc7tqSnGAIDg3Bk97anaut1RWLFdp44ekVDp51D+RnP8DtEnb4+isf23
	 iyLHDvfZbvvbcSqlUAOThpsxMHCXNjsJROH05E0kEhaehtmKx9KeuZIhTB6Xf6DG+q
	 b+jotmRydPTC/55GlVGHwYwUB9GeYQMCpH3ILXDE=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O7mCeR106592
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 02:48:12 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 02:48:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 02:48:12 -0500
Received: from [10.250.145.232] ([10.250.145.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O7m9NR012044;
	Fri, 24 May 2024 02:48:10 -0500
Message-ID: <00c132c2-7f3e-4d3a-939e-a1b2801dd937@ti.com>
Date: Fri, 24 May 2024 10:48:08 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] Add conf.h
To: Kalle Valo <kvalo@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>, Breno Leitao <leitao@debian.org>,
        Justin Stitt <justinstitt@google.com>,
        Kees Cook <keescook@chromium.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sabeeh Khan
	<sabeeh-khan@ti.com>
References: <20240521171841.884576-1-michael.nemanov@ti.com>
 <20240521171841.884576-14-michael.nemanov@ti.com>
 <9ba9d156-ce38-47ba-b0fb-63e6174c3094@kernel.org> <87r0dtattp.fsf@kernel.org>
 <735594c5-5f50-49b0-b84c-e41efbb834b0@kernel.org> <87ikz5atdr.fsf@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <87ikz5atdr.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 5/23/2024 10:18 AM, Kalle Valo wrote:
> Michael, it would be good to explain that in the cover letter so that
> people don't get confused about these multiple patches. Maybe even
> include the link?

Sure, will add link and explanation in v2.


