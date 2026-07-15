Return-Path: <linux-wireless+bounces-39118-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tpjLBwrjVmq5CQEAu9opvQ
	(envelope-from <linux-wireless+bounces-39118-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 03:31:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B0690759E4F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 03:31:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39118-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39118-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BAC63016668
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 01:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE66B13790B;
	Wed, 15 Jul 2026 01:31:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E61342BC2D;
	Wed, 15 Jul 2026 01:31:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079110; cv=none; b=SJFA0LOPp+hnB6Eb2R4MmuEGAKAXCaILR1bTcZcn0htVgjuDn+9z4TBYPe1XezBC9Mu8pO2+ooB9qCNvYXvq6/wr51l72t02XoT2axXCslEikmqLux3E8yA66dCWTZUnnw5+yp76D1bV4DH261/kC43bQEtwTc0cyvDodq5OenA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079110; c=relaxed/simple;
	bh=JolINCmfYn2E7e7jQpQVb8AT4gX2d5879Tl7fkZpYDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvuZXvFhWsrpnU9UQC9q9KmEONr0CFqCF+Eiw57+GSQPrDAq8ScZi9RI9Oe5E2noy0MuLXdb4Pj0B+X/S9QH7K9KW9ghlkzhBj+tJ6o9Xorhe35uaNwv8Wiw6hmWdB4ZIW9E6tlYOgMDTkq1YXArK9D4u5qPIgZr2jHKK6eNw/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: ef2f05047fec11f1aa26b74ffac11d73-20260715
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:33fab99c-e2d0-42db-bf54-18643809bb07,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:681d94a704a6d08e0fd9a6deed779929,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ef2f05047fec11f1aa26b74ffac11d73-20260715
X-User: liujiajia@kylinos.cn
Received: from nature [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liujiajia@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1654905911; Wed, 15 Jul 2026 09:31:42 +0800
Date: Wed, 15 Jul 2026 09:31:40 +0800
From: Jiajia Liu <liujiajia@kylinos.cn>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "Berg, Benjamin" <benjamin.berg@intel.com>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: iwlwifi: use unique thermal zone type
Message-ID: <albi_EA_RuiEQ8kK@nature>
References: <20260312014043.13361-1-liujiajia@kylinos.cn>
 <DS0PR11MB7880D6838D23BBE2A821FF1BA3F92@DS0PR11MB7880.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7880D6838D23BBE2A821FF1BA3F92@DS0PR11MB7880.namprd11.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:miriam.rachel.korenblit@intel.com,m:benjamin.berg@intel.com,m:johannes.berg@intel.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_SENDER(0.00)[liujiajia@kylinos.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liujiajia@kylinos.cn,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-39118-lists,linux-wireless=lfdr.de];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,kylinos.cn:email,kylinos.cn:from_mime,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0690759E4F

On Tue, Jul 14, 2026 at 06:58:40PM +0000, Korenblit, Miriam Rachel wrote:
> 
> 
> > -----Original Message-----
> > From: Jiajia Liu <liujiajia@kylinos.cn>
> > Sent: Thursday, March 12, 2026 3:41 AM
> > To: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>; Berg,
> > Benjamin <benjamin.berg@intel.com>; Berg, Johannes
> > <johannes.berg@intel.com>; linux-wireless@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Cc: Jiajia Liu <liujiajia@kylinos.cn>
> > Subject: [PATCH] wifi: iwlwifi: use unique thermal zone type
> > 
> > Unloading iwlmld or iwlmvm can trigger hung task when two devices using
> > iwlmvm and iwlmld respectively on one setup. Their thermal zones have the
> > same type and share the same hwmon device created by the first zone. The
> > second zone indirectly holds the first zone through hwmon and prevents the first
> > zone from unregistering.
> > Tested with AX211 (8086:7af0) and BE200 (8086:272b).
> > 
> > INFO: task modprobe:5295 blocked for more than 120 seconds.
> >       Not tainted 7.0.0-rc2-up1 #2
> > Call Trace:
> >  __schedule+0x4df/0xfd0
> >  schedule+0x27/0xd0
> >  schedule_timeout+0xbd/0x100
> >  __wait_for_common+0x97/0x1b0
> >  ? __pfx_schedule_timeout+0x10/0x10
> >  thermal_zone_device_unregister+0x173/0x1c0
> >  iwl_mld_thermal_exit+0xbb/0xd0 [iwlmld]
> >  iwl_op_mode_mld_stop+0x37/0x120 [iwlmld]
> >  iwl_opmode_deregister+0xc0/0x160 [iwlwifi]
> >  __do_sys_delete_module+0x1b5/0x320
> > 
> > Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
> > ---
> >  drivers/net/wireless/intel/iwlwifi/iwl-utils.c   | 10 ++++++++++
> >  drivers/net/wireless/intel/iwlwifi/iwl-utils.h   |  4 ++++
> >  drivers/net/wireless/intel/iwlwifi/mld/thermal.c |  4 ++--
> >  drivers/net/wireless/intel/iwlwifi/mvm/tt.c      |  6 ++++--
> >  4 files changed, 20 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-utils.c
> > b/drivers/net/wireless/intel/iwlwifi/iwl-utils.c
> > index d503544fda40..fe5fa5e59664 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/iwl-utils.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/iwl-utils.c
> > @@ -193,3 +193,13 @@ s8 iwl_average_neg_dbm(const u8 *neg_dbm_values,
> > u8 len)
> >  	return clamp(average_magnitude - i, -128, 0);  }
> > IWL_EXPORT_SYMBOL(iwl_average_neg_dbm);
> > +
> > +#ifdef CONFIG_THERMAL
> > +u8 iwl_thermal_zone_get_id(void)
> > +{
> > +	static atomic_t counter = ATOMIC_INIT(0);
> > +
> > +	return atomic_inc_return(&counter) & 0xFF; }
> > +IWL_EXPORT_SYMBOL(iwl_thermal_zone_get_id);
> > +#endif
> > diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-utils.h
> > b/drivers/net/wireless/intel/iwlwifi/iwl-utils.h
> > index 5172035e4d26..84a4543fd290 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/iwl-utils.h
> > +++ b/drivers/net/wireless/intel/iwlwifi/iwl-utils.h
> > @@ -55,4 +55,8 @@ u32 iwl_find_ie_offset(u8 *beacon, u8 eid, u32 frame_size)
> > 
> >  s8 iwl_average_neg_dbm(const u8 *neg_dbm_values, u8 len);
> > 
> > +#ifdef CONFIG_THERMAL
> > +u8 iwl_thermal_zone_get_id(void);
> > +#endif
> > +
> >  #endif /* __iwl_utils_h__ */
> > diff --git a/drivers/net/wireless/intel/iwlwifi/mld/thermal.c
> > b/drivers/net/wireless/intel/iwlwifi/mld/thermal.c
> > index f8a8c35066be..500028a4dbd3 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/mld/thermal.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mld/thermal.c
> > @@ -5,6 +5,7 @@
> >  #ifdef CONFIG_THERMAL
> >  #include <linux/sort.h>
> >  #include <linux/thermal.h>
> > +#include "iwl-utils.h"
> >  #endif
> > 
> >  #include "fw/api/phy.h"
> > @@ -243,7 +244,6 @@ static void iwl_mld_thermal_zone_register(struct
> > iwl_mld *mld)  {
> >  	int ret;
> >  	char name[16];
> > -	static atomic_t counter = ATOMIC_INIT(0);
> >  	struct thermal_trip trips[IWL_MAX_DTS_TRIPS] = {
> >  		[0 ... IWL_MAX_DTS_TRIPS - 1] = {
> >  			.temperature = THERMAL_TEMP_INVALID, @@ -254,7
> > +254,7 @@ static void iwl_mld_thermal_zone_register(struct iwl_mld *mld)
> > 
> >  	BUILD_BUG_ON(ARRAY_SIZE(name) >= THERMAL_NAME_LENGTH);
> > 
> > -	sprintf(name, "iwlwifi_%u", atomic_inc_return(&counter) & 0xFF);
> Any reason not to have iwlmld (and iwlmvm in mvm) instead of a shared counter?

I was not sure if it would break user space.

This issue is fixed by thermal hwmon at

https://lore.kernel.org/linux-pm/6017595.DvuYhMxLoT@rafael.j.wysocki/

with commit d6323469bcfb ("thermal: hwmon: Register a hwmon device for each thermal zone") in v7.2-rc1.

> 
> > +	sprintf(name, "iwlwifi_%u", iwl_thermal_zone_get_id());
> >  	mld->tzone =
> >  		thermal_zone_device_register_with_trips(name, trips,
> >  							IWL_MAX_DTS_TRIPS,
> > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > index 53bab21ebae2..ea8e616174db 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > @@ -7,6 +7,9 @@
> >  #include <linux/sort.h>
> > 
> >  #include "mvm.h"
> > +#ifdef CONFIG_THERMAL
> > +#include "iwl-utils.h"
> > +#endif
> > 
> >  #define IWL_MVM_NUM_CTDP_STEPS		20
> >  #define IWL_MVM_MIN_CTDP_BUDGET_MW	150
> > @@ -652,7 +655,6 @@ static void iwl_mvm_thermal_zone_register(struct
> > iwl_mvm *mvm)  {
> >  	int i, ret;
> >  	char name[16];
> > -	static atomic_t counter = ATOMIC_INIT(0);
> > 
> >  	if (!iwl_mvm_is_tt_in_fw(mvm)) {
> >  		mvm->tz_device.tzone = NULL;
> > @@ -662,7 +664,7 @@ static void iwl_mvm_thermal_zone_register(struct
> > iwl_mvm *mvm)
> > 
> >  	BUILD_BUG_ON(ARRAY_SIZE(name) >= THERMAL_NAME_LENGTH);
> > 
> > -	sprintf(name, "iwlwifi_%u", atomic_inc_return(&counter) & 0xFF);
> > +	sprintf(name, "iwlwifi_%u", iwl_thermal_zone_get_id());
> >  	/*
> >  	 * 0 is a valid temperature,
> >  	 * so initialize the array with S16_MIN which invalid temperature
> > --
> > 2.53.0
> 

