Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA4C5AFAAF
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Sep 2022 05:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiIGDek (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 23:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIGDef (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 23:34:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68634766F
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 20:34:31 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2872OjxG008882;
        Wed, 7 Sep 2022 03:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Pgi7QgCJZ/p9VFq08Fw1wO3KCjQzRJjmqvk/8y3fLAo=;
 b=HwsDLy9GYYyANeRjT2bCF+QQwJUUqZqnHjxE6QtfI8Cdh5Z6O3K3a/D+9l0R1g/aZFdh
 HV7I3Z1563FXf8j/3DwjeEo0RlFoBUHx1Df2Gfx9Sq2RuAq2Vuhrd/CJi+bKFw0JtC3X
 ICaROkt/1EMIDbXpG5Xaqgr2l5dLZ/cq3tCKYmdN27DvJ4IIONuO1xsmu6Lb57uD82UU
 PfhsaemcXWA4ALJsbjLwZBqfCy/GSAnei1zRp8791NJ5zvsBLG7AWYMv3aRpEh7rhWb4
 O75nCkoL/4Uk/jFMvvdqhcspi9O3ll9TxLKxObcDZazWkcVGc7UwcBXZEUWQutgsUpFV qQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3je0rrugvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 03:34:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2873YCB3024582
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Sep 2022 03:34:12 GMT
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 6 Sep 2022
 20:34:11 -0700
Message-ID: <1ea05f84-0a82-8599-7862-b41106424bcb@quicinc.com>
Date:   Wed, 7 Sep 2022 11:34:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 00/27] another set of MLO patches
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     <ilan.peer@intel.com>, <andrei.otcheretianski@intel.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
 <6175bc95-201c-cfab-2ae6-9ba77e830394@quicinc.com>
 <09556b33ad998ad243cf75dbc230f3b07349a87e.camel@sipsolutions.net>
 <935ef9e9-2092-e3f0-0edd-4aa29f4fa775@quicinc.com>
 <e01e75013f71ede7b29f2751238935e7147796f2.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <e01e75013f71ede7b29f2751238935e7147796f2.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: c2DrifsBCu9lR1EqoYnn7boUJhu7xREm
X-Proofpoint-GUID: c2DrifsBCu9lR1EqoYnn7boUJhu7xREm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_02,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209070013
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ilan Peer, Andrei Otcheretianski, Johannes,

Could you share me the patches of wpa_supplicant/hostapd for MLO?

It is not need rebased to latest git://w1.fi/hostap.git, I only need to 
test it now.

I see you have many patches in the hostap@lists.infradead.org with below 
links, but not found any patches for MLO.

https://patchwork.ozlabs.org/project/hostap/list/?series=&submitter=25407&state=*&q=&archive=&delegate=

https://patchwork.ozlabs.org/project/hostap/list/?series=&submitter=62065&state=*&q=&archive=&delegate=

On 9/6/2022 4:03 PM, Johannes Berg wrote:
> On Tue, 2022-09-06 at 15:58 +0800, Wen Gong wrote:
>> Now I hit an issue is: wpa_supplicant reject the authentication from AP
>> while connecting.
>> because the addr of authentication is replaced the link
>> bssid(00:03:7f:12:99:99) with MLD address(aa:03:7f:12:99:99) in
>> mac80211's ieee80211_prepare_and_rx_handle().
>> wls1: SME: Ignore authentication with unexpected peer aa:03:7f:12:99:99
>>
> Well, OK, you obviously are adjusting the supplicant to work with MLO
> (otherwise you wouldn't get an MLO connection in the first place), so
> yeah, this is part of the adjustments needed.
>
> Ilan/Andrei have all of this working, maybe we can share the patches
> even before rebase etc.
>
> johannes
