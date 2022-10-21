Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E3D607878
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 15:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJUNbr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 09:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiJUNbq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 09:31:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E648265510
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 06:31:44 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L91Z9t021380;
        Fri, 21 Oct 2022 13:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fPbJ4yJTywotNAl2+VbKPnLgD7XHkz8PceSLLruSo9U=;
 b=DRsIxHhYDyVzAKVBxFu363pLmzFtYWQT8HOqCsDwdod4ay9duP/kUT7XMljFtBCoNtsH
 zb5YHKc2UwLrVOMDyHwSkeoyuQ3WTT1NJMF1NUzoT/lbqnGF5Mp0eTethu3g+A89OylL
 GAY3MWGtm5jZkUqJxMN/gphLRproiQrOnbmBceL0yZE8QghOA4Khvy0cvpyx/75rgpv+
 0h2DS6JaiJRLoF/XoNJdME7qo9d8hKlJH+uzWmkozToUgdLJj6zh92qZDyPRYmmaFXew
 /KP7Npg8iE7NSF1jAXI2Pnaha2HkFVryG9eheN8aI3MwklK+/dVvELpw3NOvNqw17w8X bg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kbjcga2wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 13:31:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29LDVeNa011428
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 13:31:40 GMT
Received: from [10.216.6.194] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 21 Oct
 2022 06:31:39 -0700
Message-ID: <eefaa8d8-f84a-6f1f-1e06-adebdd949d0d@quicinc.com>
Date:   Fri, 21 Oct 2022 19:01:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC 4/4] wifi: nl80211: send iface combination to user space in
 multi-hardware wiphy
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20220920100518.19705-1-quic_vthiagar@quicinc.com>
 <20220920100518.19705-5-quic_vthiagar@quicinc.com>
 <bd8d9fe60b4ff7a420ab597b1db64b5b42616d77.camel@sipsolutions.net>
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <bd8d9fe60b4ff7a420ab597b1db64b5b42616d77.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: l7zeoExtRP8NKo6oc6d94vR6uL1RdwVg
X-Proofpoint-ORIG-GUID: l7zeoExtRP8NKo6oc6d94vR6uL1RdwVg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=818 clxscore=1015
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210081
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 10/21/2022 5:55 PM, Johannes Berg wrote:
> On Tue, 2022-09-20 at 15:35 +0530, Vasanthakumar Thiagarajan wrote:
>> A new nested nl attribute is added to the same existing NL command to
>> advertise the iface combination capability for each underlying hardware
>> when driver groups more than one physical hardware under one wiphy to
>> enable MLO among them.
> 
> That's a good point - are we assuming this implies you can do MLO across
> the groups? Maybe somebody would want to use this advertisement without
> allowing MLO? (Not sure that's useful vs. multiple wiphys though, but
> maybe to simplify driver if there are some devices w/o MLO?)

Good point. Yes, this can be used even without MLO (i.e. not quite tied 
to MLO feature). Ill update the doc accordingly. Thanks.

> 
>> +		for (l = 0; l < c->iface_hw_list->n_limits; l++) {
>> +			struct nlattr *limit;
>> +
>> +			limit = nla_nest_start(msg, l + 1);
>> +			if (!limit)
>> +				return -ENOBUFS;
>> +
>> +			if (nla_put_u16(msg, NL80211_IFACE_LIMIT_MAX,
>> +					c->iface_hw_list[i].limits[l].max))
>> +				return -ENOBUFS;
>> +
>> +			if (nla_put_u16(msg, NL80211_IFACE_LIMIT_TYPES,
>> +					c->iface_hw_list[i].limits[l].types))
>> +				return -ENOBUFS;
>> +
>> +			nla_nest_end(msg, limit);
>> +		}
>> +		nla_nest_end(msg, limits);
> 
> 
> Feels like this part is kind of pre-existing code, or should be, could
> it be refactored?
> 

let me check, thanks.

>> +		if (nla_put_u32(msg,
>> +				NL80211_IFACE_COMB_PER_HW_COMB_NUM_CHANNELS,
>> +				c->iface_hw_list[i].num_different_channels))
>> +			return -ENOBUFS;
>> +
>> +		if (nla_put_u16(msg,
>> +				NL80211_IFACE_COMB_PER_HW_COMB_MAXIMUM,
>> +				c->iface_hw_list[i].max_interfaces))
>> +			return -ENOBUFS;
>> +
>> +		nla_nest_end(msg, hw_combi);
> 
> And even this feels like it must already exist in some way? Wouldn't it
> even be easier to parse for userspace if it wasn't a separate set of
> attributes?
>

Yes, reusing existing attribute will be simpler. let me check that.

Thanks for the review!


Vasanth
