Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2DC784EB3
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 04:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjHWC2a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 22:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjHWC23 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 22:28:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AB0FB
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 19:28:27 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37N1M2pB021157;
        Wed, 23 Aug 2023 02:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=D4NMvvlBpSBphEdziYMcFX8py+7jy58aV7F0y9CBTWw=;
 b=SAlQVrIIX2P+qzeipF+S6Uf//uQtW6O8WSYKeRI/9nLD2giPKJE/y5KDNkQcJ/wO1L9m
 JZdCBjZieeKH36Ntyr1Yl5cP2fZhEcs2UUKCykZboMajefeZ4NQVjryqE0aGpgsEPyHa
 GVNvQvhEynj/vwmIutjFeu0ibTlsJXWscgTQU91oPxnJ2kHFr6z72lSyAO72bC96a6na
 6OktunJWgKcSjNJDlLKvUGXsLu5ZEvtlTeBkOf6tLymZep9ylF2LWSEkc2pbnlY+AUya
 DaoWRM2pQglVk4zFtuUaZvIiUtpdjChNuDImw/Tq5X/mjSuVoc9AAq6YmeqWKM0Lo+ps xA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn26sgtuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 02:28:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37N2SHA9004645
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 02:28:17 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 22 Aug
 2023 19:28:16 -0700
Message-ID: <bcf65017-0dbc-e957-f382-98c6dc406346@quicinc.com>
Date:   Wed, 23 Aug 2023 10:28:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] wifi: mac80211: fix cfg80211_bss always hold when
 assoc response fail for MLO connection
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230822100409.1242-1-quic_wgong@quicinc.com>
 <c4d2c8987f929f29da96154e0fc6c9e94882310e.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <c4d2c8987f929f29da96154e0fc6c9e94882310e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RdsGoLIhFvaNsqfjkRcpWKboCvMlulGe
X-Proofpoint-GUID: RdsGoLIhFvaNsqfjkRcpWKboCvMlulGe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_22,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=946 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230021
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/22/2023 7:16 PM, Johannes Berg wrote:
> On Tue, 2023-08-22 at 06:04 -0400, Wen Gong wrote:
>> It is 100% ratio to reproduce the issue with this change.
>> Add "mgmt->u.assoc_resp.status_code = 1" in ieee80211_rx_mgmt_assoc_resp().
> Don't think that adds any value, but I guess I can always remove it.

change the "mgmt->u.assoc_resp.status_code = 1" is only a way to 
reproduce the bss hold

issue. you can remove it when upstream this patch.😁

>
>> +		/* use the addr of assoc_data link which is set in ieee80211_mgd_assoc() */
> not sure that's so useful? but anyway
>
> The reason I'm even writing this message is that you didn't think this
> change through:
Yes, you can remove the comment when upstream this patch.
>> -		const u8 *addr;
>> +		u8 addr[ETH_ALEN] __aligned(2);
> That has some other consequences you need to adapt to, in particular
>
>                  /* need to have local link addresses for MLO connections */
>
>                  WARN_ON(cr.ap_mld_addr && !cr.links[link_id].addr);
>
> makes no sense anymore. Not sure if that's the only one.

After this patch, the cr.links[link_id].addr will be a valid local link 
address from

struct cfg80211_rx_assoc_resp, so I think it is not needed remove now.


Another is here in __cfg80211_connect_result():

         for_each_valid_link(cr, link) {
             if (WARN_ON(!cr->links[link].addr))
                 goto out;

>
>
> johannes
