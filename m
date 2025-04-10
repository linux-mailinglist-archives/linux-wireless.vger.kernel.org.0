Return-Path: <linux-wireless+bounces-21397-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03084A84A40
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 18:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40BA49C5E0B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 16:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0EB1F099C;
	Thu, 10 Apr 2025 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="cBHhV6n9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDA51F09B3
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302785; cv=none; b=H71K5b8Wj2atP1zN90urbpU+1mUavqMpIKUlzRdpxK24EXh2vuwnkYwndaCXSqFJQVsmR+jn9BzjlCKa4AkR8X7IxdwWDD9HHCx7p8Z/i/1DGOzIPyAxoFDHhGawnJvJkG4QZZB31941RyNiFIpzDaCCzbvpaoPCzOz3hmors4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302785; c=relaxed/simple;
	bh=AHM4v+efvqjn3/JC8vnoKup5zjx2+4HsoX2xrO5ci+c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=tYadMH+eHb9XHv8mWRoQQEC7qC0ca6vLT/wNjxupOEXHrKG5sbteFx97l5QFhZZ+pfyc13KRsG9lMrUWCCBadLyygpvxT6AyWkv5vL60pqxXQ+vGc7rUIHpNHW+QYT5a4eY/C5ySE7nxBBwrCHavBhG+EMIWLiArt3MvCiygu6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=cBHhV6n9; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from engine.ppe-hosted.com (unknown [10.110.50.120])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id A425560124
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 16:33:02 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 1590C3C0091
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 16:33:00 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 46D5213C2B0
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 09:33:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 46D5213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1744302780;
	bh=AHM4v+efvqjn3/JC8vnoKup5zjx2+4HsoX2xrO5ci+c=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=cBHhV6n9PSq9CXz3j5n8r7b/hDjoeCkggfFDT3sIb7V9K99sfVpMCwPP7THY0TZLH
	 uByR5enZDKgSigHo1qwmVlZed/6B1pq1ldt1X/zlOZxQyiyGaVhoEcs5xpCBicfYI1
	 OjjUgg6Wvd+sy1Or9As7rnbE3TNekgujRR2cVGl0=
Message-ID: <427546e4-7e1b-6dbb-2bad-751d7061bb7d@candelatech.com>
Date: Thu, 10 Apr 2025 09:33:00 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: iwlwifi: mld: Unused method iwl_mld_handle_tx_resp_notif
 (6.15-rc1)
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
References: <13cac1e0-6875-c63b-2b60-70cbbcfd951b@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <13cac1e0-6875-c63b-2b60-70cbbcfd951b@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1744302781-5J_Ndvb8dgjZ
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1744302781;5J_Ndvb8dgjZ;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;

On 4/10/25 09:23, Ben Greear wrote:
> Hello,
> 
> I'm working on porting some patches we've previously added to mvm to the
> mld driver.  Currently I'm looking at tx stats.  From what I can tell, this
> method is not called from anywhere:
> 
> [greearb@ben-dt5 linux-2.6]$ git grep iwl_mld_handle_tx_resp_notif
> drivers/net/wireless/intel/iwlwifi/mld/tx.c:void iwl_mld_handle_tx_resp_notif(struct iwl_mld *mld,
> drivers/net/wireless/intel/iwlwifi/mld/tx.h:void iwl_mld_handle_tx_resp_notif(struct iwl_mld *mld,

Bleh, nevermind.  A macro builds the method name.

And I guess it would have failed on module load even though it compiled
with the .c method ifdef'd out.

Thanks,
Ben


