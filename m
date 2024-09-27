Return-Path: <linux-wireless+bounces-13250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC85E987E10
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2024 07:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7F11F21EDE
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2024 05:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A297641C63;
	Fri, 27 Sep 2024 05:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CSnKrj0z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B332E8475
	for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2024 05:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727416772; cv=none; b=EcamyQtSaBGAqyKr7bqad/zUvYKaHhRIKNPfQ42jcHTcJY66EaomCATqyOe8mADkbg4KWoaYEyP+caTuV/SNWxQLrTr1EUK6vCtfLAvPTWDMu/OBfpNxeJbMXmvp01vMkireJ9+b+cxEimTNInin/PB05BzvJnaJgrtfn40sfW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727416772; c=relaxed/simple;
	bh=zsqyD/ntIHWC1fDEiimhwJTCGrX/YHSW2JR6SPXoqQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YSfAjfA3H5KikTsijlYT+3CUbOohNacfi54l4Wi4aQb8Q58Cvchp6nnvzjb18dQ4llxTPwZFKutkhPRPMOZxZbt6y5w5EogO8dNNsvTUvjJZRl5iE2v9FPdDGIZsFDzBERdUaxGpcQbCM2MK8/Q1rgQFZscn+yapF0oZn//5c2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CSnKrj0z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QG9aM1027971;
	Fri, 27 Sep 2024 05:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pDc6NvK0SKIk25ZudmA/LeRyjpVAKL2q52NcBzFfO2Y=; b=CSnKrj0zgQpt95ky
	bK05Vf03I2vkX7eLo0R9jKsE19DEsbC+qt7vAsQdG2FaPhZSurC268wWmO7g33bj
	RQk2EV27Rhja7VPLZU3ckYMqiY/PIHE6HQC4CeBYSoBrQHalSNvmk5bWUGdXKznV
	a0WrZSrtE6UmbDq9LTTEFnQ9VCfY0iRNq+kWzeCJcPkE+MvwQmfUCTjcXsXqzXo8
	AXcP2IIbm8SrupmsuL8diw5v7LJhzmhDnfuRGCoRJ0b9sPWPUqe43fV7i4D1LlEs
	KaT5V9t4ZAAw45yRNyKsjsor1B+oJ5iFDSSzYOnsfA0qGlPzrv5SrzwPvWFmy/of
	bh1TSg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41skuf1xg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 05:59:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48R5xP3V014205
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 05:59:25 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 26 Sep
 2024 22:59:24 -0700
Message-ID: <26302980-4cd8-466a-8de1-4be10a42536a@quicinc.com>
Date: Fri, 27 Sep 2024 13:59:22 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k/WCN6855 neighbor report request made immediately after
 connection gets no response (with MFP)
To: James Prestwood <prestwoj@gmail.com>,
        "open list:MEDIATEK MT76 WIRELESS
 LAN DRIVER" <linux-wireless@vger.kernel.org>
CC: "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <eb41d8ec-c4f1-474e-a938-099f27aa94e3@gmail.com>
 <fd90d471-503b-4f58-ae11-bae2afab08c7@quicinc.com>
 <0d1dab88-66a0-48c1-bdbe-777d07c3132e@gmail.com>
 <70567137-dfb9-4896-9e6c-6c02a97228cb@quicinc.com>
 <15c909da-f01e-43ee-b486-f9b6d5bcc29c@gmail.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <15c909da-f01e-43ee-b486-f9b6d5bcc29c@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4HdERewbce4Ki1zP2TBJgDQ79HwP1iAf
X-Proofpoint-ORIG-GUID: 4HdERewbce4Ki1zP2TBJgDQ79HwP1iAf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270039



On 9/26/2024 8:31 PM, James Prestwood wrote:
> Hi,
> 
> On 9/25/24 8:16 PM, Baochen Qiang wrote:
>>
>> On 9/25/2024 7:33 PM, James Prestwood wrote:
>>> Hi Baochen,
>>>
>>> On 9/25/24 3:07 AM, Baochen Qiang wrote:
>>>> On 9/19/2024 8:21 PM, James Prestwood wrote:
>>>>> Hi,
>>>>>
>>>>> I noticed an issue when we started putting ath11k clients on a WPA3 network which seems to be related to the fact that management frame protection is enabled (works fine on WPA2 no MFP). Immediately after an initial association a neighbor report request goes out and we get no response from the AP. After getting a PCAP in one case we noticed the neighbor report request went out unencrypted, though still had the CCMP IV parameter. The content of the request was the unencrypted request, and something like 15 bytes of 0x00 padding. I will say, this initial PCAP was made through the AP vendor so perhaps it 
how do you tell if the 'neighbor report request' was unencrypted? did you check the 'protected' flag in sniffer?

automatically added the right keys to decrypt the frame, this could be a red herring. I tried on my home network and it was hit or miss, sometimes I would get a response but sometimes I wouldn't, but I did see the frame was always encrypted in my home network case though when adding the PMK directly in wireshark I couldn't decrypt it, where on other hardware like iwlwifi I
and how do you tell if it is always encrypted?


>>>>> could.
>>>> is your home network also WPA3?
>> any comment on this query?
> Yes, my home network is WPA3.
>>
>>>> and how did you get the PMK? is it generated by IWD and printed as debug message?
>>> I actually had to modify IWD to print out the PMK after it derived it. WPA3 makes this a huge pain since the PMK differs between SAE exchanges.
>>>
>>> I've attached an IWD diff that prints out the PMK, which can be added to wireshark if that helps.
>> Thanks, I found another way to do the decryption.
> Out of curiosity how did you do this? I couldn't find any other way to decrypt WPA3 connections in wireshark except adding the PMK directly, even when capturing the 4-way handshake.
I dumped the TK:

	@@ -2055,6 +2062,8 @@ static void netdev_set_tk(struct handshake_state *hs, uint8_t key_index,
	        if (!netdev_copy_tk(tk_buf, tk, cipher, hs->authenticator))
	                goto invalid_key;
	
	+       l_util_hexdump(false, tk_buf, 16, do_debug, "tk: ");
	+
	        msg = nl80211_build_new_key_pairwise(netdev->index, cipher, addr,
	                                        tk_buf, crypto_cipher_key_len(cipher),
                                        key_index);

>>
>>>>> Some time after the connection neighbor reports work fine. I'm not sure of a time frame or delay required that gets them working, but it makes me suspect that ath11k doesn't have the keys fully added in the firmware before userspace gets signaled as "connected". Running the same scenario on ath10k or iwlwifi has no issues. This neighbor report request immediately after connecting is IWD's default behavior, so its relatively easy to test by just restarting IWD.
>>>> I captured a WPA3 SAE PCAP too, but only can find some unencrypted ADDBA req/resp frames. for those encrypted action frames I am still struggling to decrypt them
>> I checked all the action frames after decrypt the PCAP, but still not able to find a 'neighbor report' frame. next will study IWD code to understand how such a frame is triggered.
>>
>> and again, if not possible to share the complete PCAP, can you share the individual 'neighbor report request' frame ? you can simply copy it in wireshark.
> 
> Immediately after connecting you should see one of two possibilities.
> 
> 1. If IWD did not receive a response you would see:
> 
> iwd[694]: src/station.c:station_early_neighbor_report_cb() ifindex: 6, error: -110(Connection timed out)
> 
> 2. If a neighbor report was sent back by the AP you would see:
> 
> src/station.c:station_early_neighbor_report_cb() ifindex: 13, error: 0()
> src/station.c:parse_neighbor_report() Neighbor report received for xx:xx:xx:xx:xx:xx ch 44 (oper class 22), MD not set
> 
> I just re-ran the test and now, for some reason, I am entirely unable to see the actual request go out. In the case of both ath11k and ath10k I see no request and but I do sometimes see a response. For iwlwifi I was able to capture a request/response but for the most part I don't see any request either, but always a response. Maybe the request is going out at some other data rate that my monitor card is unable to capture reliably? Not sure on that one.
> 
> So as far as seeing a request from ath11k, I'm unable to get one at least on my home network. Getting a capture on the corporate network may take me some more time.
here is the sequence I saw in sniffer:
#1 AP send M3
#2 station send 'neighbor report request' without encryption, though 'protected' flag is set
#3 station send out M4

is this the same with what you saw?

> 
> Thanks,
> 
> James
> 
>>
>>>>> Since the neighbor reports work fine after some time its not really a critical issue but I wanted to bring it up just in case.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> James
>>>>>


