Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A7579E50E
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 12:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239681AbjIMKgV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 06:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238013AbjIMKgN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 06:36:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3F9C3
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 03:36:09 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38D9kTol010097;
        Wed, 13 Sep 2023 10:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yohfgTcIExRjRE9ZgBt6JPA1Vyt1kbY2Dup+/vsSSLM=;
 b=V1yasZhyg94WY/vJ9KiRL2wSYSpNEuNbURUENxcxqhASInA5HLcnMzAeLlfVfw5boLOn
 ILM/LrOAVaPFl+b25OBPNpLZkOrXXdstiJ6ot0NXwwpph9p2jk/981KfjeRnDbn8khYH
 S7bZzOWe0IAMDhXNmV9SKQ6oXlLusQ2v/I7zLE3piixlwy94t52E3lzx7ko03lP17Fec
 R1nw8J0jVKPG5iQtDeNz7fa7kcfTd/vOInoiHPmFKbV7LquwJ5tlZ2wIqzxwpqIRoIyt
 xmXiH0cZ7i5SohskSkL9HnmcKEIBxMR9Txaqfk6jU24/h2qo9Sr0YQkZr6/5ZZOYnCvj /Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3ar3g3pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 10:36:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38DAa46w007727
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 10:36:04 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 13 Sep
 2023 03:36:03 -0700
Message-ID: <efa43e0a-9ef1-4989-0a45-dc6425d9b96b@quicinc.com>
Date:   Wed, 13 Sep 2023 18:35:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 0/9] wifi: cfg80211/mac80211: extend 6 GHz support for
 all power modes
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
CC:     <linux-wireless@vger.kernel.org>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
 <319ecb67faac8a2e50408f2bfa28f2431a6e6b9a.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <319ecb67faac8a2e50408f2bfa28f2431a6e6b9a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zHn8y2OaMA7Uf5I48tCVuSDw0oNZdMRH
X-Proofpoint-ORIG-GUID: zHn8y2OaMA7Uf5I48tCVuSDw0oNZdMRH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_04,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=399
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130083
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/30/2023 1:50 AM, Johannes Berg wrote:
[...]
> johannes
This patch "[PATCH v3 2/9] wifi: cfg80211: save Power Spectral Density
(PSD) of the regulatory rule" does not have relation with concurrency.
Because it only add a field "s8 psd" into struct ieee80211_reg_rule
and ieee80211_channel. The psd value is same with other field such as
max_reg_power.

max_reg_power is also different value for AP and station mode in db.txt 
here:
for example:
"country TW: DFS-FCC" and "country US: DFS-FCC"
# 5.15 ~ 5.25 GHz: 30 dBm for master mode, 23 dBm for clients
https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-regdb.git/tree/db.txt#n1785

So could you merge the "[PATCH v3 2/9] wifi: cfg80211: save Power Spectral
Density (PSD) of the regulatory rule" firstly?
