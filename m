Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A3C7B768F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 04:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240544AbjJDCKN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Oct 2023 22:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjJDCKN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Oct 2023 22:10:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4439AB
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 19:10:08 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3941r2nn012034;
        Wed, 4 Oct 2023 02:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ydS1Nsdr7hBbmTEYNr5SVlkkXTsC+jI1AZ+rHqokxHg=;
 b=LGqnSaMO97NhSsPLFxmzjCcbXktjiadiB30cD83fhRxUd1W/OUajX4QGhMoyMHWkAK6K
 wdGQEm6nhuvivck0SfASb2jEde6jWsbR5A29xF0aBQXqMSxenBJuZOeuD8MHY2ThJx01
 k3FDBIqmqP4ntR3La0tTQQvPbYIRQl1fLpL0O1hW+SYTHojndutbM6Wn1ks9rZtw7kQA
 Dtm89TMnHaYrFJ6b8g0AqFeRWzE2XpPHfyBqN5sctTmYTkYocL++OkmE/+YQ9HQbfmHT
 XK9QvrRpjGn/bag8x5VOkfWxhHVHquKZ1IPSoUhxHAai/HP2n5RT5UAZ3jOc7b/ELrR+ bA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgr9mgr2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 02:09:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39429m54018949
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 02:09:48 GMT
Received: from [10.201.207.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 3 Oct
 2023 19:09:47 -0700
Message-ID: <735c1318-2a6d-4247-8220-868f63f08578@quicinc.com>
Date:   Wed, 4 Oct 2023 07:39:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] wifi: ath11k: fix Tx power value during active CAC
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230912051857.2284-4-quic_adisi@quicinc.com>
 <169634351476.120947.13624704208026863471.kvalo@kernel.org>
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <169634351476.120947.13624704208026863471.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3XI6ERby30MfBK6Yo1pUD1ICi7_nkY7C
X-Proofpoint-ORIG-GUID: 3XI6ERby30MfBK6Yo1pUD1ICi7_nkY7C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1015
 mlxlogscore=803 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/3/23 20:01, Kalle Valo wrote:
> Aditya Kumar Singh <quic_adisi@quicinc.com> wrote:
> 
>> Tx power is fetched from firmware's pdev stats. However, during active
>> CAC, firmware does not fill the current Tx power and sends the max
>> initialised value filled during firmware init. If host sends this power
>> to user space, this is wrong since in certain situations, the Tx power
>> could be greater than the max allowed by the regulatory. Hence, host
>> should not be fetching the Tx power during an active CAC.
>>
>> Fix this issue by returning Tx power as 0 during active CAC since it
>> is known that during CAC, there will be no transmission happening.
> 
> The returning as 0 doesn't seem to match the code. Should I change the sentence to:
> 
> "Fix this issue by returning -EAGAIN error so that the user space knows there's
> no value available right now."
Oops. Looks like only in commit message its still zero. Its changed to 
return -EAGAIN in code.

+	if (test_bit(ATH11K_CAC_RUNNING, &ar->dev_flags)) {
+		mutex_unlock(&ar->conf_mutex);
+		return -EAGAIN;
+	}

So could you just rectify while applying or should I resend?
