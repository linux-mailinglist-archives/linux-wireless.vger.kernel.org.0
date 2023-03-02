Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DC76A8A99
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Mar 2023 21:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjCBUoI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Mar 2023 15:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCBUoH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Mar 2023 15:44:07 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBBB48E26
        for <linux-wireless@vger.kernel.org>; Thu,  2 Mar 2023 12:43:57 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322KQdfg002191;
        Thu, 2 Mar 2023 20:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Aifn6ARSjyfkyKqyOyXpFjg1FACmm2jdiBH5C2tb8bs=;
 b=gDWvlVRVrCd228vclIdRRwQMkY9ghVoJNDdYBGX7VLnmipNmLUu/orAJ1Et2tLbNsTeW
 sw10iQJqUAph2czt3iY1D8Gs0qkK6QDSQkJcnGHmGPUpGR5VEvnD+l5eaKm5mwSevEd7
 edy7YTSaVw6w1MZzSj7iiovvJdop2UpcYcCqc/c0L8tcv5bTLCLw0+m1O8knPWt9uvO2
 26h+x/7qiiEdqOXCnxVurEqtV4dFS7l+T0k8H7pqpYxKbtwe9dvgyj9xUfDqtDrKDu44
 8bEzkaJfajNUzxfHD/0KzzBEsZrBDXcujaGOt/gWpzqjlMFQo+1pQfWYZEUwtqRmFxBa DA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p288r4cv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 20:43:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 322Khhhh026153
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 20:43:43 GMT
Received: from [10.111.183.21] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 2 Mar 2023
 12:43:43 -0800
Message-ID: <742e0bdf-8208-3190-f5cc-a2438aeaf813@quicinc.com>
Date:   Thu, 2 Mar 2023 12:43:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 07/23] wifi: wireless: correct validation 6G Band for
 primary channel
Content-Language: en-US
To:     <gregory.greenman@intel.com>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>
References: <20230301100935.170922-1-gregory.greenman@intel.com>
 <20230301115906.314faf725255.I5e27251ac558297553b590d3917a7b6d1aae0e74@changeid>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230301115906.314faf725255.I5e27251ac558297553b590d3917a7b6d1aae0e74@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ww8szHchbsW_k0-91JWaFie0ElLYvQyv
X-Proofpoint-ORIG-GUID: Ww8szHchbsW_k0-91JWaFie0ElLYvQyv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_14,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1011 mlxscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020179
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/1/2023 2:09 AM, gregory.greenman@intel.com wrote:
> From: Mordechay Goodstein <mordechay.goodstein@intel.com>
> 
> Current check that beacon primary channel is in the range of 80Mhz
> (abs < 80) is invalid for EHT 320Mhz due to 6G DUP beacon means that

s/Mhz/MHz/g

also suggest separating the magnitude from the units to align with SI 
nomenclature.

> AP transmits on all the sub 20Mhz channels the beacon.
> 
> 9.4.2.249 HE Operation element - ... AP transmits Beacon frames in
> non-HT duplicate PPDU with a TXVECTOR parameter CH_BANDWIDTH value
> that is up to the BSS bandwidth.
> 
> So in case of 320Mhz the DUP beacon can be in upper 160 for primary
> channel in the lower 160 giving possibly a absolute range of over

s/a absolute/an absolute/

> 80Mhz.
> 
> Also this check is redundant all together, if AP has a wrong primary
> channel in the beacon it's a fluty AP, and we would fail in next
> steps to connect.
> 
> Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> ---
>   net/wireless/scan.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/net/wireless/scan.c b/net/wireless/scan.c
> index 72e9af6158ef..0cdfbb104b80 100644
> --- a/net/wireless/scan.c
> +++ b/net/wireless/scan.c
> @@ -1885,23 +1885,21 @@ cfg80211_get_bss_channel(struct wiphy *wiphy, const u8 *ie, size_t ielen,
>   
>   	freq = ieee80211_channel_to_freq_khz(channel_number, channel->band);
>   
> -	/*
> -	 * In 6GHz, duplicated beacon indication is relevant for
> -	 * beacons only.
> +	/* Frame info (beacon/prob res) is the same as resieved channel, no need

s/resieved/received/

> +	 * for forther process.

s/forther/further/

>   	 */
> -	if (channel->band == NL80211_BAND_6GHZ &&
> -	    (freq == channel->center_freq ||
> -	     abs(freq - channel->center_freq) > 80))
> +	if (freq == channel->center_freq)
>   		return channel;
>   
>   	alt_channel = ieee80211_get_channel_khz(wiphy, freq);
>   	if (!alt_channel) {
> -		if (channel->band == NL80211_BAND_2GHZ) {
> +		if (channel->band == NL80211_BAND_2GHZ ||
> +		    channel->band == NL80211_BAND_60GHZ) {
>   			/*
>   			 * Better not allow unexpected channels when that could
>   			 * be going beyond the 1-11 range (e.g., discovering
>   			 * BSS on channel 12 when radio is configured for
> -			 * channel 11.
> +			 * channel 11) or beyond the 6G channel range.

both in subject and here can we change 6G to 6 GHz to avoid confusion 
with cellular use of "6G" and potentially WFA use of "Wi-Fi 6" where 6 
is a generation and not a frequency?


>   			 */
>   			return NULL;
>   		}

