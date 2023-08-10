Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0A5776E81
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 05:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjHJD1K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 23:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjHJD1J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 23:27:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD60FE
        for <linux-wireless@vger.kernel.org>; Wed,  9 Aug 2023 20:27:08 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A3DbAH010592;
        Thu, 10 Aug 2023 03:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GnrAdkam2sTuy+Err4uBdKhh0nsjiTJMSIrw9LGBlaY=;
 b=ILENdeIqZcpuJRv/OIScZWyJUDRcSxSHdLWp99xZkM4kihR4OyVmT2V8ADglldoEWibW
 tCOiUHD+GcvYgzfzfay10/bkpzsXYpA/OLf4GGshFuq+G5xM7dA/SRW7aJSpeM8x7sgr
 qjQ3+2zuXxKZcOGpbhKVwP6NyJmMQCL5KlJOlxiXKGSmlRzkOapZIHm0o65JvXs3OIjZ
 jbB9xwVNt+t9jBrvdlfNoc8hmALyAi2LjlU+Id8KHaljpQRwxcMC3cViZDBfuqY63avK
 l98B/6jeZglYEGM6MdLub+ERGRAmj5Yw39lJeYgt9u77udetjax5n17e1If1kHFKtb+0 dg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sc5ffab8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 03:27:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37A3R4lr031397
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 03:27:04 GMT
Received: from [10.111.180.219] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 20:27:03 -0700
Message-ID: <2a069aea-7b5d-ed12-c5ec-9c1de3b6a9ac@quicinc.com>
Date:   Wed, 9 Aug 2023 20:27:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: mwifiex: added code to support host mlme.
Content-Language: en-US
To:     David Lin <yu-hao.lin@nxp.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
References: <DU0PR04MB963607ADBFC49C7AB713092DD113A@DU0PR04MB9636.eurprd04.prod.outlook.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <DU0PR04MB963607ADBFC49C7AB713092DD113A@DU0PR04MB9636.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mDykZmzimbhkqquW0kKXXiYK3D4CNmbC
X-Proofpoint-GUID: mDykZmzimbhkqquW0kKXXiYK3D4CNmbC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_01,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxlogscore=886
 mlxscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100028
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/9/2023 7:39 PM, David Lin wrote:
snip

> @@ -491,6 +511,17 @@ int mwifiex_cmd_802_11_associate(struct mwifiex_private *priv,
>                          sizeof(struct mwifiex_chan_scan_param_set);
>          }
> 
> +       if (priv->adapter->host_mlme) {
> +               host_mlme_tlv = (struct mwifiex_ie_types_host_mlme *)pos;
> +               host_mlme_tlv->header.type = cpu_to_le16(TLV_TYPE_HOST_MLME);
> +               host_mlme_tlv->header.len = sizeof(host_mlme_tlv->host_mlme);

cpu_to_le16(sizeof(host_mlme_tlv->host_mlme)) ??

> +               host_mlme_tlv->host_mlme = 1;
> +               pos += sizeof(host_mlme_tlv->header) +
> +                       host_mlme_tlv->header.len;

le16_to_cpu(host_mlme_tlv->header.len) ?? or just use 
sizeof(host_mlme_tlv->host_mlme)

> +               host_mlme_tlv->header.len =
> +                       cpu_to_le16(host_mlme_tlv->header.len);

The approach currently being taken doesn't look sparse-compliant. You 
should write an le16 into a __le16 member; writing a cpu16 into a __le16 
member and then converting in place using cpu_to_le16() is broken.

> +       }
> +

The above jumped out at me while scanning your patch -- it failed my 
mental pattern matching.

/jeff

