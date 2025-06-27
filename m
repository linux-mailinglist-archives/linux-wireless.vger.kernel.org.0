Return-Path: <linux-wireless+bounces-24614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 679A6AEB9A0
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 16:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7D5171505
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 14:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685B72DD5F7;
	Fri, 27 Jun 2025 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YZEWa6aZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44202F1FD0
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751033977; cv=none; b=o/1bDRxjnseHiZCnqMMk51eqIkvbmr/2Yt0GUrzV9makdUOoyjt60zGgmq5NnfBMlEHkRyfsAzhcBQMx4QDtwnT0Yo635BqhIScErLer0ivg4lT5wAhZUjf0crom6UOaFqxTX8yx2Vx9qGvfAbTpdiN7WJ6X11iPMuarWADZ8zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751033977; c=relaxed/simple;
	bh=rcbU0wXVyP2/tbvn2pfoIyLV/qrCFjGOXUfW+AUogvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXKq5njwbfI/Rm0SIXoE6d26wB1RQ7Mu9yUBSNan7KlGuvd5Eqp43aaVN/LZdD1KHvmUUYnOakZEnsea/Zbfn0HKymH7YRVPJIdDvsfcyXFkhBnIo9AOeJbs144zx1xAm5iGyYdEnrfEYj//5rU+C2RCCAZyv+Rv0pP5gdrReCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YZEWa6aZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RCFRAM009529
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 14:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AVaZQsdm4HV3K9Gld7lUz1+nFeBnTyonan0a0K2Q2/k=; b=YZEWa6aZHNM0MIBR
	F8ZFosfdVbF2S3tZ9nWXclWB2tBGUUjVWeLU/yjx+rJO3SEm+jCYjMofoe1Q1WwP
	MThqa6wdWaoEzqAFVqerWo/kN+tW70tL4zXXmb0a2olYlzqWML48F5eD54StB9LH
	nf2H0RSBUyHXVZ+UidmUPBD6kaSvlmSPvoldD6M8ekeNUFRJhWXYuftJ9HKhfIgn
	ma20xYG/2Ir/IN5LTZlcMPEEPMwRrMBGbL1wdRbPEevnwBVNCzOKKnkImGmCWF0g
	LNTmGyUmQO2visUaRe/JJs9V85FC1kTBelvYu51fGwTWhu397QX5N69XKMKeHUny
	mPZItQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f4b4713t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 14:19:34 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-235e1d70d67so21034905ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 07:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751033974; x=1751638774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVaZQsdm4HV3K9Gld7lUz1+nFeBnTyonan0a0K2Q2/k=;
        b=Qsqs1DqJ45YBc+dVuLf0VlR7KjszoecpHa5hYJmZdisk2efFsTBW8SUQhvuBz3IqLx
         pR+Nj+aXd8mZC8SOPxdRGFVbjIMNx8QX8hq2QhVKAPkOXSgAltTJIHlPoz+FVonvIn3a
         mJXbNRfDDwIm6Pbl8rXNHbe0UhKx4y6ihyIQo9OcTU1YQmugb/nj63ccIObX0ykMDeTy
         kAF2wT5q02Ed+v8s977AJIaYUwQ3TNbPk2o3BMnAyaRRDycEVD3G1rZDWk6weZMkI3/C
         EECpIuaBc4Y33VV/QXqQjFYaMzugQLKWepTp2rUWwZtLK1Fh//rths3idKJkLj78fldQ
         WGdg==
X-Gm-Message-State: AOJu0YzO08G0zzdeZjFOHZ/jmw7wa+WA62pGkvpBuvBdKOC/Sty0WDf3
	2Yg8dr7Y176vXIUrFTK+0m4nAQVvpSM8zh/6IQ3lV/XtHeuKU3LuuwZIlbCMY7R47UMrzhoZKWN
	/QjdIAC+V6INZGZTaGk+b8NH04Z6nq035o5xEdaPgIfRyzh5J1lRsf+xrphVCSpZr/vKaZ9CFGl
	OdQw==
X-Gm-Gg: ASbGncu5nZEX0vv23bLNkmkILjMhWo8oWLCnCc/ot1D/ZqeocQZx7Q9QANPEmmp9Wa5
	LxsxqV9STMGpHyv6dh+TiHxpknW9N1YU54FXCsSkDxsEJLG6AhOeZL/UjzR1h0jqe8I7L5H7u+F
	0fxFl9DerZIkFx40xBP7CsUvOUF8NUBouoYVQHsWYOxttiSUNeeiiQmADY0R3UHpLlEqhjGNjdV
	vitu1CbThmXlmBW6OMsqTHe3LlZVRNMGltafQC9/aywa8im48B/u/0uJB4BmJN26UR0ItXF2PE9
	6QNAIzF4Y8Wx2EKrGYNvMrB5X1OsKudDE6Gtq8e/Ci3lj1xrs4lxwfEU
X-Received: by 2002:a17:902:c944:b0:234:ed31:fc98 with SMTP id d9443c01a7336-23ac465d22cmr49311555ad.37.1751033973744;
        Fri, 27 Jun 2025 07:19:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1RRpeIvRjgjFqIrOyQpp60LXiItSyQeWKc6KRbYhDg4KhG2KSuKhg6UkL05K1PaGOnFXvNg==
X-Received: by 2002:a17:902:c944:b0:234:ed31:fc98 with SMTP id d9443c01a7336-23ac465d22cmr49311115ad.37.1751033973215;
        Fri, 27 Jun 2025 07:19:33 -0700 (PDT)
Received: from [192.168.1.2] ([122.164.80.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39c0a0sm17107815ad.122.2025.06.27.07.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 07:19:32 -0700 (PDT)
Message-ID: <21b7d547-b550-23a9-3bff-1f1787e307a8@oss.qualcomm.com>
Date: Fri, 27 Jun 2025 19:49:24 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH wireless-next 0/3] wifi: Preamble puncturing support for
 mesh
To: Johannes Berg <johannes@sipsolutions.net>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramasamy Kaliappan <rkaliapp@qti.qualcomm.com>
References: <20250609001048.2263586-1-ramasamy.kaliappan@oss.qualcomm.com>
 <a8ff80ff5a811a09cf5556e20c7232eb1e201c2b.camel@sipsolutions.net>
Content-Language: en-US
From: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
In-Reply-To: <a8ff80ff5a811a09cf5556e20c7232eb1e201c2b.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDExOCBTYWx0ZWRfX5SLy/g0Dfgen
 U8YhHjzYaM0YwLJFMcPwZ2oUb1iQNHjGIrfrB1X2XofSHpYTS2lUPauChXd4dLsvtrI+VRKXfSo
 cFFaShIWJbOvnDVNE2oYuMT8kFC39SRLcNSFikmdx+BUXb7w1z/BOgApgD+dPM/ZjKtYoNA/uZN
 y97SOUduncT/IvWxzBmXdMbGHjUAeQo/xmqDpNELum6gh/kxiGvR7/PuC3xgyWPLm/fwmWPiBxA
 3npheNUaxapnfYwJYQlWxLrjbOn/2QnOOgRXQatFY6B65nyljPnrbhSQVmobg+aXzFUHDGynEBA
 BayhT5x4mI5d9WsSw3XouIsc7qjWdrVeIlo4viPkXi9FUNMlsM5Px6/z/FKgh0/CXksaKbJORyo
 g3oMDP5U5MJrtiDtPXrO3W/oALY2YxfHTqehovgah+gn1Ij8+Xr2QT5CLIIduKaWh+Q8aE7y
X-Proofpoint-ORIG-GUID: GtHoeBRzq3Fn42G4JAhtYEBnWALak0yZ
X-Proofpoint-GUID: GtHoeBRzq3Fn42G4JAhtYEBnWALak0yZ
X-Authority-Analysis: v=2.4 cv=A8BsP7WG c=1 sm=1 tr=0 ts=685ea876 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=tpvAdpNFOXgFvjEcSjFpoQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=NyqnUUIibY9oW5HF7GEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506270118



On 6/24/2025 6:54 PM, Johannes Berg wrote:
> On Mon, 2025-06-09 at 05:40 +0530, Ramasamy Kaliappan wrote:
>> From: Ramasamy Kaliappan <rkaliapp@qti.qualcomm.com>
>>
>> Preamble puncturing(“Punctured 242-tone RU") refers to the transmission
>> of a PPDU in which no signal is present in at least one of the 20 MHz
>> subchannels within the PPDU bandwidth. Puncturing might be the result of
>> the unavailability of 20 MHz subchannel(s) within the PPDU bandwidth,
>> such as a busy channel indicated by the CCA or the setting of the disable
>> subchannel bitmap field (16 bit field) in the EHT Operations element.
>>
>> EHT disable sub channel bitmap is a 16 bit field where
>> each bit corresponds to a 20 MHz channel in the given bandwidth.
>> Bit 0 corresponding to the channel with lowest frequency.
>> Bit set to 1 indicates that the channel is punctured, otherwise active.
>>
>> Userspace can send the EHT disable sub channel bitmap via attribute
>> NL80211_ATTR_PUNCT_BITMAP in frequency  param as a part of join mesh
>> (NL80211_CMD_JOIN_MESH) command. The received puncturing bitmap is
>> validated and copied to chandef's punctured bitmap of mesh interface data.
>>
>> Build the mesh beacon’s EHT Operation element including
>> disable_subchannel_bitmap based on chandef's punctured bitmap.
>>
>> Validate and update peer mesh station's puncturing bitmap
>> in local structures while adding new mesh station
>> (parsed from peer mesh station's EHT Operation element)
> 
> I ... don't really understand how this is supposed to work.
> 
> Say, for the sake of simplicity, we have an 80 MHz channel, the lowest
> channel is the control channel (so puncturing 0x1 is invalid). Possible
> puncturing values are 0x2, 0x4 and 0x8.
> 
> If locally we have 0x2, that means (I assume, since that's how chandef
> is meant to work) CCA and RX is always on the control channel and upper
> 40 MHz parts. If you're now going to transmit to a station that has
> puncturing 0x8, you didn't do CCA on the 0x2 subchannel, but ...
> transmit anyway?
> 
Yes,we do not transmit blindly to mesh peers with different puncturing.
Before initiating transmission, the driver computes the intersection of 
the local and peer puncturing bitmaps to determine the set of valid sub 
channels.
> I mean, maybe this could work if the remote puncturing is a superset of
> the local puncturing? But just blindly doing it the way it appears to be
> done in this patchset seems ... questionable at best?
> 
> Can you explain more how this is even supposed to work?
> 
When associating with a mesh peer, the mesh peer's puncture pattern is 
shared with the driver. The driver evaluates the intersection of this 
bitmap with local pattern.

if the resulting pattern corresponds to valid transmission bandwidth, 
the valid subchannels used for transmission.

If the resulting pattern does not support a valid bandwidth, the driver 
falls back to using only the primary 20 MHz control channel for 
transmission.

> johannes

