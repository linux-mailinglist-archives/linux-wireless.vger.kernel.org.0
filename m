Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7895AE1B6
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 09:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiIFH6e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 03:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238604AbiIFH6d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 03:58:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF8355080
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 00:58:32 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2866EHZB001306;
        Tue, 6 Sep 2022 07:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Oo9sXqvqQhMBfxMAiGB+swvQnu79ygF3qzzqDY8PP7s=;
 b=ifz29Swiap/3xvXdMrkfpMrXpbid421bVopSb4OijBJ3jb1ZeofFmIGNFoe28q0nbaIy
 9QQsAtNWhWiyHRiDnfBnmAjJq1RSvFuDKEsoDxRR2W6/AbmCYhSP8D54cUVEDU8maFAz
 sijBMJmL2xDnL+NO3JohOJbWiisSmnSgj+ZsUHnUGwsZPpdrJngSFjfFSwsoZUnMHvKE
 hBJ+IIkxQZN5GKqNsSDT9PuoWrWUZcIkF15w3w/DOA0hRkNuz/HKP0OGrAmA2azMocG1
 gI9zbOkNdfR2CNZqb42hrBaPGFUFmF5ISQfUbzI2MCcjLCZgoO1KWfsk6RdOD4zJPLcN Qg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3je0rrrcnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 07:58:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2867wS6Z015471
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Sep 2022 07:58:28 GMT
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 6 Sep 2022
 00:58:27 -0700
Message-ID: <935ef9e9-2092-e3f0-0edd-4aa29f4fa775@quicinc.com>
Date:   Tue, 6 Sep 2022 15:58:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 00/27] another set of MLO patches
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
 <6175bc95-201c-cfab-2ae6-9ba77e830394@quicinc.com>
 <09556b33ad998ad243cf75dbc230f3b07349a87e.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <09556b33ad998ad243cf75dbc230f3b07349a87e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LQCyTp4C7ze3QNKFCDb4CEfvuJ2zf6e2
X-Proofpoint-GUID: LQCyTp4C7ze3QNKFCDb4CEfvuJ2zf6e2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_03,2022-09-05_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060037
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 9/6/2022 3:28 PM, Johannes Berg wrote:
> Hi,
>
>> The 3 commit below
>> wifi: mac80211: mlme: transmit assoc frame with address translation
>> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?h=mld&id=4ca04ed36478e21b037fc379a7e6f52d0e6d8d52
>>
>> wifi: mac80211: support MLO authentication/association with one link
>> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?h=mld&id=81151ce462e533551f3284bfdb8e0f461c9220e6
>>
>> wifi: mac80211: do link->MLD address translation on RX
>> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?h=mld&id=42fb9148c078004d07b4c39bd7b1086b6165780c
>
> (Just noting that they're not part of this patchset, they were there
> before)
>
>> changed to use MLD address for send
>> authentication/assoc request for station and
>> changed to use MLD address of rx management packet include
>> authentication/assoc response received by station from AP.
> Yes.
>
>> Does it has any description about the MLD adress in authentication/assoc
>> request/assoc response in IEEE P802.11be™/D2.0 or other sepcification?
> Not _really_. I don't think the spec ever really talks about this since
> it simply doesn't (need to) care what you do inside your software stack.
>
> However, I believe there are (or will be) cases where even for
> management frames we will not want to make a determination which link to
> use to transmit - since they're "addressed to the MLD" (see D2.0 35.3.14
> Multi-link device individually addressed Management frame delivery).
>
> Note also that for protected management frames, the MLD addresses become
> part of the AAD.
>
> Today, auth/assoc frames cannot be encrypted (though that may quite
> possibly change for assoc frames in the future), and for them also only
> a single link can be selected.
>
> However, I thought that from a software POV it would still be better if
> as many MLD-addressed frames actually carried MLD addresses in the
> software stack as possible, to unify things with the encryption
> requirements etc.
>
> The only exception to this is the first received authentication frame on
> the AP which cannot be translated in the stack/driver/firmware since we
> don't have a station entry for the new station yet, so hostapd has to be
> prepared to handle that very first frame with link addresses.
>
> johannes
Thanks.

Now I hit an issue is: wpa_supplicant reject the authentication from AP 
while connecting.
because the addr of authentication is replaced the link 
bssid(00:03:7f:12:99:99) with MLD address(aa:03:7f:12:99:99) in 
mac80211's ieee80211_prepare_and_rx_handle().
wls1: SME: Ignore authentication with unexpected peer aa:03:7f:12:99:99

log:
wls1: SME: Trying to authenticate with 00:03:7f:12:99:99
EAPOL: External notification - portValid=0
wls1: State: SCANNING -> AUTHENTICATING
Not configuring frame filtering - BSS 00:00:00:00:00:00 is not a Hotspot 
2.0 network
wls1: Determining shared radio frequencies (max len 1)
wls1: Shared frequencies (len=0): completed iteration
nl80211: Authenticate (ifindex=3)
   * bssid=00:03:7f:12:99:99
   * freq=5180
   * SSID=GONGWEN-WKK-MLO
   * IEs - hexdump(len=0): [NULL]
   * Auth Type 0
   * mlo link id=2
   * mld address=aa:03:7f:12:99:99
nl80211: Authentication request send successfully
RTM_NEWLINK: ifi_index=3 ifname=wls1 wext ifi_family=0 ifi_flags=0x1003 
([UP])
nl80211: Event message available
nl80211: Drv Event 19 (NL80211_CMD_NEW_STATION) received for wls1
nl80211: New station aa:03:7f:12:99:99
nl80211: Event message available
nl80211: Drv Event 37 (NL80211_CMD_AUTHENTICATE) received for wls1
nl80211: MLME event 37 (NL80211_CMD_AUTHENTICATE) on 
wls1(00:03:7f:37:12:16) A1=00:03:7f:37:12:16 A2=aa:03:7f:12:99:99
nl80211: MLME event frame - hexdump(len=42): b0 00 f0 00 00 03 7f 37 12 
16 aa 03 7f 12 99 99 aa 03 7f 12 99 99 e0 b8 00 00 02 00 00 00 ff 0a 6b 
00 00 07 aa 03 7f 12 99 99
nl80211: Authenticate event
wls1: Event AUTH (10) received
wls1: SME: Ignore authentication with unexpected peer aa:03:7f:12:99:99
