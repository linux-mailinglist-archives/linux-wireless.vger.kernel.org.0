Return-Path: <linux-wireless+bounces-25355-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB74B03905
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 10:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71922189D5EE
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 08:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A33023C4E3;
	Mon, 14 Jul 2025 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZFdWwfwr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15D5239E82
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 08:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481009; cv=none; b=rNi6xPiNP4yFeu/0Avgrqe3p2Px0qmAjuEr3oVhok+2emBBqoqaQiawWKTkHY1saHw5uQPWcHENO8uncaV8nfp2ywTbweHylWHkTW28/VxwHMI5w30CfoLUWI1CHv8SOW2xmWIP20RyfrQnfXutVieukfxVexZb4WUX8SjftfN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481009; c=relaxed/simple;
	bh=2bzl+U5a4xnOTSTMm9NmX5loSNBN0Pnks6+xExVwShw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=MM0BVea1e2JM3+jqijyBsFNVAyCpLVR3MTs+soYixTr1xuol/xNMK6wrXD0YCkh+HylmxtHKhsMMat6WSSg84LGtOqaL68wKZIdlfTQzAqzIbF9IQCQAcKyaWMy+XEXPkJxiDIlbt97kh/IQwBVRsuvf2GE8/Ljc2Hs3bDlHOBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZFdWwfwr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DL03Ri012224
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 08:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9lG70Zv4bkzP0assEuJjlG
	H/iFaBGlX2QEBmpkORB/U=; b=ZFdWwfwrzPVp9ubYNeogpm7xOcmtzau16sAVCy
	ikyTGxqzE5h1GA5BPaAALVOvFN7jNc4dVFhG73aBO1oZnwjay5mTB47rs8gyghK1
	RYW8eJc6CA7ADKeeKOQKh7Ck8gpY/1AEGxZWIHlsv/pCNRb3vDHToCp4YWFxNS+d
	64KjOQecTDL7Iclt/9YOO6dlIMgn+JMttRpVGAGKwar7e6IVAHO4EPSpt7jwSmzC
	TJWsKD28c6eSwwLS+FrI5DZcyquK1+te505ktu1qtLTZKSRTOT7AWXdYGfh5Huc8
	5UbLKxsVTI+xEiwWwUZjweMK6DikJL1XbKELC29DaRcb6WZw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ugfhbu01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 08:16:46 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2369dd58602so39135665ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 01:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752481006; x=1753085806;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9lG70Zv4bkzP0assEuJjlGH/iFaBGlX2QEBmpkORB/U=;
        b=L+Lpy8T2u7kY3nReGYHWu5Pr7FoXtWUr3NSKU0jj7gHojPG7GsZQ+SQFmy6lOyLqkR
         I9tADC59CQ4uNk8Tu9eKVzko6jWtxAGR9Zt1fiHwskfGW5dLp+PLyzjFkWAO0zSkdIH0
         1YVRrr4TxUUaczgxJXOkNlEH+Q5DoPMyq9+g6Kmx9TZHNfl35tFa+mvl0JN6v2w2iMQe
         veXUdf+Xndxg52gP5HFi62zFZWRclma0ZV40G+4Ey/dnPF1vKfDkOk0nmADOxni18Qss
         Q9gB9p1xjzDvbPnkWc1pkygZ11zquRFOLgmCCl9+tQ+PsIm0jCNXPnZUBNnC6e6Rh5Xq
         8Jdw==
X-Gm-Message-State: AOJu0Ywpct8msrWsIXbQjv7svq9Xo9SVGmTjvpmhRfjIZlxgfQ1lB4l8
	TClqeZo82Nw1EoFBoh+F5NyyUAtuHHtq588Lrltj1krjx01ma+IkgYS6zUduf+8q0TsIzZtC1zi
	Qq01Z7XMaBowkgohjuX+SA9uozsNKUEk86vDQFMOPpWlLsv6CarYB8ASPV+V4HjqvkD0Zzfdijn
	uM6w==
X-Gm-Gg: ASbGncvU5u13AbsmdfXbcXlTUdz5BLM0fCNQyEaABebCQpKvN0sHSOzhXdluIaWHtYw
	a76b5t8ItbJEY9lZn0I55dtXymF66OhZGAYmDW/1hkzfamg3Tgf420/9QxhJe7CqHOJdhEf7s+V
	+AwSAu1cApAJUoTZllIZqn3ilZCd3EIRu20ifs42ymiLJvYDiASveaRk1hkrpODdzd8qvwZufqw
	ONzpEQP2tff4Kxg9XpokpqtARy8HWYtewFfhF8J4Ipt9bOCfHYLfV4TnrLXqkMqLr7c3wjJmgGZ
	o4CF0ZbR/IPV0AZA9uFjq17qPTjaN155CS1ENcnMxPz/4SLa0Y3tBR40vgucW9aiNVMQKcRxddL
	aNZ+hCv3J0hgE6MZCS0cx1vgOrNGRiQwX
X-Received: by 2002:a17:902:cccb:b0:234:ef42:5d65 with SMTP id d9443c01a7336-23dee3a6cd5mr170343865ad.52.1752481005635;
        Mon, 14 Jul 2025 01:16:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF3QjOFHsJQftslJ1aVj+dR6xHYDlsdPVSdPohZb6e7ScidSUihj88RSYciui3oBDSC+Bbgg==
X-Received: by 2002:a17:902:cccb:b0:234:ef42:5d65 with SMTP id d9443c01a7336-23dee3a6cd5mr170343445ad.52.1752481005052;
        Mon, 14 Jul 2025 01:16:45 -0700 (PDT)
Received: from [10.133.33.219] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322b2dsm89475715ad.92.2025.07.14.01.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 01:16:44 -0700 (PDT)
Message-ID: <e80d5786-b1c1-46f5-b723-e6197e2d06e9@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 16:16:43 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: Disconnection triggered by Puncture advertisement
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0o4TbIPxci_iYD2zdo3ifg__H-RkLYxT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA0OCBTYWx0ZWRfXwMBbeJEGNDUL
 v7Sr2IuEruiZJPe/x0RQf1ciYkys4ta6Vo6b4se59/V9aZJQMi9tEqO67UYrFLOSsbpxafGxxbC
 82il/9KEYO1eyY2CTeMJNXH64yGhWxhjIh5ertcOn+8TDpwHxD2rfUdmLsPcnTvM99eiKVFCkxU
 B5WAvLY2fw8wn1WbLI3l4PrJuqXSKB60V/FizVSGTPZJ2aYNNPSK7YLyAkSUWsekMcTvF4ktsGh
 G9PoPxsle2eHgfAod9R+oXJ7ooKszAxOoKe75joaSWXBdp0zS+aYvgnmBzLfusoLFc9CvTh6HFH
 0S3Iv24+0AYdZ4xUJN289/8JpYflWytv9BpPuDhv0dSxd7nYFltJd4K9CrmCT+eQTl36Sok8b9k
 ohgYNOVVqMun53G1IOEMQT3cw+elQIjp1oE3nThMi4xzjTYG2tw1NTzD6eVBQVq8K+ffGl1G
X-Proofpoint-GUID: 0o4TbIPxci_iYD2zdo3ifg__H-RkLYxT
X-Authority-Analysis: v=2.4 cv=HYkUTjE8 c=1 sm=1 tr=0 ts=6874bcee cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=WCmjr0ptvIdc0iB-jngA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140048

Hi,

Recently I hit an IoT issue while connecting to an TP-LINK AP. As a station, the
connection with the AP initially succeeded, as indicated by the authentication and
association logs:

[  528.655093] wlan0: authenticate with 16:d8:64:56:ab:5b (local address=66:81:93:de:79:d8)
[  528.655112] wlan0: send auth to 16:d8:64:56:ab:5b (try 1/3)
[  528.720573] wlan0: authenticate with 16:d8:64:56:ab:5b (local address=66:81:93:de:79:d8)
[  528.720584] wlan0: send auth to 16:d8:64:56:ab:5b (try 1/3)
[  528.790413] wlan0: authenticated
[  528.794115] wlan0: associate with 16:d8:64:56:ab:5b (try 1/3)
[  528.831371] wlan0: RX AssocResp from 16:d8:64:56:ab:5b (capab=0x1911 status=0 aid=1024)
[  528.858116] wlan0: [link 0] local address 9e:c1:c3:67:13:db, AP link address
14:d8:64:4c:ab:5b
[  528.858201] wlan0: [link 1] local address 66:81:93:de:79:d8, AP link address
14:d8:64:4c:ab:5c (assoc)
[  528.911598] wlan0: associated
[  528.978910] wlan0: Limiting TX power to 35 (35 - 0) dBm as advertised by 14:d8:64:4c:ab:5c

However, the connection was later disrupted:

[  533.845338] wlan0: AP EHT information doesn't match HT/VHT/HE, disabling EHT
[  533.845344] wlan0: [link 1] AP 14:d8:64:4c:ab:5c appears to change mode (expected EHT,
found HE) in beacon, disconnect

with some logs added:

---
+static void cfg80211_dump_chan_def(const struct cfg80211_chan_def *def)
+{
+       struct ieee80211_channel *chan = def->chan;
+       pr_info("chan: [band %u center_freq %u freq_offset %u hw_value %u flags %u
max_antenna_gain %u max_power %u max_reg_power %u beacon_found %u orig_flags %u] width %u
center_freq1 %u center_freq2 %u freq1_offset %u punctured %u\n",
+               chan->band, chan->center_freq, chan->freq_offset, chan->hw_value,
chan->flags, chan->max_antenna_gain, chan->max_power, chan->max_reg_power,
chan->beacon_found, chan->orig_flags,
+               def->width, def->center_freq1, def->center_freq2, def->freq1_offset,
def->punctured);
+}
+
 static const struct cfg80211_chan_def *
 _cfg80211_chandef_compatible(const struct cfg80211_chan_def *c1,
                             const struct cfg80211_chan_def *c2)
 {
        const struct cfg80211_chan_def *ret;

+       cfg80211_dump_chan_def(c1);
+       cfg80211_dump_chan_def(c2);
+
        /* If they are identical, return */
---

The disconnection is caused by different 'punctured':

[  533.845311] chan: [band 1 center_freq 5180 freq_offset 0 hw_value 36 flags 524320
max_antenna_gain 6 max_power 24 max_reg_power 24 beacon_found 1 orig_flags 0] width 3
center_freq1 5210 center_freq2 0 freq1_offset 0 punctured 0
[  533.845322] chan: [band 1 center_freq 5180 freq_offset 0 hw_value 36 flags 524320
max_antenna_gain 6 max_power 24 max_reg_power 24 beacon_found 1 orig_flags 0] width 3
center_freq1 5210 center_freq2 0 freq1_offset 0 punctured 8

This 'punctured' is suddenly (I mean even 'EHT Operation' was not seen in previous
beacons) advertised in EHT Operation element contained in AP's beacon:

Ext Tag: EHT Operation (802.11be D3.0)
    Ext Tag length: 10 (Tag len: 11)
    Ext Tag Number: EHT Operation (802.11be D3.0) (106)
    EHT Operation Parameters: 0x03, EHT Operation Information Present, Disabled Subchannel
Bitmap Present
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

Which fails the check in _cfg80211_chandef_compatible(), because the chandef's are not
identical but have the same width.

Is this AP misbehaving? or is cfg80211/mac80211 not doing correctly?

I am not very familiar with Puncturing, want to hear professional opinions from your guys.

Thanks
Baochen


