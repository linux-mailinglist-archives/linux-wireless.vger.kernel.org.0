Return-Path: <linux-wireless+bounces-5160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 783B0887A08
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Mar 2024 19:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0478A1F21765
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Mar 2024 18:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CC84C3C3;
	Sat, 23 Mar 2024 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="YB9oDZCE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AAC2940B
	for <linux-wireless@vger.kernel.org>; Sat, 23 Mar 2024 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711220164; cv=none; b=JhWuZ3VAM/7dxgiAm2gqSiPg7mqghMtCEkXzTVniVOKM7m9Ju4ee9BoS6E21NpLlRnRzEh1Uuycc//2OqSJtcxMr4bJlF8mNz4+sB6SXT2EP031d4YV6Q4/innBZZsM3RLQOMPQEBy+/ltmnmVwK6LbzQ3deuph0bvh9+mvbsHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711220164; c=relaxed/simple;
	bh=hKIMi+D5v/dJGevrVdrZ1CGi7DZlyxDMTZDZaiY+Vfw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=mRwU/zH95JI2Si4PSDEpfPw5fJ7kTbXyY8x+0yeORFEE3SOeCBiZcSbSssRFD4gYdgJBU69/UTYZiEHi1WTXLncz53Vgnh4BXdgluAn76+uPTXDp7S+/sliuYRblAMaqMgd05R0rVfIW6yTiv63ycw36jln11EMJsk8HWECUxk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=YB9oDZCE; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 917C0B00068
	for <linux-wireless@vger.kernel.org>; Sat, 23 Mar 2024 18:55:54 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 045B813C2B0
	for <linux-wireless@vger.kernel.org>; Sat, 23 Mar 2024 11:55:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 045B813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1711220153;
	bh=hKIMi+D5v/dJGevrVdrZ1CGi7DZlyxDMTZDZaiY+Vfw=;
	h=Date:To:From:Subject:From;
	b=YB9oDZCEvXsh3RXF77vWeh1kKFBtQH9WfK9CQNjVdKObDqlvsMXVwo9kQvxjGzqgM
	 hrjqg86rvmlJA3yT407AhATZtO4RazdlCk/j6VjpOeOhMId3aIg054EPQL1xnmaWBg
	 iV9/Z1MFdX99QuxSwkKMdm+yZDBtbBWIIKqh/M+k=
Message-ID: <1df701f9-3f27-4887-a9ed-60cf2f12beb4@candelatech.com>
Date: Sat, 23 Mar 2024 11:55:52 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-MW
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Subject: Access to ieee80211_conn_settings in the driver?
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1711220155-QnDtXje_plUI
X-MDID-O:
 us5;ut7;1711220155;QnDtXje_plUI;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

Hello,

I'm interested in getting access to ieee80211_conn_settings
struct in drivers.  Specifically, so I can deal with disabling
160Mhz in mt76 even if peer is 160Mhz for instance, on a per-station vdev basis.

Is this of general interest, and if so, any suggestions for you
you'd like to see it implemented?

Maybe put a copy of that struct into ieee80211_link_sta struct
during association so that the driver can find it?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

