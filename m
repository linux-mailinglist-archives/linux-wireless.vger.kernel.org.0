Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0438175CC2F
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jul 2023 17:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjGUPmc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jul 2023 11:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjGUPmZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jul 2023 11:42:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D986D3A86
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jul 2023 08:42:17 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LAxMxK008830;
        Fri, 21 Jul 2023 15:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wDnHF2PWIs/ZqPkocgVZn/AazvlicjltIRMUx6my/8s=;
 b=X8WpqbPTWQY86/tWlf9ff00DiMeWfcGocaInz2AtApz+CCaNbCq3W663wC6wSB4+/TJJ
 lbk6Wd0UF1Oaytl83wRgTGIbGd3OYOhEtBsMMY4SmMBgi4UT9K0/2ajRHcB3YTHN95tm
 o1g5OofJbuQ+pRnD9B+C4lIx2EIcdV+LMkm0zgjSGID8Q1+vMuQC5E2bwjIkqWubSoYs
 5nwPy3b0us2JM7SO9jzVuX20BMgt9va6GJC4C5AfAoPgCx0G/jm5jPwnhOe7tbZaFy/H
 +6IpIdvB2NTaG62ERfQk6PMhMu4IGZeadO+4ByABJ1y1wznJNIJShgJw4LjhzMJ3y5+a tA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ryfyf1prf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 15:41:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36LFfvpC023628
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 15:41:57 GMT
Received: from [10.48.244.138] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 21 Jul
 2023 08:41:56 -0700
Message-ID: <88dbaf62-4a44-2bed-0f1d-530b1d8302c1@quicinc.com>
Date:   Fri, 21 Jul 2023 08:41:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: avoid buffer overflow by adding clear
 data of VHT Tx power envelope
Content-Language: en-US
To:     Wen Gong <quic_wgong@quicinc.com>, <johannes@sipsolutions.net>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230721055851.20525-1-quic_wgong@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230721055851.20525-1-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MdPS1Zlw-o1ZKQwef1sAtKKaLu-Pi4KC
X-Proofpoint-ORIG-GUID: MdPS1Zlw-o1ZKQwef1sAtKKaLu-Pi4KC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/20/2023 10:58 PM, Wen Gong wrote:
> While connecting to a 6 GHz AP, the tx_pwr_env_num of struct
> ieee80211_bss_conf is increased (e.g. from 0 to 1) in function
> ieee80211_prep_channel().
> 
> when AP send authentication with status which is not 0 to station, then
> the connection failed here, and the tx_pwr_env_num is not reset to 0,
> because it is only reset to 0 in ieee80211_set_disassoc() which will not
> entered for this fail. Then connect to AP again and hit same fail again,
> the tx_pwr_env_num will increased again and become to 2, then it is an
> invalid number because it should be 1.
> 
> When connect-fail again and again, finally it will exceed the max length
> tx_pwr_env[] in struct ieee80211_bss_conf, when driver use the value of
> tx_pwr_env_num to run loop to access the tx_pwr_env[], then overflow
> happened here.
> 
> There are many steps while connecting to AP for station, and any one step
> failure will lead connect failure, so it is hard to do reset the value of
> tx_pwr_env_num for each failure case.
> 
> And the next connection maybe change to NON-6G Hz and NON-11AX-HE AP after
> connection failure with 6 GHz AP, then the check of flag is_6ghz and flag
> of IEEE80211_CONN_DISABLE_HE will not matched in ieee80211_prep_channel().
> 
> Hence change to assign value of tx_pwr_env_num each time in function
> ieee80211_prep_channel(), then the tx_pwr_env_num will be 1 when the next
> AP is still 6 GHz AP, and it will be 0 for NON-6 GHz AP , and then it
> will be always avoid buffer overflow and invalid value of tx_pwr_env_num.
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> ---
>   net/mac80211/mlme.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index 959695ed7649..d8ca7f18028e 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -4712,6 +4712,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
>   	int ret;
>   	u32 i;
>   	bool have_80mhz;
> +	u8 j = 0;

Since the scope is larger and this is more than a loop control variable, 
suggest giving this a more meaningful name like num_pwr_env

>   
>   	rcu_read_lock();
>   
> @@ -4789,10 +4790,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
>   		he_oper = elems->he_operation;
>   
>   		if (link && is_6ghz) {
> -			struct ieee80211_bss_conf *bss_conf;
> -			u8 j = 0;
> -
> -			bss_conf = link->conf;
> +			struct ieee80211_bss_conf *bss_conf = link->conf;;

s/;;/;/

>   
>   			if (elems->pwr_constr_elem)
>   				bss_conf->pwr_reduction = *elems->pwr_constr_elem;
> @@ -4805,7 +4803,6 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
>   				    sizeof(bss_conf->tx_pwr_env[j]))
>   					continue;
>   
> -				bss_conf->tx_pwr_env_num++;
>   				memcpy(&bss_conf->tx_pwr_env[j], elems->tx_pwr_env[i],
>   				       elems->tx_pwr_env_len[i]);
>   				j++;
> @@ -4818,6 +4815,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
>   				       IEEE80211_CONN_DISABLE_EHT;
>   	}
>   
> +	link->conf->tx_pwr_env_num = j;
> +
>   	/*
>   	 * EHT requires HE to be supported as well. Specifically for 6 GHz
>   	 * channels, the operation channel information can only be deduced from
> 
> base-commit: b21fe5be53eb873c02e7479372726c8aeed171e3

