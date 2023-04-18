Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65F26E5D89
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjDRJhn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjDRJhi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:37:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5ACB1713
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:37:37 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I9KVSj010503;
        Tue, 18 Apr 2023 09:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JGoZyb3Bl2kzdFe8/kjBkjoXn1iM36EmmSgf6udDhDY=;
 b=m8gH74oz8Jb5Kmqw2hU86SdVlMYYu8n4kIc3B/LPU3QotIJ9h4NSlY3p43R+opLi367h
 k2Fcc9pmbRbBbyhK87eClGYDhy2+qDuUlJd2819DunM/xLeCyKevvdW9bZc7j1W8qSgW
 0viExvn3CpRrETEDSx9OVcQG1/3+1FfGPTWmn6h8K1BZldWOVTKudXArsqmr+OHWXwHE
 rm2BYgio/KVzQv8SFmjcLUBCBXIlTdFXHm9W3E+uEJG/z1G8kyau08wP/rZ4W4Bb/5SR
 oe6optdtHRJRjfvXMRr2SdanGN7LGEJYQS6sGgFAAY2imb2Q8nkpwJVQy77mI91CJKgx yw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q12utayd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:37:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33I9bW9X003875
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:37:32 GMT
Received: from [10.253.75.31] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 18 Apr
 2023 02:37:31 -0700
Message-ID: <13980456-11a6-384c-7be2-63c005410267@quicinc.com>
Date:   Tue, 18 Apr 2023 17:37:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
 <c05780bc-864c-9323-499d-a8b1ba1c2ef2@quicinc.com>
 <545227cf18baac94ea8aa24dc08b250c47949541.camel@sipsolutions.net>
 <c7fd18fa-531f-a90d-a8fb-442a5aa66d7d@quicinc.com>
 <d1fda46a-2481-8e05-e0a5-9f2bd3850ff4@quicinc.com>
 <868131d13ed7c4c8b5d4938adcd71cf1ff8e9677.camel@sipsolutions.net>
 <5765e3c5-46d4-e92b-a93b-4a2649acff2a@quicinc.com>
 <37958ca93039114b98909d730ff57dd1d10bb68d.camel@sipsolutions.net>
 <b9c6d022-12c3-a696-c4b9-cb14a6d30a45@quicinc.com>
 <91577d586475d290e08dee9e535cb6b4896e06d4.camel@sipsolutions.net>
 <edfc26b5-f6d1-2ab7-f3cc-60a74c8c334d@quicinc.com>
 <61268d31f8a6dd4eea10fcb6048d39244bc584e2.camel@sipsolutions.net>
 <870ce439-85b1-f02c-70e5-2d424fd73372@quicinc.com>
 <34ed0938b69ead648da1aa250a2e081054fb49d4.camel@sipsolutions.net>
 <34212873-0b71-7f39-b064-6b50d8e514b4@quicinc.com>
 <09b156b1ef05377ca7fa0db35e8e13beb5c60e2c.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <09b156b1ef05377ca7fa0db35e8e13beb5c60e2c.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Cvxu9Q3TRFSYcn9yB3ViUWm7cw47ADof
X-Proofpoint-ORIG-GUID: Cvxu9Q3TRFSYcn9yB3ViUWm7cw47ADof
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_05,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxlogscore=587 lowpriorityscore=0 adultscore=0
 phishscore=0 mlxscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180083
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/18/2023 5:31 PM, Johannes Berg wrote:
> On Tue, 2023-04-18 at 17:22 +0800, Wen Gong wrote:
>> It should work, I will test it later.
>>
>> For the 1st assoc link, the data->u.mgd.assoc_data is empty in
>> ieee80211_mgd_setup_link(),
> Yeah for the first link it should work.
>
>> because ieee80211_mgd_setup_link() is called from nl80211_authenticate()
>> for the 1st assoc link.
>>
>> So ieee80211_mgd_setup_link() use eth_random_addr() for the 1st assoc link.
> Right.
>
>> For the 2nd link, ieee80211_mgd_setup_link() is called from
>> nl80211_associate()
> I don't think so, it should only be called from
> ieee80211_assoc_success()?
Yes, I checked again, you are right. It is not from nl80211_associate().
>> the sdata->u.mgd.assoc_data is NOT empty,
>>
>> and the sdata->u.mgd.assoc_data->link[link_id].addr is valid,
>>
>> it is addr by eth_random_addr(assoc_data->link[i].addr) in
>> ieee80211_mgd_assoc().
>>
> Exactly, so we've already decided on the address long before we actually
> add the link data structure, so your callback would be much too late.
> We'd need to have it called from ieee80211_mgd_assoc() already?

For the 2nd link, is it OK for me to use the random addr which is set in 
ieee80211_mgd_assoc().

I only need to set the 1st assoc link in low driver.

> johannes
