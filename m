Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFCE59A5D7
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Aug 2022 21:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350971AbiHSTBq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Aug 2022 15:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350406AbiHSTBi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Aug 2022 15:01:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA045107AD9
        for <linux-wireless@vger.kernel.org>; Fri, 19 Aug 2022 12:01:35 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JIvZwj004273;
        Fri, 19 Aug 2022 19:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QcSLGs4SuAganUIc0YVw/OiPQWqEBg69UHJVY0f3+0w=;
 b=EkLJ2d1Bp/3ieh+qmxlgsRqt1g1atXBGOUunFIoaO1/zDcHWLIXlLN0Ji4r2fcd+vXQO
 C4giXuDPFD6wKRA6clFyiqntF/fWpOk+DJwYYKXMuk5JXZyC1n50U6wWU6PjvCt3fFHN
 hGrh1vjDiZEz6wu3E/tCPoSeCazySThUwbztly288BwRpNsQjJzIxP6aoizho45lFnaN
 mtJ8Fjc9hQCJByrvEKreXSj8R1HnQ3ESKbYY/OX4I2Z5N+nILN1jWxBW13DV6N84ch2J
 sGyphv3gTqELh2bJ4ZyWQ8/J7h2BToZ6F9gpZstOIv8x+NveTQRPRiwGCcWlWlqNlR3N kw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j21v52k0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 19:01:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27JIuOgL030297
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 18:56:24 GMT
Received: from [10.110.11.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 19 Aug
 2022 11:56:24 -0700
Message-ID: <3b09b751-54c1-d684-7d5c-8f736cd80707@quicinc.com>
Date:   Fri, 19 Aug 2022 11:56:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 33/50] wifi: ath12k: add mhi.c
Content-Language: en-US
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
To:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-34-kvalo@kernel.org>
 <05841a52-3d2f-8704-b885-4b02e7a439e0@quicinc.com>
In-Reply-To: <05841a52-3d2f-8704-b885-4b02e7a439e0@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PyGS-C6aGoyKhqcXPrP9cEe_XoQnCK_W
X-Proofpoint-GUID: PyGS-C6aGoyKhqcXPrP9cEe_XoQnCK_W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_10,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 mlxlogscore=923 phishscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/18/2022 3:25 PM, Jeff Johnson wrote:
 > On 8/12/2022 9:09 AM, Kalle Valo wrote:
 >> +static struct mhi_event_config ath12k_mhi_events_qcn9274[] = {
 >
 > seems this should be const
 > but for some reason struct mhi_controller_config has:
 >      struct mhi_event_config *event_cfg;
 >
 > (not const) so this can't be const :(
 >
 > perhaps someone can propose a MHI interface change?
 > especially since internally to MHI in parse_ev_cfg() we have:
 >      const struct mhi_event_config *event_cfg;
 >      [...]
 >      for (i = 0; i < num; i++) {
 >          event_cfg = &config->event_cfg[i];
 >
 > so it is treated as const

I submitted a patch for this

<https://lore.kernel.org/mhi/20220819184245.28035-1-quic_jjohnson@quicinc.com/>

