Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04ACC713534
	for <lists+linux-wireless@lfdr.de>; Sat, 27 May 2023 16:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjE0Ov3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 May 2023 10:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjE0Ov2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 May 2023 10:51:28 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2138.outbound.protection.outlook.com [40.107.93.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4783DE3
        for <linux-wireless@vger.kernel.org>; Sat, 27 May 2023 07:51:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqzQmjg8Jp0Rt9PDkR3LPG4RGPI3sL575u0OV39bjDcTIlDYDpi4dGN8FjijV7Rmbif01GJjxvekVySHyNBgEdEQtlc32j1r2QC+iNARtf9NOTTM/ZbDuBnFVRuXegHREbGy5lZWy44Pb1tr/eFnaWsTFvcHDkHWIk9YcKNX+4pIUhaF1/irxhnMr/flri+s7ewT+5vTq/LHR9JQfCq3pgzKAlBzxBWgTRGSBMLv8H/yKQd28ck6bTu2liAY2O8HeUB64+cG8hfmWaMSMQdEc8RmVwpR1iYJAC2c5YwadPOirkgq0dB0rVof44yOm2qqceP00Xa/cT5rpFOdK2DUFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWFqzofw5oZi/aMUyzuj+brrNL/MEBsLMwoZZvMadqY=;
 b=J3iYvoKlEahUdGVN0JF+SAscGAMNxpRmUGhw3RaHL9FAVeAzAxn8ZLPWAX78TqobzhBst+H96uI3VWq176ssfcgBRlQKhTDvKVKDkLp/TfGeQWw5La0PeiG+UukFUtttiW/ObBjr4EzDR+QMLd/wMIGW8b3Fvyj1tT4Q3jYBFFqJBiboEYyVtAGxiAmgDO3/uHYsye0zR/3tK+hKUyhbGTQsEmC7SKE8dd3t1/6bhyfhEAsvB9E38Ls46F/xDNnln5f/42cuIXxFNIzPFwbWQnVV5WNzR2aaUiujZU1JsWteRDUQWnPnyWzebEqvcXVoCWit5EpY3CoLTbAdljOBBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWFqzofw5oZi/aMUyzuj+brrNL/MEBsLMwoZZvMadqY=;
 b=kIM4/k25CV996IDsaTK2nPoSL+aPzKwR7X/b3xGg7hifU+oI+b2v5PU2V1jScKkGCPsgGDNMv328e3bIJAgOaqg46I3NdXubTpHoP1w7Uozyppjf8KFflYvYLHvZ4ZQ+JJZ0S5U8NT9zOayFQDXJ/opyYzF3tYQDvxXy7+Fb1c8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH2PR13MB4555.namprd13.prod.outlook.com (2603:10b6:610:61::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Sat, 27 May
 2023 14:51:25 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::5e55:9a39:751f:55f6]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::5e55:9a39:751f:55f6%3]) with mapi id 15.20.6433.018; Sat, 27 May 2023
 14:51:25 +0000
Date:   Sat, 27 May 2023 16:51:19 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: mt7921: make mt7921_mac_sta_poll static
Message-ID: <ZHIY55KsLGhgvzeP@corigine.com>
References: <a9d38dbfb85cc394bcd394379fe6fe4283e099a4.1685186414.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9d38dbfb85cc394bcd394379fe6fe4283e099a4.1685186414.git.lorenzo@kernel.org>
X-ClientProxiedBy: AM9P192CA0012.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::17) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH2PR13MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: 6730d221-16b1-49a1-5079-08db5ec1d842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eU6n1rCjejgPMEW0YaHwlHAlICQJP7A4MVhW09dyYf7pKv8p3AkYf8TkYeupgFKeJZxDrmWiVUiV+DBD1YlQaggGJMoYqsH5Q/3TH8BNYfdtojn1bd2QgHGAqGmeuv/RUW8aTtcuUqLP5opvfZErd1/gsisEvwS6bOVg4molo9z0KcyikNezoJZn7edW1DG+9O5gOua+lMniEoEwemtI2u2qGpcoJ1W9zv/fkIUnqa9G/2/KNjXaK2BOPofo0wYc5t68aKWdsrFs35cpePAfqvsNYlVZWeqJ9ybeqoCppP0OtXtyTuhpodbgVu2YKdkHn3DD5DGk6G4WPlNqo8Rem3C1jy1g526kEfdn2OGhYkvKfqcJQQ9XeAFQQeOarcLunIxOSy/SUAzT5t9VUvce6QeE1ui0y+B+UEAivh8Clj7PzCXCe+zMukSpP4YL1bFUMmX34HDZ3GsT7MfSLSWC9vsaGkS2FKT9zsNCgm9dFv2oeu/LQtoOwY4tQrRNonyEPlracomB6qzEq76nE+wJVMQMyZVuXH4COuDiumoJ9pO+Iwq6hMnliUcKoBh8s93I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(366004)(39830400003)(451199021)(186003)(86362001)(478600001)(2616005)(2906002)(66476007)(66946007)(44832011)(36756003)(66556008)(4326008)(6916009)(6666004)(6512007)(316002)(6506007)(6486002)(5660300002)(8676002)(41300700001)(8936002)(38100700002)(558084003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2/Qw6cbaBaszEpbj1+gSbAaY+nhDfMeu0URv/RafkOaSbm08M2DFfXRqeGPK?=
 =?us-ascii?Q?Y77bvRT34jpb4UGt4xLmlBACORSYgBc6ZGFT3D6m8kBphTpHodsSmqhipehL?=
 =?us-ascii?Q?ILDOr4ltEIXY/XbKpnFRcUjsvF9mNgF0Tuwk3Ez49Bu1Wv5B9kzMLlg7a3u5?=
 =?us-ascii?Q?kZDdDmtf8OAqleqd8ta5F9yltpGdBCgJXtBlHb13IvQvOzJxtyyl11ayv47Q?=
 =?us-ascii?Q?PMafwYd5AWT239cM9VsWI6xlZhNcZqHh1GAwZSb7qnvPiNYLOk13ZZDAcVJ0?=
 =?us-ascii?Q?/c6uzGpC8FhhXaKPhP0NMU5gPqiFXxOIWNaFw91X9OBTBbJ02A6OYlyaNti6?=
 =?us-ascii?Q?f/ylh3Y+wJmbXgMUQOJ92RV7ASKBxHmZ4dp+26BkjwM1XblXruuxXrI2EpAB?=
 =?us-ascii?Q?Ekq5ikroz7uZWyQiQjLqfvBitIOnAJpTtm8suEH+Ro9guQZTkpdLEQ2wIyCo?=
 =?us-ascii?Q?qkXcICG7ZK0P/0awm+gfyiZeWjk6zWMTRM23DBpGqt+Mrrs88MZbciiENsMm?=
 =?us-ascii?Q?VzLyBfNYb7NVhIBAGeEh7662nevdomqwGa7EHeBxvIbu+DS39nV7oVwpIMOl?=
 =?us-ascii?Q?jzxPycn65KGZgIYhNVWo0OzQyDjgPvieJ7r1YYXuRMWbaXU4b8mAAFivuius?=
 =?us-ascii?Q?YTB9XzuYEOAs7Kvul/oGqvTcwLKCH6TK2qvERrgmuf4R4fvAEQ6mB747WYcN?=
 =?us-ascii?Q?3kK0RWx52M9RfkujwmvY1iK4cozQ4uN/PBV+PqToqDZ//jP2jJtnqDrq2Ntv?=
 =?us-ascii?Q?hG6g+oEUBt6c8XR85m1b2FpqM3jRrB7IYEVSJ8jBPxobXQ7I9/Ry1Bw/E35R?=
 =?us-ascii?Q?yw3wUpQkD0MZS8iSkgsQdV1Tt0p4EHw5RDiHlhkE09j2srwe1MaCv7z0sDK8?=
 =?us-ascii?Q?oE6a0i9oukQ2hGumfkjz+hzxcycGd6MJfeDGCHvf8/SYFkbLv8Yyejd8woHD?=
 =?us-ascii?Q?a0mktkSL4mXpVL0iv6mGOMcov0PW0nsWs7ZZK8C9fiXU7y1z4WIHbX+QGQ4D?=
 =?us-ascii?Q?M0O7lWHmF8ZpCmFFdrNwgffeIOHFbtYyNG/oRZ61yB1q8iAp4kKFeNTdc8/C?=
 =?us-ascii?Q?WaHNFpN6/kA+jZsfUCzXtSBut5TQ2WY+fCTkMPJcv/x+4nvLAfEXrB3pfp1t?=
 =?us-ascii?Q?dssSPq/WbIKNjSiMCQklos3Tt8fvnk8XsEi3EDURa8YRDoWfaq/tuQrHmrgh?=
 =?us-ascii?Q?9wg6WCZ0AlLBhKSeSwK0TCeEx9MzT3Yuzx+4v/Iw3FSt3oRUlspe5gBDqyiC?=
 =?us-ascii?Q?+t+Aq3DWXCgeRSDAEnHWtd+8QI8NWSNgGE5qMLhxyRKWomqBLzPusbOyIjW+?=
 =?us-ascii?Q?a/hlJpLPcT5BGFs5ktdZCYseCX0k8k60W5L2vQt4xYoG9uzmxsCzgB7E9P9K?=
 =?us-ascii?Q?FKaEDqMIARgZlPlA5Qc07ipcQ3TbtTTAL2B6I8iJ/DlTkjINVZeuGICnEJyM?=
 =?us-ascii?Q?Jb0xFQV1wqwKFXtPCu/fES/Sv/DE05ogbDU+EYP+JyzRournUXaMSythN8sD?=
 =?us-ascii?Q?a6fQyCfi2Nn9uwcGziBR1Aso+A6RUL0gKimPwNsVqTpKU9en7Gh0mR+ae3m1?=
 =?us-ascii?Q?HFeKRjlXtc/WKTt/Ky1vMVDwy3y9Q71fJfxrSOsVwJxyvWacJrp9XSh235UQ?=
 =?us-ascii?Q?olJJoSxz2K0ao0zCJsx/kvlgUpqU9vokIwKya9C+8OKBXJoCe26HBCEs4AyF?=
 =?us-ascii?Q?gDU4Gw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6730d221-16b1-49a1-5079-08db5ec1d842
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 14:51:25.4250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WI0sfXbAsRecMoKAYIt9QKE/VhrBZI7A/CuO20x5BVFgle2DJ5/2lFJdNxzq+83iY+yvrtzWfykDI4tBI1281xqcjxe3EXNuGis2ejWpaVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4555
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, May 27, 2023 at 01:23:46PM +0200, Lorenzo Bianconi wrote:
> Make mt7921_mac_sta_poll static since it is run just in mac.c
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

