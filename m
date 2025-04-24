Return-Path: <linux-wireless+bounces-21957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 540E9A9A5DB
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 10:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B0C1B8468E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 08:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEB520CCDB;
	Thu, 24 Apr 2025 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L3C2TJ7r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD1320CCC9;
	Thu, 24 Apr 2025 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745483374; cv=none; b=kQS2W0/j0dMYHL2r1XJhw3K0hYjHNf6WU4tKM2lSF+sZ55Eq0urABehd0+uGqo9ANC6yRuaugSneo4OwwvOgfbz9TzKl9s0Rx8n3abE7Q0f5/+K3CDxCbPJgWecVwOAf48daB8Nr1AeoNNyzeq9qCb9cBz90WGcZUXkpYG24rho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745483374; c=relaxed/simple;
	bh=mzXrLZ+zThC8JVdE108Ow2XX4dTZEhqVbOPm0RFznxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OW34Y6TQahIH93qtNpGJGt2Eh5qv/2iHrl/+Vbg2fHURU+3m+gXsQJxsPtiryShtvWv43tAP/a4mt9/caNl+VZNVXlokUgsTMFQrawRIFS0Uaw7+KE/k1f8yZIETmDNyi6X6MTgCMpAy2JOSvsdYTuFUpHtPZ6KY6EXzkcSs9+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L3C2TJ7r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O0FCXY000760;
	Thu, 24 Apr 2025 08:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ce2+szJFVVCXItPctB5SRVkQOp2Hn3hgtD1PP+GOeFg=; b=L3C2TJ7r33WkKcTE
	0ekdWdtyNWgWviLVmVQ2GdGC9bHQntw8ruqf04qu7acJ1XjE56ZD7U/Fd6vCVAKU
	Dpa+3CJXRWZvdTV3B5CVu/fdhkDD/8YYXV+BLaBoyPBiFJVumtokquKtkzRedvhE
	/U3K32gsH/mN+2/01A/WTGtvTjVIDp6HMDy2WIM9m8uTq7t+M/pIrdyVmlVnymFp
	XlyP3Dqesixkb6uOqInVH3EyLfFmv64IIjIQLDFVqrVezuWqX+lydA5pKtG6F+ZL
	cAdb7p/VCJkqKDFgIOC/9jFXFxhdkjzFvCwnW8Den1GwbYvJ+Qcnlj1xnoMcRct7
	43xvnA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3cs71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 08:29:25 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53O8TPKP012841
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 08:29:25 GMT
Received: from [10.239.133.66] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 24 Apr
 2025 01:29:23 -0700
Message-ID: <b4cdc0e1-eca5-4687-8c53-11eee708ff7e@quicinc.com>
Date: Thu, 24 Apr 2025 16:29:21 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: mac80211: Prevent disconnect reports when no AP
 is associated
To: Johannes Berg <johannes@sipsolutions.net>,
        <miriam.rachel.korenblit@intel.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzbot+5a7b40bcb34dea5ca959@syzkaller.appspotmail.com>
References: <20250314120614.4032434-1-quic_zhonhan@quicinc.com>
 <4ed3cfbc1a5b80bb3577f73b8c2b19ce830eeff5.camel@sipsolutions.net>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <4ed3cfbc1a5b80bb3577f73b8c2b19ce830eeff5.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA1NSBTYWx0ZWRfXzUQLXjTV2Rag A7XTO5O+n3iDy0Q632VSxfAX7RIw91vrFwXjc1G4SJnyyRrgth4FBHuq+fo+gmhR9DavtPPkS7O AxdRJE51SYZbJtSY/gGf/yCM8ga3rAyXphu05kqeeeySzpwtbQNMlTOkZIuQyqaVLktZOJkLKF1
 DDxCAtdz80J+znZKXOaIbObBGgVqQSzCi2Js2GzsR6uV+iXjzA4WTeIh0KKbX0NY3bVSy9Rrxrc qc0xH5wg+yzIw9gb7z6Z0zX8aRlnb2sh9BrKiwEZRZRKzDIMXg4OaFUvUocyCApxGdG9DR3Q+Th +401fbnU4gRUr444N0T+LDKasLXrHlhvE3gv80TqD7TG3JF8qiRc3f/7yqIQlf6GAJUIdb/p5xv
 rcJv+CXQSAGfmvZS9Nsz2plJB9k3I2VmSG2kkWhugdhMgJlqwratXJlQzm8fxxiKpU3yrDLz
X-Authority-Analysis: v=2.4 cv=bs1MBFai c=1 sm=1 tr=0 ts=6809f665 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=l3WJKU5dAmXa39zxUUEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: sDdk7289vlCSMFnr1iuju_d6r9KpV1Bl
X-Proofpoint-GUID: sDdk7289vlCSMFnr1iuju_d6r9KpV1Bl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_04,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240055

On 4/23/2025 11:26 PM, Johannes Berg wrote:
> On Fri, 2025-03-14 at 20:06 +0800, Zhongqiu Han wrote:
>>
>> +++ b/net/mac80211/mlme.c
>> @@ -4433,6 +4433,10 @@ static void ieee80211_report_disconnect(struct ieee80211_sub_if_data *sdata,
>>   		.u.mlme.data = tx ? DEAUTH_TX_EVENT : DEAUTH_RX_EVENT,
>>   		.u.mlme.reason = reason,
>>   	};
>> +	struct sta_info *ap_sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
>> +
>> +	if (WARN_ON(!ap_sta))
>> +		return;
> 
> You're adding a WARN_ON() that's now guaranteed to trigger, no?
> Shouldn't the caller (also) be fixed?

Thanks Johannes for the review~

yes, the caller can first check if ap_sta is null, thereby preventing
further calls to ieee80211_set_disassoc and ieee80211_report_disconnect,
maybe just like the condition check for ifmgd->associated in the example
below:

static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
				   u16 stype, u16 reason, bool tx,
				   u8 *frame_buf)
{
	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
	struct ieee80211_local *local = sdata->local;
	struct sta_info *ap_sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
	unsigned int link_id;
	u64 changed = 0;
	struct ieee80211_prep_tx_info info = {
		.subtype = stype,
		.was_assoc = true,
		.link_id = ffs(sdata->vif.active_links) - 1,
	};

	lockdep_assert_wiphy(local->hw.wiphy);

	if (WARN_ON(!ap_sta))--------> introduced since 687a7c8a7227
		return;

	if (WARN_ON_ONCE(tx && !frame_buf))
		return;

	if (WARN_ON(!ifmgd->associated))
		return;
...
...
}

---example 1.
----------------------------------------------------------------
void ieee80211_sta_restart(struct ieee80211_sub_if_data *sdata)
{
	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;

	lockdep_assert_wiphy(sdata->local->hw.wiphy);

	if (!ifmgd->associated)
		return;

	if (sdata->flags & IEEE80211_SDATA_DISCONNECT_RESUME) {
		sdata->flags &= ~IEEE80211_SDATA_DISCONNECT_RESUME;
		mlme_dbg(sdata, "driver requested disconnect after resume\n");
		ieee80211_sta_connection_lost(sdata,
					      WLAN_REASON_UNSPECIFIED,
					      true);
		return;
	}

	if (sdata->flags & IEEE80211_SDATA_DISCONNECT_HW_RESTART) {
		sdata->flags &= ~IEEE80211_SDATA_DISCONNECT_HW_RESTART;
		mlme_dbg(sdata, "driver requested disconnect after hardware restart\n");
		ieee80211_sta_connection_lost(sdata,
					      WLAN_REASON_UNSPECIFIED,
					      true);
		return;
	}
}
----------------------------------------------------------------------


---example 2.
----------------------------------------------------------------------
static void ieee80211_rx_mgmt_deauth(struct ieee80211_sub_if_data 
*sdata, struct ieee80211_mgmt *mgmt, size_t len)
{
	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
	u16 reason_code = le16_to_cpu(mgmt->u.deauth.reason_code);

	lockdep_assert_wiphy(sdata->local->hw.wiphy);

	if (len < 24 + 2)
		return;

	if (!ether_addr_equal(mgmt->bssid, mgmt->sa)) {
		ieee80211_tdls_handle_disconnect(sdata, mgmt->sa, reason_code);
		return;
	}

	if (ifmgd->associated &&
	    ether_addr_equal(mgmt->bssid, sdata->vif.cfg.ap_addr)) {
		sdata_info(sdata, "deauthenticated from %pM (Reason: %u=%s)\n", 
sdata->vif.cfg.ap_addr, reason_code,
			   ieee80211_get_reason_code_string(reason_code));

		ieee80211_set_disassoc(sdata, 0, 0, false, NULL);

		ieee80211_report_disconnect(sdata, (u8 *)mgmt, len, false,
					    reason_code, false);
		return;
	}
...
...
...
}
---------------------------------------------------------------------


However, sorry I'm not sure if !ifmgd->associated and !ap_sta have
exactly the same context and treatment, especially in one situations
like the below example3:


---example3.
-----------------------------------------------------------------------
static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
{
	struct ieee80211_local *local = sdata->local;
	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];

	lockdep_assert_wiphy(local->hw.wiphy);

	if (!ifmgd->associated)
		return;

	if (!ifmgd->driver_disconnect) {
		unsigned int link_id;

		/*
		 * AP is probably out of range (or not reachable for another
		 * reason) so remove the bss structs for that AP. In the case
		 * of multi-link, it's not clear that all of them really are
		 * out of range, but if they weren't the driver likely would
		 * have switched to just have a single link active?
		 */
		for (link_id = 0;
		     link_id < ARRAY_SIZE(sdata->link);
		     link_id++) {
			struct ieee80211_link_data *link;

			link = sdata_dereference(sdata->link[link_id], sdata);
			if (!link || !link->conf->bss)
				continue;
			cfg80211_unlink_bss(local->hw.wiphy, link->conf->bss);
			link->conf->bss = NULL;
		}
	}

	ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
			       ifmgd->driver_disconnect ?
					WLAN_REASON_DEAUTH_LEAVING :
					WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
			       true, frame_buf);
	/* the other links will be destroyed */
	sdata->vif.bss_conf.csa_active = false;
	sdata->deflink.u.mgd.csa.waiting_bcn = false;
	sdata->deflink.u.mgd.csa.blocked_tx = false;
	ieee80211_vif_unblock_queues_csa(sdata);

	ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf), true,
				    WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
				    ifmgd->reconnect);
	ifmgd->reconnect = false;
}
------------------------------------------------------------------------

My next step plan is change the code to as below:
For example1 and example2 pattern, I want add more check about ap_sta
such as:
---------------------------------------------------------------------
	if (ifmgd->associated &&
	    ether_addr_equal(mgmt->bssid, sdata->vif.cfg.ap_addr && ap_sta)) {
---------------------------------------------------------------------
becasue if this condition meets, the if condition {} only execute
ieee80211_set_disassoc and ieee80211_report_disconnect.


For example3 pattern, i want to add check before the call of
ieee80211_report_disconnect, but it is indeed not perfect.
Thanks for your time and discussion~


> 
>> @@ -8090,7 +8094,7 @@ static void ieee80211_sta_timer(struct timer_list *t)
>>   void ieee80211_sta_connection_lost(struct ieee80211_sub_if_data *sdata,
>>   				   u8 reason, bool tx)
>>   {
>> -	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
>> +	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN] = {0};
>>
> 
> And that's not needed then? And perhaps should be {} if it is.
Yes, it is not needed even {}.
> 
> johannes


-- 
Thx and BRs,
Zhongqiu Han

