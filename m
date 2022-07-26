Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C075F5814D6
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jul 2022 16:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbiGZOLI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jul 2022 10:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239205AbiGZOLF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Jul 2022 10:11:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95CC65EB
        for <linux-wireless@vger.kernel.org>; Tue, 26 Jul 2022 07:11:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QE7GNB020787;
        Tue, 26 Jul 2022 14:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=FZpGIyTWVxEub2Cnv7+n2jWKvNWeDgmhxQe9SnyxrdY=;
 b=k5QAqUYxEQ95L3AaCmIljpkZ3u8qfwVW8yeGEi8dTwsYIIkAo8icLqH+YYitIj+E28Gr
 T4T4We0RWrVRGMWYYuc5KriwYUoAI+ArhGnHxEmaJwcserwFsh9pxbGhG1/9fK/EutHH
 4OkL3z1q+HVsmfrkb/EgJuwEwAqJLrta7nam7dUErxrXszgLcnRPokSJr+JIFOejdteR
 xwl/4CCpn8Xf6BCGioHXpPlIM7ZytemV5pcFcbb7sMNsf8C8V7EHVYUDm2ceccbkHGNk
 O3xi/ycXJ75nhyYUl2WW9weUmfoXliY9WJlBGCm+wKistWMcA127pjMFGJK3kWtnrhaC Sg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hspmj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 14:11:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26QCo2XI006238;
        Tue, 26 Jul 2022 14:10:59 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh65bhvhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 14:10:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHUF8oPSk7+fRFyqtM5TbFmJfb3yGQBLuVuXuQzogJV4XseCrWuDeirtf5iR8K7xlJO7vEeZi/PzDsybHvxPrnTuzK/XwlueltI0Iz3XDoW+FM9m0BAn1NU1ucOf1NbkqJnm6XkbMvKn01JwWr+O7dJ5HCv2wopxXRWdsIYTiTgFsihiT7FmKM8Vf9v1NnNDC1NyWabUKpEPfi7C0eHMHFbObGZXEYxHCHVnPdNk6lIIMWLw95CEvagHLnpuUQ2tocX6bgQ3veq7MLdgh91OFqeL6B3voKvufuTIqbCnJt1kyTq7WYuyjGQgkskGLySYzStZ0aX/scwC1EcYj7XyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZpGIyTWVxEub2Cnv7+n2jWKvNWeDgmhxQe9SnyxrdY=;
 b=eQrV0WpMTlf4X8diADg0hSoKSsiF8VszHM9nIwpEEvBNrkt2ShAiMQJlJdV5FSb5YTLZ7iobeK6s4jKqA5ELjTeZVIeN2CzpPa1ABj5tyS5hGxMI4YlwUF8OJXPAuC+/TEFoVCmT++ll4V9kXStvLQSXFG1TaJx4EPIGodKMC5cOW7zH6EEwIORmee4UFmJYhGo++huoG1vtUP4TxBpoVfDmp8q2ygKYGpKY+9rc8dvlWOGxspsYoFTzTjxBnrVcR/i9WcZE+j02bRT5EF4PotPyhQHvFzAGU3GxrACr8CDcvKZkWCZJkuPPRWLJ2wJtNRpjUEqal5lwAJhPvAXOSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZpGIyTWVxEub2Cnv7+n2jWKvNWeDgmhxQe9SnyxrdY=;
 b=WQOXbA83JwNUHJjSSJwQsCjNWn1BlqDIirrMRCLvU1jBGrFLEhp+CyAxIHPFM+2JWhIMgWoO2neRd5QD8/Tc2rZKiycAlOXuRI2Qa+VCMt6A7ViBRXn6Wb+XwofrHCSbWJErQ4eDGkJYwf6511fsqr2U4ar0rSB2nzb4sh0PHLc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1271.namprd10.prod.outlook.com
 (2603:10b6:910:4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Tue, 26 Jul
 2022 14:10:58 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 14:10:58 +0000
Date:   Tue, 26 Jul 2022 17:10:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     johannes.berg@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] wifi: nl80211/mac80211: clarify link ID in control port
 TX
Message-ID: <Yt/16E0ufa0D0Ziq@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0071.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::22) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2eac567c-dbf3-4c81-2fff-08da6f10a946
X-MS-TrafficTypeDiagnostic: CY4PR10MB1271:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qsjc+CEJ9JE9Vt/WFNXQL7EMFG6LyC+ru/c/psVwIdYUVlhGzfIdwxZguf655FNDHskW8ErpHkhzrzRnIQzEqbxBbc0je/DFDHJ80LFKpnxKgsWU0CWFMxAvGH73/KW32mlltoEy5gz1c0i/nvAV+YUMpuGHPOE/oz5a+r9PUJQkxuljSgYShiQbLmV8bpgQmcu53vVZhG39IyJfaKF6NFdQbIcSF+sSSC1SYEwCVo+1wE/2udwPlYjUkKWuHOBocngiGUisUuD8JgjQqYvt2OI/enFTziA5xddLEO5Cy4QFkOMx0UFbyG6ejM1iLF3ExZMHW3PQp/4+yuQJ4k0KCALVRxkNjrvnvk8mz4eVT6OfkIII3NWNRq2/CefbZ2kr+w+FS5P0RBguEDjZN/xCxVopv3X+A0fAXlHEVmdswsUpSsL8UVb1N2vX67atcX2YYwOX5+5UmAMCUXIXCEdTb9/13sGkXO3kKI10qyCguSUX5dA2p38QIagdrzqsv5Jh5CwVwAIXgZo8o9goPuKgV8L58hHg4pIWWq+AAlcLh3lNxbFsz+d1YDsb8cqPbzQf5/jsryh2deQL0fb+4ZDA9r7/S9JUydbEBGoZ52bQduCoB9WvCWjI/M2HgayQvMW6YubZeQjyHyLPDMyXfCHp0Ej5oeQBtDfOT69VX25yH4BUMN1h4PbdhYkMWQ7NHbTMP0XPN6GlYNl0Z2Tfa9HmXfC1KCm1HtnM17rkzZrKHQ9fJe6YtjS3z28Eu2ERJuIeowgiVRXrGJGD7xlpo7ukjlTNaXew2qRrhdrXNG/cS632ZoNT6H4eFABpafMmnSv2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(39860400002)(376002)(396003)(346002)(366004)(38350700002)(83380400001)(6666004)(2906002)(38100700002)(86362001)(4326008)(26005)(66476007)(66946007)(33716001)(8676002)(66556008)(6916009)(41300700001)(316002)(478600001)(8936002)(52116002)(9686003)(6512007)(6506007)(44832011)(186003)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4XGUHtkF+749nZ6S2TafXY3D0gqe8VIsaQ414haVSsWY4GsZUi+thBJloAVp?=
 =?us-ascii?Q?X4SSAaU4sF0XA2hMlem+tZYiT949yMqiq2EZUWBR8cs1lk5+l5sZSbb8xMwO?=
 =?us-ascii?Q?qD7TcO3LUTRA2WjgRUQJcaJkWyPZzQI+70OjyG8/Cp2mQ/E4POelVjalUrZE?=
 =?us-ascii?Q?BFkW+ZHcYc1lAWn97grPrkHuSwgmJa8a+tmkMZSDRzN+JDUZX+pm1NFPrYBd?=
 =?us-ascii?Q?CZawGSnnCGmQvrLB2Xob8XzB4Jt3QdIQpuu41+/HxwMn2Eok9GIuY8OAY03E?=
 =?us-ascii?Q?YzWr0KbHApXDDlWe9H6AoV6gESNkX+wVTd17/WtnJKFmQhRlj4iK9NPWql2B?=
 =?us-ascii?Q?BO0M1mQN5LBCah/qq6yLkbJN3nZ6Jprjsy72oUyd+Byp8zqxCaX/6HHBv7R2?=
 =?us-ascii?Q?vJDn83l1x9rFaTlU+Z52qYITSCG2X+8fsVXL0prPZ6oCqiKFVv8ZTXDrhhMe?=
 =?us-ascii?Q?jeghCGhTxky6jbLQOkxbd+JLoZZt2wddaxeOJkoPho0YpLoDeywQZtxidPWP?=
 =?us-ascii?Q?6eGRuKk9vjGxFnHZDtuhIg+RO3rkQHElfxoxDlP1md5aKXSjwsLsaeVUVMjq?=
 =?us-ascii?Q?dS5bFcCtGlSdsO21G/Kw+QCBf+cjMFflZmbDe1mTzpWQi/saEF4fFXxEQhXD?=
 =?us-ascii?Q?4mUwtx7OicLAJ7aaOtTxmtB2Y+eCiRzf4Bb+ZTUMq5Ja6D+6f7Q4SGzuCNJx?=
 =?us-ascii?Q?CTk7wgD5g7I84LSH4Mo8djh5Xymnmv6lkbx/MAdERULXvH8R1V/3RFOSbt6O?=
 =?us-ascii?Q?FQoNjlBJFCw8gCVV5X87OBaa2Se5rznvUWr2gi4TR/Bpl8U4JimFqeic9th1?=
 =?us-ascii?Q?15RhBDez8Ok1bg3kTHIu5d1XB2vrr6vVzI8Y7hsZhTXm+96n7UtbLsa86/1k?=
 =?us-ascii?Q?cmR+1I1JM4TFo9u9goreIAZMleK9V8Sxx1+uDXTtzm/Mlj8pkFvz4oSRjyoj?=
 =?us-ascii?Q?SsTqM2HlPsiyVNH/I//9lLLMseds9ZPd3o1DNfWJwhglj3wlWZNy9sm5ey5b?=
 =?us-ascii?Q?y5POUSHYj/dckYKiuj8Q0kqZ2/jL2LT2r0OGUODthStJWb+276TIZTUgFut6?=
 =?us-ascii?Q?z6wRDPk5tZLlb38PCQ3OPUmV4APb4Fykjn8M2R7CPIR99gQlcE/mX0vgaDdN?=
 =?us-ascii?Q?EhU48s9MRhh9NRBGI5IqEH3XGadgh9feseOnTdWpWJN9LNWFEiwXMaO9HjOE?=
 =?us-ascii?Q?jzZ9BynPoXKx57Fo2CNivNDuVGa5k2ii3GyGcRYMHufkxQMZHNqCAenCbg/N?=
 =?us-ascii?Q?56gkBgAMpGCyz4ZkuRzIB8SvHYx2IBczjEA7wDuNTZyYJl2uTQ/PTy+yyvBg?=
 =?us-ascii?Q?bcZ2pZk4CTMz1m+gY5TLMuat6ub4T5EOzGigDGaj1Da6AxqIvf49XXoIZg3N?=
 =?us-ascii?Q?lQTZGJLmQTjKUGsu/vdWP+MFJmfo5wIHX+DJmNix39mF6k5NbM9EwjnYXAzl?=
 =?us-ascii?Q?Y+JMlr6PFjC7a4xyMX0DQBmyA2QwO0675e2/zkZn1rkyBQz9mv5iafPfRJNC?=
 =?us-ascii?Q?rYmlXRc4y8ixBiCjMTfOFTxyBq3vVYe2E0kW/jh3LOr5qLCqssG6j3081qAx?=
 =?us-ascii?Q?vH6m6HAfSpaPxStSld01ftZsslFE666G9T3F3GvbqRQYoDcOeSCfg5HPwTbI?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eac567c-dbf3-4c81-2fff-08da6f10a946
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 14:10:57.9267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsdsvtvcwFikglAXfG+S4GCrjisJ5/v6RlIWYXIfZaqclLTCbSES0sOa7bnLYF0iSWUde18yR2h8Gj9JKUJ14KAMrM2c3qT8jBo000OtjCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1271
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207260054
X-Proofpoint-ORIG-GUID: uwJx-s2i3badJW4e3htAmJuAG9Sn7v8R
X-Proofpoint-GUID: uwJx-s2i3badJW4e3htAmJuAG9Sn7v8R
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Johannes Berg,

The patch 9dd1953846c7: "wifi: nl80211/mac80211: clarify link ID in
control port TX" from Jul 19, 2022, leads to the following Smatch
static checker warning:

	net/mac80211/tx.c:5902 ieee80211_tx_control_port()
	error: potential NULL/IS_ERR bug 'sta'

net/mac80211/tx.c
    5807 int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
    5808                               const u8 *buf, size_t len,
    5809                               const u8 *dest, __be16 proto, bool unencrypted,
    5810                               int link_id, u64 *cookie)
    5811 {
    5812         struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
    5813         struct ieee80211_local *local = sdata->local;
    5814         struct sta_info *sta;
    5815         struct sk_buff *skb;
    5816         struct ethhdr *ehdr;
    5817         u32 ctrl_flags = 0;
    5818         u32 flags = 0;
    5819         int err;
    5820 
    5821         /* Only accept CONTROL_PORT_PROTOCOL configured in CONNECT/ASSOCIATE
    5822          * or Pre-Authentication
    5823          */
    5824         if (proto != sdata->control_port_protocol &&
    5825             proto != cpu_to_be16(ETH_P_PREAUTH))
    5826                 return -EINVAL;
    5827 
    5828         if (proto == sdata->control_port_protocol)
    5829                 ctrl_flags |= IEEE80211_TX_CTRL_PORT_CTRL_PROTO |
    5830                               IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP;
    5831 
    5832         if (unencrypted)
    5833                 flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT;
    5834 
    5835         if (cookie)
    5836                 ctrl_flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
    5837 
    5838         flags |= IEEE80211_TX_INTFL_NL80211_FRAME_TX;
    5839 
    5840         skb = dev_alloc_skb(local->hw.extra_tx_headroom +
    5841                             sizeof(struct ethhdr) + len);
    5842         if (!skb)
    5843                 return -ENOMEM;
    5844 
    5845         skb_reserve(skb, local->hw.extra_tx_headroom + sizeof(struct ethhdr));
    5846 
    5847         skb_put_data(skb, buf, len);
    5848 
    5849         ehdr = skb_push(skb, sizeof(struct ethhdr));
    5850         memcpy(ehdr->h_dest, dest, ETH_ALEN);
    5851 
    5852         /* we may override the SA for MLO STA later */
    5853         if (link_id < 0) {
    5854                 ctrl_flags |= u32_encode_bits(IEEE80211_LINK_UNSPECIFIED,
    5855                                               IEEE80211_TX_CTRL_MLO_LINK);
    5856                 memcpy(ehdr->h_source, sdata->vif.addr, ETH_ALEN);
    5857         } else {
    5858                 struct ieee80211_bss_conf *link_conf;
    5859 
    5860                 ctrl_flags |= u32_encode_bits(link_id,
    5861                                               IEEE80211_TX_CTRL_MLO_LINK);
    5862 
    5863                 rcu_read_lock();
    5864                 link_conf = rcu_dereference(sdata->vif.link_conf[link_id]);
    5865                 if (!link_conf) {
    5866                         dev_kfree_skb(skb);
    5867                         rcu_read_unlock();
    5868                         return -ENOLINK;
    5869                 }
    5870                 memcpy(ehdr->h_source, link_conf->addr, ETH_ALEN);
    5871                 rcu_read_unlock();
    5872         }
    5873 
    5874         ehdr->h_proto = proto;
    5875 
    5876         skb->dev = dev;
    5877         skb->protocol = proto;
    5878         skb_reset_network_header(skb);
    5879         skb_reset_mac_header(skb);
    5880 
    5881         /* update QoS header to prioritize control port frames if possible,
    5882          * priorization also happens for control port frames send over
    5883          * AF_PACKET
    5884          */
    5885         rcu_read_lock();
    5886         err = ieee80211_lookup_ra_sta(sdata, skb, &sta);

For sdata->vif.type == NL80211_IFTYPE_MESH_POINT then "sta" can be NULL.
Smatch doesn't know the value of sdata->vif.type at this point, and even
if it did, then it doesn't split the return states up with enough
granularity for that to make a difference.

    5887         if (err) {
    5888                 rcu_read_unlock();
    5889                 return err;
    5890         }
    5891 
    5892         if (!IS_ERR(sta)) {
    5893                 u16 queue = __ieee80211_select_queue(sdata, sta, skb);
    5894 
    5895                 skb_set_queue_mapping(skb, queue);
    5896                 skb_get_hash(skb);
    5897 
    5898                 /*
    5899                  * for MLO STA, the SA should be the AP MLD address, but
    5900                  * the link ID has been selected already
    5901                  */
--> 5902                 if (sta->sta.mlo)

Which Smatch complains about here.

    5903                         memcpy(ehdr->h_source, sdata->vif.addr, ETH_ALEN);
    5904         }
    5905         rcu_read_unlock();
    5906 
    5907         /* mutex lock is only needed for incrementing the cookie counter */
    5908         mutex_lock(&local->mtx);
    5909 
    5910         local_bh_disable();
    5911         __ieee80211_subif_start_xmit(skb, skb->dev, flags, ctrl_flags, cookie);
    5912         local_bh_enable();
    5913 
    5914         mutex_unlock(&local->mtx);
    5915 
    5916         return 0;
    5917 }

regards,
dan carpenter
