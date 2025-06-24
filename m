Return-Path: <linux-wireless+bounces-24423-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE205AE651E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 14:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29791188D0A4
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 12:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AB628EA4D;
	Tue, 24 Jun 2025 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B60uKzSK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17B32A1A4;
	Tue, 24 Jun 2025 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750768459; cv=none; b=p/K5LsEu9+eMEf0T6UUvc1KWGiOL00ydUViVWQ8geXCact4Hh+T0AHo7sKMfsTaKk9iZhVU/KwMcR4m2fCkaioUnklNN2kjmz4YMchwgWTwHbFLOGbiECkb2Nl4Yp8OsLMAzQ9mjCQGHvLu2rtxarZWvsYxUAuxc0N/jgo49l6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750768459; c=relaxed/simple;
	bh=qpUJhe+I6inaOi8XEJxl1i0wO7ikyMvxs506f3ASNYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=skl2zhjDYRg2iGkB6BC2r+ghaAXCJx78KkgVUDj0iGQ6nZO8bmPqvr3BUsW6/2QSsvOt2nTMS0tP0RnXcBb+Qrm+OO0NlgVeYv9gCc2AtTwpqwhz7vWLVSHnjHFEPlplTx7NzYmZx0bSCzBu0NXFGlMhGI9tLb53+PZeeJ9/TDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B60uKzSK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O8JEUv022214;
	Tue, 24 Jun 2025 12:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EZr+40Q/dN05pjVpffCdVFAZ6Av8oGgvoYGP3+OxK5U=; b=B60uKzSK9Aah1JzW
	VVZvvWj5ipjdPyyB900PTYEd/BhWnksDdw5+AAWyKgxgfsjoNpdrfQcXC/rpUyXG
	iPLblIVEKEhgSZG4rqxgTfSOVQ3mcD+Zsf6sy4zDCiHvUd2VsGcmTsonqSeYhTNS
	axswK1rNZfUmHDuMUiURr7MGHrLDdGpC7Bm3iyXyP/TcFssh7kQeXK4sw2ZbKkpb
	zIk3xQ772CjSKggJwrN/R+0vjM+OirDJg7LZgwO8PMCMFSBW0eh+c9Y4Q/fO2Gbo
	WetfHN0PBYsP6xQ9PTHHF6W+lGG7Jrl0zcJiXG5HTDBrc1tQqvSfhFr3wv7hQU+K
	R+3KFw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fdfwt9sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 12:34:10 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55OCY9fp016286
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 12:34:09 GMT
Received: from [10.239.133.66] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Jun
 2025 05:34:07 -0700
Message-ID: <5e378fe7-90ec-4453-b549-1106f9d0cfef@quicinc.com>
Date: Tue, 24 Jun 2025 20:33:36 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: mac80211: Prevent disconnect reports when no AP
 is associated
To: Johannes Berg <johannes@sipsolutions.net>,
        <miriam.rachel.korenblit@intel.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzbot+5a7b40bcb34dea5ca959@syzkaller.appspotmail.com>,
        Zhongqiu Han
	<quic_zhonhan@quicinc.com>
References: <20250620032011.1102373-1-quic_zhonhan@quicinc.com>
 <a5078d3c7f3d1c2281a3f5a50386fdb7072935bb.camel@sipsolutions.net>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <a5078d3c7f3d1c2281a3f5a50386fdb7072935bb.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1oz8pxn3BR7064wjOa2tySkwVmI1eznF
X-Proofpoint-ORIG-GUID: 1oz8pxn3BR7064wjOa2tySkwVmI1eznF
X-Authority-Analysis: v=2.4 cv=MtZS63ae c=1 sm=1 tr=0 ts=685a9b42 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=P-IC7800AAAA:8
 a=VwQbUJbxAAAA:8 a=stkexhm8AAAA:8 a=WmAPXemx3fBSO5k2XtMA:9 a=QEXdDO2ut3YA:10
 a=zY0JdQc1-4EAyPf5TuXT:22 a=d3PnA9EDa4IxuAV0gXij:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEwNSBTYWx0ZWRfX4zYJSrKcIJEm
 hbEerxR9Le12/kWCFC2URFI6Q4w54ZAlnzMCqqXcIG0Bna8f3BmOGOuyRK8DBBQtHZhv36oPmi1
 iTkjhneBBvwwrckaoSOaltbohYWzvxjtzfVzyDrjzge8gNqurY5U2VRaNVQENDAzWjKNPnvxs25
 frpJFEWG7h8R+3hF+kTi5nsr4uD2MTkOtHpYjxVtj0qC3FjmiJsargymqOt674Cpxnd34ylvwoO
 QEkq1E3u3ugjp/vBMLxF2qBfhSXj/yNVY3Z6S2UUJKAbnf1tPLnzuHoR58AEA3GMVrSQzQyedd0
 p8bBbWVDbQNNvmkhnwePFaHoRATEfTC940Xi3gZNbhPseFTv4pHJl4ErULfeCExoliWcTvFedHf
 Ope/4ZYoJPV67TLOjSZtbaYFOLmDbp+wI21G0spHnPxrzU3a2kq6/Ysm2znkqbBv78uhyfCy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240105

On 6/20/2025 7:13 PM, Johannes Berg wrote:
> On Fri, 2025-06-20 at 11:20 +0800, Zhongqiu Han wrote:
>>
>> - Rebased on top of current next.
>> - Update the v2 code implementation:
>>    - Remove zero-initialization of frame_buf
> 
> You could keep that I guess, but we shouldn't claim it's any relation
> with fixing the bug. Just as a cleanliness thing maybe?

Hi johannes
Thanks for the review~

yes, we can keep it.


> 
>>    - Remove WARN_ON and early return in ieee80211_report_disconnect()
>>    - Change the return type of ieee80211_set_disassoc(). If
>>      ieee80211_report_disconnect() uses the frame_buf initialized by
>>      ieee80211_set_disassoc(), its invocation is now conditional based
>>      on the return value of ieee80211_set_disassoc().
> 
> I don't understand this change ... surely syzbot couldn't have run into
> an uninitialized buffer after the WARN_ON since it has panic_on_warn. So
> why all these changes:

yes, syzbot couldn't have run into an uninitialized buffer after the
WARN_ON on **patch v2** such as:

--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4433,6 +4433,10 @@ static void ieee80211_report_disconnect(struct 
ieee80211_sub_if_data *sdata,
  		.u.mlme.data = tx ? DEAUTH_TX_EVENT : DEAUTH_RX_EVENT,
  		.u.mlme.reason = reason,
  	};
+	struct sta_info *ap_sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
+
+	if (WARN_ON(!ap_sta))
+		return;




Why did patch v3 override patch v2: Only check if the frame_buf has been
initialized by ieee80211_set_disassoc.

func ieee80211_report_disconnect() must use valid(initialized) frame_buf
to call cfg80211_tx_mlme_mgmt() or cfg80211_rx_mlme_mgmt(),

there are 2 condition:
condition 1: func ieee80211_report_disconnect() does not use a frame_buf
initialized by ieee80211_set_disassoc, so it is not affected by commit
687a7c8a7227 ("wifi: mac80211: change disassoc sequence a bit").

https://elixir.bootlin.com/linux/v6.15.3/source/net/mac80211/mlme.c#L4915
https://elixir.bootlin.com/linux/v6.15.3/source/net/mac80211/mlme.c#L4963
https://elixir.bootlin.com/linux/v6.15.3/source/net/mac80211/mlme.c#L9740
https://elixir.bootlin.com/linux/v6.15.3/source/net/mac80211/mlme.c#L9761


condition 2:.func ieee80211_report_disconnect() use a frame_buf
initialized by ieee80211_set_disassoc(), in such case, once
ieee80211_set_disassoc
early return and not call ieee80211_send_deauth_disassoc(), frame_buf
will be uninitialized. i want to fix this by current patch v3.

commit 687a7c8a7227 ("wifi: mac80211: change disassoc sequence a bit").
add one more early return case:

https://elixir.bootlin.com/linux/v6.15.3/source/net/mac80211/mlme.c#L3936

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

	if (WARN_ON(!ap_sta))--------------->commit 687a7c8a7227
		return;

	if (WARN_ON_ONCE(tx && !frame_buf))
		return;

	if (WARN_ON(!ifmgd->associated))-------------> the caller of
ieee80211_set_disassoc and ieee80211_report_disconnect has check the
this case.
		return;

so as long as ieee80211_set_disassoc() early return, it maybe better not
to call ieee80211_report_disconnect().

from your comments on patch v2:
https://lore.kernel.org
all/4ed3cfbc1a5b80bb3577f73b8c2b19ce830eeff5.camel@sipsolutions.net/

"You're adding a WARN_ON() that's now guaranteed to trigger, no
Shouldn't the caller (also) be fixed?
"
I would also like to add a check (!ap_sta) in the caller of
ieee80211_report_disconnect(), but the logic appears to be somewhat
complex, because I'm not certain if it is evaluated together with the (
ifmgd->associated) condition. I'm worried it might introduce new bugs.

https://elixir.bootlin.com/linux/v6.15.3/source/net/mac80211/mlme.c#L4946
https://elixir.bootlin.com/linux/v6.15.3/source/net/mac80211/mlme.c#L9085
https://elixir.bootlin.com/linux/v6.15.3/source/net/mac80211/mlme.c#L4907

in summary, why did patch v3 override patch v2:
(1) When ieee80211_report_disconnect uses a frame_buf initialized by
ieee80211_set_disassoc, we determine whether to call
ieee80211_report_disconnect based on whether ieee80211_set_disassoc has
already initialized it. This approach is more comprehensive than the one
in patch v2, which only checks WARN_ON(!ap_sta) inside
ieee80211_report_disconnect. It also allows for an early check before
calling ieee80211_report_disconnect.

(2) According to your comments on patch v2, it might also be necessary
to perform the check in the caller of ieee80211_report_disconnect.
However, if we simply check (!ap_sta), I'm concerned it could introduce
new issues if it's not clear where exactly that check should be placed.


> 
>> -static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
>> +/*
>> + * Note that if ieee80211_report_disconnect() relies on the *frame_buf
>> + * initialized by this function, then it must only be called if this function
>> + * returns true; otherwise, it may use an uninitialized buffer.
>> + */
>> +static bool ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
>>   				   u16 stype, u16 reason, bool tx,
>>   				   u8 *frame_buf)
>>   {
>> @@ -3935,13 +3940,13 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
>>   	lockdep_assert_wiphy(local->hw.wiphy);
>>   
>>   	if (WARN_ON(!ap_sta))
>> -		return;
>> +		return false;
>>   
>>   	if (WARN_ON_ONCE(tx && !frame_buf))
>> -		return;
>> +		return false;
>>   
>>   	if (WARN_ON(!ifmgd->associated))
>> -		return;
>> +		return false;
>>   
>>   	ieee80211_stop_poll(sdata);
>>   
>> @@ -4168,6 +4173,8 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
>>   
>>   	memset(ifmgd->userspace_selectors, 0,
>>   	       sizeof(ifmgd->userspace_selectors));
>> +
>> +	return true;
>>   }
> 
> here to have a return value? It's only false when you had a WARN_ON()
> which means there's a bug elsewhere?

Maybe there is some misunderstanding.
in patch v2, WARN_ON() is added in ieee80211_report_disconnect() to
direct avoid use uninitialized frame_buf.

in patch v3, add return value on ieee80211_set_disassoc() to determine
if frame_buf has been initialized. if return false, will not call
ieee80211_report_disconnect().


> 
>>   static void ieee80211_reset_ap_probe(struct ieee80211_sub_if_data *sdata)
>> @@ -4448,6 +4455,7 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
>>   	struct ieee80211_local *local = sdata->local;
>>   	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
>>   	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
>> +	bool report_disconnect;
>>   
>>   	lockdep_assert_wiphy(local->hw.wiphy);
>>   
>> @@ -4477,20 +4485,22 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
>>   		}
>>   	}
>>   
>> -	ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
>> -			       ifmgd->driver_disconnect ?
>> -					WLAN_REASON_DEAUTH_LEAVING :
>> -					WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
>> -			       true, frame_buf);
>> +	report_disconnect = ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
>> +						   ifmgd->driver_disconnect ?
>> +						   WLAN_REASON_DEAUTH_LEAVING :
>> +						   WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
>> +						   true, frame_buf);
>>   	/* the other links will be destroyed */
>>   	sdata->vif.bss_conf.csa_active = false;
>>   	sdata->deflink.u.mgd.csa.waiting_bcn = false;
>>   	sdata->deflink.u.mgd.csa.blocked_tx = false;
>>   	ieee80211_vif_unblock_queues_csa(sdata);
>>   
>> -	ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf), true,
>> -				    WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
>> -				    ifmgd->reconnect);
>> +	if (report_disconnect)
>> +		ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf),
>> +					    true, WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
>> +					    ifmgd->reconnect);
>> +
>>   	ifmgd->reconnect = false;
> 
> So all of that also doesn't really do anything.

Maybe there is misunderstanding, if ieee80211_set_disassoc return false,
it avoids using an uninitialized frame_buf by not calling
ieee80211_report_disconnect. In patch v2, this was handled by adding a
separate (!ap_sta) check inside ieee80211_report_disconnect to prevent
further execution.

Both approaches effectively prevent the current syzbot-reported bug.

> 
> But then the rest of the patch also doesn't seem to do anything, so what
> am I missing?
> 
> Does the bug even still exist? Looking at the code now, I feel like
> ccbaf782390d ("wifi: mac80211: rework the Tx of the deauth in
> ieee80211_set_disassoc()") probably fixed this issue?

this commit should not. What we're currently concerned about is how to
prevent ieee80211_set_disassoc from returning early before
ieee80211_send_deauth_disassoc is called to initialize frame_buf.



ccbaf782390d ("wifi: mac80211: rework the Tx of the deauth in
 > ieee80211_set_disassoc()") partial change:
-       if (tx)
-               ieee80211_flush_queues(local, sdata, true);
+       ieee80211_flush_queues(local, sdata, true);

-       /* deauthenticate/disassociate now */
-       if (tx || frame_buf) {
+       if (tx) {
                 drv_mgd_prepare_tx(sdata->local, sdata, &info);

                 ieee80211_send_deauth_disassoc(sdata, 
sdata->vif.cfg.ap_addr,
                                                sdata->vif.cfg.ap_addr, 
stype,
-                                              reason, tx, frame_buf);
-       }
+                                              reason, true, frame_buf);

-       /* flush out frame - make sure the deauth was actually sent */
-       if (tx)
+               /* flush out frame - make sure the deauth was actually 
sent */
                 ieee80211_flush_queues(local, sdata, false);

-       if (tx || frame_buf)
                 drv_mgd_complete_tx(sdata->local, sdata, &info);
+       } else if (frame_buf) {
+               ieee80211_send_deauth_disassoc(sdata, 
sdata->vif.cfg.ap_addr,
+                                              sdata->vif.cfg.ap_addr, 
stype,
+                                              reason, false, frame_buf);
+       }


If ieee80211_set_disassoc is responsible for initializing frame_buf,
then the address of frame_buf will definitely not be null. Regardless of
whether tx is true or not, ieee80211_send_deauth_disassoc will be
called, and frame_buf will be initialized.
Our goal is to ensure that ieee80211_set_disassoc does not return
prematurely before ieee80211_send_deauth_disassoc is invoked.

Besides, maybe patch v2 should also fix the issue. Please kindly let me
the update~

Thank you for your time and the discussion~



> 
> johannes


-- 
Thx and BRs,
Zhongqiu Han

