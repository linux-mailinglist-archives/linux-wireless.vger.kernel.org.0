Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDE84DE72A
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Mar 2022 10:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242539AbiCSJGt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Mar 2022 05:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiCSJGs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Mar 2022 05:06:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAC52E8CE4
        for <linux-wireless@vger.kernel.org>; Sat, 19 Mar 2022 02:05:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22J1um6r027688;
        Sat, 19 Mar 2022 09:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=fHpLAHH9zJNvUte14+2Owof+XKmQ80bT5xIrc81LWYs=;
 b=K5jgt6oCbZlNRxOmxgmGP6JF9eNMg10B4C+G74QfSS3rByfRx1ggdLlXTONpmj5zvQlx
 Lg1WXLm1Dg/d2ALh+P0OTgjwy2AdW5O8PwLc0S4+/SLHOdo44VOovNRJnODzNRjgbzUC
 Mz7pGOqe8TdQd0DXh0ZpRLzyNesx320eWjPJZkZHJSj5q7rpxs52RZ0QdZ5ioUhcvvjM
 kCyurJVMSafYk1iuL6gqGUuSrJ/2mLnXiJy74KYAgVcXb3mwJ4WMa+rl90oOCUbDDLRy
 8u1XPX0AL9yVt4NRHcH57uXPjfpIUVQArlKDjc926lVVb/SpyLH2DHgBfGKvjwFPTGaW pg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5y1rbk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 09:05:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22J92Akm009547;
        Sat, 19 Mar 2022 09:05:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by aserp3020.oracle.com with ESMTP id 3ew6yyjt60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 09:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxrUhQicCnr7zMlr/FA29fb+LJ4N8mMbby7s4XOSxHASSIWdilHi0n9qEejPj0bzjTlc+9NOvOTqjzrZgKgHyevv4zpI4eyFUWj8P6Z7ST4iY9nS1cu0KPJKgGENbrvFiJ4eTSNoer6u783s4GScSSN9uZ5VfesmvHxpyDFQwenUurI2eqsWvgd9N7B1V89pJb0UNAjhiRYds7jAmiNzvAIQ8y/c5Uv2K1GpMmK/dVe0yJAaVCVaw1PB2kBKyINAqBDM3Oj3/T//h+59YY/dZ5MGU84cKQdKMbLEVtXu5p7J1l8hA1O4vGIzpflSem/v/nlEYQ6gcTS8GhN3XRYJYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHpLAHH9zJNvUte14+2Owof+XKmQ80bT5xIrc81LWYs=;
 b=kPFVarOV1gPgYdMad0KiiMhjo1ZvcHLTrPxuiXN6wEkZKNpBD/V0JttNYkiQc9GlzgxXoi9n3QTVsqOqncrZ1VLYps7k+srvXfSuMdZCDOKZwv5TSHn9Sqkh06HadYH7XWuSk4VnKpPVMG3jjAYzf8TFO4c+KT1LF+5wuCpIk5EZmSFQxNSxTNVAR0vt+BXPVV28iXD4iHzKwdtDrCfPRrGhRNpHD+CHJ8+fVgKJ3ktWKsWXEa1bXLBxHerc5lIhlUdTswZ33uq+0ZoNRsr4iJc19H3vlhaPJf39DMT6WqbyqSk+LA93eExMyhWiman3tr9/BygVgbQzObvTcZ94rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHpLAHH9zJNvUte14+2Owof+XKmQ80bT5xIrc81LWYs=;
 b=yx4YIZAhgX0nuptFEza4uRTeMHcGiAfqfCW90+ZYqhWPITP7NcKXZT7yePdx00iZL7KfASQm9d2bLaykqch/ltiKaS5fxYe93eZTGb4TjWloSrBpehvPKs988TvTlXDHed/oVnzdmcyLrEt4wmXBPpKQrhzfv279HtoEdn7fGWQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB4221.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Sat, 19 Mar
 2022 09:05:16 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.019; Sat, 19 Mar 2022
 09:05:16 +0000
Date:   Sat, 19 Mar 2022 12:05:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     lorenzo@kernel.org
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] mt76: mt7915: introduce 802.11ax multi-bss support
Message-ID: <20220319090501.GA5051@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0191.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::10) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8e0845a-54da-4179-d4fc-08da09879526
X-MS-TrafficTypeDiagnostic: MN2PR10MB4221:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4221EEC94469C1B6D776A8F98E149@MN2PR10MB4221.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wVoJ2P0iDPR1xvaXzkympHbLYJ9X/zSJOU494MTo09Qt1/wOIE62UmsL+rvVn2XwGuplmVT6pxfCGb+zjfImWKl76qXRX1s83izeICmUAdXJPurOcGBSxAwXKRvKL9w26a8Km3sutMEosSoLIJVMF96BFsuYu8KQWNM4Sek9zGN7Sl8OecuWoSTdzM6p0t0yn74xVRpmjXwwV9JSS/fiEVtnnNjIoygFG6sVGK+xdslPSyBJBsMfVSXW4mmi0Ijqf6REakz2IudbIP/l36v4Q1FUhKzj8n2KATDnYo8UjZOaCt5B9Y0MZDbb0S5IKewDdFat41MgVvGi4zEzYP5uXsFR0vlT0+ybMJ268pJyS3L3XQHapT+emt+xbzK2SJvmTPYvKn12CJkA+opm7HxhT7zPTVNFnxYMkd5SslO6IJfk3UqLk5Qn8/JWEVuGSMwx6bKzOmFiu5bKAGFFA/VaP3gRcAwUqVyWuO6WncUZkXmvJ90FAqbuEX3B46K3LYWGnf4xj2azMh4swSHrOUBQQp8WD4HFItQSeQJwB4A0nzKWAZtMAhmoEBEtDv5v3RDOxvdMnLcUy6UUyQ550Ycne8gv6HpEBUzmuOckv/9WuC29CNDLomFkYd0aiw/ZV3hKxIPji7TDLXMiPkIsCuV7aPaKnna4Q0sJywRpcx9wMxRMwbXsUI1tRY+RVKhsxaidP19Cy79ZcupNZDxClLO5Uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8936002)(26005)(6486002)(86362001)(186003)(66476007)(508600001)(38350700002)(66556008)(66946007)(38100700002)(6666004)(4326008)(8676002)(9686003)(6512007)(44832011)(83380400001)(2906002)(52116002)(316002)(6506007)(1076003)(33656002)(33716001)(5660300002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GKPEuwD9MijeL/FOCkNYVXfc1KvZSnXmjqGWIXHuvw4K8tygANMA77sn1d1I?=
 =?us-ascii?Q?0Ep6E948QmKtlsuZKKo6oftWPD5mp6G76036j8rnTYLLUktXezaTLJRZ6k3t?=
 =?us-ascii?Q?wcRdJGpIPn+8uEg+gASAGrF6jQwn8m5WnBHzhsez0yvocQk8Iv9EFH4byOg1?=
 =?us-ascii?Q?ms7JsmdnTMnjScUJDDqi3U2bVQAEib4Hgwp8+3IozqLHFrUj45ClhChaT2bR?=
 =?us-ascii?Q?mHVbUFUW+so7nwEcJHiwtPr2Q8CtXCjIdGrwSbRUAzz4QV9/M5PhZcm+aahA?=
 =?us-ascii?Q?BmFRhidmOx45gQYAUk02CegFbf1jPJtKQv4/HN6NJ3EqVEea0F3NioZT247+?=
 =?us-ascii?Q?3c5lXrSCekvQsFQlcGkCPDVauxeloJ9V9nWNLBcY8zk/972gF8xfM51IHL/R?=
 =?us-ascii?Q?aAZS5YpQyHh5MxF1csr+Jm6EYZyE6bJX+mIpdeF62ETFvHLHdUuK0TaVKkXS?=
 =?us-ascii?Q?ZGmEp+EfT7GVVGwqMelHo5HqbeFgLkPUCuxnUlo/uv4yZjn6gxjH+td+6E0a?=
 =?us-ascii?Q?VcmjfR5ZOwxG28Vfx1bcvA3MKdwi2DOR0MeVt5AQ0H1/Sap+UwKkZfaEntuT?=
 =?us-ascii?Q?mBV1o3pvYd+br2iYGbureqTuZ4cP383mkDzpLzvpaVEKgxhFKuhcWk7inHPg?=
 =?us-ascii?Q?ks5sywiaSqfQN5J6iXZWpKoh14dpV1nhiXgsczx0/lnpjnttAYsYbKTa7e0G?=
 =?us-ascii?Q?iHeni7MLTC63H2WICpL818eLcMz3kMlRqOGYYNJoYZ3rgb+qIpcHK3huOBI9?=
 =?us-ascii?Q?A/LPHg1J5ErMQu6JFcA/gzOHHsDx2VgKP26qkmPfMPIEKP++EP9W0xr+OeWw?=
 =?us-ascii?Q?LcyrI/72wAFyRS3Vn/YtWpAeRqWgWsBV/bpcGdd5cRm//fcZquR/y5vUXjoV?=
 =?us-ascii?Q?y5S4NwGm/FONEh4uMlxHfVENnEh8Kr/Gid2FcaAK+kTPuCxtFQ7fzswSrdyv?=
 =?us-ascii?Q?3NVA+J9dWfHum3Jyz0g86a4zlwTfOnGOhOnK1EH3Kqlz/VAZKgiJGR8Us3h8?=
 =?us-ascii?Q?GeQsqN3ShlLV4AaxKvvsUx48qstohaxEnJdwW9Qj8tXqNod2hmva7hFZKzxH?=
 =?us-ascii?Q?27TuupILSH/ksY6gqbJbwJJDqxxzBeIIY4P89C/Bwef3AX3AGT2LB2zoX+U6?=
 =?us-ascii?Q?UYSubkqmsUnVBz1AtsK2HY1KUiLmchmWmNemVF7wuv0cQZtvuah5G9ul19JT?=
 =?us-ascii?Q?IJvLHV76IS+AxobB5P3IwJOlY2xQviVBeDSUiILftULa2GuoBra9C/4dLGdw?=
 =?us-ascii?Q?H4pwmygsTG0JLNkJ7W/LyipOggqHEUseF2OnjDeHaYot99U/NeaaV/8vvhrP?=
 =?us-ascii?Q?yiO+KflesbJDYZq++EA6MHlUDOL4wkvPSE0WR1SfkXd8L6vzTqUo8po3NmYt?=
 =?us-ascii?Q?gG6wdxdPOrJQ4g7yg+Ac/JJya6Zp38Q/SJHyPk0WAfXaUJlr9RDKCBc6SGF0?=
 =?us-ascii?Q?6nQTwnAjEN5kmbrEf9bcIz31MdTXAWLc5Zv+iW/gl65vIQLcIiogFg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e0845a-54da-4179-d4fc-08da09879526
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2022 09:05:15.8462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25I++VTCEjMEuPdCVLSoh7zhXnf4T06QHhcSbS+Hxl1D/HL9AM1B2SZ74kaKMvHktfH0/4GPN4JhHs19UxLa7ryDBZjWf8voZ9ncpkgq6Wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4221
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10290 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203190058
X-Proofpoint-GUID: qJ0IlOl0Zz7ieU0P5veKt95dqBho9D1m
X-Proofpoint-ORIG-GUID: qJ0IlOl0Zz7ieU0P5veKt95dqBho9D1m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Lorenzo Bianconi,

The patch 6b7f9aff7c67: "mt76: mt7915: introduce 802.11ax multi-bss
support" from Mar 15, 2022, leads to the following Smatch static
checker warning:

	drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:1872 mt7915_mcu_beacon_mbss()
	error: undefined (user controlled) shift '(((1))) << (data[2])'

drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
    1828 static void
    1829 mt7915_mcu_beacon_mbss(struct sk_buff *rskb, struct sk_buff *skb,
    1830                        struct ieee80211_vif *vif, struct bss_info_bcn *bcn,
    1831                        struct ieee80211_mutable_offsets *offs)
    1832 {
    1833         struct bss_info_bcn_mbss *mbss;
    1834         const struct element *elem;
    1835         struct tlv *tlv;
    1836 
    1837         if (!vif->bss_conf.bssid_indicator)
    1838                 return;
    1839 
    1840         tlv = mt7915_mcu_add_nested_subtlv(rskb, BSS_INFO_BCN_MBSSID,
    1841                                            sizeof(*mbss), &bcn->sub_ntlv,
    1842                                            &bcn->len);
    1843 
    1844         mbss = (struct bss_info_bcn_mbss *)tlv;
    1845         mbss->offset[0] = cpu_to_le16(offs->tim_offset);
    1846         mbss->bitmap = cpu_to_le32(1);
    1847 
    1848         for_each_element_id(elem, WLAN_EID_MULTIPLE_BSSID,
    1849                             &skb->data[offs->mbssid_off],
    1850                             skb->len - offs->mbssid_off) {
    1851                 const struct element *sub_elem;
    1852 
    1853                 if (elem->datalen < 2)
    1854                         continue;
    1855 
    1856                 for_each_element(sub_elem, elem->data + 1, elem->datalen - 1) {
    1857                         const u8 *data;
    1858 
    1859                         if (sub_elem->id || sub_elem->datalen < 4)
    1860                                 continue; /* not a valid BSS profile */
    1861 
    1862                         /* Find WLAN_EID_MULTI_BSSID_IDX
    1863                          * in the merged nontransmitted profile
    1864                          */
    1865                         data = cfg80211_find_ie(WLAN_EID_MULTI_BSSID_IDX,
    1866                                                 sub_elem->data,
    1867                                                 sub_elem->datalen);
    1868                         if (!data || data[1] < 1 || !data[2])

This probably needs a "|| data[2] > 31" but maybe using a define?

    1869                                 continue;
    1870 
    1871                         mbss->offset[data[2]] = cpu_to_le16(data - skb->data);
--> 1872                         mbss->bitmap |= cpu_to_le32(BIT(data[2]));
    1873                 }
    1874         }
    1875 }

regards,
dan carpenter
