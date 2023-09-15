Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924197A26FF
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Sep 2023 21:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbjIOTMC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Sep 2023 15:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbjIOTLi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Sep 2023 15:11:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D9D10E
        for <linux-wireless@vger.kernel.org>; Fri, 15 Sep 2023 12:11:33 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FJ0CLg026646;
        Fri, 15 Sep 2023 19:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OIp95nQrT6+Wc6rT2AA5bpJQUvnQ1yxBTrB1pgLz0zc=;
 b=Y9yNUk+fJb+UaIyjJAFgkF1GXuC2bt9WVi7hFNGnrvznJIepCA0PC7C1JYcHRMD9dYiv
 5Q+BL9IpFDD8i3Lp4I/sU0iJ9a+oVjTx13RdGBmHV2+WxjPAreJMre3JPC9xFv6slwof
 hIz2EzCUg4oEZP518CzqRLBg1SQKoG05mCZkVSSBnF4VT2/LEuVZu/UHqkkFOCXp0Rg7
 zYD4SDX5FaEYZoFi72okRKX/O2qGtHNYW7pkcoOjM91lIHv/bHCQPkcux/Rf223nqxgP
 5qELh39FZ+ekEyg+PzMEGgAwXRvsIOyJ7Ur7kCnaUANohSIG9P8xK8Trma5zq2b/Ulnh Rw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4g3gsw49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 19:11:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38FJBRuG004434
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 19:11:27 GMT
Received: from [10.111.183.186] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 15 Sep
 2023 12:11:27 -0700
Message-ID: <75476a44-e85a-4fba-ae02-c15f1f051bdd@quicinc.com>
Date:   Fri, 15 Sep 2023 12:11:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cfg80211: Allow AP/P2PGO to indicate port
 authorization to peer STA/P2PClient
Content-Language: en-US
To:     Vinayak Yadawad <vinayak.yadawad@broadcom.com>,
        <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <jithu.jance@broadcom.com>
References: <d19fc849488e63cf367029b614289c324f531ae8.1694751711.git.vinayak.yadawad@broadcom.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <d19fc849488e63cf367029b614289c324f531ae8.1694751711.git.vinayak.yadawad@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9Fb1L08aUO2-eFvuiNMe2B3tX2gvM0WT
X-Proofpoint-ORIG-GUID: 9Fb1L08aUO2-eFvuiNMe2B3tX2gvM0WT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_15,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 mlxlogscore=569 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150172
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/14/2023 10:17 PM, Vinayak Yadawad wrote:
> In 4way handshake offload, cfg80211_port_authorized enables driver
> to indicate successful 4way handshake to cfg80211 layer. Currently
> this path of port authorization is restricted to interface type
> NL80211_IFTYPE_STATION and NL80211_IFTYPE_P2P_CLIENT. This patch
> extends the support for NL80211_IFTYPE_AP and NL80211_IFTYPE_P2P_GO
> interfaces to authorize peer STA/P2P_CLIENT, whenever authentication
> is offloaded on the AP/P2P_GO interface.
> 
> Signed-off-by: Vinayak Yadawad <vinayak.yadawad@broadcom.com>
> ---

v1->v2 change log is missing
can you provide that as a separate message

