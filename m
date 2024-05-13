Return-Path: <linux-wireless+bounces-7589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748638C3FCF
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 13:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E5C1C21451
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 11:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB4B14C590;
	Mon, 13 May 2024 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tr0jJKID"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAA514C58E
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715599666; cv=none; b=iZIqJW82qc05UQPmYRNDX4khc5cuyosWyEbUJpaultjZptD9xIQpoZyvv1Ph2wWn3WC+nOPQZlbKtjeVs+QfcTj83ZKeMI2ZHGCintqipsRqhGw5bDs1lTpFfgn5j4HCtLp0hDROM4dathurYNTVVM5ZSTRoirYNsXjOwMg5KmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715599666; c=relaxed/simple;
	bh=lNSjlbL5gaLvZ3AfzOsKvy+wLOnaG3uXFqnM9YBX3lU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hIWWIU0qWtlnT/6DuuPVzUmLarRMTQeBCQGSjL/uHAoNaGiBS8DRR1IKEJFptUUFpvHKvXskWVU/3eIaNpOHlnr9YwnRvXkpoL+v4KS8VbhOvxVfqLyVPLSMHkP42YPRvVUkq9tIBihTa3CXl6Xzz15PlLb0iCquOMnbVvLa/Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tr0jJKID; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44DBRe1t104999;
	Mon, 13 May 2024 06:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715599660;
	bh=2cXAMNZ7LUcMh/T60xJfG9QB3qZS2qy199RQ/bm4vTM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=tr0jJKID5HucJmTo3f1x1sDBtiacstnqtv2iB2DO4W27d1qLrTTxIlopDinbR0Y26
	 kP7fdWAfilL/VHAgLgvlW8YhPkOsx3/C2S+nNAbFYhtTd+VfijmcaIch3yx4zp48z4
	 uJOIDyP7sClnZUgdVKfZ4K1icqPG0KzPj3/KOpGY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44DBReJO120527
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 May 2024 06:27:40 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 May 2024 06:27:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 May 2024 06:27:40 -0500
Received: from [10.250.145.232] ([10.250.145.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44DBRcAr055255;
	Mon, 13 May 2024 06:27:38 -0500
Message-ID: <8c301a6d-a5a5-4821-82a8-5ea241b5159d@ti.com>
Date: Mon, 13 May 2024 14:27:37 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/17] wifi: cc33xx: Add driver for new TI CC33xx
 wireless device family
To: Kalle Valo <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Khan,
 Sabeeh" <sabeeh-khan@ti.com>
References: <20240512183247.2190242-1-michael.nemanov@ti.com>
 <87cypqjjpw.fsf@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <87cypqjjpw.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 5/13/2024 9:42 AM, Kalle Valo wrote:
[...]
> I didn't review this yet but decided to do some build testing and it
> doesn't even build:
>
> drivers/net/wireless/ti/cc33xx/debugfs.c: In function 'cc33xx_debugfs_add_files_helper':
> drivers/net/wireless/ti/cc33xx/debugfs.h:37:37: error: 'cc' undeclared (first use in this function)
>
> I also see some warnings from GCC. I pushed the patches to a pending
> branch so most likely you get reports from kbuild bot:

[...]

Sorry, I did not test with CONFIG_CFG80211_CERTIFICATION_ONUS=y and 
missed it. I will also make sure to build with W=1 and fix everything it 
throws.


