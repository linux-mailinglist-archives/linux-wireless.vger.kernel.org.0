Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137D06E5CB3
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjDRI76 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 04:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjDRI7z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 04:59:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F68C40D5
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 01:59:54 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I77YjV030047;
        Tue, 18 Apr 2023 08:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=px8uqX1hsREvgok+XbCORC/WqEIB+kE1m4evsiay0jw=;
 b=lppweXUao5fXIJ4tid//UmwKlNGKXOTQcJfOfDOfmZWIu6pRZF+9+RQSgM7H7gfQbG0L
 7OuI7LwY0V0gf1k7++vopxUP9scz450sp3Wl9IH4x53Y+2VBB0OcgGbqYNHxVApZBHRj
 rv6wbtSORX9YN/adDBmlGe3NOCzbVcPn5DEOpj+Yq1rNlGNXZb0pRvUwGDH5mIBW/l4v
 HgoDcF0fSTzlAUbEIxIc7fdbU34ZtssAZ+z0iwTXiKl60BVKoFMh2RNGkTrI+78f01W/
 hhtYyFeN1kh/K1H6XA1XMJW883f+Y3ocvWyh7bScJti1Brzxq1Bit683K33+jjSQ5N2b 6A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q12utavqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 08:59:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33I8xltT018764
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 08:59:47 GMT
Received: from [10.253.75.31] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 18 Apr
 2023 01:59:46 -0700
Message-ID: <870ce439-85b1-f02c-70e5-2d424fd73372@quicinc.com>
Date:   Tue, 18 Apr 2023 16:59:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
 <5d82e564-86bf-c26b-077a-d0bc14e2d3c3@quicinc.com>
 <74f3eb848326607b15336c31a02bdd861ccafb47.camel@sipsolutions.net>
 <2de44394-cb93-7be4-481f-2d92788b8d28@quicinc.com>
 <351f74e0e1cd6e9724f97dbd042bdc5e04c44842.camel@sipsolutions.net>
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
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <61268d31f8a6dd4eea10fcb6048d39244bc584e2.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AUXXCHMwN7v32UVlvrCFyhmVeO_neD6k
X-Proofpoint-ORIG-GUID: AUXXCHMwN7v32UVlvrCFyhmVeO_neD6k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_05,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxlogscore=740 lowpriorityscore=0 adultscore=0
 phishscore=0 mlxscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180077
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/18/2023 4:15 PM, Johannes Berg wrote:
> On Mon, 2023-04-17 at 22:07 +0800, Wen Gong wrote:
>> OK. So I will try to put this in mac80211 layer, is it OK?
>>
> I guess? I'm still not really sure why you even want it, but hey, that's
> up to you in a way. I really didn't like the suggestion with
> wiphy_iftype_ext_capab (or any other capability for that matter), it
> feels like it should be more dynamic, like maybe a new "add link"
> callback or something? At least then you can't blame mac80211 for when
> it breaks when you have two 5 GHz links ...

ok, so I would like to add callback such as

"add_link(struct ieee80211_hw *hw, struct ieee80211_vif vif, struct 
ieee80211_bss_conf *link_conf, unsigned int link_id)"

in struct ieee80211_ops, and mac80211 call it in 
ieee80211_mgd_setup_link()/ieee80211_vif_update_links,

then lower-drvier could dynamic set the local addr of assoc 
link_conf(also for 2nd link_conf), is it OK?

>
> johannes
