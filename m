Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E23700C79
	for <lists+linux-wireless@lfdr.de>; Fri, 12 May 2023 18:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241897AbjELQCN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 May 2023 12:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241886AbjELQCL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 May 2023 12:02:11 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2109.outbound.protection.outlook.com [40.107.237.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFE126BF
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 09:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Po/uF2qWtGUrVhHoZJq1bqyS2JTVk1TaNua7bu+MiWhf69WbgwkHbHoX3FKBrPSHXanPYCuiQ0+uTihnNST8z6X10LUv6z7x1GZs6M7RhBrFQHQhTp31YBW/5yFaqxnFiUgSJqr3weXd9sxzxtkP1YMansVQuD285HNNqahUJPPnVPGshmdxqVPZV2m8oyWj5FTVzBj1cB9B7LzW0EhyUUkQCilWr1UZAwmwJmHp669BWoQIqLnJQoB+Hn98hD9by0c1U09TuPNrAB+Wx+8dfMMoJ3zvnSll74yeo0VEjilhrY2aMqooR3kiTxCGntWsA1mCpTR+v3f+j3gOeHrJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uC0REubmIzX4f2Z6f9sjFZHHqNUeqUWQOKxa6T2NEB4=;
 b=IKPx5pcgupL016j8XPAt2r9xcw94xYsF2SuTXtAcuQetsQyHWC6+RPZDVpl721i5GbKUyi/18Fc4COu7r3nyr6OZmmMTFMYlHDickpt6qSBHNzIKqdQM1Wzxu2aUS/vAoCCZ4qyL31Ag2oxAMjCTaxQWe90+64d66V600JxhMms1nRJQb31/OSJx6H35p+v8QPnKAS62vE9pEpm4R3ASFX2YaCrsJoFRxBePfs+2dz+YVKaM/uoxOAkUcsxOEOsBUZh1EYRmq+TQEBC+c+ry6opUiiPvucpVawZxAu3+RPPBpD23IakyhlshYvE1jDK3SVo3bZu86/hsbDzZT5z8vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uC0REubmIzX4f2Z6f9sjFZHHqNUeqUWQOKxa6T2NEB4=;
 b=CnZw5HOWU4pXtFzgoTPUSRqHSzRt0MW+LxpyMkUn0QGHV07gJ3V35Q0tRBBpOpuW9JyNFryw7Sh/EWIq4k1EX6dO/zpOa/1K3GCJ+mJ59GL0ViX9WhVPCADUFiHLRsCyJ02idfV3ksk3+LJ0gQ/qY11iAyzUL7eDo754X1C0jeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB5521.namprd13.prod.outlook.com (2603:10b6:a03:424::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Fri, 12 May
 2023 16:02:03 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34%5]) with mapi id 15.20.6387.024; Fri, 12 May 2023
 16:02:03 +0000
Date:   Fri, 12 May 2023 18:01:58 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: mt7921: remove macro duplication in regs.h
Message-ID: <ZF5i9iP0bIGeZaFd@corigine.com>
References: <78c80c25f8dc40b21b61092ab75f44fd4085c24c.1683897026.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78c80c25f8dc40b21b61092ab75f44fd4085c24c.1683897026.git.lorenzo@kernel.org>
X-ClientProxiedBy: AM0PR02CA0034.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::47) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB5521:EE_
X-MS-Office365-Filtering-Correlation-Id: 3958fbe4-0559-4c45-c58c-08db530239fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+47JfptoooU1ZONk1KCwN4aseuKO2HMV5Q0dY0TfaD3z24wtsll/rGxG3A7iC8aF9HyeLDytNkic8fk7Y7v5lE+eZrzjYU6tcCfln7akHZBUiuZ2Q11NCtuvdKxrmCwaNn82INhFU8EkfEWQT1MeBVs2q4/WeTUTNG/G023ymiwzW7/6MRuxK1PIbm4I7EGncN8yHFAa/6TsZEzIDQ72SI+8fOHLWQfeZNmCNslX3cG2m/uiDA++LC1VN2Fq01aieLMvbBodt2sdTw1YWGvuuaFJj8FbXliUpLCw9lFEyLRyuiHSahlclNss6C05wA3FqX+UwzbudxzQXG/ZQjSFW2JDofYEbuIHJbtMQ32cFaurBloyiuJWznlxHhbwRLXk8bfxbxW4v19+uiZqKnIyvLbXzrnWpdi4a6FVTQcOVIvDdw1/iWguKcLXMbXcYSt69wwlv6meG2HYI7ABvXeeF1L+PDrVn9ZVS4vmGZPaVlgELmVvpVBjr/+8jbcwuzA7nY49Pw5ntslUW+o8F9Ftc8z1qdgcG3aYdYgqRveO4ifDNTi7q4262DAU0i+1VSAUeHdAN4iQGdgfrp/KyKelllzHD7rx6zbBjGmNZMMgw4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39840400004)(136003)(346002)(396003)(376002)(451199021)(54906003)(5660300002)(6486002)(8676002)(8936002)(41300700001)(316002)(6666004)(44832011)(6512007)(6506007)(478600001)(6916009)(66476007)(66946007)(4326008)(66556008)(186003)(2616005)(2906002)(558084003)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aY4FJFxIWuIHGCWGa/MO+A9/P5DQ6qa1NahZsc4CdcvDCleFpanl8wwEiN4G?=
 =?us-ascii?Q?kwnfyX0+CcJsTX2Dc5EQ6CfaAtqqk6l6cghsPMfJ469Cw7V2+CAQrCEtfDS6?=
 =?us-ascii?Q?Pqhv6TLvKbJwLCJxe5piGymnMooVUUmc+P9qULKprj1fpWTTKFslZnAmf15N?=
 =?us-ascii?Q?sdqEWsB1jb8PajkFRestMSY3kZSTNniK54AAVHRZQLIsO/+j3UoyTt4saMvS?=
 =?us-ascii?Q?YoFo2FhaIdOUO66UgsTPzjGUe6NN2Ud5oSB6tUsA1XKpC263TvIeMHuWz8Lm?=
 =?us-ascii?Q?i4g9hTKd0dkW0x4T3A0nii4V48sqcE7SJZMUqMw5R+V9w/yBcgispjzVJC8e?=
 =?us-ascii?Q?qNe+x8f3Vg4WMc9zPdTqzFkzlCAXDOCC+4FICeJAY3Dh1xHnDDY3j2M88A/M?=
 =?us-ascii?Q?CQPTpuUnD7saQw84vac1enj0q8sQfkuaFqzF5r+HI5LnDHM1AxcnbxhPK+up?=
 =?us-ascii?Q?yf+3YdZQVcyIVvm7gxa4/GEUFX/kOCA2hS8jVcotcTim1VHc4pYc+4BRcC99?=
 =?us-ascii?Q?HTdWYjgen4R4WuJ+TTGMpH+fNBbNTwsiQIJAmZ4YaxbvDrxqJ1JaD6BmHU07?=
 =?us-ascii?Q?xq+e2i9DJDM7AIVPmVEceQQFr5SsH5hcTofumRGaOeaCVvf9A94eT57LUZy9?=
 =?us-ascii?Q?Mp+489/uVC0605DcIQRqUVtC2W1QMUo2t2sMiDWZNceTS+WvnrLwxNsTDW1a?=
 =?us-ascii?Q?+jeN2QHEXps8G7tgmvOY4YnrPdoMAwbK9zjkClHvMC72N6+COXSz19sZ0rKy?=
 =?us-ascii?Q?lvUNZc1QswmW6fg26a5bV1GJv2meo2EnhnIx4V/2MtwwerzbJ/lSs7P413b+?=
 =?us-ascii?Q?q0KVAmDL91tvs8d6m7nHhyxOm4bfV2+7V9zR7mfePY82MhIUGwVcXRDUyrO5?=
 =?us-ascii?Q?8KB5BKolOfF44hySp93xCO3pmfc2EImAlNYObXDcCTLyDSsDZ51mJDWJApq/?=
 =?us-ascii?Q?dMLT3duiPN91QGbj5No9VUyh40+vBEEDihAcCRsSxHwqrLdRlUJSF7+CWvS/?=
 =?us-ascii?Q?JWrYaOos2kEUB2XFTHlZC64ErkOzveLgtTJUQa0ebedDYaayVY8/3J8tX/+r?=
 =?us-ascii?Q?5n7QrVk4ixf5TT4jxqtMmb4GJBBSPKKmpg+2Mptz1wbUhTZ5AEONNCvBlKZU?=
 =?us-ascii?Q?ey0vkVxTwoFi91gzj0wqa8SRGDGUailIYX2FzL8Z/QO02RozjaUmg1P47JHm?=
 =?us-ascii?Q?fRhnLbfeK6XChjiWIANI8zlzosUzJuRBiWyBMP7DPE3pUpNZBMK6EgZ95Tbx?=
 =?us-ascii?Q?8L/FxqnIJ6Le4/huOtxQNhdseKCY31HWhakiqnI6WkvoF6OA98zyDe/UTq6i?=
 =?us-ascii?Q?a4RlMCEQVpRo13ZVbme5ShbyB3LPBX691Dc8CDHawBF5/p1DeVwUlXGL5zHT?=
 =?us-ascii?Q?lx2nKuH1oFae3q+118512QnVR13cXkeYYGV8zMBpr5H/o32kooMUdhw59lQO?=
 =?us-ascii?Q?+Fz8s1E7TwGgyeLfGGQNt/pFRKfW8OQUBBASVuZC8FUCTjJ5unS9xUwf7Xbu?=
 =?us-ascii?Q?+SVoGwWXgr85GN97zNrTB5NL8zovLVEry92EQkvlwHV1uV2UBnUjHNchCMNW?=
 =?us-ascii?Q?LEGA+IGrk2117YtBXrkv76/5tOiVTZ1OtzLPyUAqEl3T35kJHC40DsrNMhCj?=
 =?us-ascii?Q?mhUslbHZcRG8aHwqR00svs9p3GSnV5INmvQRRrwJma1Rsz0I/3qaSJK+sr5Y?=
 =?us-ascii?Q?pI1/pw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3958fbe4-0559-4c45-c58c-08db530239fe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 16:02:03.3267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2T9G3tfrwNZ0sUpyq81QKI5zasNC/QnKwp7cQVOt8wqPy+hpZH79pv+4TeS1FyNefw95jPttNbU+KQk9JUmn9aPARhCptKbZ0h3JxYooks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5521
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, May 12, 2023 at 03:11:58PM +0200, Lorenzo Bianconi wrote:
> Get rid of MT_MIB_RTS_COUNT_MASK marco duplication in mt7921/regs.h
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <simon.horman@corigine.com>
