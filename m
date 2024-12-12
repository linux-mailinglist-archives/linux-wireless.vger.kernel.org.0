Return-Path: <linux-wireless+bounces-16340-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7555D9EFD91
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 21:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C6E2882A7
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 20:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333E018A6B5;
	Thu, 12 Dec 2024 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="a6/p+8wE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96681422D4
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734036060; cv=none; b=EHE9hprAg9I4ows491RuysZoNBAzsSCzqkueUNmlqyTjlh5LG2a1nOlQcZxFtR6zX/Aecl17pfYuTaAQeWsDbfcw16RMABi7VQQ6jcFVYt+DWb07YJlHB/gGJZlVtglfGaKRHqNSeBpOdKOg5m56pl0NPZ0xbVhk4oSa75WINfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734036060; c=relaxed/simple;
	bh=hJDIfoyE61ENzYjvaD+sMY7mTahoT8AFRHDjW0Vj+6o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mPgN/tpEra7Ts2q8O6DBYZ9OdmbhqqH6y0RUYbY6SlmQOImWHgj9oPIunEWEIWCqgGUqU8/NQ9tCr6wWl8fKVLcfoqX2z//AR7xOzUXuBp8WGoKOHZB/Shlg7+zZ+3kgFdLpJ1jd/mEM5PPdM/Lq/UOdmaIIDAkT036GYjMybLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=a6/p+8wE; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 91B522A6B8F
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 20:40:42 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 4C707100105;
	Thu, 12 Dec 2024 20:40:35 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id D6D2113C2B0;
	Thu, 12 Dec 2024 12:40:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D6D2113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1734036034;
	bh=hJDIfoyE61ENzYjvaD+sMY7mTahoT8AFRHDjW0Vj+6o=;
	h=Date:To:Cc:From:Subject:From;
	b=a6/p+8wEe+Q/sdQb+XHlzycy3U1Idcm7/Y6DYB1edOvEyLZcwTwhaUtnUtMm75Vcd
	 FjmT3Vc+JaDYFdoTYrRjVdroI4wP110898HpXTGX0eddSpEp8HS66ldzlqukIxrFjG
	 AkYRNLvlPNS329+WVyRBiSo09T6y2J060+PvSjMI=
Message-ID: <9e15167d-d4ef-9306-d70b-94f056fec413@candelatech.com>
Date: Thu, 12 Dec 2024 12:40:34 -0800
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
Cc: "Berg, Johannes" <johannes.berg@intel.com>
From: Ben Greear <greearb@candelatech.com>
Subject: Intel be200 leaving ESR due to low RSSI
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1734036036-ud7yHsUuZiTm
X-MDID-O:
 us5;ut7;1734036036;ud7yHsUuZiTm;<greearb@candelatech.com>;232dd55d48f96bb835b07b88a6baba61
X-PPE-TRUSTED: V=1;DIR=OUT;

Hello,

I've been testing in a chambered setup with a mesh testbed, doing eMLSR testing.

I am noticing something I cannot explain:

Fairly often, ESR mode is disabled due to low RSSI.  On the one I caught with
debugging code, it was on link-2, but as of now, I'm not sure that is always
the case.  Both links actually have RSSI in the -46 range on average.  But also,
there are faint beacons from farther-away (through attenuators to another RF chamber)
mesh APs with same SSID.
Any chance the firmware is listening to those far away beacons and reporting that
in the OPER_STATS?  I'm using v94 firmware, latest available AFAIK.

Here's my debugging output and warn-on-once splat I used to make this assumption:

2236 [77144.620999] iwlwifi 0000:15:00.0: iwl_mvm_update_link_sig esr: update-link-sig-low-rssi, Link 2 link-info-sig: 180 sig: -76  thresh: -74 freq: 6465
2237 [77144.621040] ------------[ cut here ]------------
2238 [77144.621041] WARNING: CPU: 7 PID: 14476 at drivers/net/wireless/intel/iwlwifi/mvm/rx.c:728 iwl_mvm_update_link_sig+0x159/0x2e0 [iwlmvm]
...
2267 [77144.621332]  iwl_mvm_handle_rx_system_oper_stats+0x16a/0x600 [iwlmvm]
2270 [77144.621356]  iwl_mvm_async_handlers_by_context+0x107/0x170 [iwlmvm]
2271 [77144.621369]  cfg80211_wiphy_work+0xd5/0x140 [cfg80211]
...
2282 [77144.621431] iwlwifi 0000:15:00.0: iwl_mvm_exit_esr Exiting EMLSR. reason = EXIT_LOW_RSSI (0x20000). Current active links=0x6, new active links = 0x2


The debugging printout at the start of the info above comes from this:

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 3ac62ad0144b..41e8e3f7ef03 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -720,10 +720,16 @@ static void iwl_mvm_update_link_sig(struct ieee80211_vif *vif, int sig,
                                             &bss_conf->chanreq.oper,
                                             true);

-       if (sig < exit_esr_thresh)
+       if (sig < exit_esr_thresh) {
+               IWL_DEBUG_INFO(mvm,
+                              "esr: update-link-sig-low-rssi, Link %d link-info-sig: %d sig: %d  thresh: %d freq: %d\n",
+                              bss_conf->link_id, link_info->beacon_stats.avg_signal,
+                              sig, exit_esr_thresh, link_info->phy_ctxt->center_freq1);
+               WARN_ON_ONCE(true);
                 iwl_mvm_exit_esr(mvm, vif, IWL_MVM_ESR_EXIT_LOW_RSSI,
                                  iwl_mvm_get_other_link(vif,
                                                         bss_conf->link_id));
+       }
  }


As work around, I'm thinking of requiring 3 low RSSI reports in a row, or something
like that, before disabling ESR in that case.  Or maybe just look at the link_info->beacon_stats.avg_signal
and use that as tie-break (skip disabling ESR if the beacon_stats.avg_signal is within 6db of passing
the threshold check?  If I did my unsigned to signed bit math right, beacon_stats.avg_signal is -52
in this case, which is in expected range.)

Does that seem like decent work-around in your opinions?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


