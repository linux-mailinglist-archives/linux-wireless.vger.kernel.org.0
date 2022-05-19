Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF5652CD11
	for <lists+linux-wireless@lfdr.de>; Thu, 19 May 2022 09:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbiESHaz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 May 2022 03:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiESHax (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 May 2022 03:30:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6198E1149
        for <linux-wireless@vger.kernel.org>; Thu, 19 May 2022 00:30:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J6A7of005168;
        Thu, 19 May 2022 07:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Y2BUA8kMTpsfDFelUy7kGXXA2KSVoFQNigMJe/cf/Ic=;
 b=fIP6PbuZS3145e/V5Xs9iJhXhOeSxfRUKgDXpWYdCflKfxVtmjXmZ/EMDKjVn7Ucrqak
 ojbMDozfHH+zDfzrjnl6xsSdbUohz2YjkLq7yi4LUCHkYzRY61D577QVBceupEAOLd9z
 QGmUnOaYzEojgpFpp2uw0rvgpFeS2lf9jM4MxmDWQCORsgcphMPx+eSPazJf/dMgwEM5
 eE8isFj0XWCehsbdLFlCOVzQSoPXY+xDvZVtr3wr27Jn5/HsFcaJ08InUo0T32XMbE3+
 JyM0OAsg5tQu+llC6tcA5/iosP5kFqq/nnnqk46ILhL2vpbdqMaGSks437YoXWwZFCNI eA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24ytudjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 07:30:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24J7Fs8u035459;
        Thu, 19 May 2022 07:30:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37cr4xs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 07:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPIT6LzuHNUBjksCffMJBnGivenEaWU+Ss9FJPRHUlLQGxX3baA9bAzjVWZ0NRoPQ+t80aqbwZeMyzaGp4p9CEzRoZa6/tz/dbSwIA+npWFCQGXTgDCWOtgW3MNKaR7Dl7vpl01x2UaYCy934hOkVlJ7CD9kdx0l8bIMEMxMA1jhHja/d4b0s4eorX5PVR1xZ5QVz1kCnOO1Bobour3ZYg9cLqWDTch9iSu67bTausRynSHAY0iPoyPczfu/eGnx2zh78qBRBvzQAWVk5X4xbpwAJmpU7lnyqXNwae5ibb3GaLZ0ppR9ir/cSNvrjpWF3USZSF8Klqa9xfM/tkJUcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2BUA8kMTpsfDFelUy7kGXXA2KSVoFQNigMJe/cf/Ic=;
 b=bDKe8dEsTPlIC/GaXGT9homF6AjXk8Q794EQ16AHnDawk8+z6ngmatntINMkJrADOAu8K30SMHLQTwbKmUf9O+5GFYeOyUZEMCdrKdOulZlDC0eyohZ8IYHD3Zaz4DMpaXPagYPdBwLlj+R3L2pywAMOOrC7yGUp6FephHV32erBmijLUQllXQvDOXTwoBh7yo4zgtpm6/ESjDP67c34oiB4mJ3Ws8J777W8QSZaV4zusfXt0q9ByIzVafhmdhZLpR1sDvoT/gojEMVQI+xytPr6CfyW2DAJfHu5X6UQNuhTNb+czaeQm4OZcqdr9yXf3J61WFfoyA31Gg84ubVodw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2BUA8kMTpsfDFelUy7kGXXA2KSVoFQNigMJe/cf/Ic=;
 b=UPL3V0aWdrSjHAl4jYIqpZ9FuEPgfCwvb+1GbdjmYG7MTrWY2ftf2EkHSDRzvzcMiWTIkn9rbRad+wxgmGvUWV9ha6T63Rmzxx/M1hx6d/BlYENmsDza/9lYiliWpNs/eE+zo0i+8xxTgdjOpqRDAgVb9fOaP8S2KYFfuM1Gg6A=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1589.namprd10.prod.outlook.com
 (2603:10b6:903:24::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Thu, 19 May
 2022 07:30:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 07:30:44 +0000
Date:   Thu, 19 May 2022 10:30:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     shayne.chen@mediatek.com
Cc:     linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [bug report] mt76: mt7915: add debugfs knob for RF registers
 read/write
Message-ID: <YoXyGg8vpJBgVjwN@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0078.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5ca3280-5cd5-4cb0-18e2-08da39697bd6
X-MS-TrafficTypeDiagnostic: CY4PR10MB1589:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB15890C34A39A5F2FE3D6639D8ED09@CY4PR10MB1589.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+lE+GbpFaWlu4cERDEH9WCI1zU2Jmrt3cuXM/LrEkCO4rJL63KaUvPvUuWkyMq++sPmh/XK588CGPBSoUcl6FGZBq5MCx518F9o/VFquXq4lNDVzafs4vUv9GpiZMc89Cb7yOfqbpoZj1t6/9j2GV+0ipfH9XHyih3bwNoMdOZi1JP6yVR5c6OYONAHnf2sGYZc43DS/KyghSkhRe+SNuqADSgYz7hJOH+7Wovdpw6kcOlR/SYJdTQH9/3eaTot3xTvY/34b6h4CjAh5vmF27JELTJVCd3o5io0IesF9hwHIzPu/dfdsAAY8y9f5yu2t1lg81F44iSTewG59QTtQ74iYpxV2SAXx1vbL8VgemBkSDdviZwQTjUX8kK0aa8969qZN3w13/gcqMSIjzKnnjPWCEBKYLYuFjSrR3piR5jOZdGLwRS48f81I6HxFxEq5HyP5oBhORMGjXKVG5lojkueFTUBjFEsXBaHoIOcrIH0d6YGPOVHFGqh0HC3CCsxHfTxLZ8gWtz1LtNrkSag0wQtnwDDe0eL0h8LbHgWIB846f/bbvOlafrx6IDP2wUpdbBIyc1E2ZeQYqCuKprbrAKQCOIxQxkz/1RkTKk9+jMHKR/GE4gK6DiGCngoelMgjCm7Fmags1qoMGllF6OwZgJ9E6c5OTDXjwIJrFH8KIqxNrBFghU0Tayt61CUqjhCU/1netCScyRUyeEvdXy/Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66946007)(66476007)(86362001)(5660300002)(38100700002)(508600001)(44832011)(4326008)(8676002)(38350700002)(66556008)(9686003)(6512007)(6916009)(26005)(6486002)(6666004)(52116002)(316002)(186003)(33716001)(2906002)(8936002)(83380400001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ouQ17jc9V9mutec+Weho0i/rtN1kbEKPZHf9YEgbWZJUviLyG8qOxVnuVMsL?=
 =?us-ascii?Q?WaMTAUs0uOuB3bkuFvx0hPakmEwB74RS5MsSlOkQ6d3n8Y8do+szU4bMD5cY?=
 =?us-ascii?Q?dn+FbXGEVAQOqM5+DcXUs9v/rJWWoqJABcabByvGOYgkY1PaOI7r3Eggle5h?=
 =?us-ascii?Q?q9so1j/WeiYR+GE2k3WR0/LGQ6pGsvJSJEiaVxHN6u5TPlyuDJGPeLZQPMnR?=
 =?us-ascii?Q?5IX6MEJFKX5Uvi+ybFG8jFUE4MmMy06404ZGwpexNJ/0IXqA21sWf057EcDF?=
 =?us-ascii?Q?NUCu5hexdgZpDeZGTCl3hGKJCoRKDhyz/YQsvukBWJottzMLRy4wLNSAEee5?=
 =?us-ascii?Q?PSSjWq2UDxoUfvUxIK+wGl/fJyqVhNCB8Htb9wSW9rmHEeW3S2KP+4txHIiw?=
 =?us-ascii?Q?uRTsp6Cap59mBDpLCLBzIYZ+BjhMx5bnbIcy3KrgRS42/Q9tdUIdWAT+yMOP?=
 =?us-ascii?Q?0pCv/aqiPGrSL9HYIua1ouWTNqW3lXEFIZJKAr+AmUXSE8bPrpUSfxJaHeF2?=
 =?us-ascii?Q?Xkz1mp+Atq61iuSB1aojz5tjy/ddJm11j2xRUYjXWXJTsZw86YMDjWJoIkwU?=
 =?us-ascii?Q?WVeiafUrpaDMEPRuPXggOXU8tN+1SZB78LxRe1BIfkDSqxFOQQcVUdNkAxBz?=
 =?us-ascii?Q?O7A8Ik0hOumCaT/YZ6vl/JL5sLk6iLR/my9RRFimYzZkupGYguxBtdHgbxSS?=
 =?us-ascii?Q?NJNFa5/AhRG8s5fRVqRhG09dPeZDyzM1hPwJSQzptKUxY/9+BWsFjIFuPZ2p?=
 =?us-ascii?Q?DJ/pojW5+aUE0gYx3099ppDvQCFta9YIaUljMMoNs6rG564PYMuTQ3GjG2ys?=
 =?us-ascii?Q?/sGkDZGpxK1gxD98iZ+qETHUIypryQovHDc3vc24rcRSJ5hGm3w/g650v1oM?=
 =?us-ascii?Q?Jd5nSQZaTKdjrmFCwN5P/AmwjkX1EdpKXqzbb+11lKuUk13MTL0iTRzxg4fl?=
 =?us-ascii?Q?HiKRSsEkAiwMoRMzJGPvO/rmcaBADtI3EDJnHduqlwNa8CcacCaMq0gz3kfh?=
 =?us-ascii?Q?kkarXk2DRNYARpXKaRAvQJUeNOm1C3HWWIwVaRdkuio4yWSywK0I2r/3jJ6h?=
 =?us-ascii?Q?e6kpIb4bhDJ2tJS6UDu4yX5uprMeqJ+SamZ6zMyvqovU4XYCdolxkQQ7aOW3?=
 =?us-ascii?Q?u9kmnvdVGR0udGMzj2cBJw978dsTwEB9tX+v2TsXOapnetO5AmADHU42KS45?=
 =?us-ascii?Q?KfMcTvuabW5jLXKpljX2UZcFR6Cu1FkMeVDETsCG5MIOjyk/dND5cJaFsHTf?=
 =?us-ascii?Q?4iV+/hbZYauDy0JeiM3O6i3CKUOXT0lvZWmJbiDg449UX+nytF8zfwxUPAJy?=
 =?us-ascii?Q?1SiCLFrxEuk7Uc6f8dGg6hBB1BolO33Rwp9Nzr5tKj4GKXUSa1QJgcCGyT9+?=
 =?us-ascii?Q?f4Gz5JAsn1pL/+VS7mcKLViiCaVO75XjsxLqmqxoAjq5vbpnMD4n/Wm1coeN?=
 =?us-ascii?Q?FYChly3a7HGiSi5KqPOrtR27TxBuLloXTRxGIuXkHjZkjGHwOY5s219uGub/?=
 =?us-ascii?Q?m1q0dMAaicZPRcmO0ryA603pNKckNTpd0xngYdb6ehM5TNC/sJskhNF8o1vG?=
 =?us-ascii?Q?S70fFK4jsZp7Rg/XwLPnbnvuuRA20gpOCGCkJ+/ft9Ys6vrlOHdUKOYwoL9k?=
 =?us-ascii?Q?a8mfgwB4ieKZB4OqF9De6J2y4z3efaerEk2EX4DMSpZSvhF21etOzrXPsNob?=
 =?us-ascii?Q?de1misVZvcdjXKA9CBuu5Y1KEv5r6J0dEz4y4Z60SSrOSLEd0NL6fdWgY3Xi?=
 =?us-ascii?Q?i2R3kMbFHSwBh58jWErZiuGjqa8tZJQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ca3280-5cd5-4cb0-18e2-08da39697bd6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 07:30:43.9886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8j2aoqEFrUDQJLk+3kbJi1f+VP+0vUnzzeGIL6PtKJ+yyWE9ICpEMDliz5AcM1icJZb3QNQcB3+NJ8oPexfY5OLvEGXyBWKM4xfgiKEudA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1589
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-19_01:2022-05-17,2022-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=451 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205190045
X-Proofpoint-GUID: 3UE4z_afc0fPZ4rFpwD-jDhuHb-kuUVr
X-Proofpoint-ORIG-GUID: 3UE4z_afc0fPZ4rFpwD-jDhuHb-kuUVr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Shayne Chen,

The patch 0a17329ae9c1: "mt76: mt7915: add debugfs knob for RF
registers read/write" from Apr 18, 2022, leads to the following
Smatch static checker warning:

	drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:3757 mt7915_mcu_rf_regval()
	error: potentially dereferencing uninitialized 'skb'.

drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
    3734 int mt7915_mcu_rf_regval(struct mt7915_dev *dev, u32 regidx, u32 *val, bool set)
    3735 {
    3736         struct {
    3737                 __le32 idx;
    3738                 __le32 ofs;
    3739                 __le32 data;
    3740         } __packed req = {
    3741                 .idx = cpu_to_le32(u32_get_bits(regidx, GENMASK(31, 28))),
    3742                 .ofs = cpu_to_le32(u32_get_bits(regidx, GENMASK(27, 0))),
    3743                 .data = set ? cpu_to_le32(*val) : 0,
    3744         };
    3745         struct sk_buff *skb;
    3746         int ret;
    3747 
    3748         if (set)
    3749                 return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(RF_REG_ACCESS),
    3750                                          &req, sizeof(req), false);
    3751 
    3752         ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_QUERY(RF_REG_ACCESS),
    3753                                         &req, sizeof(req), true, &skb);

Presumably this has been tested and the static checker is wrong...

But how the heck is send_and_get even supposed to work?  If the device
has a ->mcu_send_msg() op then it calls send.  The mt76_mcu_send_msg()
function uses send_and_get so that means the device has a
->mcu_send_msg() op.  So it will never ever do a get() only sends...

But that can't be true!  What is going on???

I've complained about this code before.  Nobody could explain it.  Other
people had wrong answers for how it worked so I'm not the only person
confused by it.

Update:  Oh...  *Groan*.  Send does *not* rely on ->mcu_send_msg().  It
will still send if we don't have that op.  So what must be happening is
that the caller *knows* that the op is NULL.  The only way this code can
work is when ->mcu_send_msg is NULL.  :/

    3754         if (ret)
    3755                 return ret;
    3756 
--> 3757         *val = le32_to_cpu(*(__le32 *)(skb->data + 8));
    3758         dev_kfree_skb(skb);
    3759 
    3760         return 0;
    3761 }

regards,
dan carpenter
