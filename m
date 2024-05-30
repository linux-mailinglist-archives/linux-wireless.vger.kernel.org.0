Return-Path: <linux-wireless+bounces-8313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25178D4BE7
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 14:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F72B1C220EC
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 12:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FF81E521;
	Thu, 30 May 2024 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="v9SEEwfX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EED1E492;
	Thu, 30 May 2024 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073196; cv=none; b=QErkuSA2M0jK0lOhVrOb+MsIgxX1d+ZIIKeiQ97fWgZZ5scF0FNSAugaDm4uKq5VsLlGbpstPlYigALtfxvNzcvkGAjFZVhvNbyQoCrN7n2BrQdMBB9rrYMXTDB1vd3sun8DZlAJ9KgbTyqFU1DpvqYdS5uFnD58BuSnhuUuVOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073196; c=relaxed/simple;
	bh=M5cLfJOtV1h8PSu49sdoWyPeSFo/8tAvf2DXyneFJQI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=JNbPMJP4FEIByox5Ps2TEVrWhE4/upOquZbwzbInZk2Ou/vEquZTb5khXzEwpr8EeYEfpiROBd3iae4txrJakJNNnD14X0VGSknnh2y3IX8J6AZvijStLocHLzJ7BKyQpeS2ySUH0qtYMbFT19MDl+H6vP4Ov1TLcvRLbNo7vig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=v9SEEwfX; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44UCkLNc077883;
	Thu, 30 May 2024 07:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717073181;
	bh=zYGq4EHSKfHIOX67qHZBni7kCft57gh+IHahPaxuDp4=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=v9SEEwfXB8H9R4J9eJXJSvrSDQOTeCmace4MGu45KjaZoRWXhuD4O4gRSxHBSkkup
	 pRyrTrcCgazsB3/sfyem9hvrjX6uJHbWtsBZwwOuHdPu89En06UYIhbRu1zyTH/QTu
	 BSq/tKkDMa6W6eR5SNKylw3UWm8yc0GgaO2t7cto=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44UCkLeh014887
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 May 2024 07:46:21 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 May 2024 07:46:20 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 May 2024 07:46:20 -0500
Received: from [137.167.6.219] (lt5cg1094w5k.dhcp.ti.com [137.167.6.219])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44UCkJsR019315;
	Thu, 30 May 2024 07:46:19 -0500
Message-ID: <24be3582-1b2d-4f94-9a16-26ab70da36b8@ti.com>
Date: Thu, 30 May 2024 15:46:18 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 6/8] wifi: wlcore: add pn16 support
From: "Nemanov, Michael" <michael.nemanov@ti.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>
References: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
 <E1sBsy7-00E8vu-Nc@rmk-PC.armlinux.org.uk>
 <e6ae6dfa-6554-4e88-abb0-31dbbd8df03f@ti.com>
 <Zlg2zGb7s7zu6jb+@shell.armlinux.org.uk>
 <ceba870f-34d3-4545-884e-f04f966646ab@ti.com>
Content-Language: en-US
In-Reply-To: <ceba870f-34d3-4545-884e-f04f966646ab@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 5/30/2024 3:25 PM, Nemanov, Michael wrote:
[...]

> 
> On 5/30/2024 11:20 AM, Russell King (Oracle) wrote:
> [...]
>> > The original code was > tx_lnk_free_pkts = 
>> status->counters.tx_lnk_free_pkts[i]; > diff = (tx_lnk_free_pkts - 
>> lnk->prev_freed_pkts) & 0xff; > > if (diff == 0) > continue; > > I 
>> wonder if comparing tx_lnk_free_pkts to 0 was added intentionally? 
>> This is > monotonously incremented counter so 0 is not significant, 
>> unlike the diff. > Have I missed something? You are... While you're 

[...]

And sorry for making a mess of the quoted text on the previous message, 
got it sorted now.

Michael.

