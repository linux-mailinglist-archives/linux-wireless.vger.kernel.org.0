Return-Path: <linux-wireless+bounces-10278-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44935933487
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 01:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704DC1C2224B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 23:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469E113CFBC;
	Tue, 16 Jul 2024 23:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="U89F3OVN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49421DFDE
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jul 2024 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721172369; cv=none; b=CxG+YSwS2KfkgyX4mI5GQ+EJfRYblLwnmZRkWf1BhkWCOjo+fSW4OSQCgZJGVUDoKBAFCylq6QcKOgDgNpEPBaGc7sGWRSrgVdYwIHo+ria12VuHeFlCvbM4gB2UGhPapLqZfIl93S37iPquTIHL92K0lzhZtvsPvxLJLehCjrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721172369; c=relaxed/simple;
	bh=2uE8Wu5C2W+2p1m9cAhESdQKfGDHeZGIcUKAQASHK/U=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=PWSoI0UxAOoxJ6uaxDFJlXEvO3vsy1ibSRqVmM2B7uZeRYlusDiH+tKzLxRmBHzwAHkppZ/gTXp7mFR59bNAKsCxP88R0mqeiyurfMA/wISuyRMNpXFTIOAMOAWoGiQai9bMRam0M4v5oG84TO1EwxWJLweDOURomM2jkZi+nP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=U89F3OVN; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 309E3B8008D
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jul 2024 23:25:59 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id A947213C2B0
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jul 2024 16:25:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A947213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1721172358;
	bh=2uE8Wu5C2W+2p1m9cAhESdQKfGDHeZGIcUKAQASHK/U=;
	h=Date:To:From:Subject:From;
	b=U89F3OVNB3cMEQVyoj96oeMkzXgQmaw7ZPlKf9Rlszon2fx+XbJ0NPuqDnVNQ2oi0
	 G0UtSENapMkrPIjU13D/uSXWW1U9j1mSiulMIErgFVRVl6cIVv/91YXQmQx5jFtpme
	 m/NijfuEqme/jLdh9gx0cb4Qy00LqmGW80KlxBXA=
Message-ID: <d42ef01b-996b-a645-d59e-f3dec5a974a9@candelatech.com>
Date: Tue, 16 Jul 2024 16:25:58 -0700
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
Subject: HACK/RFC: Fix link_sta->rx_nss == 0 in iwlwifi upon eMLSR link
 change.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1721172359-mCWK-13Yhke5
X-MDID-O:
 us5;ut7;1721172359;mCWK-13Yhke5;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

While poking around at some instability and poor performance seen in download
direction, I noticed that the rate-ctrl was probably set incorrectly in
the iwlwifi driver due to link_sta->rx_nss being zero when changing active link
to the secondary link (the one we didn't originally associate with).

After debugging, I found that the hack below will make this problem
go away.  I sincerely doubt this is the correct approach, but I'm not
sure how it is all supposed to work in the first place.

And as a side note, even once this is fixed, download throughput still suffers
much of the time.  AP may be buggy, it is hard to tell where the fault lies.

diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 4dc1def69548..b69d0eb250d6 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -39,6 +39,27 @@ void rate_control_rate_init(struct sta_info *sta)

         ieee80211_sta_init_nss(&sta->deflink);

+       pr_info("rate: sta-init-nss called from rate-control-rate-init, nss: %d\n",
+               sta->deflink.pub->rx_nss);
+
+       {
+               int z;
+
+               for (z = 0; z<IEEE80211_MLD_MAX_NUM_LINKS; z++) {
+                       struct link_sta_info *ls =
+                               rcu_dereference_protected(sta->link[z],
+                                                         lockdep_is_held(&local->hw.wiphy->mtx));
+                       if (!ls)
+                               continue;
+                       if (ls == &sta->deflink)
+                               continue;
+
+                       pr_info("rate: rate-control-rate-init, setting other link rx_nss from: %d to %d  link-id: %d\n",
+                               ls->pub->rx_nss, sta->deflink.pub->rx_nss, z);
+                       ls->pub->rx_nss = sta->deflink.pub->rx_nss;
+               }
+       }
+
         if (!ref)
                 return;

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


