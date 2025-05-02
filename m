Return-Path: <linux-wireless+bounces-22315-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E204AAA67A0
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 02:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9133D5A15D0
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 00:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B047E36C;
	Fri,  2 May 2025 00:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="EhB1EZh/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92FF182
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 00:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746144177; cv=none; b=runtcx2CRCJEfJNRUUXYQx4SbstbmubYK9uzWka7g5mapzdPRqIavNFaMTRYmCnIUhAUsSpImtmoMWACoZursBrMTG+QLEw2EKc7kT1JDTuKBnCKA1ScNGS3rKc6jivNjwxD9QoGPGLATyRkJdyigOlHXqVplkWCQFY8gOoM7Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746144177; c=relaxed/simple;
	bh=YwmBn/uZfxaauIkcPESv3AADAG+1bJJSwvoMicowB+w=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=lM5W8uUI/FB3NfNdmLl+HmmPuR3WHoO8X6r2OV0/XM67Gc1BvJR3GNTbDXKD24l3PO9evCkr2+w0H+adac86ylnicrkLoPyXpCv5al68Vv4KWRntR8lKfK5DDfPkQJCAS6ZKX31ynfXB0y2w1Z3Q0J6Pb1S7TSleW7nBq5NX1X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=EhB1EZh/; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from engine.ppe-hosted.com (unknown [10.7.65.214])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 43609600BF;
	Fri,  2 May 2025 00:02:49 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8BACA60008A;
	Fri,  2 May 2025 00:02:47 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 14D7313C2B0;
	Thu,  1 May 2025 17:02:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 14D7313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1746144167;
	bh=YwmBn/uZfxaauIkcPESv3AADAG+1bJJSwvoMicowB+w=;
	h=Date:To:From:Subject:From;
	b=EhB1EZh/kyQRaDFA7MZL4glgWjJmf8wiblCY7gifwasRMVl/661bDs0aMFSBHldpo
	 2Ds/EypAHSPVYSxlEZizvGA3GhtF6xC3Jq6adzhxtXBi0l0bcyMLrT0WIyzEXb6JkM
	 ripOGMthVTrTmGBnAxqmXYi0BdiPabTLLkiipmzo=
Message-ID: <aee3f644-16f6-6edb-5e45-f9da3c021f89@candelatech.com>
Date: Thu, 1 May 2025 17:02:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: linux-wireless <linux-wireless@vger.kernel.org>,
 "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
From: Ben Greear <greearb@candelatech.com>
Subject: Intel mld stuck at 40Mhz on 6.15-rc4
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1746144168-lybG3lTgLVuZ
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1746144168;lybG3lTgLVuZ;<greearb@candelatech.com>;b05365583a7ac22983513582f8b41fd7
X-PPE-TRUSTED: V=1;DIR=OUT;

Hello Miri,

I am seeing an intel be200 radio using 6.15-rc4 + hacks kernel show only 40Mhz
bandwidth on a channel 36 wifi-7 AP that should be supporting at least 80Mhz.

I looked through the recent mld related driver patches on linux-wireless
but did not see anything that looked like it was addressing this.

Do you know if this is a known issue and/or is there a known
fix for bandwidth problems in STA mode for the new mld driver?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


