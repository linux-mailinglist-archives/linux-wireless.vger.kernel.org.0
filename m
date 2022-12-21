Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961BF65399F
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Dec 2022 00:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiLUXNi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Dec 2022 18:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLUXNg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Dec 2022 18:13:36 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D1B233B6
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 15:13:35 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BLKfwdR011146;
        Wed, 21 Dec 2022 23:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5HWHQDdfUcBP5u5eXO+mfGukcew6CaRvbRxf7h2qfr8=;
 b=oUL4+OzrhYnZKAuLoUj/1caHKfjXQNfB95YRJ/VNvOlwidqRGDj//V7O4bsqeylkxWRs
 Lrpqa/uOlT5N5BNVGmk8mAapYBaudZF5L0vHMwNwKlX+FDDk+UolCJCzLr0UgadBTJn1
 unhDAqSAJ3nn49Wxp5Z9VjWGnP6j7G/Owoxyk2A+qMSAgQe4mt6sZhQLfr3Ji3Ag5clv
 r0eHux4CcefpfP7+Tub/vfPjBJC0GvT9BswhC5727P2XPz8KQ0BGjFmQOUiO02F+XR8C
 y+2mzJSGMJ69+wDKgQYwI6hhPi3TItDZjMhiQ41vDoE3dZPgOXWY3Xyi8INX64iGKJ/U ow== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mm2brs7xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 23:13:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BLNDP3b014055
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 23:13:25 GMT
Received: from [10.110.106.113] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 21 Dec
 2022 15:13:25 -0800
Message-ID: <38ababd2-0ec9-f1eb-2af8-e7c4368817cd@quicinc.com>
Date:   Wed, 21 Dec 2022 15:13:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/3] wifi: ath11k: add support to parse new WMI event
 for 6 GHz
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        "Lavanya Suresh" <quic_lavaks@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>
References: <20221214164639.31542-3-quic_adisi@quicinc.com>
 <167162704604.23347.8011938867680129068.kvalo@kernel.org>
 <c73a9b25-f7b7-5265-7a86-8b599aaa6df9@quicinc.com>
Content-Language: en-US
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <c73a9b25-f7b7-5265-7a86-8b599aaa6df9@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DDYo2VbWBHWSMOlGCxJGDhgbPHYmO04N
X-Proofpoint-GUID: DDYo2VbWBHWSMOlGCxJGDhgbPHYmO04N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_12,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=972 adultscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212210197
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/21/2022 4:54 AM, Aditya Kumar Singh wrote:
> On 12/21/2022 18:20, Kalle Valo wrote:
>> Aditya Kumar Singh <quic_adisi@quicinc.com> wrote:
>>
>>> In order to support different power levels of 6 GHz AP and client,
>>> new WMI event for regulatory - WMI_REG_CHAN_LIST_CC_EXT_EVENTID is
>>> added in firmware. This event provides new parameters required for
>>> 6 GHz regulatory rules.
>>>
>>> Add support for parsing 2.4 GHz, 5 GHz and 6 GHz reg rules and other
>>> parameters from WMI_REG_CHAN_LIST_CC_EXT_EVENTID.
>>>
>>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> I don't think using Reported-by is correct here. You are
>> adding a new feature, not fixing a bug reported the bot.
> Bot did report a bug in v1 Kalle. That I fixed in v2.

but it did not find a bug in merged code.
in cases like this I've added the Reported-by in the signature section 
of the patch so that the bot sees it but the tag does not become part of 
the commit text

