Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD2475FE09
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 19:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjGXRoR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 13:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGXRoB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 13:44:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE481736
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 10:43:57 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFS3lt005215;
        Mon, 24 Jul 2023 17:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QPpAkPFaT04QWbh/aeKEC4bpj9Coeh6xfvd0qEdcaxc=;
 b=Kzc3tpqiLJgPm/KhSlMJ83XwjNgn44txWXbwVFBFG0m/iLoCQ/GOAZMpD+ndHc9y2MIo
 UG73BuNKmkKQiCmW1Xzc4ycnlOrR96kcAOxNbp0u4FdAYINhOupoxxhAHfGZHnqFOnMz
 MiQfT4bdinxpgEMf8maaQCPo3ep5tm0e6xAj3ZHWYhUNCUDU9pN2MJPbpJO5Iv95XPXU
 U4MMOiDAuphYUL97Nw3Cg2TYPSDKXKvblj/Rv82SWErCRpPOsK42XzOqD5g2Q/wLEDHL
 h+FOioaulIJCgMX7tD70uV1VT/F19deVYlyHa9eNJyJNhZXZ2tHFAhnBdBABgd5ShT8T Ug== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1sr70qje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 17:43:52 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36OHhowd015896
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 17:43:50 GMT
Received: from [10.227.89.240] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 24 Jul
 2023 10:43:50 -0700
Message-ID: <5a0e5c52-d4ec-3dd3-47c7-2d6bc098c440@quicinc.com>
Date:   Mon, 24 Jul 2023 10:43:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 00/11] wifi: ath12k: (v4) EHT support
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230602235820.23912-1-quic_alokad@quicinc.com>
 <87y1klaqw0.fsf@kernel.org>
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <87y1klaqw0.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8QeMT-DxFi94T1EMfyNd7MCHV8SWRc_h
X-Proofpoint-ORIG-GUID: 8QeMT-DxFi94T1EMfyNd7MCHV8SWRc_h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=855 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240158
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/15/2023 4:47 AM, Kalle Valo wrote:
> Aloka Dixit <quic_alokad@quicinc.com> writes:
> 
>> Add driver support for EHT bring-up, association and
>> preamble puncturing.
>>
>> v4: Modified patch 3 to support WCN7850.
>> v3: Modified patches 6 and 9 to fix some issues,
>> changelog included in the respective patches.
>> v2: This version modifies only few commit descriptions,
>> changelog included in the respective patches.
> 
> I did some minor changes to these patches in the pending branch, here's
> a list:
> 
> * patch 3: ath12k_wmi_tlv_mac_phy_caps_ext(): remove unncessary cast and add const
> 
> * patch 3: shorten struct ath12k_wmi_mac_phy_caps_ext_params due to
>    long line warning
> 
> * patch 3: improve error messages
> 
> * patch 3: move struct ath12k_fw_pdev after struct ath12k_pdev
> 
> * patch 5: ath12k_mac_get_phymode_eht(): add extra spaces, improve error messages
> 
> * patch 6: cosmetic cleanup, extra lines etc
> 
> * patch 6: ath12k_mac_set_eht_ppe_threshold(): move declarations
>    to the beginning of the function
> 
> * patch 7&8: use BIT() for enum wmi_tlv_peer_flags_ext
> 
> I have two more comments which I'll send as a reply to patches. I'm
> hoping to fix those in my pending branch as well so there would no need
> to resend anything.
> 
> The changes are now in the pending branch, under tag
> ath-pending-202306151144. Here's a link to few of those commits:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=master-pending&id=974310a085acad9cee462b3f343e8c05185abc67
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=master-pending&id=e4b7f51541b4ae79baa1ab9a8389fd4d9e0fe219
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=master-pending&id=ae4b76c40bc7350d52d42de6e8633f6e52d905fb
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=master-pending&id=3594ef351ae29788c00fad6c69d60b9a41dc1bbb
> 


Hi Kalle,

I have created a new version which fixes the comments you added 
separately for 2 patches.
Should I send those now?

Thanks.
