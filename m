Return-Path: <linux-wireless+bounces-36000-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BDdAdIC+2liVQMAu9opvQ
	(envelope-from <linux-wireless+bounces-36000-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 10:58:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E6F4D8365
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 10:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4913E301DE53
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 08:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748EF3ED138;
	Wed,  6 May 2026 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OWo4rG+z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fekG49PX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C953264C7
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778057917; cv=none; b=GT+IN/pGMoUr6ywEI0iXwzKfqWrNHnYyrzQyjOB2KTnEKMUKgPLqQlrN/yFCrnZUNrDvoUKtOT34oc+CjrgDf25LDqneE8XW8eG6j7pf9W1ipwWVDZR4i4EDsWUG+U9wagPsm2GobRSgifGE+fdoJc877PsbLQxKHhWPDXU/ZtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778057917; c=relaxed/simple;
	bh=q9cc0cp7FGdvpY2b9DUStXn9qL62a1ZZGN1IQExAXxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T3YQO+Pxj+DIo/ahjUaWEbN4ePSziXa8uYnEE8imdaHpuClJchWU4Snw7p9MmJR4irsYRoRzPJcxajAX/Wwrm3w4rZDrB/VZ1/yAh4wsCcPxIJS8BNSaud0cNywOVbIIj33yoFo4wW2mjc2w8q4M/Bwg+QgG3As6Pf1bUMogdNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OWo4rG+z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fekG49PX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6467jbOp248447
	for <linux-wireless@vger.kernel.org>; Wed, 6 May 2026 08:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mlfzRIFh+aU9BhMyO6JqxL761KKTTqzLc1t/lUqJvhw=; b=OWo4rG+zQqVnvL1C
	USzrfcNGU0iEL9U4eRdRKtS4VvtFvcXpNQGreKJVbcO4Zux494oQ0uE2ucOLFmLM
	uZGglYqbjRj0jz0eRiAZbZpx1aPsABQNoO2bj5ZxLfwnzhZLwLPVqg7elmAToklV
	3+0KzJcBvl3DoHI9ezeOMrBqIXclrRYlnRb2GHGxFzvkc+oaxUtkSMt+Cw2nDuv6
	fpK6WVpxu0/9d+5O4JeSGqfXn3QjqTrXzgcnkjTvCwypvbiQGuLV45e01589wPuz
	uUdBopJlAh1QSZrUyriKt98/6gY+EaobXMoJdpLOLFKhgwc7JMnZGDgNUOmk6cD2
	JTd5Ug==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyjq43qd4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 08:58:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b9f5ac4e36so34442655ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 01:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778057912; x=1778662712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mlfzRIFh+aU9BhMyO6JqxL761KKTTqzLc1t/lUqJvhw=;
        b=fekG49PXD7WaFqVUGqT5rQL0240y2YJUWf/LAxYa2uvzCbuldbEbio3Ay6pOhr+Oz0
         6Q/peHjqo68fgy8UXSCv0Y6rGT9kH1s1GstrU+fwnv03g3S3qFu5J+Qt7LlEihW36Ekx
         yjtv89ruGLKDqN00lJbqQzruRSetlMiO8e9GXmOnBeuWCoYwRl2RnseA7Br6yCo8G+eb
         G5tTaeFi6k5pydbpkrIxrD6pc+PvZkITyIWTQvO4UuAf3vKlx1t0VF+QPirPW/cSA6BW
         2S24qosNPlO92sSP+eS58VpjicC1v/KTB63UGAJQASKl0BDmk3Z3yDyTsKFIXmyLeJwB
         kLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778057912; x=1778662712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlfzRIFh+aU9BhMyO6JqxL761KKTTqzLc1t/lUqJvhw=;
        b=PcxRXKGymyEtfb6lPfVzlvzEnYTMWzk9qC5qLTSBT98SdDlLATximk+YR1Juk/0B4c
         WG7sIX4FeyQDvtaWN8WTUXdsBipdUW1aa1XgVkMcUUXYfVdgSX8NIurNl2r0D+3FBt99
         sv1jO4Xe+hS5azchbbcCIiQk0EZHDppdO0mfaYWLO0US3IFkZ2oMjd18tYiG6NQB/0XO
         fphXd81cjfLQEtV1qk6LSpFvmzNWcEih2SGlZqPuv3KaT1WtK7x0gSpedqFBdA+72clg
         pelgL1+E9B/ad2yJoIkFSlYcYp57+GKoJSg/MQMJoCA4vDPkdsKmsXd69otdz/B4FVlT
         SKeQ==
X-Gm-Message-State: AOJu0YwwNGtJ4C3UNZdc7cBgQUKYN4BDcCF3YzhNE9ziwhTabafJb0tL
	fyX76sLwFnIb2DzDDYI80hl8CL6aieFuzvimZVaeCR52IaRnivmsusF3aA6I67NXWpWU8Ch3NYq
	A9tiNTYPk1riuYTxvpr07mOx5Syl1JqIKOdNqxReLv1knTriNRZ6FUXEcjIqokH6jP0kyFA==
X-Gm-Gg: AeBDievem7jNwbYqlVobqsbKjViGEU6Jc4dkXijEi0mJ1lrnIhEv0LK+oXYn7KhRxtY
	3R24ON7F8TlXl7KHMMhevSVtaABUqyaIEN0zk4MSa5lb9QnCCUkNWvQUwvqd/66i7qkPBrkwPaX
	qxAdGMKTFseOdte71afnHZvd+aQBz6GJp09921cmHpmedxdCSEMAMPkJtWMyNcX+XzQsHgQCqBw
	8V7O7a9vA1IOaTChdWw0uEG0qTz9j4DcjbcaqUYMVbANhJHzUUBeaDbl/SuNnnThk9l7Fj7g3bz
	L1FenxSOUL31jUJEWRL34RF1dmz2TPttKqyvYWtS3dtd9GIlbf4ACz00c98mkjRkF+DR4kH1NfM
	Db94AjKxIrmA4N4TPyRy/I464zAM2tMQVRo6r+DH1/v+L/Wm/4V8u5Q5ir3698koa
X-Received: by 2002:a17:902:988c:b0:2ba:6ca2:be0 with SMTP id d9443c01a7336-2ba792b3830mr18295795ad.4.1778057911605;
        Wed, 06 May 2026 01:58:31 -0700 (PDT)
X-Received: by 2002:a17:902:988c:b0:2ba:6ca2:be0 with SMTP id d9443c01a7336-2ba792b3830mr18295655ad.4.1778057910979;
        Wed, 06 May 2026 01:58:30 -0700 (PDT)
Received: from [10.206.105.147] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7bf2c4aasm17078595ad.23.2026.05.06.01.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 01:58:30 -0700 (PDT)
Message-ID: <04b7b4a3-5eb0-4dc2-b12d-22e876a56a59@oss.qualcomm.com>
Date: Wed, 6 May 2026 14:28:26 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 2/2] wifi: mac80211: set assoc_encrypted
 for EPP associations
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Jouni Malinen <j@w1.fi>,
        ilan.peer@intel.com
References: <20260504123624.529218-1-kavita.kavita@oss.qualcomm.com>
 <20260504123624.529218-3-kavita.kavita@oss.qualcomm.com>
 <0a53312265b6f466f01e169f0b385a0ef4d0b157.camel@sipsolutions.net>
Content-Language: en-US
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
In-Reply-To: <0a53312265b6f466f01e169f0b385a0ef4d0b157.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MYxcfZ/f c=1 sm=1 tr=0 ts=69fb02b8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=XK8QCLNWGkyHhmqo_KsA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA4NyBTYWx0ZWRfX7q4+o5I5OHH5
 KU0xoING3arVsOuYXDIw+KhSZGKSM0QjDcqGDxQhxlz3vGHalwCY10nCohOHy7DasMGyzUybYId
 Ac4FEEjYeJmDctlwug5dmAmxMKwEWu+36Nvb0vsvtAEqltpRT91Ac2rDVa621vYFhuMfWtWya8A
 5M59e6DflPvt3nLP1jR5n/u1SS/epD/CLydrWY4Uc6kl7qa3Ksy8HMlG3yHQROK6C337U4nEyqS
 Foi4AWD3YTi1SscIZpWz4prRFuRgE72m4DAAtxEqGXeoWIwAomu67AMC114kpFBcQDUqKGBqDZw
 D7bhj6y3NxDhhjYbIqay2qKkRx1k6FZ6/LC/OKK4EXHiXbZyC5ONCmhO5rK3y7hhNma9czWXTkT
 IzUg4jF0CqFfS9p53kJ25khJq/wx63ilPSf9DeeYSdMcABYhZfbUCJZUJ2El/VZNVSxb7poSKMl
 IevAJFufCoWSVhIe0Eg==
X-Proofpoint-GUID: 8qS7Zj2Tubz4nR__GjKfpV6iS7z8MyIz
X-Proofpoint-ORIG-GUID: 8qS7Zj2Tubz4nR__GjKfpV6iS7z8MyIz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060087
X-Rspamd-Queue-Id: A3E6F4D8365
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36000-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 5/4/2026 7:45 PM, Johannes Berg wrote:
> Hi,
> 
>> +	/*
>> +	 * If epp_peer set, unprotected (Re)Association Request/Response frames
>> +	 * are dropped, which ensures that the (re)association exchange is
>> +	 * encrypted over the air.
>> +	 */
>> +	sta = sta_info_get_bss(sdata, sdata->vif.cfg.ap_addr);
>> +	resp.assoc_encrypted = sta && sta->sta.epp_peer;
>>
> 
> Not related to this patch, but something I realised just now looking at
> this, coming from your earlier commit 63e7e3b6433f ("wifi: mac80211:
> allow key installation before association") ...
> 
> The code you added in that commit seems insufficient to me. As far as I
> can tell, it's possible to have assoc frame encryption with FT (see
> 802.11bi D4.0 "12.16.8.2 FT protocol"), but that doesn't explicitly
> specify that it can only be FT-over-the-air. If FT-over-the-DS is
> possible, then the code in mac80211 cannot support it, because the only
> way to get the sta->epp_peer flag set is via authentication (802.1X over
> auth frames or EPPKE), and the only way to install the TK before
> association is to *have* a station entry in the first place, and have it
> have the epp_peer flag already from authentication. It also sort of
> breaks down if the station entry is removed for some reason (rather than
> not being present in the first place) and from mac80211's POV we go to
> assoc immediately without having the station.
> 
> One way to fix it would be to add the TK to the ASSOCIATE command, but
> that would have to replicate a number of settings there, I'm not sure
> that's desirable.
> 
> Another way to fix it would be to have an NL80211_AUTHTYPE_FT_EPP or so,
> that just does all the processing, adds the AP's station entry and
> immediately moves it to authenticated while setting the epp_peer flag.
> That way, wpa_s could do this and then proceed to install the key and do
> association as it otherwise would.



Thank you for pointing this out. We agree with your points and will follow the
approach you suggested. We will take care of this in the future when we add support
for FT protocol with (Re)Association frame encryption support
("IEEE P802.11bi/D4.0, clause 12.16.8.2").
Currently, we have only implemented support for initial association
(EPPKE and IEEE 802.1X Authentication).



> 
> johannes


