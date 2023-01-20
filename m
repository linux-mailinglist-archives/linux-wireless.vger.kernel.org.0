Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5093F67482B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jan 2023 01:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjATAmk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 19:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjATAmi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 19:42:38 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20BB4A230
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 16:42:37 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30K0Nf9F022939;
        Fri, 20 Jan 2023 00:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dcmEx5oOmofBfvPm6M4zS+VuS9JPhpJdaHVdoi4Uxnc=;
 b=a0dtsf4o4iMt74LcIx7Qem4ry+RrfQwGi9tjEjuyrQj0SSkjcWwXcTdjLqIy1PP98+zU
 +2lc32DRh14hhMJ5D/ZQX0b8gHDwlhXcuNFhUxbWDk0higvjGMe/tffMDjrnilnpDzMx
 W0/XVlkl2hCq/Pe7dFIr47HQPgwduiJaP91KcIVt+U5Krm+/CAVr0JnrdB9C+84sSkpQ
 wTg9g+a+jTL9vH42BNpESy3giIhW6X9KoulUQaf7FVeU8NAF8ZUVWZLxnaNkv0TUQ7Xh
 X7AgGHatCTUQ20BPGvrEVis6DwS43EoLWKU+bZkwaTWFGCCEsrZG8ywdp96qS9k8enQo 3A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6xktjpsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 00:42:34 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30K0gXBX003177
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 00:42:33 GMT
Received: from [10.110.52.22] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 16:42:32 -0800
Message-ID: <0b77bad5-f55c-73d5-7cd0-dfed57871f25@quicinc.com>
Date:   Thu, 19 Jan 2023 16:42:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC 3/4] wifi: nl80211: validate RU puncturing bitmap
To:     Johannes Berg <johannes@sipsolutions.net>,
        Muna Sinada <quic_msinada@quicinc.com>
CC:     <linux-wireless@vger.kernel.org>
References: <1670006154-6092-1-git-send-email-quic_msinada@quicinc.com>
 <1670006154-6092-4-git-send-email-quic_msinada@quicinc.com>
 <3df39d4f2e2e64bd3899cfbe7bade547e54330f7.camel@sipsolutions.net>
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <3df39d4f2e2e64bd3899cfbe7bade547e54330f7.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: X6r2sZvvrAoSD9UlABJTRli3NKyhXv89
X-Proofpoint-GUID: X6r2sZvvrAoSD9UlABJTRli3NKyhXv89
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_16,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1015 spamscore=0 mlxlogscore=314 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200002
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/19/2023 7:37 AM, Johannes Berg wrote:
> Frankly I'm not happy for this to be stuck into set_interface() like
> that - can we add it to set_channel() only or something? At least there
> should be too? And read it only if the channel is actually touched? This
> feels very ad-hoc.
> 
> johannes

Hi Johannes,

I will work on these comments.

Secondly, this RFC uses ieee80211_valid_disable_subchannel_bitmap() 
defined in following RFC you sent:
https://patchwork.kernel.org/project/linux-wireless/patch/20220325140859.e48bf244f157.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid/

Is there is any plan for the next version?
If not, I can move the validation function defined in cfg80211 to 
mac80211 from the following patch-set:
https://patchwork.kernel.org/project/linux-wireless/patch/20220214223051.3610-3-quic_alokad@quicinc.com/

You had asked me about exporting this during the review as well.

Please let me know so that I can incorporate accordingly.
Thanks.
