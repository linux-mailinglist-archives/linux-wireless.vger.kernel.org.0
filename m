Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1DE674302
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 20:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjASTkZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 14:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjASTkQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 14:40:16 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CA4A5FD
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 11:40:15 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JIne2s029552;
        Thu, 19 Jan 2023 19:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=y506F+B5T7AgN+/hZRmgqj3lp5X0E5QuTIjI7WdWEnE=;
 b=Ktia2fnoGtwC+tpRME6/hSCxUo3vNOyyVLTKRR8S1a/SJKJPDimKduV2sBjKlnqW1Vt7
 yQCiH6iqPhP9B6fiVrWP3xxfbGFHVy93qfmooUYAcbA3xrWp/nwJRAbNHsSYkEtywYMF
 E6k/AOvvJK8RO+/MAWZpvzPVTBAGUQkThcZrOmPT9l/xmiZ82Ppc2Z9JgKK3iS3MLyuH
 KezKdWkLsmots2QeCaSSGVA7wPdscgLrrdvX3o26P+Yq+ncgi8rCE0c2cP92Uv6g5Edn
 WVcVnOGpumXwkSokDRSJxHbeS7WiaQN9O6MeNtOgRFHJUCotfxKKH1jl9BWq7WSeAJGG JA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6vg02ckk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 19:40:12 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JJeBch016002
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 19:40:11 GMT
Received: from [10.110.52.22] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 11:40:11 -0800
Message-ID: <9ff00d88-6d12-8ee5-aa25-a5e82879d25c@quicinc.com>
Date:   Thu, 19 Jan 2023 11:40:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v7 2/3] nl80211: additional processing in
 NL80211_CMD_SET_BEACON
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20221109214720.6097-1-quic_alokad@quicinc.com>
 <20221109214720.6097-3-quic_alokad@quicinc.com>
 <0b42cfb9f0effce61b33c41ec9067b3747fade5c.camel@sipsolutions.net>
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <0b42cfb9f0effce61b33c41ec9067b3747fade5c.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _k7254rnLc9FgJzSBCV4Kt_YbZExAknS
X-Proofpoint-GUID: _k7254rnLc9FgJzSBCV4Kt_YbZExAknS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_13,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190164
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/18/2023 7:57 AM, Johannes Berg wrote:
> On Wed, 2022-11-09 at 13:47 -0800, Aloka Dixit wrote:
>> FILS discovery and unsolicited broadcast probe response transmissions
>> are configured as part of NL80211_CMD_START_AP, however both stop
>> after userspace uses the NL80211_CMD_SET_BEACON command as these
>> attributes are not processed in that command.
> 
> That seems odd. Why would that *stop*? Nothing in the driver should
> actually update it to _remove_ it during change_beacon()?
> > Are you sure you didn't mean to "just" say "however both cannot be
> updated as these attributes ..."?
> 
> johannes

FILS discovery has primary channel, center frequency in the frame format 
which should be changed depending on why the beacon changed. Hence the 
current design, at least ath11k, assumes that BSS_CHANGED_FILS_DISCOVERY 
and BSS_CHANGED_UNSOL_BCAST_PROBE_RESP "not being set", when beacon is 
changed, means disable these features.
What do you think?

Like you said, we still need this code to update these templates if 
provided by the userspace, e.g. in case of channel switch.

Should I send a follow-up with a different commit log?

Thanks.
