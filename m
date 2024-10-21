Return-Path: <linux-wireless+bounces-14264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB4D9A6520
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 12:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4FA28324B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 10:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067E41E9064;
	Mon, 21 Oct 2024 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RRM2dnoi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531471F130E
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 10:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507725; cv=none; b=TYRLcPQDTso75EwX2AOFiw5VdOGiKjOjNbrDIrCLdgXWdNwc/8Dzza8xwj6a9/IZjw5amk0A5BYqZT0RnUO4lP1CWi8363O5cXSjyDXM+KDzj/lPXN753rEoCXSRH/KRF58mznBeX231uA9yCVEmatAmMmPv1Fl+i5PnqvPHsBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507725; c=relaxed/simple;
	bh=B13I7n8are1oGypp3klPgnwWrd/Vd+RSgJJDvztvLeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YLscm9nXqNz3aYm+St4Us/bJY4Re9npGe925BvJ5iEMUe4wiGtk4XOLzaFiJrDDPpk+HpusrfJ3vZPer4YaWseXqL6UliV7ZXF2T9QWQLe1eDHX/p6je9jWTZqTkI6GftFOvP1D/jBc4TKr2O+ztpEzk8zmZX+8AXtMlu2y8cNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RRM2dnoi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LAZni4010199;
	Mon, 21 Oct 2024 10:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MC3sfIkAgbneYNivKXndNMa2jsLxWbhO9eNu4eolsYE=; b=RRM2dnoiVuTym9pz
	iBSVqjZpFSpsyHBTYlmoWHlR6eNcq1YYF16cK7jvxthNw7NFwhzJHj0EHji0ByBC
	9CyEr9DEZY2iCMYEugJ2W/KvSYp56sLB3JoAm5aoV9F3YJgVsbbbMZP8al7HTYAk
	JIaiL2J+4nIrTIQZlVO6FN7jfYXNqvDBxUWzWzQ+lKjjDhitJ4IiK8f/FWyH7TLv
	V+j7EdLifnMzvpjJzXNKvpkb9Z7dCK3fLsgD/HzeKG9vGXvZ6IiHLWnmyBNwdsLN
	akY180ftXyNdK4AcbPTNh2rlDXeG+vCYKl2EJgfgzMBFH2R3F7b2ne+v7rm+7XLz
	jPGLqw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6tsm81g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 10:48:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LAmdXS005056
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 10:48:39 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 21 Oct
 2024 03:48:39 -0700
Message-ID: <ca085fd4-fc22-4c91-a571-7a55ac4f32d5@quicinc.com>
Date: Mon, 21 Oct 2024 18:48:37 +0800
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
 <96a7a24b-61e2-45cc-9c76-15552107976d@quicinc.com>
 <1606121bda73a1295f934cff07b1ab52fcebaf94.camel@sipsolutions.net>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <1606121bda73a1295f934cff07b1ab52fcebaf94.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1tD39MopoegrkPAKV2PuXTDHuapvmTXo
X-Proofpoint-ORIG-GUID: 1tD39MopoegrkPAKV2PuXTDHuapvmTXo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxlogscore=873 phishscore=0 adultscore=0
 mlxscore=0 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210077



On 10/21/2024 6:45 PM, Johannes Berg wrote:
> On Mon, 2024-10-21 at 18:35 +0800, Baochen Qiang wrote:
>>>>
>>>> Oct 21 17:50:17 xps13 kernel: [  153.758773] iwlwifi 0000:00:14.3: loaded firmware version 77.0b4c06ad.0 Qu-c0-hr-b0-77.ucode op_mode iwlmvm
>>>
>>> Huh, I'm surprised you have that version :)
>> i just upgrade to the latest linux-firmware repo :)
> 
> Oh, didn't realize that was released there already.
> 
>>> Hm. Support for SAE AKMs should've been backported, so that's a bit odd.
>>> What's the AKM in use, ciphers, etc.?
>> i am not familiar with 802.11 security, guessing it is SAE & CCMP?
>>
>> here is M2 in 4-way handshake:
>>
> 
> Can you also capture the rekeying M1?
this is rekey M1:

802.1X Authentication
    Version: 802.1X-2004 (2)
    Type: Key (3)
    Length: 159
    Key Descriptor Type: EAPOL RSN Key (2)
    [Message number: 1]
    Key Information: 0x1380
        .... .... .... .000 = Key Descriptor Version: Unknown (0)
        .... .... .... 0... = Key Type: Group Key
        .... .... ..00 .... = Key Index: 0
        .... .... .0.. .... = Install: Not set
        .... .... 1... .... = Key ACK: Set
        .... ...1 .... .... = Key MIC: Set
        .... ..1. .... .... = Secure: Set
        .... .0.. .... .... = Error: Not set
        .... 0... .... .... = Request: Not set
        ...1 .... .... .... = Encrypted Key Data: Set
        ..0. .... .... .... = SMK Message: Not set
    Key Length: 0
    Replay Counter: 5
    WPA Key Nonce: 0000000000000000000000000000000000000000000000000000000000000000
    Key IV: 00000000000000000000000000000000
    WPA Key RSC: 0000000000000000
    WPA Key ID: 0000000000000000
    WPA Key MIC: 8ea97cf0e8547fdaa82432f8fc0ea23b
    WPA Key Data Length: 64
    WPA Key Data: ac3e43897dfc934f8f84d58e6fa5bd6c26ae666a29892de0a30d43c7dc7a063ac6b5884718d8945274c0df6559e48c861efec804b5be920bd5550c43b0889ea0


> 
> johannes


