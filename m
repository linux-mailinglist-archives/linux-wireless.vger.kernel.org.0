Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D376040B2
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Oct 2022 12:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiJSKLu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Oct 2022 06:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiJSKLd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Oct 2022 06:11:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F72FC1DA
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 02:50:52 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29J9CR79030520;
        Wed, 19 Oct 2022 09:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=N4XbolfPRYP6yQS3rO7PdXpeLrCTZh1nx3CX/lYi56E=;
 b=GpIJWE3MLDHRl12ADGK9hyT275NToi8bvKU2ccktXKcnpT6+DgTivOYK9ITS4bXTUSxW
 JKBm9p+hR7p3EJPwSp1SErKHk0XbFsZAB0TlnniL9JstiH50YPW2dJpQDjYc0he4AjvI
 xqvvCec75stNFJrf8zGP5iAnUrC7KznoHqDkM03iWJLwku7l0bz52Rhmpjrcd4kBV3e7
 p6GaqyhaE6eRxuzmHzPyALC2QNSMiq3y3F3WszjF7SVdkK773+YQMKMGFYBxxgxzyR+M
 vUecUSQ/VgGEOdwuMbOXKwNZw0xVhUCWlE/GJ0TYdigPXZzwmZbvpZcfmbQpYgpQrOJn 5w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kaed8r4ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 09:35:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29J9ZtJL019075
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 09:35:55 GMT
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 19 Oct
 2022 02:35:53 -0700
Message-ID: <9fe7c0f2-e02f-e87f-dced-90e973c8992f@quicinc.com>
Date:   Wed, 19 Oct 2022 17:35:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: wifi: mac80211: Re: unicast probe response bssid changed by "wifi:
 mac80211: do link->MLD address translation on RX"
Content-Language: en-US
From:   Wen Gong <quic_wgong@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>, <ath12k@lists.infradead.org>
References: <e1c5fbac-7e6e-c643-f24d-32cec779f2d3@quicinc.com>
In-Reply-To: <e1c5fbac-7e6e-c643-f24d-32cec779f2d3@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BR9fgVrzolWHlHCFTY3NnqECkUqnFIDI
X-Proofpoint-GUID: BR9fgVrzolWHlHCFTY3NnqECkUqnFIDI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_06,2022-10-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 phishscore=0
 mlxlogscore=912 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190052
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/14/2022 11:13 AM, Wen Gong wrote:
> Hi Johannes,
>
> The mac addr of unicast rx packet all changed to the MLD address by 
> below patch.
> Now the probe presponse which is unicast packet is also changed mac 
> address here.
> I found bssid which is the MLD address of my test AP in 
> cfg80211_get_bss().
> For example, if the AP has 2 mlo links, link 1 is 5 GHz band, link 2 
> is 2.4 GHz band,
> then the 2 probe reponse will be changed to a same one.
> seems we should skip probe presponse for the mac address change here, 
> right?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?id=42fb9148c078004d07b4c39bd7b1086b6165780c 
>
> wifi: mac80211: do link->MLD address translation on RX
>
Hi Johannes,

May I get your comment about this?

I did below change in my local test to workaround the issue.

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index a57811372027..eaff5353520a 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4858,7 +4858,8 @@ static bool ieee80211_prepare_and_rx_handle(struct 
ieee80211_rx_data *rx,
          shwt->hwtstamp = skb_hwtstamps(skb)->hwtstamp;
      }

-    if (unlikely(link_sta)) {
+    if (unlikely(link_sta) &&
+        !(ieee80211_is_probe_resp(hdr->frame_control))) {
          /* translate to MLD addresses */
          if (ether_addr_equal(link->conf->addr, hdr->addr1))
              ether_addr_copy(hdr->addr1, rx->sdata->vif.addr);

