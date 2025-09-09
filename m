Return-Path: <linux-wireless+bounces-27139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A85B4A11E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 07:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100E3189FB91
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 05:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB16E217F24;
	Tue,  9 Sep 2025 05:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H8M3B/Lk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5BCF9C1
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 05:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757394614; cv=none; b=NP9241rBCPeNl+XDmFXhQuG2Eqm+PSdRzJ1YaV7hnH7lizUlbbp6zUHRlUUFbO5ee6TzsdK29LdZdlPk+ZpFffNWOu7AXA9I0GThJEY9cdpVwzRvNOEAGuTG9MrHJEOOVQ8h+W1FdFT+hhKybkfOU7Z+YavxaVQurljH6iHkOTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757394614; c=relaxed/simple;
	bh=MzyU4z4ieNko6Vsflzyq/th7QJ/5oCp3gdzfA5JBgPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ONrBBCY/WXXcH0kOK3aowVr/y1MYFxX41pwFNWantdgwJJIfNFmmX3yHEEWClx6fQ0D5qgHxljXftTK9DiK5+VrHCIQYgdQKbW1Y/ICmYnLq9wMlwlE4wO3DA6JFXlYTQsh+ujvpjpz1hs3mO24zOswaC5OsKCWUDSrITeWDqwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H8M3B/Lk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5894cjiN009418;
	Tue, 9 Sep 2025 05:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xeSyk29U2KKujsKXj7VeQx0C0U8g7bH5VfuOyDv9I5o=; b=H8M3B/LkIwx5CegU
	CbwYR3RA7SB5LJ8tqgyd0xuDrH7mVUH7dV1gPK36QT0Gr3919T5FgVKujZ4Dvf5q
	sIEV5R5SDE50Axv/1mvx+cD5lGeDiC5jcng0m2K5NuprH/lENCpW+sOcocom4uP2
	xyWaZCg2QKGob40HsKaXvVREqNJh7nHMzvsFk05kJLl2SECBtgho98ieLWdTPJy6
	LAFanEiP8gIM3J8lMGGncoOlIErS/1MCcvl8KnHkJGZ7kQI8aQ/3iR9Sk9LskCfJ
	eEbXRkKWnpzmdAeJa3w3JwWn7M7bgvWNC6lQBfRWXXqAGhd5XcU4BE+6zOA+iS7J
	X/uaYg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapf86q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 05:10:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5895A6D5028521
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Sep 2025 05:10:07 GMT
Received: from [10.79.198.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Mon, 8 Sep
 2025 22:10:05 -0700
Message-ID: <f59d7f7d-6b57-4ffa-9679-de1c32b0c1bd@quicinc.com>
Date: Tue, 9 Sep 2025 10:39:47 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 1/3] wifi: cfg80211: add support to handle
 incumbent signal detected event from mac80211/driver
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Hari Chandrakanthan
	<quic_haric@quicinc.com>
References: <20250818101947.2464612-1-quic_amitajit@quicinc.com>
 <20250818101947.2464612-2-quic_amitajit@quicinc.com>
 <83b5c2e55c7ad55851b9877c5c085a57b6414ad9.camel@sipsolutions.net>
Content-Language: en-US
From: Amith A <quic_amitajit@quicinc.com>
In-Reply-To: <83b5c2e55c7ad55851b9877c5c085a57b6414ad9.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68bfb6af cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=dTsDST_KAKpKjHVxWTgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dV6QfWzRxuuPtGYeVTmXuPletE-MnyqV
X-Proofpoint-ORIG-GUID: dV6QfWzRxuuPtGYeVTmXuPletE-MnyqV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX1vAtZtQ7m4hy
 Wme4T/KXp9rMMs69e0IrghhveMhBbo0LDjeiPwanieOVApYvhYiaTSF4WfUEhJm9f7BhAXDPxGX
 92pGZcsnp716mX3LQ8E21dEZ2n3CvKPH2myrwgXU0e3STjz/Y0fDHou/mRTEchQkwKsQf7b6YYE
 IuphMtvMEN6Vs2y/VBJFZCMFGSjoren8/xxQYtGQLFe9U1xBL3qE7lc/Rovjjp4cW9DDbUl2m7Y
 +E4JwEzV6XR0YgFGcf3N5B8NBkOxAK6KSOLvzkMW/qIKr4KAlDPFnwzPdu8cfDTzuh4NwQao8Da
 vmFrYgWELiFYnmIWDPRg8xWOgySujFnHaXzvsxzQZxCya1fEmMe/c7E1VneCltRU1gzcTZ6sibf
 /crZsiBY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000



On 9/4/2025 3:28 PM, Johannes Berg wrote:
> On Mon, 2025-08-18 at 15:49 +0530, Amith A wrote:
>> + * @NL80211_ATTR_INCUMBENT_SIGNAL_INTERFERENCE_BITMAP: u32 attribute specifying
>> + *	the signal interference bitmap detected on the operating bandwidth for
>> + *	%NL80211_CMD_INCUMBENT_SIGNAL_DETECT. Each bit represents a 20 MHz
>> + *	segment, lowest bit corresponds to the lowest 20 MHz segment, in the
>> + *	operating bandwidth where the interference is detected.
> I think you should clarify how this interacts with puncturing.
>
> Are disabled subchannels not considered part of the chandef, so if e.g.
> you have an 80 MHz channel with one disabled subchannel, only the lowest
> _three_ bits are taken into account, rather than the usual four for an
> 80 MHz chandef?
>
> Or, perhaps more easily, are disabled subchannels part of the bitmap and
> then must be zero since there cannot be incumbent signal on them that
> matters, since we don't even use them? Should the code perhaps then
> check that those bits are indeed zero?
>
> Or something else entirely?
>
> johannes
Punctured sub-channels are excluded from interference detection logic 
and are
typically not represented in the interference bitmap. Their 
corresponding bits
remain unset (zero).

