Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D32378A581
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 08:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjH1GKd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 02:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjH1GKG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 02:10:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29E5124
        for <linux-wireless@vger.kernel.org>; Sun, 27 Aug 2023 23:10:02 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37S5o78E028879;
        Mon, 28 Aug 2023 06:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bXqAEnmAJ+SzSoAAwlJv7RmfyCrm1SX+TInmKBPDo3Q=;
 b=MTEFNISM+uqgIRxyNOaQr8t8Pp/7+Yn/Apq5Ah0l78lU7gE6Bf2It6r3U16VfhWPiVQy
 1uIJlXTRFSKQBRzAwiWaWeW8HgxO4TX8IsZ5ZSeq9xdCU9pMFWBYA1wP8lVcbioLV2/x
 TnVzCkihlvg0w7ld3MNfAk9y+W6owzGsrFaslWn3xgQBHnQqZUrQ3rU+GxqAPrHkgGtO
 s/GjoTyIDenHJCnlT5IU+d4SfF70ACLujQecutROZ+i3NRdCFDM1EipdtkNVdJhMLy75
 4VbzkAot1H+ewwDr3qRSkIuX3sFdzfvsYKP0LlsmGxmBaeo4zsyB2nOFMSFxn0k5+6LU pw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq9g1jp9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 06:09:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37S69qEw019038
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 06:09:52 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 27 Aug
 2023 23:09:50 -0700
Message-ID: <5376cd01-ab3e-416f-ea73-649c82e3bc40@quicinc.com>
Date:   Mon, 28 Aug 2023 14:09:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] wifi: ath12k: enable 320 MHz bandwidth for 6 GHz band
 in EHT PHY capbility for WCN7850
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230824025432.19406-1-quic_wgong@quicinc.com>
 <169295002356.1753110.7150166655358699685.kvalo@kernel.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <169295002356.1753110.7150166655358699685.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WgQZn7PTEhJjL1UTe225nSAJ96Fz_aGo
X-Proofpoint-GUID: WgQZn7PTEhJjL1UTe225nSAJ96Fz_aGo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_03,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308280055
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/25/2023 3:53 PM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> wrote:
>
>> 320 MHz bandwidth is reported only for single PHY mode for WCN7850, get it
>> from WMI_HOST_HW_MODE_SINGLE ath12k_wmi_caps_ext_params and report it for
>> 6 GHz band.
>>
>> After this patch, "iw list" show 320MHz support for WCN7850:
>> EHT Iftypes: managed
>>          EHT PHY Capabilities: (0xe26f090010768800):
>>                  320MHz in 6GHz Supported
>>          EHT bw=320 MHz, max NSS for MCS 8-9: Rx=0, Tx=0
>>          EHT bw=320 MHz, max NSS for MCS 10-11: Rx=0, Tx=0
>>          EHT bw=320 MHz, max NSS for MCS 12-13: Rx=0, Tx=0
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>>
>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> New warning:
>
> drivers/net/wireless/ath/ath12k/wmi.c:4199:69: warning: restricted __le32 degrades to integer
>
> Remember to ALWAYS run ath12k-check.
>
> Patch set to Changes Requested.

I found ath12k-check output many logs, about 5000 lines.

And ath12k-check only has one item in CHECKPATCH_IGNORE, it does not 
have the other items which

existed in ath10k-check/ath11k-check, so ath12k-check output many info

"struct  should normally be const"/"networking block comments don't use 
an empty /* line, use /* Comment..."/.

Also it print many "note: in included file ..." by sparse.


May I change ath12k-check with diff below and use "ath12k-check | grep 
-v "note: in included file"" for the patch check?

wgong@wgong-Latitude-E6430:~/opensource/kernel/ath$ ./ath12k-check --version
/home/wgong/opensource/kernel/ath/./ath12k-check:32: DeprecationWarning: 
The distutils package is deprecated and slated for removal in Python 
3.12. Use setuptools or check PEP 632 for potential alternatives
   import distutils.spawn
ath12k-check (md5sum 194c6d6c4bad47f9780fe22541f2f68c)

gcc:            gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
sparse:         0.6.4 (Ubuntu: 0.6.4-2)
checkpatch.pl:  Version: 0.32 (md5sum b169dcb45a7f32bd19b128e08288e9cc)
gtags:          gtags (Global) 6.6.7

wgong@wgong-Latitude-E6430:~/opensource/kernel/ath$ ./ath12k-check | 
grep -v "note: in included file"
/home/wgong/opensource/kernel/ath/./ath12k-check:32: DeprecationWarning: 
The distutils package is deprecated and slated for removal in Python 
3.12. Use setuptools or check PEP 632 for potential alternatives
   import distutils.spawn
drivers/net/wireless/ath/ath12k/wmi.c: In function 
'ath12k_wmi_tlv_mac_phy_caps_ext_parse':
drivers/net/wireless/ath/ath12k/wmi.c:4197:69: warning: restricted 
__le32 degrades to integer
drivers/net/wireless/ath/ath12k/dp_rx.c:2110: space required after that 
close brace '}'

diff --git a/tools/scripts/ath12k/ath12k-check 
b/tools/scripts/ath12k/ath12k-check
index 7112fd9..3035b34 100755
--- a/tools/scripts/ath12k/ath12k-check
+++ b/tools/scripts/ath12k/ath12k-check
@@ -41,10 +41,48 @@ FILTER_REGEXP = r'/ath'

  IGNORE_FILES = []

-CHECKPATCH_IGNORE = [
-    # some find extra parentheses helpful so ignore the warnings
-    'UNNECESSARY_PARENTHESES',
-]
+CHECKPATCH_IGNORE = ['MSLEEP',
+                     'USLEEP_RANGE',
+                     'PRINTK_WITHOUT_KERN_LEVEL',
+
+                     # ath10k does not follow networking comment style
+                     'NETWORKING_BLOCK_COMMENT_STYLE',
+
+                     'LINUX_VERSION_CODE',
+                     'COMPLEX_MACRO',
+                     'PREFER_DEV_LEVEL',
+                     'PREFER_PR_LEVEL',
+                     'COMPARISON_TO_NULL',
+                     'BIT_MACRO',
+                     'CONSTANT_COMPARISON',
+                     'MACRO_WITH_FLOW_CONTROL',
+
+                     # Spams hundreds of lines useless 'struct should
+                     # normally be const' warnings, maybe a bug in
+                     # checkpatch?
+                     'CONST_STRUCT',
+
+                     # TODO: look like valid warnings, investigate
+                     'MACRO_ARG_REUSE',
+                     'OPEN_ENDED_LINE',
+                     'FUNCTION_ARGUMENTS',
+                     'CONFIG_DESCRIPTION',
+                     'ASSIGNMENT_CONTINUATIONS',
+                     'UNNECESSARY_PARENTHESES',
+
+                     # Not sure if these really useful warnings,
+                     # disable for now.
+                     'MACRO_ARG_PRECEDENCE',
+
+                     'BOOL_MEMBER',
+
+                     # TODO: ath11k uses volatile for now, fix it
+                     'VOLATILE',
+
+                     # TODO: document all DT usage in ath11k
+                     'UNDOCUMENTED_DT_STRING',
+                     ]
+

  CHECKPATCH_OPTS = ['--strict', '-q', '--terse', '--no-summary',
                     '--max-line-length=90', '--show-types']

>
