Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD827A1914
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Sep 2023 10:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjIOIoO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Sep 2023 04:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjIOIoN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Sep 2023 04:44:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E1B10DF
        for <linux-wireless@vger.kernel.org>; Fri, 15 Sep 2023 01:44:08 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F7nGij008297;
        Fri, 15 Sep 2023 08:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EN0iKJSDkDV2U04k+3tw2wCh4hoqZXBv0iTXm4rec1U=;
 b=GIsIsQf1Xua8EkOODQK8PUyfG2jWyXtp+vziUW9tsCAeR6ClZCW6TgRQ/yjxFvnk+vC7
 1IBW2s88UJD9QQWvlAUAeyd84AKlFcKHvmDLljfpPyL+bU+3KcRO2r+1+Yyw6f74rMWn
 Eu3670qyDRFKBzee/TWQ2gWXNy+NW9iQM6aYTBaGBBe8JuBgjGgtBu6RDMh4LDZDMWzY
 ghC1xvk59Ou540kzN69sLC9jWExSzxP+lx3aViP7OcwMhMd7yLcL3+b43V7V8rB8SBXe
 pswnEElyJWD8tTLGlbIQ54hq1xP2dUytft/cnuFXqFfmQhaL+LR2v2q3dLhQNjNBShXH ow== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4g5tgg9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 08:44:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38F8i19L026561
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 08:44:01 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 15 Sep
 2023 01:44:00 -0700
Message-ID: <bfdcbf9a-0b27-1f7e-3eca-7390a9a7404e@quicinc.com>
Date:   Fri, 15 Sep 2023 16:43:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/3] wifi: mac80211: update link RX NSS by
 ieee80211_sta_set_rx_nss() in ieee80211_assoc_config_link()
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230906103458.24092-1-quic_wgong@quicinc.com>
 <20230906103458.24092-4-quic_wgong@quicinc.com>
 <e6ea3009c489fae910adbf2e1c766f2d827f287f.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <e6ea3009c489fae910adbf2e1c766f2d827f287f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: plgS4T18f3K-nB8dR6qCyiBnIn6qxIdb
X-Proofpoint-GUID: plgS4T18f3K-nB8dR6qCyiBnIn6qxIdb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_05,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150075
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/13/2023 5:04 PM, Johannes Berg wrote:
> On Wed, 2023-09-06 at 06:34 -0400, Wen Gong wrote:
>> Currently for MLO connection, only deflink's rx_nss is set to correct
>> value. The others links' rx_nss of struct ieee80211_link_sta is
>> value 0 in ieee80211_set_associated(), because they are not pass into
>> ieee80211_sta_set_rx_nss() in mac80211 except the deflink in
>> rate_control_rate_init(). This leads driver get NSS = 0 for other links.
>> Add the ieee80211_sta_set_rx_nss() in ieee80211_assoc_config_link(),
>> then the other links' rx_nss will be set to the correct value.
> This is pretty much true, but I also think it's problematic the way you
> phrase it. Software rate control is pretty much, at least currently,
> _not_ supported for MLO (and I don't really see how to support it, if
> firmware picks the link to transmit on, as it probably should).
I searched all the folder wireless, I only found 5 places have the 
handler of rate_init below,
and the functions are all empty. Is it means no driver support rate_init 
currently?
drivers/net/wireless/realtek/rtlwifi/rc.c:304:     .rate_init = 
rtl_rate_init,
drivers/net/wireless/intel/iwlwifi/mvm/rs.c:4098:  .rate_init = 
rs_rate_init_ops,
drivers/net/wireless/intel/iwlwifi/dvm/rs.c:3276:  .rate_init = 
rs_rate_init_stub,
drivers/net/wireless/intel/iwlegacy/4965-rs.c:2779: .rate_init = 
il4965_rs_rate_init_stub,
drivers/net/wireless/intel/iwlegacy/3945-rs.c:867: .rate_init = 
il3945_rs_rate_init_stub,
[...]
