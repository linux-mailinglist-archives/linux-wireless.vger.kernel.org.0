Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C6D5AAA74
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 10:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiIBIq2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 04:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbiIBIpz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 04:45:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88371E0
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 01:44:45 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2827tvCP029033;
        Fri, 2 Sep 2022 08:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2022-7-12; bh=XNKSSYdEDvphvKaoBOxn1fY8XXUOEJWYVX+dZqlt8S4=;
 b=Do6XMbUpT2FqV5QrpVTpWVXxVUsDGPdMTrS5fBV2y0dUeXGREgBcs9C/RILunJrdXntm
 goTStnB89If668tlolpxriLdMgaiRbGTXTlgIH+SdOlALkhueH21CoBtTB6qnS+Dnoxx
 fcxBxFO02QPlino93NtAlZ3ZHDRwHBjjDOiXB/QGeJ8MmRgjQ0o0bvf7a8ZvmL2SmKfu
 SEu5nFmHGyxydlafW+dtnhcJqPaLHU1sR1Y7dX8EuCbZIajSr/2s6KpbiWTrOqNBbSsL
 qj4TsB3EZFM0aX4lr8L8eTU6out1jm1jgcRK7CZS7CFNH4fTjDSJXpvU0E/8/gdP63uN PA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0xjsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 08:44:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2828NXsC036737;
        Fri, 2 Sep 2022 08:44:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jarpbykwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 08:44:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2MpJ+DbRFmB2oigFAJEX7o6YH3tdgD4e2Ma1Z9aQ98JV2cpOB2HWXbZgnJ4pLcetYQ50aym2LQkou/6l3JfnqKrsy0gO0HKjKj4rcpdb8xSsQ7PrmHT+vTf9Kn9duFZGpsa7rQYSqisKybWXH31kaSzc1UUiFOhOGMoAoHFNXQ8GkV9TtwqiI+wWEpy7LVYZ1ZJxSWbkovNCurUCUf8bnj7sma4fThcnJot3N63Ilmjnls99XezCc99pGRtfPrPEYkPhs48chJSDi9ZeFuZkPld4G7ypV558n0clFYkhzs6vi0uTZCK8qjVPEnsxNreC23Z9krfQLizx4MF6YgLJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNKSSYdEDvphvKaoBOxn1fY8XXUOEJWYVX+dZqlt8S4=;
 b=gjp2eS5ITOqsnlCJHxtkGmP0jZ6WEAhKBCwwlr/zYCoRGAfdA19cb2/Q+w6/uej0IV30z3gAt+6vRq27gsmbNEIpTBMwzXkDwXqgCG5Gz016GvGSe7n/B+lcetG0mj1lfPA5hv1NgbCmfnjMOnEemsX+tqTST0F35TcwaIX1YDX9Jn1Oggr0QFSjGvR4e2evj/Hg8ICxK4ZJsfrZECLRR8WEEtAYnL5AhaaZ81DgxgDGRnUv3KFscBijGnnd07omZh1MRwiyZLm1nxVdB+6gBB67TTQWBhTr3IY5WZ+45XVUfmdS8Xo6ZWK6USfODrBvFTjYpFd6hqDAAmfODYdOdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNKSSYdEDvphvKaoBOxn1fY8XXUOEJWYVX+dZqlt8S4=;
 b=y+RbIsYMbw/SHBWhj3T/6Z8ZH1rejVIoVFLZuwJ7o19wqKDgjb/EPRTZN1BXGnScQIhzks9ZNum0EjkqJmkLgw8hL+guWcTEiPHHfxdL04WSwydcle2K8htS8R6YGetLERyg1R4XNXCYUiYoiSGkQRImDGCUURkrElSUCF6mPT4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SA2PR10MB4554.namprd10.prod.outlook.com
 (2603:10b6:806:111::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Fri, 2 Sep
 2022 08:44:20 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5566.021; Fri, 2 Sep 2022
 08:44:20 +0000
Date:   Fri, 2 Sep 2022 11:44:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Kieran Frewen <kieran.frewen@morsemicro.com>,
        johannes@sipsolutions.net
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: Re: [PATCH v2 01/12] cfg80211: regulatory: extend regulatory support
 for S1G
Message-ID: <202209020018.S33cD0dC-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830022017.51017-2-kieran.frewen@morsemicro.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0033.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6815590c-9577-49e2-12c0-08da8cbf5373
X-MS-TrafficTypeDiagnostic: SA2PR10MB4554:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYp4rSrFb595JLU64ED/uk0mTr3JJD7qTODVUgpg1tWuyrsJZnvK6sUCuzVTfDZZ+Y5x/Y0I2ll/vjTt/Bec1Ti0xVOVuLelW2S+BE7wVNMzkqG9wLYOyolHpQi4DnuCf+c5xkadrz+VfptKyUYfeAn0au8FQUxXrrb+gK8bCLLxeZzCeobfz9piuKRrhzvD04mGUInui2hOBFFN+bAFIT/Znho91/DnhB8uDx8UMjc3KN/K1c+AKzdd5eZ8sMp4bcV9D68jwbVBu9gO9ckmTLXLlZ+ItpnRPBohtiLi/y+GLZ6XpT6JMoR42DOKW5eVtSYIuDrUTEpjh0pcaBSXhCAN7Wed9ZP31nTq2KvavfgdzKsFT9iXRkkFNnZB/be/OxH+YJg5XGD58c7/aSgxW9817LwpojBEn0QDcs92Qnxz3yA91EBn/A5Rczf1hJ6VLYqJW7UOvYoCG7yN7oMUmd2UL8nUQoEy5un8/8Yrqj52We0ZnvHpLQu54c/7z8zBRsR1m5YKOs7yDHgSfTc2nuwdc0OWzdhgbIb9kC90Dsw7MxKGG/KESflVv4bUA4KkncpN1EOtfvwxcjsLLVgq6mu6mvWshwJkHXEtyWqUOMeudJE0MH0zfLMBos3rlc7cHX5uvC7UNe3rhuu18ei5gWlwR2LFszRURr5zABdwXt83lqcqTwKWCKK06RelLSXMk68DdFhReXgQvcqROgRXUtOU/REbQCfLUIC9MJcdA3cERzVW6quFgUZUeJqzDzK83oO1MsPTbeTVUI+CqYjBFktAZPKadCr6eltOsYcuSuFZ+xLGRN7H+Mheb8msk8OwKfjtE8TifiDzsIZSu8Fd4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(366004)(376002)(136003)(39860400002)(9686003)(1076003)(186003)(8936002)(26005)(52116002)(6512007)(4001150100001)(2906002)(66946007)(66476007)(66556008)(8676002)(44832011)(4326008)(15650500001)(5660300002)(36756003)(6666004)(86362001)(478600001)(6486002)(41300700001)(966005)(6506007)(38100700002)(38350700002)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VyH5EZ7g1pXCyvy7J3VkSi817d0N3dgXtHS3BaF4dUPya40E/tTmtyczQUM1?=
 =?us-ascii?Q?FGLYouncQarsRDWLf0vUM8/uJBgPgMbrRVZN32zsm3IxP1eCqd7GOa0+m7V/?=
 =?us-ascii?Q?OSlcwIRq8BivqalJUpybMywZOfxMg4DGx6KHjUoj9SvldyBN/4oMFGdSn2n1?=
 =?us-ascii?Q?tNsDGJYJAkfuW46S0lD8DOircrFKsNGGPEEKZqt+s5u0dZh/1Aq2tUQDMCJh?=
 =?us-ascii?Q?6PUmCSzA9+U8EK/qLJmib7o1O6xhsIZVyPdRMww2chofdHmHpVbHx+w+sgAk?=
 =?us-ascii?Q?cEG6k097m5DdKcas+Al9dcSZ+exnaH20sMPC1R/1UZ45WBq8Aw1hhQpiVYhN?=
 =?us-ascii?Q?36JtGNQhhkaSvr4hwxuqCoY3UwmL6kb9l48EmnPME1KI3rDd5akbFhb5k16Q?=
 =?us-ascii?Q?pwijkA0JorDjXHtcJl6q1Ye77CML7nS5q48oxTBmmNdCWVJXPK7tOwh+spWf?=
 =?us-ascii?Q?cFrXqlLgzTo7CDnDiFlwndEc0u0y9xoyK8ruW9SM4h5743ivRX2+ogyKdVU6?=
 =?us-ascii?Q?Oadb/Z2Eu4IRyETDe4WJG+JH4n0rO1iV8+sPn9EQrB2mek2tv/kfXmxewePs?=
 =?us-ascii?Q?i6/I9jpP1333SI3b50T/av7ScfF0VQpggBXqDWd2llSBSYBAD5YTlgYSNVhG?=
 =?us-ascii?Q?zxYiyqh89HWTt7es8oqTay2AMXno99Ruj/1iSkIM9N4Y/tRRuvZeaFPnGfOP?=
 =?us-ascii?Q?cfdba/TfhxLUvvk1NJVnsJXIvxikTSplHXPavZWOCrZ8WJYYDRtUCWkUuDvP?=
 =?us-ascii?Q?6E3Ly6RDt4jHmN0dwSzyebTDYddk3+ZDdz/ufcQ2nn3Q7Bv+oKjOV6/rpYnp?=
 =?us-ascii?Q?oPSxKGpgx6xKSivZKyN4pcuo6OyfAmkB4NO9EWk8N3uqoKEw/ibTtnaGYx/n?=
 =?us-ascii?Q?WVmquLu3RtWDl8ZJWtepaZ3BQKzBJddjKz4WxxXKuPqC/C8cFmoyy+K4c9O6?=
 =?us-ascii?Q?488rtBnOrF4N4zNWUp1oERQZ2YN/1qOXj2KYxOVVsSHR81ELx20wqnydlXfO?=
 =?us-ascii?Q?IvUGRlwuGkkf4y1qn5H+4DTgpZbM8Ww/N/Mw4UAg3ZfeRqyWuB4P6unioMll?=
 =?us-ascii?Q?srF5FBpmQ2FW2eZtYVeZUuAYpQDK1tTYqQtBZrSd+Evq6lXqE+5eQK/AXHrb?=
 =?us-ascii?Q?qdIHWaIhGR1tCMp4WxFkcyN05rNEd6rovShqOk09hcrm13DevbIvABzehf3C?=
 =?us-ascii?Q?HO6U6/9kfv4SmXtH6dEwFLzZXv3xJeS57itYrDO5C3AjEJPHUvP4Y4DbU5gu?=
 =?us-ascii?Q?chz3meLlMNiRPw7olMfDXOIR93V9kE/ctfbqerXaK1ChE1Pgw1CEX0ck0sqa?=
 =?us-ascii?Q?oflLiRjpEw/vXd2lSFErNWBUM/nN+TRGhtbAx9QC0YALH7uDhG7PuAWH6c+6?=
 =?us-ascii?Q?cUVHmni9L970NeOhQ13iZ/66hwqHiSRRzxkR2IeDH/xwzzKfO1DWnkdGgHY5?=
 =?us-ascii?Q?pYWS1zAmN5oGozi7o9MRSA5BjcAiiisy7yevG6TqKyH1BLm3Wfq1uaFRu7jT?=
 =?us-ascii?Q?biC4W0r5Nx1ZfB+VTc9jTWI9w1UHaotZZvUCBWABIaBK6LzIqACyM6nQUfE2?=
 =?us-ascii?Q?5KsPHzoaAkqoLmtSi1knbKOC/+xj33eddywiPfcQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6815590c-9577-49e2-12c0-08da8cbf5373
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 08:44:20.0694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bakJdoNIwQ/sGocg+dchfhbDPkRbnyvXuGTlneBvdarGv/w4I2g7VV2zfNgRVYcIXSvTxYO80TAeGlM7Mv7VF5GD4N/tUvQtFiZcKa8KRyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4554
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209020040
X-Proofpoint-GUID: OUx4SMUBwDw-Eu-VlqoqQFVT1rs0xy31
X-Proofpoint-ORIG-GUID: OUx4SMUBwDw-Eu-VlqoqQFVT1rs0xy31
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kieran,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kieran-Frewen/Additional-Support-for-802-11ah-S1G/20220830-102217
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git main
config: csky-randconfig-m031-20220901 (https://download.01.org/0day-ci/archive/20220902/202209020018.S33cD0dC-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
net/wireless/reg.c:2597 handle_channel_custom() error: uninitialized symbol 'center_freq_khz'.

vim +/center_freq_khz +2597 net/wireless/reg.c

1fa25e413659f9 Luis R. Rodriguez 2009-01-22  2578  static void handle_channel_custom(struct wiphy *wiphy,
fdc9d7b2863ce6 Johannes Berg     2012-12-03  2579  				  struct ieee80211_channel *chan,
c4b9d655e445a8 Ganapathi Bhat    2019-12-20  2580  				  const struct ieee80211_regdomain *regd,
c4b9d655e445a8 Ganapathi Bhat    2019-12-20  2581  				  u32 min_bw)
1fa25e413659f9 Luis R. Rodriguez 2009-01-22  2582  {
038659e7c6b385 Luis R. Rodriguez 2009-05-02  2583  	u32 bw_flags = 0;
1fa25e413659f9 Luis R. Rodriguez 2009-01-22  2584  	const struct ieee80211_reg_rule *reg_rule = NULL;
1fa25e413659f9 Luis R. Rodriguez 2009-01-22  2585  	const struct ieee80211_power_rule *power_rule = NULL;
934f4c7dd3a544 Thomas Pedersen   2020-04-01  2586  	u32 bw, center_freq_khz;
7c0e7a45e22911 Kieran Frewen     2022-08-30  2587  	bool is_s1g = chan->band == NL80211_BAND_S1GHZ;
1fa25e413659f9 Luis R. Rodriguez 2009-01-22  2588  
7c0e7a45e22911 Kieran Frewen     2022-08-30  2589  	if (is_s1g) {
7c0e7a45e22911 Kieran Frewen     2022-08-30  2590  		bw = MHZ_TO_KHZ(16);
7c0e7a45e22911 Kieran Frewen     2022-08-30  2591  		min_bw = MHZ_TO_KHZ(1);
7c0e7a45e22911 Kieran Frewen     2022-08-30  2592  	} else {
7c0e7a45e22911 Kieran Frewen     2022-08-30  2593  		bw = MHZ_TO_KHZ(20);
7c0e7a45e22911 Kieran Frewen     2022-08-30  2594  	}
7c0e7a45e22911 Kieran Frewen     2022-08-30  2595  
7c0e7a45e22911 Kieran Frewen     2022-08-30  2596  	for (; bw >= min_bw; bw = bw / 2) {
934f4c7dd3a544 Thomas Pedersen   2020-04-01 @2597  		reg_rule = freq_reg_info_regd(center_freq_khz, regd, bw);

Never initialized.

4edd56981c8fbb Matthias May      2015-07-17  2598  		if (!IS_ERR(reg_rule))
4edd56981c8fbb Matthias May      2015-07-17  2599  			break;
4edd56981c8fbb Matthias May      2015-07-17  2600  	}
1fa25e413659f9 Luis R. Rodriguez 2009-01-22  2601  
a7ee7d44b57c9a Johannes Berg     2020-02-21  2602  	if (IS_ERR_OR_NULL(reg_rule)) {
934f4c7dd3a544 Thomas Pedersen   2020-04-01  2603  		pr_debug("Disabling freq %d.%03d MHz as custom regd has no rule that fits it\n",
934f4c7dd3a544 Thomas Pedersen   2020-04-01  2604  			 chan->center_freq, chan->freq_offset);
db8dfee57d37d2 Arik Nemtsov      2014-12-15  2605  		if (wiphy->regulatory_flags & REGULATORY_WIPHY_SELF_MANAGED) {
db8dfee57d37d2 Arik Nemtsov      2014-12-15  2606  			chan->flags |= IEEE80211_CHAN_DISABLED;
db8dfee57d37d2 Arik Nemtsov      2014-12-15  2607  		} else {
cc493e4f5296f4 Luis R. Rodriguez 2013-11-06  2608  			chan->orig_flags |= IEEE80211_CHAN_DISABLED;
cc493e4f5296f4 Luis R. Rodriguez 2013-11-06  2609  			chan->flags = chan->orig_flags;
db8dfee57d37d2 Arik Nemtsov      2014-12-15  2610  		}
1fa25e413659f9 Luis R. Rodriguez 2009-01-22  2611  		return;
1fa25e413659f9 Luis R. Rodriguez 2009-01-22  2612  	}
1fa25e413659f9 Luis R. Rodriguez 2009-01-22  2613  
1fa25e413659f9 Luis R. Rodriguez 2009-01-22  2614  	power_rule = &reg_rule->power_rule;
1aeb135f84fe40 Michal Sojka      2015-11-23  2615  	bw_flags = reg_rule_to_chan_bw_flags(regd, reg_rule, chan);
1fa25e413659f9 Luis R. Rodriguez 2009-01-22  2616  
2e18b38fc8fb03 Arik Nemtsov      2014-11-16  2617  	chan->dfs_state_entered = jiffies;
c7ab508190aee6 Arik Nemtsov      2014-11-16  2618  	chan->dfs_state = NL80211_DFS_USABLE;
c7ab508190aee6 Arik Nemtsov      2014-11-16  2619  
c7ab508190aee6 Arik Nemtsov      2014-11-16  2620  	chan->beacon_found = false;
db8dfee57d37d2 Arik Nemtsov      2014-12-15  2621  
db8dfee57d37d2 Arik Nemtsov      2014-12-15  2622  	if (wiphy->regulatory_flags & REGULATORY_WIPHY_SELF_MANAGED)
db8dfee57d37d2 Arik Nemtsov      2014-12-15  2623  		chan->flags = chan->orig_flags | bw_flags |
db8dfee57d37d2 Arik Nemtsov      2014-12-15  2624  			      map_regdom_flags(reg_rule->flags);
db8dfee57d37d2 Arik Nemtsov      2014-12-15  2625  	else
038659e7c6b385 Luis R. Rodriguez 2009-05-02  2626  		chan->flags |= map_regdom_flags(reg_rule->flags) | bw_flags;
db8dfee57d37d2 Arik Nemtsov      2014-12-15  2627  
1fa25e413659f9 Luis R. Rodriguez 2009-01-22  2628  	chan->max_antenna_gain = (int) MBI_TO_DBI(power_rule->max_antenna_gain);
279f0f55249820 Felix Fietkau     2012-10-17  2629  	chan->max_reg_power = chan->max_power =
279f0f55249820 Felix Fietkau     2012-10-17  2630  		(int) MBM_TO_DBM(power_rule->max_eirp);
2e18b38fc8fb03 Arik Nemtsov      2014-11-16  2631  
2e18b38fc8fb03 Arik Nemtsov      2014-11-16  2632  	if (chan->flags & IEEE80211_CHAN_RADAR) {
2e18b38fc8fb03 Arik Nemtsov      2014-11-16  2633  		if (reg_rule->dfs_cac_ms)
2e18b38fc8fb03 Arik Nemtsov      2014-11-16  2634  			chan->dfs_cac_ms = reg_rule->dfs_cac_ms;
2e18b38fc8fb03 Arik Nemtsov      2014-11-16  2635  		else
2e18b38fc8fb03 Arik Nemtsov      2014-11-16  2636  			chan->dfs_cac_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
2e18b38fc8fb03 Arik Nemtsov      2014-11-16  2637  	}
2e18b38fc8fb03 Arik Nemtsov      2014-11-16  2638  
2e18b38fc8fb03 Arik Nemtsov      2014-11-16  2639  	chan->max_power = chan->max_reg_power;
1fa25e413659f9 Luis R. Rodriguez 2009-01-22  2640  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

