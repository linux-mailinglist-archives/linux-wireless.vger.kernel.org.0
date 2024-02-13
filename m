Return-Path: <linux-wireless+bounces-3506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B0685282D
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 06:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A5A1F2265B
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 05:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAFA11723;
	Tue, 13 Feb 2024 05:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L1rSmZaZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A50611717
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 05:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707801412; cv=none; b=JVLc4oAvVTIziMCu9ovdv/EAV/wV7x+ey1q48ddGM3zwO95wa7nEtjhg9u/hUZo0zI7eO3nk0AfmWyU+fW4FKoQxxgGjs3lWWs5qfrxLXbyzDmmz4yJtQUoMaGQqkh0ORcMRNcXhBA7UAml0lHqCsBvSN5TOCqQ9xezDZPaX9OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707801412; c=relaxed/simple;
	bh=imGpI1Iv+JFOA3av9IyJacuEYcVQiBDfnAfQ2DxgND8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bx5vD5VnIQMJvHj+ZnrUy+dSxRtMobkaB9bc7SrJGFocWetJHbybWpxrUAZa4IRicpiyzOSKlK60YgWxPIiSu41u9Un7tYs5feFVFMAQmhM/RFsbax0w0fHpUGdsu7EH+iEzGKpt4wOlR4rNiTzMR4D4YwyR/FZHCUi2o8hUDrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L1rSmZaZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D3Osrb024660;
	Tue, 13 Feb 2024 05:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HPz34Ke4XpK7RdGz9YZ1+o+Hn58h1yIErVDvrd8SjiQ=; b=L1
	rSmZaZiwoMuAQIq7zTLTuZO6RNKUMcXFWFjDAV7hy/z88JGexyYLgy1Lc+TWiUbb
	ejHK5MBLbaq3MU526ppDw14Pk2A3l0u+jjNd90Lcu4xvD8VCNqxd+d+wq659mM1r
	LSxmH0opCFAB05I3n5Il+ope5pTPm+h3RKTWpgSWrmis4QGhWTHBGTSEXelipZu8
	EL3hcBu9Fy0yyyQIEXcgRr7aRVZRWrTEtwt1fYjdauuuAjzLFeI6AW3K39XqC4eD
	xem8IineKFlOyHCZnWBfqvHe5/Gg6JE1NPt5VBYdw9K/wvXtxof6/fpnQHb3hz+i
	9P2+28AI2hhB0Wprs0tQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7s390x3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 05:16:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D5GcrQ028897
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 05:16:38 GMT
Received: from [10.201.207.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 21:16:35 -0800
Message-ID: <ac5825e8-0cb1-476e-be5c-ad0170122f77@quicinc.com>
Date: Tue, 13 Feb 2024 10:46:31 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel switch
 on link basis
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>,
        Ilan Peer <ilan.peer@intel.com>, Jouni Malinen
	<j@w1.fi>,
        Ping-Ke Shih <pkshih@realtek.com>, Ryder Lee
	<ryder.lee@mediatek.com>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
 <20240130140918.1172387-5-quic_adisi@quicinc.com>
 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
 <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
 <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
 <b2cf5c1d-7842-4e59-b25a-904a6879fa9c@quicinc.com>
 <f7174207668cac149246cafa0e4b4749ee3289f0.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <f7174207668cac149246cafa0e4b4749ee3289f0.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uh8Um11WfJnsOdfWqK1LFTNty8LRdJmh
X-Proofpoint-GUID: uh8Um11WfJnsOdfWqK1LFTNty8LRdJmh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402130037

On 2/12/24 20:16, Johannes Berg wrote:
> So ... I'm looking at the client side, and thinking about that.
> According to the spec, multi-link element should be present in beacons
> of APs affiliated with the same MLD if one of the (other) links is doing
> CSA, and then have also the CSA counters of course, relative to the
> target link's TBTT (of course.)
> 

Yes correct, you are referring to critical update(s) right?

> Theoretically, both mac80211 and hostapd today support different beacon
> interval on different links, I believe.
> 
> This makes the whole thing of including CSA for link A on beacons/probe
> responses transmitted on link B very tricky, because you have to know
> the timing, etc.

At least handling for probe response seems to be a bit easier since 
there we need not maintain any timer as such (as you have said too - we 
need not be perfect there). But beacons, as you said, it is indeed bit 
tricky to handle full support considering both links could beacon at 
different intervals.

> 
> For the CSA counter of a link _itself_ we have counter_offsets_beacon
> and counter_offsets_presp (for probe response offload) in struct
> cfg80211_csa_settings, and also counter offsets in struct
> cfg80211_mgmt_tx_params for sending probe responses.
> 
> But ... for the cross-link information in the MLE this gets way more
> tricky? Especially if the beacon interval is different - we couldn't
> just count down, we'd have to fill in the information when we know where
> the frame is transmitted. For probe responses maybe we can afford to not
> be perfect, but for beacons it better be right - so we have to calculate
> the right counter value(s) for (all of) the switching link(s) according
> to the current TSF, TSF offset and TBTT - not all of which we even have
> in the driver?
> 

Yes correct :)

> I can see a few ways of implementing this:
> 
>   a) Punt to firmware and it parses the multi-link element etc. to
>      find the places to update. But that's awful, it requires parsing
>      possibly fragmented MLE with fragmented subelements containing the
>      CSA elements inside ...
> 
>   b) Punt to firmware and give it a (possibly long) list of offsets K_N
>      where to put the N'th counter for link K when transmitting the
>      frame.
> 

At least for beacons if firmware takes care of it then it will be good. 
Firmware could maintain the counter (for the affected link) and (I 
assume it will be aware of the partner links) so whenever partner link 
transmits a beacon it could add the CSA (or such IEs) in per STA profile 
of the reporting link. It could get the contents from the affected link 
but actual value of the counter could be filled from the global counter 
being maintained. But not sure whether we can force every driver's 
firmware to do so?

Let aside actual drivers, adding the test case for mac80211_hw_sim would 
also be tricky since there beacon Tx is handled in software only.


>   c) Require the get_tsf operation and add an operation to retrieve TSF
>      offset (**), and then calculate the TBTT for each link when
>      beacon_get is called with the per-link beacon intervals and update
>      the values correctly if CSA is in progress on any link ... requires
>      against parsing like in (a) or offset information like in (b), but
>      at least now it's in software?
>      For probe responses this could be a bit off I guess, but maybe that
>      doesn't matter as much - probe responses are not authenticated so a
>      client probably shouldn't use them for real CSA anyway.
> 
>      (**) which I guess we need anyway for hostapd to put it into beacons
>      etc.?

Yes I'm too anticipating hostapd changes to support the critical update.

> 
>   d) Require beacon intervals to be the same, and then just count down?
>      Still requires the offset information etc., but that's also not
>      great because if the configuration happens during a TBTT on any of
>      the links (some before, some after), it'll be very wrong. So not
>      very inclined to do this one ...
> 

Agreed. Can't enforce the intervals to be same.

> 
> Do you have any plans for any of this?

I do have some idea (possibly half baked code) for handling critical 
updates in probe responses. Beacons, I assume firmware takes care hence 
I have changes to mark it in the link_conf so that drivers could read 
that and give it to its firmware.
Handling in beacon at kernel level, I need to think of it since anyways 
hw_sim test case is good to have :)

Do we have any data right now, how many actual drivers have offloaded 
beacon Tx to its firmware (at least those who are supporting Wi-Fi 7)?
If we could see majority are using firmware then we could first add 
support for such drivers then we can think about handling it in kernel?

> 
> I'm mostly asking right now because I want a reliable way to test the
> work I'm trying to do on the client side though, so I could also live
> with some hacks (inject through debugfs?), but having it for real would
> be nice.

Okay. I'm right now working to add basic test case in hw_sim for MLO CSA 
(on first link) as we discussed. There is need of a few mac80211 changes 
in order to support for other links. I'm checking those now. Once done 
with these, then I'll take up critical updates.



