Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7330F5FE995
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 09:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJNHak (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Oct 2022 03:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiJNHai (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Oct 2022 03:30:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D797AED995
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 00:30:36 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E7Nsxe001314;
        Fri, 14 Oct 2022 07:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=afnKtxDtW16GDfuwLlB3OfXabbMb7ultunOmWDqvX2o=;
 b=q+18B740zg8reFD3GyzS6Fq2V4iJz6cUPrHtaXx9yieLs59529VklRzEZ7hyiFeM3MMO
 VjwRpHI7YGtAPjzX8FfqaLzN6v/DXP0oCVyUYtjQbUR6ZWQ+EPybZmlSj4B9CNxu9t1W
 3Dymf9vxnCFw6ow/E2LxEb6ctH6e70uYTWgc9T7FPzVGChEDFO9vnRSjavAADJAW4Xsi
 tbXaoGERnp+zwZj0C/XMeAQauQB/iHBqcVM50k4bO09m9SleROhFCAtbGBIX9YjDy07/
 RRbcthHxDf0QmhE7la6jHStQrZFr0YeZr2rFiC7jlcTQ7ugyj6EH+HPRvSCpGnUFUlNC VQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k6qw7hamx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 07:30:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29E71vh1026957;
        Fri, 14 Oct 2022 07:30:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn6xwx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 07:30:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqVqmcQn8ve2QSJtj4UZj9+Z9391iuE/4zwxuvTWlEEMNeAgn7HbxGv8f+Jf/hiNMr1pbK/4zx7eKKH0Ho3RVOoZbItSYObMAprCRy+bu/yMr7N/chA8o/S6wmOHh7bN7pw4Kb8jax/WGSTSUDSZExOgHIpNiaEFxZiy8Rj2F3v0kHLlxk8BcG/ncTEnLdmyp1LccXDO80+zBYPuyCs3t4yEsnlwI17S/Jc/tRprqp6mKEvuPo/JskKRibadaBZ2jiJwRKZDdySmdHVHWmaFeXBzbcjplxVcKqnv0EvcTStDfxlH7iMt5b0I4euD2calOj1y0iiprLYPWtH0yyWdJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afnKtxDtW16GDfuwLlB3OfXabbMb7ultunOmWDqvX2o=;
 b=H/4EBVId2Rep/LNSMJ944LyLdNsV0cI0aKevGTOKoqNHyG/fJfIs61EkJOADuA6BkMsDvV5dGknVXSDt6Y+3ewoFkUAdFuwCpxovyuVnc8JvJf4WxB4lUHsNOsiOFLiS2uTjd3ufD2wzHNzGoQX7S/Ysnv3TevNBZKEVtpPANY+pOhNpwCW4Xx5DWR2PoF7EY/xgSaHtRAqwwkispZMUNsVo1ZwK5x5ggPOOOvyHiBG2b9SYlgB+rCCThX7nPCzbd3crm6i2tXyxGS8AxAA7bwnTCRLE6OSQvumQNWVMAKJQQbLfwH8jcRrWMrNo98Tsbvt6ACTChCpXM52aMpzZpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afnKtxDtW16GDfuwLlB3OfXabbMb7ultunOmWDqvX2o=;
 b=ydUP7EeKpyjeLkkEnLyX1R1x88LB99WIZQ4p+Tdhz/ZXCLZapIKePQa6aJHXtPZwYjkkGhJ7/TklNtJgk3xUXHXe79NUqraEUKlUbU7pvjdP2kssZzfnk0dszrBrGqt8Z1RGYq+hnf6uGwwo7Ox0RWLchKbRoysQzc99p/PP4EA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4599.namprd10.prod.outlook.com
 (2603:10b6:510:39::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 07:30:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Fri, 14 Oct 2022
 07:30:18 +0000
Date:   Fri, 14 Oct 2022 10:30:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [bug report] mt76: implement functions to get the response skb
 for MCU calls
Message-ID: <Y0kP/WOjnCexAPCy@kadam>
References: <20211008130007.GA23161@kili>
 <9298fd82e4b49b965e9f26957510b9e968e8b691.camel@sipsolutions.net>
 <20211008142734.GI2083@kadam>
 <Y0gM2jeo/X5Vq+lq@kadam>
 <Y0g8Ev4hE7m/kP3H@lore-desk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0g8Ev4hE7m/kP3H@lore-desk>
X-ClientProxiedBy: JNAP275CA0056.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH0PR10MB4599:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d3cfd40-1bb0-4345-e356-08daadb5f16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XR0s4oRThYNXjt5Gfb7z7C0+u7woG3maLzj8jDRK6NP8zcBwWdDQWKqMEs21vcyIsxAfJNVnUliqCwHADGrl7mQt+9O4cpmeVmgCGKEqYg4HFncg+j6cmBc/xCM9q12k1ZP7UJNLSnJwLrc4GJhoje/Tu06wdP/IhW0yZGTPgTzeVPXyuWLl7v7isVAiqTgmikXGkDXASos/x3JJ0jSmVH32X6t/qh4PdcPd/83gzYdjvqWe5iw59dBBXeIA3SpLCznC9xhzKnqv/qxmyUhtUffayg6/J9LuWeC6cB7xeRpcXin6iWCOECRyf3HdKUjHdHxQYjgC7IOTpsluaDrxecayQCrJ4JvK+QEFFNe5f9V5dNg9mdtM82lQsGz4Bv31zNEjEuLwVtFYU7hM5LWoCEymsBlanae83Tza2ZADF/1k8YlFDAfOk9lrT0FqJwvvDayrZt6Equ2gi06hAvU7mgPUjAjp3gtoct+RuecfmE9nBOzOVbNuvjISy9l5tDxv2sj1eAqZiovKsJPDePzh0adbGbNeOzoLRNZwllKriaNjaceuQLJVwch1aHsLUS5vFxAM7pZcZpu4QdabcUjlI3UMPbtc/qSxrG9ifc6rmDhYUQ1Z9kNp8FVYwDFvADEFMcqyCi+63f223FixLRaa3fpmHRge+HQ4K3lNTgunWdS3fuEeoCmk12whJHofC5kc5a3rqXcFc44LDAgbvZCOlcJedd13THhg1tVd19FxsxDpiOffqoA6piTiOO+N/7nu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199015)(66946007)(186003)(83380400001)(6506007)(2906002)(86362001)(38100700002)(44832011)(5660300002)(8936002)(41300700001)(8676002)(6666004)(6512007)(26005)(478600001)(4326008)(33716001)(54906003)(6486002)(66556008)(6916009)(316002)(9686003)(66476007)(15583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pe678VlwUZXVrpinsg8qcxHjcVLFYzvGLfdA9mUiZSg71JM0JCLGGBpImFW0?=
 =?us-ascii?Q?OQGn6YJpdSlhn0dNlj4xPWcekpURlVVnoamuvArs2AvOAxByBSUkB8zhdoxC?=
 =?us-ascii?Q?tXUdHHLw+2j7OVUdVe2MaygBlYWxR76UMKlShM7McdzvatQfZXmPcWjgja89?=
 =?us-ascii?Q?ZmTW3sU74JuI/6Y0V5J5YT9EeeJ1FJ9TEc05AIPOhsfI0a0OQeIpjxl4ET0T?=
 =?us-ascii?Q?AtA+C4KdGJKOR+ME1gUA+BbzpG7CX6Zr4W2AKS+3qroQ8rdBMQthNY0pfveB?=
 =?us-ascii?Q?kaT5Ikr5mtTSmrspo/h9Dj2PZ4qNa18aTfs2uTX/GSymkIFffsb30doVGVcP?=
 =?us-ascii?Q?mE13jitgUoaBNxrV4ArpnNfnllw9FdLXZ73MVSp3lh29p3iDO0S3Jjo3PpJk?=
 =?us-ascii?Q?inA1veYLNyDcrfbo9Ww8Nh7xFDFr890F10BHEtA418pi6GAeDHhOvQrNVAQO?=
 =?us-ascii?Q?sg6g7SJTWGLTLBgXe44dSdagZwkBJ7ThTDYUTBMiClOwx1hRHLGolRwtqYoo?=
 =?us-ascii?Q?E5VzXQyNeDV3sC/iRBqBKPFLo7+EW2iBBwaeUFuMoeC8LaX+U/wSfGpt8Inq?=
 =?us-ascii?Q?VDTlnZY8AfpuZ/WGh2pn5oV4R8zYuxSelEpKpWYwI0cb9cADkmd60uYMqbO4?=
 =?us-ascii?Q?aiMjbdXg6xp20ZS4jWVRdF/AN+iRn1g0P1NwWlmDOJcu/lSobqUr3Vx+xZJJ?=
 =?us-ascii?Q?+wMhvsIBFfhKu9OikJRlPw42m5Sog44s+Kokr9klNhte7yjBq0axCFb76/Ks?=
 =?us-ascii?Q?kiuyazt2wN3XWkx3au9PmSawazwl9GZk887/R25riI5ZNRPRhiVdyeUa8Uf9?=
 =?us-ascii?Q?52B/iP1zmQkK1LY6et/2/AElEvomRyRIHvnHHfTK/AjXJ6NB1syjqtd0kb1a?=
 =?us-ascii?Q?KM+LvLYvNEVFbUrFd0GKicV+dHeT1D7wFnTo7ryAioOPd2j1z5D9lrGPRgbm?=
 =?us-ascii?Q?A18s2nT+G3RDBEV4i5wcKFdn5NCExKAptLrZIgFrLraL8p+2hpxKfsTENPd6?=
 =?us-ascii?Q?BYgjPr6KTOHjozK3OJpiz4ZZz+kC9i8iavDuHskpNsltqbNhtTp8hVRGKVmg?=
 =?us-ascii?Q?MfpA9JayS9J/jNA0wwUc4QBlhDrKO+JLK1MWgDgpKfJLAHcgWbfwavk2adxi?=
 =?us-ascii?Q?SScdmCjw+UlEXKA7wkWm7+EOuPA/Z7NKFK1ctfW3m3Bh7bTpc+LvxZLOenFR?=
 =?us-ascii?Q?32S+yFFZ2YUJgx7irZRAfgoEoKd7nmnRIBAqc5Ms358W5DiWeg5Z3WEzepua?=
 =?us-ascii?Q?ywtgaqVD3a9PgBOaLfbi9pmgfCjB5K2r4p2YurdWh79NS/v+B4QLc5szF15d?=
 =?us-ascii?Q?lhadFCW+89s0mIqnWXuyZP3Buux+ge8sK5jfMnnwtt7xFd5Bhz2Frobhd5jX?=
 =?us-ascii?Q?CIkfcsUdYSjMK6YgAsPy8bjejiH2tUmB5tnG/BdijKhl6a5+wQY2sNg3IXkf?=
 =?us-ascii?Q?K5yp7tCGRB1LcJ2yFwNqA71GfyQxWeonHC7GnJH9nyIR1XkZAOiXK1HZxytz?=
 =?us-ascii?Q?O7U8QM8da02dF6QEAbLB5bRannoX/htK6Qhd+4WrAGKisLWWks/DYnLdUavp?=
 =?us-ascii?Q?PkC2IWxLE7p1oTUWIEjaDucAMt8mQiySwW7OJ2dXJQ9lbR79aRTA/QTjE6a3?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3cfd40-1bb0-4345-e356-08daadb5f16b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 07:30:17.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuSHq1NrfVHcp47pzcXlNkxy+FotDvvJyHqJIMIguhyeyiOucr4KJ/gyPj59+cZiV7BckP93ohZWXRJLLiBXfvNmccL5+YHxxILojbiRxXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4599
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_03,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210140043
X-Proofpoint-ORIG-GUID: QnMaLINiogQSeWuC6Xj9zMbcOgmXN2rU
X-Proofpoint-GUID: QnMaLINiogQSeWuC6Xj9zMbcOgmXN2rU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Oct 13, 2022 at 06:25:54PM +0200, Lorenzo Bianconi wrote:
> > I would like to revisit this question.  Last time I complained about
> > this Johannes responded but he misread what mt76_mcu_send_and_get_msg()
> > does.  I have looked at it as well and I also cannot explain what is
> > going on in that function.
> > 
> > I have looked at the callers and my first instinct is that maybe this
> > is dead stub code?  But then when I look at mt76x02u_mcu_send_msg() I
> > think "No, this is not stub code.  This should be returning the newly
> > allocated skb to the caller."
> > 
> > But then I think, surely at some point someone tested this code???  It
> > must be stub code.
> > 
> > Could we get some clarity on this?
> 
> for mt76x2 and mt76x0 we do not care of ret_skb (in fact we do not run
> mt76_mcu_send_and_get_msg() directly but we rely on mt76_mcu_send_msg()).
> For mt7921 we set mcu_skb_send_msg function pointer and not mcu_send_msg.

Ah thanks...  It's easy enough to silence the warning in Smatch but I
was never sure if it wasn't a bug.

> Moreover mt7921_mcu_get_eeprom() has been remove a while back.
> Am I missing something?

There are 12 callers for mt76_mcu_send_and_get_msg() and 11 of them
assume that the "ret_skb" is initialized (i.e. they assume that
the ->mcu_send_msg op is not used) so I get 11 Smatch warnings from
this...

Why not just do something like below?  It moves the ->mcu_send_msg()
call to the only place where it won't cause a crash.

regards,
dan carpenter

diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index a8cafa39a56d..6bf0b7d8daee 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -58,9 +58,6 @@ int mt76_mcu_send_and_get_msg(struct mt76_dev *dev, int cmd, const void *data,
 {
 	struct sk_buff *skb;
 
-	if (dev->mcu_ops->mcu_send_msg)
-		return dev->mcu_ops->mcu_send_msg(dev, cmd, data, len, wait_resp);
-
 	skb = mt76_mcu_msg_alloc(dev, data, len);
 	if (!skb)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 87db9498dea4..99f931c08da9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1383,6 +1383,9 @@ static inline int
 mt76_mcu_send_msg(struct mt76_dev *dev, int cmd, const void *data, int len,
 		  bool wait_resp)
 {
+	if (dev->mcu_ops->mcu_send_msg)
+		return dev->mcu_ops->mcu_send_msg(dev, cmd, data, len, wait_resp);
+
 	return mt76_mcu_send_and_get_msg(dev, cmd, data, len, wait_resp, NULL);
 }
 


