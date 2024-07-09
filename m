Return-Path: <linux-wireless+bounces-10130-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD8392BEE2
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 17:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C4728253A
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 15:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C9B158A0D;
	Tue,  9 Jul 2024 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="WSc2+lIQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C79515C9
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720540532; cv=none; b=CoLMSi5YJwDRCmeheZmusxR3+UZOl0yjVYKXTvptMu9VOpU5mwCJOC7p5/RJctWh+Vv5LwkIiu4n6RjZMfyrDMOiVHIreY7Yr/X4WA7sGv5GO0zIBm6y+suiH96lMW5mIlAT8cBrk9WaY7Gpyo5Agvp/LHUWfIyKgP7z/1No0+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720540532; c=relaxed/simple;
	bh=AUa7JBvhDlhCCCl/RuuJHmyihbvRvX9yEfohgAnFpz4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=D2uPVTTFx+Jl0JUvxVvYSXtsB7i+B58uxzldTa/v4cI+Q8GHWY/e3U98jpXzV+ov0nh6honSQg8Hi1boIH0JHYiEKRdGROqPh67qX3+4s+h6APfyF4tT/kBL6Y1vR3/afXy15fRjTExfEMjgLYIeHOVi6NSr0YZnSCkz4JfYGHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=WSc2+lIQ; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 886ACA800C5
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 15:55:22 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 05CFA13C2B0
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 08:55:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 05CFA13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1720540522;
	bh=AUa7JBvhDlhCCCl/RuuJHmyihbvRvX9yEfohgAnFpz4=;
	h=Date:To:From:Subject:From;
	b=WSc2+lIQ+larLvOIRn3DVyj+NfL1R80YwqcvxUwDkP1UfDLxFFqtpH6jv+jXjQZMW
	 2ePGwNX1kSmAkNQcH6G8bKWeKjGRiwG7PCeVRn6opFYWgMYEszv9Jsb/TutBhqQNqX
	 kPknE6yL9TCtteGZ5ThGNwtosqqAoyWfPZHOvYaY=
Message-ID: <6974c7b4-4915-d4c8-07c6-ee337005b50a@candelatech.com>
Date: Tue, 9 Jul 2024 08:55:21 -0700
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
Subject: MLO failing due to attempting wrong link-id
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1720540523-q_6prNIGS3Nj
X-MDID-O:
 us5;ut7;1720540523;q_6prNIGS3Nj;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

Hello Johannes et al,

I have an AP that is advertising MLO link 1 and 2 (but not zero).  I'm using be200
6.10 ish kernel, be200 hacked to enable MLO.

I am seeing that the method below is failing because link_id is set to 0,
and link and link_sta both end up at NULL.  When this happens, I see only
one active link (and no dormant ones) when looking at those fields in debugfs,
but there is a second link at least partially constructed and seen in debugfs.

I'm going to keep digging at this, but curious if this is already known
issue and fixed by some of the pending 6.11 patches?


static int sta_link_apply_parameters(struct ieee80211_local *local,
				     struct sta_info *sta, bool new_link,
				     struct link_station_parameters *params)
{
	int ret = 0;
	struct ieee80211_supported_band *sband;
	struct ieee80211_sub_if_data *sdata = sta->sdata;
	u32 link_id = params->link_id < 0 ? 0 : params->link_id;
	struct ieee80211_link_data *link =
		sdata_dereference(sdata->link[link_id], sdata);
	struct link_sta_info *link_sta =
		rcu_dereference_protected(sta->link[link_id],
					  lockdep_is_held(&local->hw.wiphy->mtx));

	/*
	 * If there are no changes, then accept a link that exist,
	 * unless it's a new link.
	 */
	if (params->link_id >= 0 && !new_link &&
	    !params->link_mac && !params->txpwr_set &&
	    !params->supported_rates_len &&
	    !params->ht_capa && !params->vht_capa &&
	    !params->he_capa && !params->eht_capa &&
	    !params->opmode_notif_used)
		return 0;

	if (!link || !link_sta) {
		sdata_info(sdata, "sta-link-apply-parameters failed: link: %p  link_sta: %p link-id: %d new-link: %d\n",
			   link, link_sta, link_id, new_link);
		return -EINVAL;
	}

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


