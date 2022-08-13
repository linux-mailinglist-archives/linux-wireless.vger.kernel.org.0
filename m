Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C184E5917C4
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Aug 2022 02:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiHMAQW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 20:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiHMAQV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 20:16:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619EB96FDC
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 17:16:20 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27D00AXe006934;
        Sat, 13 Aug 2022 00:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=o3uxq8sbqmYpTOvEn1/zROV8kbcgKT4IDV/8Na86RJo=;
 b=XmQF06xDB4xwyph8yZZ3ixEpQDaFINBxuejivkk1ZW7CyehB/jSOkYhWwLLIB4PBnY0E
 axeN6NDgWCesy7S2IgYahPxXpFBnVxSc1+iKYVWZSZpvQjpv8evWFaGYKG4Ea2Xj7qwC
 Ca1995aJmHmlg1Cux4cngb9se+Dq10yjOl3pKgJELZKHCS44TDX0mjtvVIx8JtoElxkY
 RuYM5lX9sLgKkc6QZoZoBnpSaH52VlspaSFyARb/7WkiUebaIsAM8h8zR91wru/7e8Fo
 DKoTrGSVWQeJl7hc1wv7DUCNGUstHXsZNglgW1WVNIo/nbyumNfDXB3PK0omHsBs05eE WQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hwahwksb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Aug 2022 00:16:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27D0GC8t009398
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Aug 2022 00:16:12 GMT
Received: from [10.110.64.247] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 12 Aug
 2022 17:16:12 -0700
Message-ID: <f0c1dad2-cb69-cc7e-5cc8-892b4a3fa9d9@quicinc.com>
Date:   Fri, 12 Aug 2022 17:16:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 06/50] wifi: ath12k: add core.h
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-7-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220812161003.27279-7-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 32S95HJ_uC-jcAa7vjitYaTnp9YFWcJi
X-Proofpoint-ORIG-GUID: 32S95HJ_uC-jcAa7vjitYaTnp9YFWcJi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_10,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 suspectscore=0 clxscore=1011 bulkscore=0 adultscore=0
 mlxlogscore=837 malwarescore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120067
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> +struct ath12k_skb_cb {
> +	dma_addr_t paddr;
> +	u8 flags;
> +	u32 cipher;
> +	struct ath12k *ar;
> +	struct ieee80211_vif *vif;
> +	dma_addr_t paddr_ext_desc;
> +} __packed;

Usage of __packed seems incorrect since this is not an ABI buffer, and 
packing will potentially result in some members being unaligned (ath11k 
has struct ath11k_skb_cb packed as well).

Suggest removing __packed and using pahole to find the ideal layout 
since the only concern is that this does not exceed 
IEEE80211_TX_INFO_DRIVER_DATA_SIZE
