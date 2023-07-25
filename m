Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B9F762740
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 01:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjGYXVS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 19:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjGYXVR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 19:21:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9224919B
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 16:21:16 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PMJF59025460;
        Tue, 25 Jul 2023 22:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Szm6rw8E3NGaviAOOxAt+3YjDMFdrRk3jOSYxyAhq3g=;
 b=MZOw89Hp3kEojyiGLxHpjI09gdhJIj8Pw4V/boCOGowDoAVhVEyIrI6FFIw5b9LMRpRu
 eLoZKjI6VW86davWItnN1c8OIsi08qFPpBij8PRMi87UDyVRG4jRqCeU9p5dX9cUIZvk
 29QeA3WVhe7ihrTE/WsdoXBc1MzA0ehY8KFfkwx6UtluKAMHx2AkXahOHwIjcJ/gRG3o
 TCHZfGl3cXJ+Yji2OSqB/8HsnP/hMvZK2niils8Xc+6x1XHuW0DwZHq8snd7lPyikSEt
 utHADie3kb9cP9z25Be93pe6WOUHWPhxrI3N3mPArfawvzXSgwcIFcTL+8uXSrjqx5bQ 2w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2cf8sm7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 22:44:32 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36PMiGZn011834
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 22:44:16 GMT
Received: from [10.110.108.92] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 25 Jul
 2023 15:44:15 -0700
Message-ID: <54dc7722-0335-e585-56fd-c01318c52ed4@quicinc.com>
Date:   Tue, 25 Jul 2023 15:44:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Aloka Dixit <quic_alokad@quicinc.com>
Subject: Re: [PATCH v4 06/11] wifi: ath12k: prepare EHT peer assoc parameters
To:     Wen Gong <quic_wgong@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
CC:     Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
References: <20230602235820.23912-1-quic_alokad@quicinc.com>
 <20230602235820.23912-7-quic_alokad@quicinc.com>
 <f4515520-1d3b-1b07-6ddd-ae269c12a91f@quicinc.com>
 <cdfbb85a-f3be-8cdc-7117-7550d3808a13@quicinc.com>
 <f9f53552-4823-c841-866a-77057bef0b11@quicinc.com>
Content-Language: en-US
In-Reply-To: <f9f53552-4823-c841-866a-77057bef0b11@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7yyKgBy-gxwG9UCEAhYJHv-vHoFTosT8
X-Proofpoint-GUID: 7yyKgBy-gxwG9UCEAhYJHv-vHoFTosT8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_12,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=967
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250194
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/25/2023 3:07 AM, Wen Gong wrote:
> 
> For station mode of ath12k, the eht_cap->eht_mcs_nss_supp is from the IE 
> "Supported
> EHT-MCS and NSS Set" in assoc resp of AP in function 
> ieee80211_eht_cap_ie_to_sta_eht_cap().
> Now it is "EHT-MCS Map (BW <= 80MHz): 0x222222" for the AP(11BE-EHT mode 
> for 20 MHz
> bandwidth on 6 GHz band) in my test as below IEs.
> 
> The field only_20mhz and field _80 are union in struct 
> ieee80211_eht_mcs_nss_supp, the
> value of field _80 is 0x222222 for this AP, then the value of field 
> only_20mhz is like this:
> rx_tx_mcs7_max_nss=0x22,
> rx_tx_mcs9_max_nss=0x22,
> rx_tx_mcs11_max_nss=0x22,
> rx_tx_mcs13_max_nss=0.
> 
> Then ath12k_mac_set_eht_mcs() will get value 0 fro mcs13 because it used 
> the field only_20mhz
> passed by ath12k_peer_assoc_h_eht().
> 

Understood, I fixed the default case to check for the he_cap field for 
the bandwidth support instead of peer_phymode in v5.
