Return-Path: <linux-wireless+bounces-23035-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E1AAB8E75
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 20:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86B3460DB6
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 18:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B0B25A633;
	Thu, 15 May 2025 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jFC/KlBy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E971EA7F9
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332323; cv=none; b=SxfKUZzKNLGea5PGdrafphx8JiDW0t69zWMlGBBrppuU+A4BmLdAKGTyFfN5qijAQ3MW46YepfRsP94XqBkG+7APXYUs/HzvQF71r5kniY5aCRATD4XcxiVOO29qg6YkQqVG9WKVbBAjp6DMttC42DLjE0UdiDs+nUXpiZsjfi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332323; c=relaxed/simple;
	bh=ROFLMNaRFR9x/wyzv/emjASjuPB47MFbP09DEuBS5HM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ks4pwqqHSor+iIKp2qrdfa/ECSHac27wvwJNPtkAh28yNnoECTUG0KOkzC7+sp+HzjD6do1L3u7BJ2W6s5s+v5veIsF5OAf6cWbwXRHS2WsBZSsyOMBLNjAuiEKrbeGtBl9czxO1Ts/iW8ZEduLiUQYkdpC+YuCNbiA5WzNZE7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jFC/KlBy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEFT9A025111
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 18:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YGTbjpAygM2J0KwEeWYgPo4Eet0TyJJhore/XR7KdgQ=; b=jFC/KlByBPlkzI/O
	uZtXIqLuoFLxOn8kTxiAnIlkEUIWCyQN6RLfEk0+tVM/e5KqqIHeRiMZa8KcV9Wy
	6DFybNa1siSyQvLrDhEH30CvkLmUuqfwU6HK/iObosFt2JnQsj9C+aHobOLsq5pe
	AQ0zvQJ4RupCTnoeiaA7I34JeA4OC9gG6RTy1Zb/ym2oi8EC8sd1P+1ii27XmZmb
	UfvlGvNObzJAgz3hV+W76SoezAbLjL7HBu3174XlZYxXI+/P/ob0J0bSvcQoDBGq
	XkwpzgjPKHQM2NmU/zjSzqm1qS1JKqRkqf7uW+SXqnh4e3ljYSSOoPsbemM+Zw+V
	uiX+CQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcmyc2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 18:05:21 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b269789425bso1244164a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 11:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747332320; x=1747937120;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGTbjpAygM2J0KwEeWYgPo4Eet0TyJJhore/XR7KdgQ=;
        b=ss2TmHgUIsbERBKgjPVXUuesMJgb2ZnpvBGh4p8MJEUOk2W6uujVbSF3ONzC8mEUr+
         eJxjQj8M6x+QyPe4QE6jt09tupNHV5P7F42KNrAiBKAgOAF7F51k9VNT2vXZqXIh0mJa
         /7tkuGh0a45TBYRmTR2gyt88tF2OG/tZsQDHcEjJHbQCWjB/dWnl8ZmYYMoiYt9GPSc2
         Res+PaAWl2cU968KD/SDpt1ArQIFXtHmnhzAyEZpOkpXSvowp/p9xe4A9P2ia9tT64c5
         2btW9V2gZI7Uoy9EVAgYG8T59wmd/Gl1lf8YjaUvB606vHhrv+UhyiMbC8xWd0DghonQ
         jTjw==
X-Gm-Message-State: AOJu0YyFYFqwxFF9sRBgCxBh9SLzvlqx0IHSX+AOHzQe3eLfyTFsHJZS
	+qcwESqRaHbYyHkMiNfvXlYZ1jvRUK515rDi+tT9D0CWwb/N4Zx7BtK0aPyLpOlHlAU5dWpPaMB
	79eqk1xw7jWcJ82Hl2Zk+3jkV2QHDqOQcvyvHSv7p+sJIYKx3aZ6km5vOaV2t2w+uuYMhNWPpRz
	aGiw==
X-Gm-Gg: ASbGncst0rexRV0SfZA8/dEhQU68O9Me0pwidmvmpw/uDjUi4HKufDYhc7w1SPfjuXi
	De7wnZRWT1B42/BUnOoIhuDWskjGBCFn39mW5I2PkGzYhynKSceOSp1erbSB5KkFK63H3dkXItb
	7t43iGYNPZYPWfv8R4h3VR3JYeUzkqVah3fIyNIhH7ORcP2yf+8OD/X3Qa899AHxUPx/jR9REWC
	S4OYNDnlnVprfdKTnFs6nV1dloSmAGhTDF49++MNG/HCxLwtcZPTb/0a/Fjz7vq/YpIhv5kxORx
	352iksPr8f9Q9Z3FLfUQWy6SleB6IiWLEinhET7SSPa2HF2hzBQ=
X-Received: by 2002:a17:90b:2d4c:b0:301:1c11:aa74 with SMTP id 98e67ed59e1d1-30e7d5a84a3mr435247a91.28.1747332319773;
        Thu, 15 May 2025 11:05:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh4TYq3jsoeNL50CmSxPGpRbpni09FC9zVNSR1KqfJ/OUNHnXz0I9U6uNc4wtsY+Glw2D+AA==
X-Received: by 2002:a17:90b:2d4c:b0:301:1c11:aa74 with SMTP id 98e67ed59e1d1-30e7d5a84a3mr435185a91.28.1747332319210;
        Thu, 15 May 2025 11:05:19 -0700 (PDT)
Received: from [192.168.29.88] ([49.37.212.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e7b4dda42sm198205a91.35.2025.05.15.11.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 11:05:18 -0700 (PDT)
Message-ID: <535df7b7-def9-4aac-8118-04e2fd0239d9@oss.qualcomm.com>
Date: Thu, 15 May 2025 23:35:15 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 1/2] wifi: mac80211: validate SCAN_FLAG_AP
 in scan request during MLO
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250513-bug_fix_mlo_scan-v1-0-94235bb42fbe@oss.qualcomm.com>
 <20250513-bug_fix_mlo_scan-v1-1-94235bb42fbe@oss.qualcomm.com>
 <16499ad8e4b060ee04c8a8b3615fe8952aa7b07b.camel@sipsolutions.net>
 <26a9e68d-bce6-4bba-871d-13e2aeee3fed@oss.qualcomm.com>
 <296b9aa887022258f8ec8e4f352822c24b41ab82.camel@sipsolutions.net>
 <77fe950d-c5af-4c28-8b0b-bd1aa08d885a@oss.qualcomm.com>
 <d211e634532031322a77053ff912394714b5ff35.camel@sipsolutions.net>
 <772514cb-298a-40b0-9a33-a7dfcf037bd1@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <772514cb-298a-40b0-9a33-a7dfcf037bd1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YexLwqX9wPchhgvvwozSacAKOZ85Rpzq
X-Authority-Analysis: v=2.4 cv=HZ4UTjE8 c=1 sm=1 tr=0 ts=68262ce1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=XZDIsMRYGlSp8tquX/g+9Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=YmykfdemIhMYyei05fwA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: YexLwqX9wPchhgvvwozSacAKOZ85Rpzq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE3OCBTYWx0ZWRfX1xgT6jXwJUBq
 A4GFsPjcBss16EiVSIm3NYdwMuMLFFOmYcOQMPFCS4ITVMj/8PbIAqXJXbOlLI4Hh2dv2kYwA2P
 ntg8v2kn7nkfhNLfpxlMPnJGs4kMt/bRg3sMTKo84rxQ4Ua7SDJtg1435tvX7P4iqDnzCMnWzcs
 dbOA1lpzq/+Uq2GojCVY/W7WaC0JwmsE//YP/Q6rrVwO52l++oJLE1xCPtem1MSZ6Xt39gmaKsB
 iBhP2Fvt76MqcYruBtRRgm0QRadPdyBdrbSCwE+ZwCvUellU6Krsylb9v5Pv9K5V2yEzt5xzJl8
 zvVZhxW/Eipb6RORJ9dAeW2IYbfy1paBrk8CklyUxKEU/QoswfagGQqSRGL4uaKPpYZ9MVegKjT
 CfUgMy7USFohMtkaXvu1AFn9GiX2OItGvCsWLkjyA/Qy44YjX6KKEa1r9bWLxhnVhOumv0eO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_08,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=714 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150178

On 5/13/2025 4:26 PM, Aditya Kumar Singh wrote:
> On 5/13/2025 4:18 PM, Johannes Berg wrote:
>> On Tue, 2025-05-13 at 16:02 +0530, Aditya Kumar Singh wrote:
>>>
>>> Okay sure let me first send a clean up. So,
>>> ieee80211_num_beaconing_links() should return 1 for non-MLO as well?
>>>
>>
>> That would seem logical to me? For this and many other things non-MLO is
>> mostly equivalent to just having a single link (apart from the address
>> translation.)
> 
> Yeah in a way true only.
> 
>>
>>> And callers should test for == 1 instead of <= 1.
>>
>> Not even sure that matters enough to need to change?
> yeah can be left as it is. Sure then I will change the function alone to 
> return 1 for non-MLO case as well.
> 
> Thanks for the inputs :)
> 

Done. Here is the clean up patch for review -
Link: 
https://lore.kernel.org/all/20250515-fix_num_beaconing_links-v1-1-4a39e2704314@oss.qualcomm.com/

-- 
Aditya

