Return-Path: <linux-wireless+bounces-14260-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B569A63C5
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 12:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D5B1C21F28
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 10:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DBF1E47B7;
	Mon, 21 Oct 2024 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TfxIgU6n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA591E47CD
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506928; cv=none; b=EGILmR/XLlwQcE+izna6eswdLGHjRUCfx08GMUwyaGYAKEiEhIKCiD8arqnKDGjvih7H8C1qaDLneGmMwS0PPM/OBa8Msmjru8j+MDNv8AuCobyV6u3u5quNO5UlVbwtegHVPW/SlDZQTmqtxmfyx4zahRhK6HtV1TCkRBMiws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506928; c=relaxed/simple;
	bh=/uCMHe/bFGhGFHbkd6+dcI12ftf1fhM/O948f2vFTh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OPCLU6hkfOTR7mDvLcnd/rWZE5N1MsQjdLZwEWoEneNDsKwUqrcv0N6/C6iEdOUxvv7UVjm+Q3M8WxB510rvg8Y1FcyP5jnv3pzNzl7kc/+u+JVu9vzNb1JMj20L9QHgWUsOEgyf2OS60BFquYK3uPcYsMj1lCDeXA3fJdlB3sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TfxIgU6n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LAL9pE014002;
	Mon, 21 Oct 2024 10:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BGyQq6SyF9AsuGlmx8PGOsMuSmdxd4pZh/fIHSN0nC8=; b=TfxIgU6n4Ngwfbd+
	AXV+zEi7ZiABHbkdLEy1bPvEV88KPhfNQhWWh5+uzmhL7EcMV0TVROJ4SO4YOqtl
	SNfbQEEVU99kB8oKzNDt7H/uv4bHMdPoXz4GE6E8gVzazNUspKj2HJ8iuK3WPu/z
	BjJfTQ8UoFmGDB+cVnazrRCmD6Lu/b9JZ/KSwBlIWM9Om/+HXFtpdP4aPNcqyjJJ
	+v6nVktkjUYpwM2Juqg77tFfQwbDi5eFkPaqoA8ZsrAKUp61tOdbQ7yaXrELoTJ9
	sH0tTq+tjA6kKQ4g2mnBQczgK+vW8pmdmXAzbQleTAgBbxL2JCCXecLqSLG/jp83
	t1Etgw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6vc49s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 10:35:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LAZMbn030409
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 10:35:22 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 21 Oct
 2024 03:35:21 -0700
Message-ID: <96a7a24b-61e2-45cc-9c76-15552107976d@quicinc.com>
Date: Mon, 21 Oct 2024 18:35:19 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iwlwifi GTK rekey is not working with WPA3 SAE encryption
To: Johannes Berg <johannes@sipsolutions.net>
CC: linux-wireless <linux-wireless@vger.kernel.org>
References: <9840f652-7d4a-4693-90da-844174dc30f5@quicinc.com>
 <ee5e7f5020bc874f477def3b1ea79339f0812b40.camel@sipsolutions.net>
 <a45e6c7a-7348-45a1-9ce6-7a5425b21a36@quicinc.com>
 <e96a1d4b63388e8d7e8a9fadfce31f408ae83ab2.camel@sipsolutions.net>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <e96a1d4b63388e8d7e8a9fadfce31f408ae83ab2.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MTZdcdI5Dqq_OLl9OocY-I_5f3-6Mdt6
X-Proofpoint-ORIG-GUID: MTZdcdI5Dqq_OLl9OocY-I_5f3-6Mdt6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210075



On 10/21/2024 6:17 PM, Johannes Berg wrote:
> On Mon, 2024-10-21 at 18:05 +0800, Baochen Qiang wrote:
>>
>> Oct 21 17:50:17 xps13 kernel: [  153.758773] iwlwifi 0000:00:14.3: loaded firmware version 77.0b4c06ad.0 Qu-c0-hr-b0-77.ucode op_mode iwlmvm
> 
> Huh, I'm surprised you have that version :)
i just upgrade to the latest linux-firmware repo :)

> 
> Hm. Support for SAE AKMs should've been backported, so that's a bit odd.
> What's the AKM in use, ciphers, etc.?
i am not familiar with 802.11 security, guessing it is SAE & CCMP?

here is M2 in 4-way handshake:

802.1X Authentication
    Version: 802.1X-2001 (1)
    Type: Key (3)
    Length: 126
    Key Descriptor Type: EAPOL RSN Key (2)
    [Message number: 2]
    Key Information: 0x0108
        .... .... .... .000 = Key Descriptor Version: Unknown (0)
        .... .... .... 1... = Key Type: Pairwise Key
        .... .... ..00 .... = Key Index: 0
        .... .... .0.. .... = Install: Not set
        .... .... 0... .... = Key ACK: Not set
        .... ...1 .... .... = Key MIC: Set
        .... ..0. .... .... = Secure: Not set
        .... .0.. .... .... = Error: Not set
        .... 0... .... .... = Request: Not set
        ...0 .... .... .... = Encrypted Key Data: Not set
        ..0. .... .... .... = SMK Message: Not set
    Key Length: 0
    Replay Counter: 1
    WPA Key Nonce: c10f804544a44114c39ae7044839aab67c82be3ca1a1816641bc98bed35d0271
    Key IV: 00000000000000000000000000000000
    WPA Key RSC: 0000000000000000
    WPA Key ID: 0000000000000000
    WPA Key MIC: 183a4a5e17e821561cfc0088ee6729c0
    WPA Key Data Length: 31
    WPA Key Data: 301a0100000fac040100000fac040100000fac0880000000000fac06f40120
        Tag: RSN Information
            Tag Number: RSN Information (48)
            Tag length: 26
            RSN Version: 1
            Group Cipher Suite: 00:0f:ac (Ieee 802.11) AES (CCM)
                Group Cipher Suite OUI: 00:0f:ac (Ieee 802.11)
                Group Cipher Suite type: AES (CCM) (4)
            Pairwise Cipher Suite Count: 1
            Pairwise Cipher Suite List 00:0f:ac (Ieee 802.11) AES (CCM)
                Pairwise Cipher Suite: 00:0f:ac (Ieee 802.11) AES (CCM)
                    Pairwise Cipher Suite OUI: 00:0f:ac (Ieee 802.11)
                    Pairwise Cipher Suite type: AES (CCM) (4)
            Auth Key Management (AKM) Suite Count: 1
            Auth Key Management (AKM) List 00:0f:ac (Ieee 802.11) SAE (SHA256)
                Auth Key Management (AKM) Suite: 00:0f:ac (Ieee 802.11) SAE (SHA256)
            RSN Capabilities: 0x0080
                .... .... .... ...0 = RSN Pre-Auth capabilities: Transmitter does not support pre-authentication
                .... .... .... ..0. = RSN No Pairwise capabilities: Transmitter can support WEP default key 0 simultaneously with Pairwise key
                .... .... .... 00.. = RSN PTKSA Replay Counter capabilities: 1 replay counter per PTKSA/GTKSA/STAKeySA (0x0)
                .... .... ..00 .... = RSN GTKSA Replay Counter capabilities: 1 replay counter per PTKSA/GTKSA/STAKeySA (0x0)
                .... .... .0.. .... = Management Frame Protection Required: False
                .... .... 1... .... = Management Frame Protection Capable: True
                .... ...0 .... .... = Joint Multi-band RSNA: False
                .... ..0. .... .... = PeerKey Enabled: False
                ..0. .... .... .... = Extended Key ID for Individually Addressed Frames: Not supported
                .0.. .... .... .... = OCVC: False
            PMKID Count: 0
            PMKID List
            Group Management Cipher Suite: 00:0f:ac (Ieee 802.11) BIP (128)
        Tag: RSN eXtension (1 octet)

> 
> johannes


