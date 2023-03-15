Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CB46BB499
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 14:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjCON33 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 09:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjCON32 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 09:29:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC38D72B0E
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 06:29:25 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FALrJL026904;
        Wed, 15 Mar 2023 13:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=a2kkM7uhply7FlyjG0Q2C+Dd5KaDJE7p8h4qx2Im4z8=;
 b=Lj25QIhrsx/t6KTX/T3rtTfe9bsdkVYjRhCMubCI9JwQeyDrUR6I7vDmv1JKkKWubVPH
 VeVhX1LrBhCRN3PPMpgtZ7+JPKY5t07opuyMpIXbSEeynsR7+KGR+dCZIhVsr1HUiIcK
 +2bmU8X3iKtXauA8Z8jsvvn5vTU+h9D9REqZhrcT8vA8JLs5UEsZ4mrCbji8ikoIMWuV
 RxnMBTWG/3Ow+8XGVWpfna9A7f8nvIJj9x6m+JpQCxfaPl6l5KWjhVfjeOccgaHH1qb/
 lGlUYKqrkMwfFhcGSz5U7nOZYh5EvqmsKvrY/CqOLgEshM4hqsfayNfYiWkFXc5dPV1r UA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2ck1nwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 13:29:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32FDTLpH019985
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 13:29:21 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 15 Mar 2023 06:29:19 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v3 0/9] wifi: cfg80211/mac80211: extend 6 GHz support for all power modes
Date:   Wed, 15 Mar 2023 18:58:55 +0530
Message-ID: <20230315132904.31779-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: egUleK_Ak4MM7dyDLfMfGlpXfIYFVN0Q
X-Proofpoint-GUID: egUleK_Ak4MM7dyDLfMfGlpXfIYFVN0Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_06,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=938 clxscore=1015 mlxscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2302240000
 definitions=main-2303150114
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

6 GHz introduces various power modes of operation. Currently, based
on the power mode, channel's Power Spectral Density (PSD) value,
Regulatory power value, as well as channel disabled flag can change.
For single interface, current implementation works just fine. But for
multi-interfaces, for example AP-STA concurrency, two different channel
context needs to be maintained. This is because, STA power mode also
depends on the AP's power mode it is going to associate with. Hence,
PSD value, regulatory power value and channel disabled flag might vary.
In this case, same channel context cannot be used for both AP and STA.

Therefore, to support multiple channel space for each power mode, the
6 GHz channels needs a separate storage space in data structure
ieee80211_supported_band. Because of this, the existing APIs to get the
channel/frequency from frequency/channel will not work for 6 GHz band.

Add support to store all possible 6 GHz channel pools according to the
power mode as well as add API support for getting channel/frequency info
from the new struct ieee80211_6ghz_channel.


Why different channel pools and not array of varying member in the same channel?:
--------------------------------------------------------------------------------

Let (A) be the implementation of having separate channel
pools based on power mode:

[...]
struct ieee80211_6ghz_channel {
	struct ieee80211_channel *channels;
	int num_channels;
};

struct ieee80211_supported_band {
	/* Other members */
	struct ieee80211_6ghz_channel[MAX_POWER_MODE];
	/* Other members */
}
[...]

After updating the regulatory rules, in case of (A), all the channels
stored in the struct ieee80211_6ghz_channel will have its desired
value based on the power mode.

Let the alternate implementation be (B) which maintains array of such variables
which can vary based on power mode:

[...]
struct ieee80211_channel {
	/* Other members*/
	u32 flags[MAX_POWER_MODE];
	int max_reg_power[MAX_POWER_MODE];
	s8 psd[MAX_POWER_MODE];
	/* Other members*/
}
[...]

After updating the regulatory rules in case of (B), for 6 GHz sband channels,
all the values based on the power mode are stored in array for each channel.


During 6 GHz interface bring up, power mode will be known and in
method (A), accordingly the corresponding ieee80211_channel will
be selected from the pool. With this, all its members are having
the desired value stored in them just like any other ieee80211_channel. 

For method B, ieee80211_channel will be selected, but its members are
having array of possible values. Even though configured power mode is
known, still, the members dont have the exact required value. 

Now, as per the code flow, a pointer for the configured channel
is stored in chandef and thats parsed to extract the required information
like flags, power, frequency information, etc.

If current implementation (A) is followed then the subsequent functions
using the set ieee80211_channel will need not be modified since the exact
required values based on the power mode is applied to its members
already and everything will fall in its place.

But if method (B) is used, then in all subsequent functions using the
configured ieee80211_channel, condition check on power mode and then
accordingly using the appropriate values from the array needs to be
implemented at each single place.

Hence, method (B) would require code changes at a lot of places leading to
more possiblity of errors to come in.

Also, currently only flags, power and PSD value is changing based on
power mode. If later on any new member or exisiting member is varyed
then with method (A), less code changes will be required since altering
the ieee80211_channel struct  would do. But if method (B) is used then
apart from altering ieee80211_channel struct, all functions using
ieee80211_channels needs to be modified accordingly to fecth this new varying
member from correct power mode index.



Aditya Kumar Singh (8):
  wifi: mac80211: rework on 6 GHz power type definition
  wifi: mac80211: add combined power type definition for 6 GHz
  wifi: cfg80211: add NL command to set 6 GHz power mode
  wifi: mac80211: add support for 6 GHz channels and regulatory
  wifi: cfg80211: rework nl80211_parse_chandef for 6 GHz
  wifi: cfg80211: save 6 GHz power mode of the regulatory rules
  wifi: cfg80211: fix chandef identical logic for 6 GHz chandefs
  wifi: mac80211: use proper API to fetch 6 GHz channel

Wen Gong (1):
  wifi: cfg80211: save Power Spectral Density (PSD) of the regulatory
    rule
---
v3: - resolved sta mode association issue and AP-STA concurrency bring up
	* added patch 8 to handle concurrent AP-STA bring up on 6 GHz
	* added patch 9 to handle bss assoc in 6 GHz
    - no other changes in patches 1-7 from v2.

v2: addressed v1 review comments. 
     * moved variables to link specific w.r.t MLO
     * rebased on latest ToT
     * added "wifi:" tag in commit title.
---

 include/linux/ieee80211.h    |  33 +++---
 include/net/cfg80211.h       | 111 ++++++++++++++++++--
 include/net/regulatory.h     |   2 +
 include/uapi/linux/nl80211.h |  61 +++++++++++
 net/mac80211/cfg.c           |  41 ++++++++
 net/mac80211/ieee80211_i.h   |   3 +
 net/mac80211/mlme.c          |  14 ++-
 net/mac80211/scan.c          |  15 ++-
 net/mac80211/util.c          |  40 ++++++-
 net/wireless/ap.c            |   2 +
 net/wireless/nl80211.c       | 196 ++++++++++++++++++++++++++++++-----
 net/wireless/nl80211.h       |   3 +-
 net/wireless/pmsr.c          |   8 +-
 net/wireless/rdev-ops.h      |  21 ++++
 net/wireless/reg.c           |  61 +++++++++--
 net/wireless/sme.c           |   2 +
 net/wireless/trace.h         |  34 ++++++
 net/wireless/util.c          |  87 ++++++++++++++++
 18 files changed, 671 insertions(+), 63 deletions(-)


base-commit: 4eca8cbf7ba83c3291b5841905ce64584036b1ff
-- 
2.17.1

