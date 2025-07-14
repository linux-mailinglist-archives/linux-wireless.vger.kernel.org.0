Return-Path: <linux-wireless+bounces-25360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9B9B03B9E
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 12:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95543BA722
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 10:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC68221739;
	Mon, 14 Jul 2025 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Co8DCs1O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44D1FBE87
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752487750; cv=none; b=W0f+ZQ9gNSgsFYqNPAZE0EGqaob02bQIRN1v3fBC+YnwK9BBrn9ldQlVbudDIEDFEiMms1ozlbfnXsj9xU+phzeCLm6Qt2SZiDey6kFbDB0WsD+6oVrnjIAK/x6kqU02k1xpX3DxXRpLc+gd+3I19/gA2edyr8ZiAsOh8E95WKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752487750; c=relaxed/simple;
	bh=8KZ9XDI+BP2zW+ymF4qi2IDFzMpzUnz/g4WbY2lZiik=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=o4ywq91eNei3iI/Jq/tZzbZA/tENtzQ2jvKZjH2/uD8hAUgM4Hq6r4NZbUbNiDcRdiH24n0/1Ng3URUR8xyJtgriTyLwVWtRWUrqzZJ4mIq9nszq+AIaiaiTeDh+9ulIwyq78CBQy+IzrO9TuTuagu789HnlIkjja7o1fakYOnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Co8DCs1O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9gd0d026710
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 10:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vYNaReKZZS2bydL6FgurQ5D5
	vN58dH3olfMKak3r50U=; b=Co8DCs1OzRqORWACMAhjXg6OSFXI2J5n+9HQU45b
	+X4SMC4qQFarGNzyoCsAzu8IMvJJgMtpoXiBSBIHwIB7goexQfm53J8vXBabSE2W
	r43xMShm1aAuEH0x9WExWMRk0r/weEd5KCNSYQJaXNjpK5e7jCw0kkfqhgoENeyf
	3Ikh1d4nuzXjPwHuSpWkV2vy2yBhDrZbDxwqoyOhARvGcTOXL1QNUFx1ndUpx9mz
	Na0/qbToEAHsmcJ+b+gZHz0gnaWqrK5+Xj4usUpycu4TvSeULye4ymSD6IrjzTcF
	ZbU/rGgagpEqYsdRJE58CgScLP0vdcYvKmNjWtosduybjQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ugfhc7re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 10:09:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-234f1acc707so34151685ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 03:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752487746; x=1753092546;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vYNaReKZZS2bydL6FgurQ5D5vN58dH3olfMKak3r50U=;
        b=PKQ+RQItG91n8SFo42e2Y4jtiHV+Ue1MYE372zrmChSj/WO7m/rAIr9ekx2l35WF9F
         yPSax3WmZ2z6GyF8Rs6wrto+7BQLcfcZUVq9FWJQ05rJy1dyezm92rakXkYXYPbFkFJm
         UeySbFX33r9pRW+YHdqBUwqJ+ueLkzxSetP1MfqxZOcldJSY2iTcD8aZE4nLTeuAUdRa
         b+O4pLveRMBLrSyA1+8VVY4Z9znOr+k4vZMezIajPSWZNjQ3FZde9uvPkXg9XJH9K1nl
         aehzlIwcsqbsVdiVfk3/q2tbeIcI9UYsoC1Ldc41LiOtwz8F7+jq9XYXmsi9cHkwZY+c
         UXMg==
X-Gm-Message-State: AOJu0YwI6Pgt47KZfODsgzsGb0q+YxQVcfUAaaPpedguA99MwxdkYWVV
	k2ubOnJRsLNHfRx01BvTkxfRonZILP3SfoBIGtOCDJgRTpdfBCO2j4slBTOpAo3At5RGRfVQKYq
	VjKFUWlHQjFBOkQsf/mBkyYL7A4Zq9XqnxQGVYqRCwFIwyqFGNs3F02qQQ0qOgJajEIen5Q==
X-Gm-Gg: ASbGncv7AACvYHvll/mMv+jpchdr+ABU4Lw6TNnCQUK/QLMp9fH1aQu0fnm6K/3wTJR
	a1GYVAq4npQqOOLD1+NqpgeHwzonQ72zXO+lsEOmMPbCl+4kwHHJcVp/PfNKCZKvWJ4J0ZKMYW+
	jGx9TQpffXjPbR5xPQHPZSXFEhz2nMEY2j+erhKAkcKzrPDXc7ZaN8gWxjijznaVj6zvWt8k+9x
	0762lp+dVKspPCP77GMRrZRta/Z2hUkCudA/XeOQBMfMEq2x2ccxdK18cI8Uer1pBqXNYh8iZtQ
	3flsGL45nAjfQo/UI0Y+dAKvAgXzpH9RgkE/e6F+mZbFexZg6YEM73D4NEPh6YmIeJ3VnJgKL2s
	1IaafGvhC0uJFlfcG9cvZTef9W5reTIKw
X-Received: by 2002:a17:902:db0d:b0:232:59b:58fe with SMTP id d9443c01a7336-23dee188917mr226607045ad.1.1752487746193;
        Mon, 14 Jul 2025 03:09:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv8LI4daNdnFQxura3YkauLwvep+CE8aPoIdwDwqEpZpTFptsRhWl3YvjCb6+euEJ7Jz+vVg==
X-Received: by 2002:a17:902:db0d:b0:232:59b:58fe with SMTP id d9443c01a7336-23dee188917mr226606515ad.1.1752487745470;
        Mon, 14 Jul 2025 03:09:05 -0700 (PDT)
Received: from [10.133.33.219] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de43226d9sm90234575ad.116.2025.07.14.03.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 03:09:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------nwDNZFyK3vgYr0lzjw5kUj88"
Message-ID: <652c3aa7-dee6-470c-b5dc-638198990192@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 18:09:02 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Disconnection triggered by Puncture advertisement
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
References: <e80d5786-b1c1-46f5-b723-e6197e2d06e9@oss.qualcomm.com>
 <e713c376c01a81dd21d928e5d84bd3a1ae9e6613.camel@sipsolutions.net>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <e713c376c01a81dd21d928e5d84bd3a1ae9e6613.camel@sipsolutions.net>
X-Proofpoint-ORIG-GUID: ydDSoO4JGHQ1K-f2TM4ntKK1OJMjL34d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA1OCBTYWx0ZWRfX63qMDbkI/I+H
 lRVQsnCwbYRkARntUJVBcxR98os4i705R32pmC31zRBcK2IIxGHCgpTtZFJeGRORRKzoNNopKxZ
 MJhKvOfbdZn4+fq8R5rOF+TC70gByPDw9HQ2BmZfd9XtxjSYjB+fgpYkl00vJ8kwv1Cug7M1oGP
 J2CT1cjNSjTGJKI5t6G4jh+MMvZ/oOBcyE97PBE6pSE2oj29gNRz6cvD46OqXFLH9N325Bzt3uB
 bp+ASmLheE6fiWUqYkD/HCQI98Nmdtc/ov5NQtcOVHojKQJWRx9xKQDNrZhbjlpFpW8biZ62yfA
 lHHfReQGXe0n5omqj3gsLmBVyBq7vnULsBjxaBE2y7sUFH6Mf2PjXTA9K/amDqnTU8+yi56qQQx
 aAe/9fq7ugmo/+xSXsCEx4i5nbjbz0e+LeiGRxVuybcIeZU5ukLUOhNgSrUAKUQn53fmHwpR
X-Proofpoint-GUID: ydDSoO4JGHQ1K-f2TM4ntKK1OJMjL34d
X-Authority-Analysis: v=2.4 cv=HYkUTjE8 c=1 sm=1 tr=0 ts=6874d743 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=r77TgQKjGQsHNAKrUKIA:9 a=OqjJB9qmJEMmvYQhYIwA:9
 a=QEXdDO2ut3YA:10 a=RorA9MK6TyB60wMLaHgA:9 a=MdQSIEomN50A:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140058

This is a multi-part message in MIME format.
--------------nwDNZFyK3vgYr0lzjw5kUj88
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/14/2025 5:29 PM, Johannes Berg wrote:
> On Mon, 2025-07-14 at 16:16 +0800, Baochen Qiang wrote:
>> Hi,
>>
>> Recently I hit an IoT issue while connecting to an TP-LINK AP. As a station, the
>> connection with the AP initially succeeded, as indicated by the authentication and
>> association logs:
>>
>> [  528.655093] wlan0: authenticate with 16:d8:64:56:ab:5b (local address=66:81:93:de:79:d8)
>> [  528.655112] wlan0: send auth to 16:d8:64:56:ab:5b (try 1/3)
>> [  528.720573] wlan0: authenticate with 16:d8:64:56:ab:5b (local address=66:81:93:de:79:d8)
>> [  528.720584] wlan0: send auth to 16:d8:64:56:ab:5b (try 1/3)
>> [  528.790413] wlan0: authenticated
>> [  528.794115] wlan0: associate with 16:d8:64:56:ab:5b (try 1/3)
>> [  528.831371] wlan0: RX AssocResp from 16:d8:64:56:ab:5b (capab=0x1911 status=0 aid=1024)
>> [  528.858116] wlan0: [link 0] local address 9e:c1:c3:67:13:db, AP link address
>> 14:d8:64:4c:ab:5b
>> [  528.858201] wlan0: [link 1] local address 66:81:93:de:79:d8, AP link address
>> 14:d8:64:4c:ab:5c (assoc)
>> [  528.911598] wlan0: associated
>> [  528.978910] wlan0: Limiting TX power to 35 (35 - 0) dBm as advertised by 14:d8:64:4c:ab:5c
> 
> Clearly that was with EHT, otherwise you couldn't have two links.

Yeah, indeed.

> 
>> However, the connection was later disrupted:
>>
>> [  533.845338] wlan0: AP EHT information doesn't match HT/VHT/HE, disabling EHT
>> [  533.845344] wlan0: [link 1] AP 14:d8:64:4c:ab:5c appears to change mode (expected EHT,
>> found HE) in beacon, disconnect
>>
>> with some logs added:
>>
>> ---
>> +static void cfg80211_dump_chan_def(const struct cfg80211_chan_def *def)
>> +{
>> +       struct ieee80211_channel *chan = def->chan;
>> +       pr_info("chan: [band %u center_freq %u freq_offset %u hw_value %u flags %u
>> max_antenna_gain %u max_power %u max_reg_power %u beacon_found %u orig_flags %u] width %u
>> center_freq1 %u center_freq2 %u freq1_offset %u punctured %u\n",
>> +               chan->band, chan->center_freq, chan->freq_offset, chan->hw_value,
>> chan->flags, chan->max_antenna_gain, chan->max_power, chan->max_reg_power,
>> chan->beacon_found, chan->orig_flags,
>> +               def->width, def->center_freq1, def->center_freq2, def->freq1_offset,
>> def->punctured);
>> +}
>> +
>>  static const struct cfg80211_chan_def *
>>  _cfg80211_chandef_compatible(const struct cfg80211_chan_def *c1,
>>                              const struct cfg80211_chan_def *c2)
>>  {
>>         const struct cfg80211_chan_def *ret;
>>
>> +       cfg80211_dump_chan_def(c1);
>> +       cfg80211_dump_chan_def(c2);
>> +
>>         /* If they are identical, return */
>> ---
>>
>> The disconnection is caused by different 'punctured':
>>
>> [  533.845311] chan: [band 1 center_freq 5180 freq_offset 0 hw_value 36 flags 524320
>> max_antenna_gain 6 max_power 24 max_reg_power 24 beacon_found 1 orig_flags 0] width 3
>> center_freq1 5210 center_freq2 0 freq1_offset 0 punctured 0
>> [  533.845322] chan: [band 1 center_freq 5180 freq_offset 0 hw_value 36 flags 524320
>> max_antenna_gain 6 max_power 24 max_reg_power 24 beacon_found 1 orig_flags 0] width 3
>> center_freq1 5210 center_freq2 0 freq1_offset 0 punctured 8
> 
> That message is a bit misleading then - we decided that the EHT wasn't
> valid and so that code fell back to reporting HE, and then that means it
> changed in a strange way.
> 
>> This 'punctured' is suddenly (I mean even 'EHT Operation' was not seen in previous
>> beacons)
> 
> Pretty sure there must've been EHT operation before, otherwise we
> couldn't connect with EHT, and you had multi-link.

Sorry for misleading, I was not clear. I was trying to say 'EHT Operation Parameters' in
beacon was always 0 AFTER AssocResp, until this sudden 'punctured' frame.

Of course 'EHT operation' was always seen in the beacon frames.

> 
> Of course the puncturing bitmap could've been elided before.
> 
>>  advertised in EHT Operation element contained in AP's beacon:
>>
>> Ext Tag: EHT Operation (802.11be D3.0)
>>     Ext Tag length: 10 (Tag len: 11)
>>     Ext Tag Number: EHT Operation (802.11be D3.0) (106)
>>     EHT Operation Parameters: 0x03, EHT Operation Information Present, Disabled Subchannel
>> Bitmap Present
>>         .... ...1 = EHT Operation Information Present: True
>>         .... ..1. = Disabled Subchannel Bitmap Present: True
>>         .... .0.. = EHT Default PE Duration: False
>>         .... 0... = Group Addressed BU Indication Limit: False
>>         ..00 .... = Group Addressed BU Indication Exponent: 0
>>         00.. .... = Reserved: 0x0
>>     Basic EHT-MCS And Nss Set: 0x00000011
>>     Control: 0x02, Channel Width: 80 MHz EHT BSS bandwidth
>>         .... .010 = Channel Width: 80 MHz EHT BSS bandwidth (2)
>>         0000 0... = Reserved: 0x00
>>     CCFS0: 0x0000002a
>>     CCFS1: 0x00000000
>>     Disabled Subchannel Bitmap: 0x0008
>>
>> Which fails the check in _cfg80211_chandef_compatible(), because the chandef's are not
>> identical but have the same width.
> 
> Question is _which_ chandefs it's comparing.
> 
> Can you show the rest of the operation fields? HT/VHT/HE.

IEEE 802.11 Wireless Management
    Fixed parameters (12 bytes)
    Tagged parameters (472 bytes)
        Tag: SSID parameter set: "TP-LINK_BE3600"
        Tag: Supported Rates 6(B), 9, 12(B), 18, 24(B), 36, 48, 54, [Mbit/sec]
        Tag: DS Parameter set: Current Channel: 36
        Tag: Traffic Indication Map (TIM): DTIM 0 of 1 bitmap
        Tag: Country Information: Country Code CN, Environment All
        Tag: Power Constraint: 0
        Tag: TPC Report Transmit Power: 63 dBm
        Tag: Tx Power Envelope
        Tag: RM Enabled Capabilities (5 octets)
        Tag: AP Channel Report: Operating Class 128, Channel List : 42, 58, 155,
        Tag: RSN Information
        Tag: HT Capabilities (802.11n D1.10)
        Tag: HT Information (802.11n D1.10)
            Tag Number: HT Information (802.11n D1.10) (61)
            Tag length: 22
            Primary Channel: 36
            HT Information Subset (1 of 3): 0x05
                .... ..01 = Secondary channel offset: Secondary channel is above the
primary channel (0x1)
                .... .1.. = Supported channel width: Channel of any width supported
                .... 0... = Reduced Interframe Spacing (RIFS): Prohibited
                0000 .... = Reserved: 0x0
            HT Information Subset (2 of 3): 0x0005
                .... .... .... ..01 = HT Protection: HT non-member protection mode (0x1)
                .... .... .... .1.. = Non-greenfield STAs present: One or more associated
STAs are not greenfield capable
                .... .... .... 0... = Reserved: 0x0
                .... .... ...0 .... = OBSS non-HT STAs present: Use of protection for
non-HT STAs by overlapping BSSs is not needed
                ...0 0000 000. .... = Channel Center Frequency Segment 2: 0
                000. .... .... .... = Reserved: 0x0
            HT Information Subset (3 of 3): 0x0000
                .... .... ..00 0000 = Reserved: 0x00
                .... .... .0.. .... = Dual beacon: No second beacon is transmitted
                .... .... 0... .... = Dual Clear To Send (CTS) protection: Not required
                .... ...0 .... .... = Beacon ID: Primary beacon
                .... ..0. .... .... = L-SIG TXOP Protection Full Support: One or more HT
STAs in the BSS do not support L-SIG TXOP protection
                .... .0.. .... .... = Phased Coexistence Operation (PCO): Inactive
                .... 0... .... .... = Phased Coexistence Operation (PCO) Phase: Switch to
or continue 20 MHz phase
                0000 .... .... .... = Reserved: 0x0
            Rx Supported Modulation and Coding Scheme Set: Basic MCS Set
        Tag: VHT Capabilities
        Tag: VHT Operation
            Tag Number: VHT Operation (192)
            Tag length: 5
            VHT Operation Info
                Channel Width: 80 MHz, 160 MHz or 80+80 MHz BSS Bandwidth (1)
                Channel Center Segment 0: 42
                Channel Center Segment 1: 0
            Basic MCS Map: 0xfffc
        Tag: Extended Capabilities (8 octets)
        Ext Tag: HE Capabilities
        Ext Tag: HE Operation
            Ext Tag length: 6 (Tag len: 7)
            Ext Tag Number: HE Operation (36)
            HE Operation Parameters: 0x003ff4
                .... .... .... .... .... .100 = Default PE Duration: 4
                .... .... .... .... .... 0... = TWT Required: Not required
                .... .... ..11 1111 1111 .... = TXOP Duration RTS Threshold: 1023
                .... .... .0.. .... .... .... = VHT Operation Information Present: False
                .... .... 0... .... .... .... = Co-Hosted BSS: False
                .... ...0 .... .... .... .... = ER SU Disable: False
                .... ..0. .... .... .... .... = 6 GHz Operation Information Present: False
                0000 00.. .... .... .... .... = Reserved: 0x00
            BSS Color Information: 0x36
            Basic HE-MCS and NSS Set: 0xfffc
        Ext Tag: Spatial Reuse Parameter Set
        Ext Tag: MU EDCA Parameter Set
        Tag: FILS Indication
        Tag: Vendor Specific: Tp-Link Technologies Co.,Ltd.
        Tag: Vendor Specific: Tp-Link Technologies Co.,Ltd.
        Tag: Vendor Specific: Tp-Link Technologies Co.,Ltd.
        Tag: RSN eXtension (1 octet)
        Tag: Reduced Neighbor Report
        Ext Tag: Multi-Link (802.11be D3.0)
        Ext Tag: EHT Capabilities (802.11be D3.0)
        Ext Tag: EHT Operation (802.11be D3.0)
            Ext Tag length: 10 (Tag len: 11)
            Ext Tag Number: EHT Operation (802.11be D3.0) (106)
            EHT Operation Parameters: 0x03, EHT Operation Information Present, Disabled
Subchannel Bitmap Present
                .... ...1 = EHT Operation Information Present: True
                .... ..1. = Disabled Subchannel Bitmap Present: True
                .... .0.. = EHT Default PE Duration: False
                .... 0... = Group Addressed BU Indication Limit: False
                ..00 .... = Group Addressed BU Indication Exponent: 0
                00.. .... = Reserved: 0x0
            Basic EHT-MCS And Nss Set: 0x00000011
            Control: 0x02, Channel Width: 80 MHz EHT BSS bandwidth
                .... .010 = Channel Width: 80 MHz EHT BSS bandwidth (2)
                0000 0... = Reserved: 0x00
            CCFS0: 0x0000002a
            CCFS1: 0x00000000
            Disabled Subchannel Bitmap: 0x0008
        Tag: Vendor Specific: MediaTek Inc
        Tag: Vendor Specific: MediaTek Inc
        Tag: Vendor Specific: Microsoft Corp.: WMM/WME: Parameter Element
        Tag: Vendor Specific: MediaTek Inc


> 
>> Is this AP misbehaving? or is cfg80211/mac80211 not doing correctly?
>>
>> I am not very familiar with Puncturing, want to hear professional opinions from your guys.
> 
> I don't know. I have a feeling that perhaps the AP is misbehaving and
> setting HE operation to 80 MHz as well (which is invalid if EHT

So what's the expected bandwidth in HE Operation? 40 MHz or less?

> punctures it), which would explain the 'compatible' check failing (HE
> and EHT need to be compatible, of course.)
> 

FYI I attached the pcapnp file, the last frame is the beacon frame in question (Note this
is not a regular air sniffer, but instead generated with WLAN RX packet dump in driver
log. So only frames from the AP can be seen)

> johannes

--------------nwDNZFyK3vgYr0lzjw5kUj88
Content-Type: application/octet-stream;
 name="disconnection-with-puncture.pcapng"
Content-Disposition: attachment; filename="disconnection-with-puncture.pcapng"
Content-Transfer-Encoding: base64

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
J6QAAEJDXgBiMi8A3QoADOcBAAAAAQEBHAIAAA==

--------------nwDNZFyK3vgYr0lzjw5kUj88--

