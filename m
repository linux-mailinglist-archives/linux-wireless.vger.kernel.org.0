Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8482462CAD
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 07:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhK3GXx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 01:23:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24242 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229566AbhK3GXw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 01:23:52 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AU5n2jX000953;
        Tue, 30 Nov 2021 06:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=eeD+2BKuVcR4ChKuHnDoXSBb3QuOiJcSrxp1A3bP634=;
 b=MdyDEgiBQWjFupErwyYYbH4UQvx/O6+cU2sIuoJNMDWSQ4QTZB/Q2bPUxuq92AxUzpI8
 EZO6lMXbxdg4qxP29YY9FW+Myj5c6DKuwHPLzyyI9xZFGOYPfSgjZx7a0ZY3MZMArUIv
 5odkOi2bYFA9p44FCkuQF6k+ziKJ6EkF31NK+phGsmzuMMTo8Fdy8yRNWtasavejJnNi
 XWAIrcT3+q3MGRmu85eajFTJlGWyD2tRGfPupKBUxQb6QA8xg4HTK2p1i3ujQSEwIwJ8
 6QXpv4W+RwOU76Zm0i6DUTkxb06oyLw1O0tppKhNa5TP2xmOQkSLnW2ceKJ66y3zVoqP HQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmrt7yduk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 06:20:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AU6FjFA152856;
        Tue, 30 Nov 2021 06:20:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 3ck9sxvw2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 06:20:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUSI/B3BxmWFqp5JOILnwkvZpDmqAaIL1Uyh5FHNgjQJpL2zZwWVR/QiHL2DucZwMVHWa++zFRYKubFEMHALif912m/WcOsaB8NG534hLLlH7OD1lk90psgiAcW2YuqWoOJIHGLoqlPvuK1Zva3YREFysF8+ZrfcuUPrrDWCzSAVvTyIbf2vyqK2I5c4cUaaKkqu8ddJ0p5WOFjHMwl9wCklYAN1IiwasPH+lqhCxAtKp1OVdFiTs+XVzsp8MIU20BeaaSckjvzQEY0EVH7f4Cxhlh7SvlKjN3jJsl9Ew5j4ICJxU0IGAbCmc0FLpvG+MtBYirivQCPi4B4jRwjJPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeD+2BKuVcR4ChKuHnDoXSBb3QuOiJcSrxp1A3bP634=;
 b=Al9KzJmvxEXgu5WSqvDirCUbd1anKUIwOHUMw0nZgInP0ZRRpmEraJ990RVWTgq+T31Qv03Of3wnKCkWF3rCtowNhMTr3yPT2N5GB2Zs41zhwd0zIIdDXQTvGZG4LDg+asSxakp7AgCZU6flDfWYboqUTVoYf7VHhvA/tUwp+bY5y2fAZCJ5awYLbT1D1uyUK569dHsvZDJiWcEsGBmMpo6nX7AzZ3hTabaxbhiPdzVZu9ZkgFWfwcJ0su0o7adsA5wtNE9O8lXdTeCQtaz02ZmS0t54OtUh2UIwB0H170l4gL5cdXlBZ0Qlo7C3v/q46iiFxi6NXN8bRSWjs2FNKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeD+2BKuVcR4ChKuHnDoXSBb3QuOiJcSrxp1A3bP634=;
 b=POIFw0scNVNfm9zmCmeueQ4DKWby8S7EodcZB3WbureYCQUXsIHTD6m+QNJFGjQBuS0cqZz88Pq/4kg/tglEqp+FivfswEgAUyPM5h7H8V6MjIrZBSowP5a2j6fhGa+Q1nrdD4SJwCQRwa2yXG+v10dg/xtN/QjKi/hcs3p5vQM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2317.namprd10.prod.outlook.com
 (2603:10b6:301:35::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 30 Nov
 2021 06:20:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 06:20:28 +0000
Date:   Tue, 30 Nov 2021 09:20:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     emmanuel.grumbach@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] iwlwifi: integrate with iwlmei
Message-ID: <20211130062017.GA20271@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0013.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 06:20:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdd1c4f4-c50a-446c-037b-08d9b3c980e1
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2317:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23171661B363C3C29488DAB58E679@MWHPR1001MB2317.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5C5yMLPEAnhT8Z6Oy6eE7Uh32qZEL7L8GLYHScd1Z6FBdiePK8cQvcNn/Psvz4gQGkvQt7EONkMWy4tpOFMtM0vsiHGKTO+ESokE+0A3V/MGQqisys/r7KfPPoES0uImIlQz7WFNjoBL6E//gE+GSyCgZQd1QmTtqpcY0J8tSbKY5YD4oeyUaNU6dEFnAoQ61FLUICEXPqxm+RAvlURBkwJKCrAAfgVZDEWhfHZbAzyiYqMs8y2qUTRRT08Q2VD13w3XNlmYpQ8pZD3MC/7V4SqSNRHDeJMl7fL4X92T3UPTmW22YR3aiO29K/eT1zTyu4605NyG91BqUcPrSoSj7VWIDAMp8Uars1ibrT5BEIdXdHDLVDDpZj6s1TQFFPEIaKD1SxFtSLCma2F/lMocDfQUBbSsivt+47AdlJl54VPHApBq3WSJIdmRUAYcSkD+QYnQu/Fqd8LBKobDAGDI5k/6rKqw5MXr/RB7P8a7hYFNjb9jC40hUfvkrARgHGi40usiCRe/EnaJwZMKKHKxGp7HFzBANN2Rxp9WB7RvJrWCGC170g1k0zn8tY1YFFXQMQNbGetRrbldiPH6EEEqjWANqg0Iz7S6OOCfqJmZu2RcQ1qdlPVbcjGVEb8MYaSSDg5tLYXEztp47TUPQ3f8BEGeS6W97xGKVUtMvidfcrNmktaFyQTYTJCmm+gWmEqu6e1V9FreZI9weDH7ZyiPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(4326008)(9686003)(6666004)(8676002)(38350700002)(8936002)(2906002)(6916009)(66476007)(33656002)(5660300002)(6496006)(83380400001)(1076003)(52116002)(508600001)(66556008)(26005)(86362001)(956004)(66946007)(33716001)(9576002)(38100700002)(186003)(44832011)(55016003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WYNNSfHus4xpnwd8pbmRZb01qNdoq8I2LwX1XgnEktT+WLYQ673k5Rr5jMqk?=
 =?us-ascii?Q?0ykhd3lk7qjl40BKTKezX7y5EzCSL6eh5zf263WkrdQkKCMUKUklvHtmyEwd?=
 =?us-ascii?Q?VdEzjOEmf6kbQlz3f2TxS7NYWuwZhAUHJGBETvj/cpPU5YKcriHK8UVBfD5t?=
 =?us-ascii?Q?K4LT8hNInaTgrJ5RuKI1ZlHwaORLnDwl29/IvbdPCTYASBJyrg92yf/N2I19?=
 =?us-ascii?Q?xuSuu7mc1CRFSKQy1qDeA1YgFSPKwpS0T8hf0+mtkExI8CPNfl4bf99kvAlU?=
 =?us-ascii?Q?xdQMatbNUXd+9K/TjcY50d69RC7uzmSg9KccPSSkFzL1m91J7skKmuITBJiR?=
 =?us-ascii?Q?ZbLaidwXpUPQx0RDvu8EAExHW0UUtGEZ/hs9/2Y0xJKCZVOH9aQ65ofRuDP6?=
 =?us-ascii?Q?jfs0eZimxavPq36rJpJu0c2XcJlt4un/MyFy1il0LIoSYC93GP5Ik2IwqkIj?=
 =?us-ascii?Q?e5APvo/hX7yU3JMt3ltUh0yHoq6mq7qjxj30bKBz3rwE8552s5f3b4zZG3BU?=
 =?us-ascii?Q?ZkUEPxVBYv+O6WLZfEwerqj0GQsX7m4avIpiKSBdRfz7h+qXv6xvu5XbTRC1?=
 =?us-ascii?Q?bZ1RM8x6CyCXJ+C0q+pt73htyWBlW1WVjGqpoGQhRvuyevDemq9wcVl4QJFk?=
 =?us-ascii?Q?iK0F0ZhPsKKege1j/nJjAIvp8a/fNkDZJZnz0EWnCR23o67hqM3AIIwFxLj7?=
 =?us-ascii?Q?cSKRaxCGRbg5WcK4+mGVT6Z68zGuKCDhQ8GHkCKXiMmfYnqudyy/WutEh9+U?=
 =?us-ascii?Q?qbI23Sy0bGYB2SWdUW/XtKD+gTzddYlUG4bp6cuIrUzRIBOpbAq29O4x58lB?=
 =?us-ascii?Q?COKrxwegnF7rWJ/nsORtWTDG1aQ8WImhRc/XcfGCWK+cjnnxnnYDMj4QgwjC?=
 =?us-ascii?Q?asfmWs/BUpnmgjo/TBReRTP/A7v4Wg7cSv/kDEpnB2h2UEpsugbdIk9NtVCs?=
 =?us-ascii?Q?t5m1OOavRljEffhxX/6uMjVSKkqkB9pIra4N1GerC36DjEp12hv0wJHZXj5o?=
 =?us-ascii?Q?m7tyJRsNKOO0OdH9EQgW7jI0V+4vdu2R4Wn5GqHE4wHrRcoWEUl920yWva2f?=
 =?us-ascii?Q?0XQNPRrynag3vRugUKqGihniI0iIc9tvg3+TOgvLTW671h+aMNmtCqAHW2qv?=
 =?us-ascii?Q?gNDZMVNEXkiSeyEBkTAsd2GT7JFF7tKUkvEuKWgMhiH4LASxJvpqcqv1SBpi?=
 =?us-ascii?Q?XwSsHKBQev6wuPpLB84gDFYYWuO+OU0bdluCBhIddzOydHUt4Xp1bBgwWI5q?=
 =?us-ascii?Q?Z88cmMfnVMX41Sx5SXDoNBJibIzk15HHVv2ZUWvHoiV4HvKUdsodIqI9aL3H?=
 =?us-ascii?Q?ITjQzwfvW8tyB3eijml6gNFUzPn5unQl1kzVcGYjUvfWYL2K4YMdtfewK6he?=
 =?us-ascii?Q?dVOg1nDwWsnWJfZ8wGcc/GtcbAJV1ksvn+B1zWzzwXHUVqbr94wlxRobVlcH?=
 =?us-ascii?Q?sslNKxAuroScInEoetcdeGOe24WFZp8ZQt5gzKy5U2asU6vL89kTakkOoAb0?=
 =?us-ascii?Q?jgI60fiiHjghaclyKYPymMqJ+rSAAuGoXuUOQXSRPLbW766utZ1DffOag4tZ?=
 =?us-ascii?Q?HmJkBUO+OJmsPnLkGh8XxVnlBpWUqhp0Zz1H8BlR9YvPVhzHj/WmWniO+OP/?=
 =?us-ascii?Q?zLOScI86rjgP1NMJOzkh3yvof31RuBlylcmy/nO6kgk4sRDa3ga6Nl9yrLK5?=
 =?us-ascii?Q?OsDFQ9JuyTdpRUhQtFbrZNQph3E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd1c4f4-c50a-446c-037b-08d9b3c980e1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 06:20:28.3153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SxxwtGxyDlMcg9r85xD6ZmokGtLyQo+7Bvjd9yw4x2QFuYPzuwZI1/v8nbYSjP+bh/gVQIDq/PukgAV2DbLeWCMVbbm7dHR1ZgoEzmGwfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2317
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=917 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111300035
X-Proofpoint-ORIG-GUID: N4ise4MboEt6N5bVRW0-fSlDmA1qRO1g
X-Proofpoint-GUID: N4ise4MboEt6N5bVRW0-fSlDmA1qRO1g
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Emmanuel Grumbach,

The patch 6d19a5eba5cd: "iwlwifi: integrate with iwlmei" from Nov 12,
2021, leads to the following Smatch static checker warning:

	drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:2640 iwl_mvm_start_ap_ibss()
	error: NULL dereference inside function '__iwl_mvm_mac_set_key()'

drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
    2559 static int iwl_mvm_start_ap_ibss(struct ieee80211_hw *hw,
    2560                                  struct ieee80211_vif *vif)
    2561 {
    2562         struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
    2563         struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
    2564         int ret, i;
    2565 
    2566         mutex_lock(&mvm->mutex);
    2567 
    2568         /* Send the beacon template */
    2569         ret = iwl_mvm_mac_ctxt_beacon_changed(mvm, vif);
    2570         if (ret)
    2571                 goto out_unlock;
    2572 
    2573         /*
    2574          * Re-calculate the tsf id, as the leader-follower relations depend on
    2575          * the beacon interval, which was not known when the AP interface
    2576          * was added.
    2577          */
    2578         if (vif->type == NL80211_IFTYPE_AP)
    2579                 iwl_mvm_mac_ctxt_recalc_tsf_id(mvm, vif);
    2580 
    2581         mvmvif->ap_assoc_sta_count = 0;
    2582 
    2583         /* Add the mac context */
    2584         ret = iwl_mvm_mac_ctxt_add(mvm, vif);
    2585         if (ret)
    2586                 goto out_unlock;
    2587 
    2588         /* Perform the binding */
    2589         ret = iwl_mvm_binding_add_vif(mvm, vif);
    2590         if (ret)
    2591                 goto out_remove;
    2592 
    2593         /*
    2594          * This is not very nice, but the simplest:
    2595          * For older FWs adding the mcast sta before the bcast station may
    2596          * cause assert 0x2b00.
    2597          * This is fixed in later FW so make the order of removal depend on
    2598          * the TLV
    2599          */
    2600         if (fw_has_api(&mvm->fw->ucode_capa, IWL_UCODE_TLV_API_STA_TYPE)) {
    2601                 ret = iwl_mvm_add_mcast_sta(mvm, vif);
    2602                 if (ret)
    2603                         goto out_unbind;
    2604                 /*
    2605                  * Send the bcast station. At this stage the TBTT and DTIM time
    2606                  * events are added and applied to the scheduler
    2607                  */
    2608                 ret = iwl_mvm_send_add_bcast_sta(mvm, vif);
    2609                 if (ret) {
    2610                         iwl_mvm_rm_mcast_sta(mvm, vif);
    2611                         goto out_unbind;
    2612                 }
    2613         } else {
    2614                 /*
    2615                  * Send the bcast station. At this stage the TBTT and DTIM time
    2616                  * events are added and applied to the scheduler
    2617                  */
    2618                 ret = iwl_mvm_send_add_bcast_sta(mvm, vif);
    2619                 if (ret)
    2620                         goto out_unbind;
    2621                 ret = iwl_mvm_add_mcast_sta(mvm, vif);
    2622                 if (ret) {
    2623                         iwl_mvm_send_rm_bcast_sta(mvm, vif);
    2624                         goto out_unbind;
    2625                 }
    2626         }
    2627 
    2628         /* must be set before quota calculations */
    2629         mvmvif->ap_ibss_active = true;
    2630 
    2631         /* send all the early keys to the device now */
    2632         for (i = 0; i < ARRAY_SIZE(mvmvif->ap_early_keys); i++) {
    2633                 struct ieee80211_key_conf *key = mvmvif->ap_early_keys[i];
    2634 
    2635                 if (!key)
    2636                         continue;
    2637 
    2638                 mvmvif->ap_early_keys[i] = NULL;
    2639 
--> 2640                 ret = __iwl_mvm_mac_set_key(hw, SET_KEY, vif, NULL, key);
                                                                       ^^^^
This passes a NULL "sta" and now it will always crash.  (Possibly it
used to sometimes crash before your patch but the static checker does
not mind about that.  :P).

    2641                 if (ret)
    2642                         goto out_quota_failed;
    2643         }
    2644 
    2645         if (vif->type == NL80211_IFTYPE_AP && !vif->p2p) {
    2646                 iwl_mvm_vif_set_low_latency(mvmvif, true,
    2647                                             LOW_LATENCY_VIF_TYPE);
    2648                 iwl_mvm_send_low_latency_cmd(mvm, true, mvmvif->id);
    2649         }
    2650 
    2651         /* power updated needs to be done before quotas */
    2652         iwl_mvm_power_update_mac(mvm);
    2653 
    2654         ret = iwl_mvm_update_quotas(mvm, false, NULL);
    2655         if (ret)
    2656                 goto out_quota_failed;
    2657 
    2658         /* Need to update the P2P Device MAC (only GO, IBSS is single vif) */
    2659         if (vif->p2p && mvm->p2p_device_vif)
    2660                 iwl_mvm_mac_ctxt_changed(mvm, mvm->p2p_device_vif, false, NULL);
    2661 
    2662         iwl_mvm_bt_coex_vif_change(mvm);
    2663 
    2664         /* we don't support TDLS during DCM */
    2665         if (iwl_mvm_phy_ctx_count(mvm) > 1)
    2666                 iwl_mvm_teardown_tdls_peers(mvm);
    2667 
    2668         iwl_mvm_ftm_restart_responder(mvm, vif);
    2669 
    2670         goto out_unlock;
    2671 
    2672 out_quota_failed:
    2673         iwl_mvm_power_update_mac(mvm);
    2674         mvmvif->ap_ibss_active = false;
    2675         iwl_mvm_send_rm_bcast_sta(mvm, vif);
    2676         iwl_mvm_rm_mcast_sta(mvm, vif);
    2677 out_unbind:
    2678         iwl_mvm_binding_remove_vif(mvm, vif);
    2679 out_remove:
    2680         iwl_mvm_mac_ctxt_remove(mvm, vif);
    2681 out_unlock:
    2682         mutex_unlock(&mvm->mutex);
    2683         return ret;
    2684 }

regards,
dan carpenter
