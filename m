Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1034A79F904
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 05:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjINDq2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 23:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbjINDqX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 23:46:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBFD1BE2
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 20:46:19 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E22qYl016253;
        Thu, 14 Sep 2023 03:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jkHoHjDpRq+/2ght+txHpJ1V3UOtGDHDwG/wTmALlEA=;
 b=bpgQtAJgJvWpw5SL6rNBlX7UmE69jovALtKNOt0b/UjDZ8kVjM3gExS6i5JLcZCGXI/f
 9DuMbbQhVnJ2c/zkQ/H5s5zfKOVHq6t2G3GGohjao/jrnb9NeYqmsmeVcJ9XWGE1w4S0
 CEY2SL6fbdGN0XXjsQ9/6k6/34Fj50DxLy7sFGdZdTN4OG3F3eHlit1Iy1fK+RlvoWRD
 40Ge+ka9ZMSULshrtfjslTnuR/cTdoCfDXsZ2dF3rmQmIS4oUWba9CzaSZmI9ir8xdnL
 Ct3VIs2PmaXr4OPHkbHKoIzxn9ux4biSWL6flbD83zHpbRfjaPhdgDcgFtdqLsV6hSUI sg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3dj89tfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 03:46:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38E3k1ZX022230
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 03:46:01 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 13 Sep
 2023 20:46:00 -0700
Message-ID: <e79cae30-0d38-1d01-2ab2-943ad191149a@quicinc.com>
Date:   Thu, 14 Sep 2023 11:45:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 2/9] wifi: cfg80211: save Power Spectral Density (PSD)
 of the regulatory rule
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
CC:     <linux-wireless@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
 <20230315132904.31779-3-quic_adisi@quicinc.com>
 <4cb3e92530d3f4db3b414e2a7536a0f01b765c4d.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <4cb3e92530d3f4db3b414e2a7536a0f01b765c4d.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bvS8k4s9QvGQwWuBpRTa3h6hCyo45gsg
X-Proofpoint-ORIG-GUID: bvS8k4s9QvGQwWuBpRTa3h6hCyo45gsg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_19,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140031
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/13/2023 10:58 PM, Johannes Berg wrote:
> On Wed, 2023-03-15 at 18:58 +0530, Aditya Kumar Singh wrote:
>
>> @@ -8650,6 +8660,14 @@ static int parse_reg_rule(struct nlattr *tb[],
>>   
>>   	reg_rule->flags = nla_get_u32(tb[NL80211_ATTR_REG_RULE_FLAGS]);
>>   
>> +	if (reg_rule->flags & NL80211_RRF_PSD) {
>> +		if (!tb[NL80211_ATTR_POWER_RULE_PSD])
>> +			return -EINVAL;
>> +
>> +		reg_rule->psd =
>> +			nla_get_s8(tb[NL80211_ATTR_POWER_RULE_PSD]);
>> +	}
> Wait ... I'm not sure why we've been adding stuff to this recently, but
> anyway, this part should only be used by CRDA which is deprecated
> anyway?
>
> So I'd say we shouldn't touch any of the code under #ifdef
> CONFIG_CFG80211_CRDA_SUPPORT any more since CRDA will not continue to
> developed with any updates here.
>
> johannes
Oh, I will remove the change in parse_reg_rule() in next version, because
you asked me to add change in 2 
functions(nl80211_put_regdom()/nl80211_msg_put_channel())
below, but I added change in one more function(parse_reg_rule()).

https://lore.kernel.org/linux-wireless/a4e56dbbe88771456bcf3051a0891d66d5e34fd4.camel@sipsolutions.net/
