Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045E7662211
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 10:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbjAIJuP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 04:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbjAIJtV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 04:49:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A5995AE
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 01:48:30 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3098oGSs002826;
        Mon, 9 Jan 2023 09:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=yqqk2EzZfeChfMWrB1gzEFSlZdqXxGS89cKk9izFgVY=;
 b=Ugue+L0hOlXcLo+DKbUPbEbFRP77du/E495phwwnoyZJW9VipWzuYp8cR8d4wFfoZJ5y
 wQf2tOxDhE7DTibE0gooH9bCr+8JgqeX+0+Ev5EVZvj88kjZxAdFj0WFvLm5sppeqMaT
 hFmnDyPuwuGBGxoooDeyqM+MQUkw14bK5osqmD3UibaD2ZKkciM6rKEDS0TnvxTsc278
 D6zvxUCF252TvKiZIQsB/gTF8uhJhQybSk3nVRbxM91HhuU1nWSt2H4F8CU59giGymB+
 1ggmSpNhaW+8tlpDC3SmY+9tj+qf7btqqSldCsVXJmcFDRD2tJOEpYXNQYEdHxnCA4XP 1w== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my0yaasnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 09:48:20 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3099mKqZ006922
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 09:48:20 GMT
Received: from [10.253.34.122] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 9 Jan 2023
 01:48:19 -0800
Message-ID: <efad76dd-14ff-4a36-ec67-fe6f3b8dcc5b@quicinc.com>
Date:   Mon, 9 Jan 2023 17:48:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Content-Language: en-US
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>
From:   Wen Gong <quic_wgong@quicinc.com>
Subject: authentication timed out by "wifi: mac80211: do link->MLD address
 translation on RX"
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PTJ2GypClcugAyHHyzlm3V0Qdho-t7kl
X-Proofpoint-ORIG-GUID: PTJ2GypClcugAyHHyzlm3V0Qdho-t7kl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_03,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=861 adultscore=0
 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301090069
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

When the rx packet is skb_copy(), the hdr is not re-assign the new skb 
value, and lead the

operation of "translate to MLD addresses" take effect on the original 
skb, and lead

the check "if (!ether_addr_equal(ifmgd->auth_data->ap_addr, 
mgmt->bssid))" fail in ieee80211_rx_mgmt_auth(),

and thus happened "authentication timed out".

After below change, issue not happen again.

--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4854,6 +4854,8 @@ static bool ieee80211_prepare_and_rx_handle(struct 
ieee80211_rx_data *rx,
                         return true;
                 }

+               hdr = (void *)rx->skb->data;
+
                 /* skb_copy() does not copy the hw timestamps, so copy it
                  * explicitly
                  */


commit:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?id=42fb9148c078004d07b4c39bd7b1086b6165780c

wifi: mac80211: do link->MLD address translation on RX

