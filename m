Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395D36977C3
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Feb 2023 09:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjBOIEw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Feb 2023 03:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjBOIEq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Feb 2023 03:04:46 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2823234C10
        for <linux-wireless@vger.kernel.org>; Wed, 15 Feb 2023 00:04:45 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F3NEIG001092;
        Wed, 15 Feb 2023 08:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dLz/ICb878vnaf5vikMXiiEq38nlRo75UIkcNcafyAQ=;
 b=KnqHmBnXIfwdN5LHNk8GGDey64dx+/SJPa4W4WWsMJd6mBKDT1L+XeeghknVAQlszV+Z
 w/oJASKTFu0yfqmK7Op3p1FXktYbRaS4fShC5VljbjE0bOTySMdHmyvdSyKc0ciuWsXU
 tMPSR0zPpPf3QeVnqe5YGWMdWzzWyYaGA9+v7w3Y4hQervbYZU1IYDi6KJZJb+5ZUiwQ
 A4rTR6r9ivZ+8WS1GRimbjh+tC5L7QEvsILgm8Ksfje/Xb7zX9gnG3JhnRrCE+cmncbx
 dRTfalkHE1EOyECtSzAN2O7qjYjFS5dwzYKtDyVLsDXpcD3I2j+32sHZ4iR8JEas8ib4 aQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nr26u3u1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 08:04:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31F84amQ007977
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 08:04:36 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 15 Feb
 2023 00:04:35 -0800
Message-ID: <30e87756-ddfc-4581-4ff9-98b2068a3808@quicinc.com>
Date:   Wed, 15 Feb 2023 16:04:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3] wifi: cfg80211: call reg_notifier for self managed
 wiphy from driver hint
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230201070327.27578-1-quic_wgong@quicinc.com>
 <bcaf5a88-76f3-c4ed-0fca-2c131d392f82@quicinc.com>
 <4ab31b2407d9b2d930a2637730c4f3c0b2555c6a.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <4ab31b2407d9b2d930a2637730c4f3c0b2555c6a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: soi53ihFx03LLmCu7xw1IDVtbyx97xev
X-Proofpoint-ORIG-GUID: soi53ihFx03LLmCu7xw1IDVtbyx97xev
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_03,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 spamscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=717 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150073
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/15/2023 3:31 PM, Johannes Berg wrote:
> Hi Wen,
>
>> I see you have merged v2 to wireless-next.git and this v3's state is reject.
> Yeah. Actually, I saw v3 only after I merged v2, but then I saw what the
> change was and figured that was unnecessary anyway.
>
>> So do you mean we should not keep hole BIT 24 in enum wiphy_flags from
>> now as well as hole 11/12 in commit 8e8b41f9d8c8/ca986ad9bcd3?
> Indeed. The point of the comment saying "use" was to actually, well,
> _use_ the hole next time. I haven't really enforced that since I keep
> forgetting (and we're nowhere near running out of bits), but yes, the
> point is that you could even have used bit 11 or 12.
>
>> If that, then backport this patch will be more complex, because the
>> backport kernel already have
>> WIPHY_FLAG_HAS_STATIC_WEP= BIT(24), then firstly the backport kernel
>> need backport other
>> patch(585b6e1304dc ("wifi: cfg80211: remove support for static WEP"))
>> which is not really needed.
> I guess it could use another bit number (such as 11) in a backport, but
> I don't see that this really _needs_ to be backported? And if you're
> using backports to backport the whole wifi stack then this isn't even a
> question since it all comes in backports.

If use another bit such as 11 while backport this patch, then it will 
easily lead mismatch/error

and increase difficulty of maintain code.

I need backport this patch soon.

> johannes
