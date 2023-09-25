Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9F37AD8EA
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 15:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjIYNUH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 09:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjIYNT7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 09:19:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3744116
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 06:19:52 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PBYwV6027472;
        Mon, 25 Sep 2023 13:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sDTE0IWc/J8446XYp7pN4Oqlbu/L5tnhQ47P3NDeIjc=;
 b=eTJxVxGulSDXu1qubA6U4TD4+PDusmoyP5LaY5f6Djip4Ty/BPmKeLlQSketH9nKlXyr
 I3UpZbDM7+iHcFnNCK1fh1nOYkKG0uI1wofNt1UmeMW6RcAXnFG67oMwu87Ovlo/1Ejx
 oPbly5MHRpqY3t7Sh3KiEB0qjGZ+w4UN2M2pqbK0ZK2qaiwMd9q0Ktj11cWUUcEL1Chx
 qYZma2vU5xYPc7Ky1kWho8c9KyrVDCnB2LyrW9/e5ha2Dnmk/4NNhiyvhqblYKJAINp2
 Pg6zrx84MxCGJoPAiU+EC6WtAC6Ai61ut5OKNLu5agigMRppAcKOQ5HVwIR0t7c9eXIF Ng== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tb3hfs7wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 13:19:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38PDJkLJ011273
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 13:19:46 GMT
Received: from [10.216.1.235] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 25 Sep
 2023 06:19:44 -0700
Message-ID: <1d8e7395-61c1-4fba-9d83-8cebfb557b33@quicinc.com>
Date:   Mon, 25 Sep 2023 18:49:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] wifi: cfg80211/mac80211: add support for AP
 channel switch with MLO
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20230925115822.12131-1-quic_adisi@quicinc.com>
 <20230925115822.12131-2-quic_adisi@quicinc.com>
 <af4a763b624363543a37140c2106fb7a05800977.camel@sipsolutions.net>
Content-Language: en-US
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <af4a763b624363543a37140c2106fb7a05800977.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kQNbFoPcWjvH5XCHY1OEPYV8esCC9Ed3
X-Proofpoint-ORIG-GUID: kQNbFoPcWjvH5XCHY1OEPYV8esCC9Ed3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_10,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/25/23 18:40, Johannes Berg wrote:
> On Mon, 2023-09-25 at 17:28 +0530, Aditya Kumar Singh wrote:
>> Currently, during channel switch, deflink (or link_id 0) is always
>> considered. However, with Multi-Link Operation (MLO), there is a
>> need to handle link specific data structures based on the actual
>> operational link_id during channel switch operation.
>>
>> Hence, add support for the same. Non-MLO based operations will use
>> link_id as 0 or deflink member as applicable.
> 
> Much of this commit log really applies to mac80211 - perhaps make a
> simple cfg80211 patch first only?
Okay sure, will do. Thanks for the suggestion.

> 
> 
>> +	link_data = sdata_dereference(sdata->link[link_id], sdata);
> 
> We should probably use wiphy_dereference() now?
Hmm yeah, missed this. Sure will use this instead.

> 
> Perhaps we should just get rid of sdata_dereference() entirely, after
> all, it's the same now, just the arguments are switched for no good
> reason.
Yup agreed. Are you already aware of any WIP in this regards? If not, I 
can take care for the CSA part at least in same series (in a different 
patch obviously :) )

> 
>> -	conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
>> +	conf = rcu_dereference_protected(link_conf->chanctx_conf,
>>   					 lockdep_is_held(&local->hw.wiphy->mtx));
> 
> Hm, I guess that was an artifact of the (mechanical) conversions - but
> really that should probably be wiphy_dereference() as well now?
Yeah. Let me update accordingly and validate. Thanks for your inputs.

