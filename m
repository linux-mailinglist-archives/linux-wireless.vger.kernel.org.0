Return-Path: <linux-wireless+bounces-21395-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F8EA8497F
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 18:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AAF0171236
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 16:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8B51EDA3C;
	Thu, 10 Apr 2025 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="RrlwdNE4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111BA1E991C
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302230; cv=none; b=Y6+cSIcTbSv8d5BPYTHkXQc1MO84fOKLaaI+K57nAJofwwRF9FfFYAkSG9X8PWnGXD8Add7kXTQJYskqkEjmUM49Cn+elErut8QMw7Uf0OZuOl7uy/843yd9Caxb2ZCD3apl2TeDUIY7xAsoqwAsw0ckUy7HRffs9Xg+0N2Iq8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302230; c=relaxed/simple;
	bh=C6ixc7FpzDsxWvykE1K/Ok8t5TgaCWHE8Zb2s41cUjw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=nyK4pKbcYUlgjvjMv4R9nxiGj+nz8vieAHQUcRnAp8j/b6bX1P4tHUkrgSopxcDBXO+43KnxplCYSlmq7HyQybDrUjR6hK0L9lEgvZGTqJWzWUjL1WtEq0i8ekNLc/wfRCGdsgtbE/aquRQFcV1za2W6HMSiELCGlSdASkfKfjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=RrlwdNE4; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from engine.ppe-hosted.com (unknown [10.7.65.239])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 5B0596013D
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 16:23:48 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8A3804000D0
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 16:23:46 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 2BAC013C2B0
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 09:23:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2BAC013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1744302226;
	bh=C6ixc7FpzDsxWvykE1K/Ok8t5TgaCWHE8Zb2s41cUjw=;
	h=Date:To:From:Subject:From;
	b=RrlwdNE4K2fO2lhq85Z3c6qZSECtgZrr3EF/pUFdkBf2UM/Dplxcqyw7E7iATPAEL
	 dNSEsQe4d1pWG5QK8UFG57jEGt5uqP0bx1RvUxUqvwRl+XEIwqkiTewyrwKv4d/ud2
	 EK3K0rDdDp6wB+nKx4CIxzW/VDyiU3/3PE+DbwQM=
Message-ID: <13cac1e0-6875-c63b-2b60-70cbbcfd951b@candelatech.com>
Date: Thu, 10 Apr 2025 09:23:45 -0700
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
Subject: iwlwifi: mld: Unused method iwl_mld_handle_tx_resp_notif (6.15-rc1)
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1744302227-Dxc8CQ4au-pa
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1744302227;Dxc8CQ4au-pa;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;

Hello,

I'm working on porting some patches we've previously added to mvm to the
mld driver.  Currently I'm looking at tx stats.  From what I can tell, this
method is not called from anywhere:

[greearb@ben-dt5 linux-2.6]$ git grep iwl_mld_handle_tx_resp_notif
drivers/net/wireless/intel/iwlwifi/mld/tx.c:void iwl_mld_handle_tx_resp_notif(struct iwl_mld *mld,
drivers/net/wireless/intel/iwlwifi/mld/tx.h:void iwl_mld_handle_tx_resp_notif(struct iwl_mld *mld,

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


