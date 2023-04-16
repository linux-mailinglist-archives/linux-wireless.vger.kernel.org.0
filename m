Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946F06E34B1
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Apr 2023 04:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDPCKd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Apr 2023 22:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDPCKc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Apr 2023 22:10:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C662C1FD7
        for <linux-wireless@vger.kernel.org>; Sat, 15 Apr 2023 19:10:30 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33G1uoXW008252;
        Sun, 16 Apr 2023 02:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yqa7h6fZ8PxqDN5oB2svtJXsEhJU62CLg9TqIAjRQjE=;
 b=BPSRy6bXmpfpouppLWKgTrIdLY4u+xAp9TQUd76KrjBQKzfgdI0ECKbu3sI0XExT6NTf
 h9u2K2sgpqtvyJKHXKemQDkJMjJ/mZ0eUW8Qxsv/tixQVUBV+gE4TSiZr3/Jk3NGNcKT
 W5LyHd470YUWcATaCTqvhJzlktNZwz7BGM+wrbnkYzaDV5Zz4VMx38K7r02F/HVmE+Ug
 o/yn/LbaFjQAmOcgaOP6/nSb5CjwMJWRSl19i/z++OM8L2Ui1fZxWDSYHxm8uLu2ji6W
 mBXYh3OGhJZG+FrwZEWFtuwyP2AfCALW8d8woT6ksMC7TGs0bbE64RSGc9B0nhopzYHL Nw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pyn7es4g0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Apr 2023 02:10:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33G2ANPI023378
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Apr 2023 02:10:23 GMT
Received: from [10.253.76.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sat, 15 Apr
 2023 19:10:22 -0700
Message-ID: <571d8ecf-2ca6-8b7b-6e15-be12c56e9f88@quicinc.com>
Date:   Sun, 16 Apr 2023 10:10:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: parsing the multi-link element with STA profile wifi: mac80211:
 support MLO authentication/association with one link
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>
References: <48715509-62fd-2307-e38f-176234b482c1@quicinc.com>
 <f240b33d507daf898480b0a11eb27d4475e45164.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <f240b33d507daf898480b0a11eb27d4475e45164.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: T42KEk0dmOESgN3bZ-sh9YWJPq8PKMLO
X-Proofpoint-GUID: T42KEk0dmOESgN3bZ-sh9YWJPq8PKMLO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-15_12,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304160018
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/29/2022 3:28 AM, Johannes Berg wrote:
> On Wed, 2022-09-28 at 23:33 +0800, Wen Gong wrote:

...

Hi Johannes,

The change below which added in ieee80211_rx_mgmt_assoc_resp() by
patch "wifi: mac80211: support MLO authentication/association with one 
link (commit 81151ce462e5)"
maybe need refine to meet 2 links.

I hit issue that the BSS of the 2 link will always hold and never free.

My case is:
When connect with 2 links AP, the cfg80211_hold_bss() is called by 
cfg80211_mlme_assoc()
for each BSS of the 2 links,

When asssocResp from AP is not success(such as status_code==1), the 
ieee80211_link_data of 2nd link(sdata->link[link_id])
is NULL because ieee80211_assoc_success()->ieee80211_vif_update_links() 
is not called.

Then struct cfg80211_rx_assoc_resp resp in cfg80211_rx_assoc_resp() and
struct cfg80211_connect_resp_params cr in __cfg80211_connect_result() 
will only have the data of
the 1st link, and finally cfg80211_connect_result_release_bsses() only 
call cfg80211_unhold_bss()
for the 1st link, then BSS of the 2nd link will never free because its 
hold is awlays > 0 now.

I found it is not easy to refine it, so do you have any advise/idea?

for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
         struct ieee80211_link_data *link;

         link = sdata_dereference(sdata->link[link_id], sdata);
         if (!link)
             continue;

         if (!assoc_data->link[link_id].bss)
             continue;

         resp.links[link_id].bss = assoc_data->link[link_id].bss;
         resp.links[link_id].addr = link->conf->addr;
         resp.links[link_id].status = assoc_data->link[link_id].status;

