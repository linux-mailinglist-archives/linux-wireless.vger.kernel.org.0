Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82DD7A55D0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 00:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjIRWaH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 18:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjIRWaH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 18:30:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8936CAC
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 15:30:01 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IMDtOl030098;
        Mon, 18 Sep 2023 22:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UjgpIAT368TUH5pVXyUzJsbbnlBYwkn9yQc8ImD6CJc=;
 b=oz4cJ+e/9hQoVTJBB/pMM1ccVlMH8LeTmcviMgsLhJFMsHG39SNv3sSlTsu1qpGI2Oiz
 0ZQQ2GD60fPVDetlvrDsVVO57EWvPXpttB+JkgnQJ92+bCzHbIe2pkisbdd9IQwzN+k3
 BWfzjyZzjqZim8Q5qwkr5nCHTrk2kR53q+AF8+0WS5ARz3Tm809Qtsq6z/KpbLR+0MFz
 7l+sfjaQtqGXDZDMJHgaihmSRKFHA1klgUBNc/sXcYzp/xbF9xHZU+bxnAJSz2EIZCcR
 oiQuOy2fskVSxlhhe42zJ/g0QzoePhONDzSrYwPLa5HRcNA+KC+KTSLqk8Z2XOQ/b/f1 Zw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t53ybc4yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 22:29:58 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38IMTvFx010985
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 22:29:57 GMT
Received: from [10.227.89.240] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 18 Sep
 2023 15:29:56 -0700
Message-ID: <53c81779-d423-c266-c8bd-f9583538c2e5@quicinc.com>
Date:   Mon, 18 Sep 2023 15:29:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] Additional processing in beacon updates (v8)
To:     Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        <linux-wireless@vger.kernel.org>
References: <20230727174100.11721-1-quic_alokad@quicinc.com>
 <46340c48-285e-4e2a-b6e9-802f922f0c2c@quicinc.com>
 <759fb125-7bfc-7d85-5c71-0a134030a9b9@quicinc.com>
 <6e680b33-55f5-2c49-3458-6baa4d8cff52@quicinc.com>
 <1912863dcd17aa50b09d1ddfc889478eb323f901.camel@sipsolutions.net>
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <1912863dcd17aa50b09d1ddfc889478eb323f901.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: km6MAvCe3d5K-sfDn0TbLu0qALSDeri0
X-Proofpoint-ORIG-GUID: km6MAvCe3d5K-sfDn0TbLu0qALSDeri0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=924
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/13/2023 3:26 AM, Johannes Berg wrote:
> Hi Aloka,
> 
> I've applied the series since I was rebasing it on the current tree with
> the locking changes and while that wasn't hard, I didn't want to
> needlessly double the work and have you do it for a resend as well.
> 
> I've made some small tweaks and fixes, so please take a look at it, I
> hope I didn't mess anything up.
> 

Thanks!

> Also, I'd like you to send a follow-up patch that updates the
> documentation: now that we pass the whole settings to change_beacon(), I
> think we need to document - perhaps as part of the kernel-doc for struct
> cfg80211_ap_settings - which of the parameters are actually changing
> there. Right now given your patches, it's clear that only beacon,
> unsol_bcast_probe_resp and fils_discovery are (currently) allowed to
> change.
> 
> 
> Alternatively, maybe we should indeed change the prototype again and
> introduce a new struct cfg80211_ap_update that contains only the
> parameters that change?
> 
> That feels a bit harder, but really it isn't by that much - in mac80211
> ieee80211_set_fils_discovery() etc. already take the sub-parameters
> (&params->fils_discovery), so not a problem there, and in nl80211 we
> could as well pass struct cfg80211_fils_discovery directly to
> nl80211_parse_fils_discovery() rather than the entire struct
> cfg80211_ap_settings, which wouldn't be a massive change.
> 
> 
> I think maybe I even prefer the latter if I'm looking at it now, but I'm
> not sure I'm not missing something from earlier discussions on this.
> 
> What do you think?
> 
> johannes

The second option will take couple of weeks due to current work load. 
How about I do the first option, kernel-doc, until then?

Thanks.

