Return-Path: <linux-wireless+bounces-13092-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB44F9839F4
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 01:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6021F2207C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 22:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A259A12CD89;
	Mon, 23 Sep 2024 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="FbHY57bP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B142126BE0
	for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2024 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130730; cv=none; b=FzhIhfQyXRBphdHCSzCLlmcYC97QtJOSUCvm0ojnDMLbf0Ql8PpCoToqlq4jNz6N8M5EsqWPNOx3pFtTrLMqR/+8O9EBGhw1ERzgoyg8FSgFbyNrS9SKRvolunSgejYAkdmVa4fMxlkC+1a6oyZbhNbg0auQ5UnbUgwWB+z9KTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130730; c=relaxed/simple;
	bh=YtQq87q7e+eI2hD8wOoBBmQF0k8GZh38DnvAVTLm3H4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=S1gEcpiL7FJRRycjQfp41GvDQuxyCb5nPtbP8cBvz26hz/YmFi2Fs9Df2w0djaBAfE28A8Q/ktOm9DM42lOQ4SQkCPlL0BFqI8SSy77Kz6yLVnvMrLc6FCy6USyojZhCay//YZXEy3ag9nkoQhoBVLmPFPCYkB3ICrJmz/1D7is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=FbHY57bP; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5F8313C007D
	for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2024 22:32:06 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id BE99613C2B0
	for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2024 15:32:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com BE99613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1727130725;
	bh=YtQq87q7e+eI2hD8wOoBBmQF0k8GZh38DnvAVTLm3H4=;
	h=Date:To:From:Subject:From;
	b=FbHY57bPJ5oN1YbdZPQv+fN8la+Gjm1nIldsGwH7QOA9diK90cdhPRQM9jC8jE/pz
	 SooLZEnmwuniia7eWOnEzoVdoBPWO7S1RNjnozh2L7ZjfDvOxBqf7U8ku+Ic48WS51
	 T20XhMCZ+c+yQa/PTuTnTRLu2TYNNVN5dKbyXWYs=
Message-ID: <281bc376-6015-04d7-c2d4-e6bff9f9f085@candelatech.com>
Date: Mon, 23 Sep 2024 15:32:05 -0700
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
Subject: How to set txpower on a radio with mt76?
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1727130727-rZyTBHqS7wt8
X-MDID-O:
 us5;at1;1727130727;rZyTBHqS7wt8;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

I've been doing something like this...for a really long time:

./local/sbin/iw phy phy0 set txpower limit 1500

While debugging today, I notice that this never manages to send anything down
to the mt7996 driver.

Part of it maybe that the driver doesn't handle the BSS_CHANGED_TXPOWER,
but none of mt76 seems to support that, so maybe not a critical oversight?


As I understand it, in the method below, the call to ieee80211_hw_config(sdata->local, 0)
is completely worthless since changed flags are 0 so method just returns?

If the driver cannot do per BSS txpower, what is the proper way to have mac80211
set the radio txpower?


bool __ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata)
{
	struct ieee80211_chanctx_conf *chanctx_conf;
	int power;

	rcu_read_lock();
	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
	if (!chanctx_conf) {
		rcu_read_unlock();
		return false;
	}

	power = ieee80211_chandef_max_power(&chanctx_conf->def);
	rcu_read_unlock();

	if (sdata->deflink.user_power_level != IEEE80211_UNSET_POWER_LEVEL)
		power = min(power, sdata->deflink.user_power_level);

	if (sdata->deflink.ap_power_level != IEEE80211_UNSET_POWER_LEVEL)
		power = min(power, sdata->deflink.ap_power_level);

	if (power != sdata->vif.bss_conf.txpower) {
		sdata->vif.bss_conf.txpower = power;
		ieee80211_hw_config(sdata->local, 0);
		return true;
	}

	return false;
}


Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


