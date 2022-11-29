Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36FB63BA30
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 08:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiK2HF1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 02:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiK2HFO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 02:05:14 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893BC54B24
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 23:05:05 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AT47dd7011459;
        Tue, 29 Nov 2022 07:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Uw0UXs4yjpgkacJNcaN5lIctnEhPb6+pG+i4QFSGQcA=;
 b=UfXBMfsFui3IJzWxllAi3OJfoje8RxoFXvo2Z76JAdfWQyGvlt0yGJw3ii4sfzu1r4Lq
 LEM1hUB6MoEoVnMDO6O71uUICaGYbMISU+1mOmKyH2Xxn3UQUADiun0Gw0S0E1vT4JIN
 /N63ZSeQjkmmpBM3YgwypazOovIuR2f+r4vGaCjcwOLfQulQgNj/Z+eYLpDHdqikEzE/
 uinogUtf9XRLjq8o/2EQTmeNzzE4x+aAS5QaJC3nNmrWcHmLbZz5vBZDeeL00swoBENw
 VRvQt/vgmGFuJeXgAyt90SE2He8ZYdeEVJli4fiNq0I2VJ4wh15XN+HGHhawf8IbbDYJ mw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m55m90xe8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 07:04:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AT74uv0003712
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 07:04:56 GMT
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 28 Nov
 2022 23:04:54 -0800
Message-ID: <3d4d37ff-583e-ebd7-1ad5-6a577f6d9e42@quicinc.com>
Date:   Tue, 29 Nov 2022 15:04:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: wifi: hostapd:/wpa_supplicant MLO Re: [PATCH 00/27] another set
 of MLO patches
Content-Language: en-US
To:     "Otcheretianski, Andrei" <andrei.otcheretianski@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Peer, Ilan" <ilan.peer@intel.com>
CC:     "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
        "quic_drohan@quicinc.com" <quic_drohan@quicinc.com>,
        "quic_vjakkam@quicinc.com" <quic_vjakkam@quicinc.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
 <6175bc95-201c-cfab-2ae6-9ba77e830394@quicinc.com>
 <09556b33ad998ad243cf75dbc230f3b07349a87e.camel@sipsolutions.net>
 <935ef9e9-2092-e3f0-0edd-4aa29f4fa775@quicinc.com>
 <e01e75013f71ede7b29f2751238935e7147796f2.camel@sipsolutions.net>
 <f3afceb8-8120-12c7-74b9-caa3abce5cb8@quicinc.com>
 <DM6PR11MB3897D1A4E13419D9F938F559F5449@DM6PR11MB3897.namprd11.prod.outlook.com>
 <96bcc467-c530-46de-8f91-c5eb0af7a368@quicinc.com>
 <776991f3-384e-f487-83b7-e1fbfd40cc4f@quicinc.com>
 <de54f4e0-810b-70a0-7629-39a2957ecd3d@quicinc.com>
 <a3edddb2-82e4-2c79-564f-1918b59aead9@quicinc.com>
 <DM6PR11MB3897D1DE6EB7A89F4F6A6A16F5139@DM6PR11MB3897.namprd11.prod.outlook.com>
 <4390cf15-50e6-9941-15b7-4927d1afc976@quicinc.com>
 <DM6PR11MB38979D307490C7DDA235A7B7F5129@DM6PR11MB3897.namprd11.prod.outlook.com>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <DM6PR11MB38979D307490C7DDA235A7B7F5129@DM6PR11MB3897.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: U1pB8RvHxUs3wnp3XliiZn9fTI7fX5AZ
X-Proofpoint-GUID: U1pB8RvHxUs3wnp3XliiZn9fTI7fX5AZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_04,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 mlxlogscore=958 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211290046
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/29/2022 2:59 PM, Otcheretianski, Andrei wrote:
>> Thanks Andrei, did you tested your station with single link or 2 link or more
>> link?
> Tested with 1 and 2 links, but should also work with more links as well
>
> Andrei
Thanks a lot!
