Return-Path: <linux-wireless+bounces-22723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FCFAAED7F
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 22:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E055B3B5EA2
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 20:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF5828B7D4;
	Wed,  7 May 2025 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="q57BdsoY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5371C17E4
	for <linux-wireless@vger.kernel.org>; Wed,  7 May 2025 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746651484; cv=none; b=b97ZImqMfnpp7OqrORb5KBZxjp+vdJW8f8HgJhFp4sa7dVwC8b/pMALY9AOl3JVz5ac3hP5qc8zWHfZMJeBlbLwgNFVxFygGOGun6a6l2F3DewnZYZcP0v3tXNXXAOLx/rbxyYkUZN31SoeNofNcov5h0rmTyyT7nj9W41E/fno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746651484; c=relaxed/simple;
	bh=5kHiapWhSgWOL97TCLULoo3iwJqqyjUP9BhkkA+4WXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KP+M+bKc/hmXQ/AgkdWM1nKJ9cdOBabaZqEMx4XNyDXjPyJO1IYSq6Aw/0EXwbGNqycwa/wfe9aYD9UTdTFxLwEDTQ67xr2nFnUxzl9jW5fkgBPHYVdNDmYpQ70IYD9f0gnDCeSABRW14+7uR5s0GebuZ0lONCZ+mtABfwT8up0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=q57BdsoY; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from engine.ppe-hosted.com (unknown [10.110.50.125])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 9F6BF600BE;
	Wed,  7 May 2025 20:57:55 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C53DE180073;
	Wed,  7 May 2025 20:57:53 +0000 (UTC)
Received: from [192.168.101.245] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 0CB6213C2B0;
	Wed,  7 May 2025 13:57:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0CB6213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1746651473;
	bh=5kHiapWhSgWOL97TCLULoo3iwJqqyjUP9BhkkA+4WXM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q57BdsoYGWh0P+iIIaFP1LZqp8Zi+Lrl22DxMQFJ7nWVKIalU9t6sKDCSOQ4zxr6/
	 QYx0peRcQw1Z/h/AXMrlcRc4wvGsdGWHsGdfQYG5ngAPjs1AQiAo/YkKhWljwHBLuK
	 4eMBpvvIy/+fFhG93rbpqLvLWRLsGHiYbpvNSjiQ=
Message-ID: <07f8ef36-0164-47b8-b6d8-092cb2cdcbda@candelatech.com>
Date: Wed, 7 May 2025 13:57:52 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mt76 v2 1/4] wifi: mt76: mt7996: Add per-radio phy debugfs
 directories.
To: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com, sean.wang@mediatek.com,
 linux-wireless@vger.kernel.org
References: <20250430232225.3943242-2-rory@candelatech.com>
 <202505071352.R4Bb2GN1-lkp@intel.com>
Content-Language: en-US
From: Rory Little <rory@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <202505071352.R4Bb2GN1-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1746651475-vBKEl52yHPd5
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1746651475;vBKEl52yHPd5;<rory@candelatech.com>;f49eb8a899f4a60c9b856bf22a60d609
X-PPE-TRUSTED: V=1;DIR=OUT;

> kernel test robot noticed the following build warnings:

My apologies for letting these slip through again. Before I resubmit a 
V3 - in hindsight dumping debugfs additions in with a refactor and two 
bugfixes was probably poor form on my part. Are there any parts of this 
series that are wanted upstream, and should I break those out into 
individual patches?

- Rory

