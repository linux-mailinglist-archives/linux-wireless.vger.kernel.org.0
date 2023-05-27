Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027D671353A
	for <lists+linux-wireless@lfdr.de>; Sat, 27 May 2023 16:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjE0O4G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 May 2023 10:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjE0O4F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 May 2023 10:56:05 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2131.outbound.protection.outlook.com [40.107.93.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46C6E1
        for <linux-wireless@vger.kernel.org>; Sat, 27 May 2023 07:56:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwPJFXip98XvO3eDjt2ThOs9nM+IeqohKC+pq/jxe61K/AbshrwdfgkiL36S73eEJLQct1qmcW0KvnsU5jMAhgt3UOKaLwhFyW8+Tj0yGF+Mo0YkJcM9CxDPpaBTfhAe/7aa+PcoBlCoFYg7CShOTcBqOfz2eGKUHXppV5ZG+WrPhR/70mISYYBB3qaGhRfimIyDbobB51yxA5n9d+eAkinjfuIwuvv26NsoDVm3HnyWtJtt1ya6mqFp+SnqOX1giSXWv7WNEhw1A5TsSOkg9xa/zvLFHedELWYbOdK6vH9/kIVZNyWT/v+V/79QCHLN1ooDMbzCdnlQwFrthOl9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCWclxxMC79Mnj3fknSWBk6zIoCFQOXdCRFiXgigmXc=;
 b=bsHlTVXulewbglFsUdwPbU6+NdQShakPLPX3LtR02ZpXTrL3dNRg+4yjyiN+TauLY73rNR05RvH+0/AJSvgiXkS6M5N0mDE2pw7S5cXA1JLZekcaU74LYncKRc46GpM2iLFwkwv4XUpgsOzW/xMFtPXjGbOsGlAPavccNALj5Mp+5yYIdLGBXlACHCSA6j8ER6UC1+5u40PBCUKeypUNaoPk8zySZkxIrDOQKBvueCs3qy5gp7rIogL6R+KLXMSXXWTUeUZzr36dcqPBJjojlKPTTQXLSEN47eiXQHPqFX++8lqB5Ncv1+MOCMMXuBk7CEiza3ZdwLkdKnCLT/hvQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCWclxxMC79Mnj3fknSWBk6zIoCFQOXdCRFiXgigmXc=;
 b=T3HocX+7dyuonP0JPSTZp3RfD2+YAlwahMiDdR21NX7OpM4tEKe23bzqIFnKOdxEluRiNqzUhH7vi2t0Ur0eKNyAMy/EHxFyc0bVk4yoNbOU2Vo/sq4w73/prBLb4458dl/ybRXUgGgs46WCUjld4Q/X73audl5wwfId0ZjjoBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH2PR13MB4555.namprd13.prod.outlook.com (2603:10b6:610:61::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Sat, 27 May
 2023 14:56:01 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::5e55:9a39:751f:55f6]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::5e55:9a39:751f:55f6%3]) with mapi id 15.20.6433.018; Sat, 27 May 2023
 14:56:01 +0000
Date:   Sat, 27 May 2023 16:55:54 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Juhee Kang <claudiajkang@gmail.com>
Cc:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, pkshih@realtek.com,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: Re: [PATCH wireless-next 1/2] wifi: rtlwifi: use helper function
 rtl_get_hdr()
Message-ID: <ZHIZ+rzyqwaPfqHu@corigine.com>
References: <20230527114954.3281-1-claudiajkang@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527114954.3281-1-claudiajkang@gmail.com>
X-ClientProxiedBy: AM0PR08CA0035.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::48) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH2PR13MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a6f45a5-35e6-487b-47d5-08db5ec27d02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a05d16JKpry6kiwHcfMbS6t/urv+xyNRNJZ4lVxkcjejlGcUjmfcaAnleUvguRAyqVp0eT3D0elx+VLe4YnlAKHNd+G8zlPKLPl+TtvOOYLOwsFLeYhMl+ONlAZXaZZgq6cYsWAGfPDFDGnFXQlAj7x4q7P4WxS66k9KuTuH0gnPbcv8rl4diQC5hQlfd8vvWfyqFYqGDiEW0xzyQu+uKzJv0vgwJR1bItRaIRYZqkHMLWtlgEgXdvVlptTfInyb1DerTjkuXXeSftjrFRje0YEyS+fE327/yLT/FojnXqB9CNiG0VumIm1wGmIbMouEDAXqjq0ZZEYk/tNQzLS5zkB9YjRX7TgPYxcmDRfyeH1n/FbV2jLFNLCUIZ1gRTsMAbQdKjp8vm/+Svt6ipiPBiatgXWHTZ9oEMljFbmPQj2jlrssxTZX/+AWPbJZ8GMwkjlr7T9+cFzN9heJgRUwFEiL5RT3XPV/qBTXHd8yNdpGWSz+LzMYY8+Tud6pZhpkMmy9qhxzRTxo4+yJAcKa9KUrkweUCKmSwaRDMWfbZoXn6pJdyAZMihASaKllv/12P4rEJzv7IfLd/8NmRreawqdqGdhzAjBayZbYI0x/GBY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(366004)(39830400003)(451199021)(186003)(86362001)(478600001)(2616005)(4744005)(2906002)(66476007)(66946007)(44832011)(36756003)(66556008)(4326008)(6916009)(6666004)(6512007)(316002)(6506007)(6486002)(5660300002)(8676002)(41300700001)(8936002)(38100700002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aiCW/GtZBGnrLJzICfbCQpipQSI4EzsRY+c5ahacimfUCltaL6Oyh6ONGJ5y?=
 =?us-ascii?Q?SCxPvL/oOF7S6TQGPotkP7ISO7DbyFMjc9wnz/UN5Kh1uT4aqATMFDjtVyjL?=
 =?us-ascii?Q?agSWzfZOucNKfhPeALmJ3wNjSX+gC0fcaBwF3lmvGefhmyCwqy3LPH4XWAxW?=
 =?us-ascii?Q?d1XnfEiBZMhGC1a0tGs0HR0GTPly88aybIFDoG90E/y26CWspgD9qy18dMa5?=
 =?us-ascii?Q?jYuw3gjqCCeaLceSAkSQjCpv+XKQjwTghIT9fgXyBkoa6bHvi6lDAKNWB8x2?=
 =?us-ascii?Q?RY192q8VuuKVcMtaFdbr9uzEV1aPAZZ2fKt2ugodUXva9MpGUwIP0K9DIFmo?=
 =?us-ascii?Q?YfLCI7lPYsxk0MRi3iTmbtXcbS3RPnZEVLAv+WLVE8aPaHXdEsPfdAR2aQj5?=
 =?us-ascii?Q?3AMfCFtD5WyO7gDio7X6F2GynBZcvp92mGHhJfNYHX5mvFtmSQDD3S3+ukAy?=
 =?us-ascii?Q?YDHE7KT2Cffj7IK5pnd0pA3MIHaYD9/ja2ztuoumhGfAfdF5Bx7M9+grNZ4v?=
 =?us-ascii?Q?z6jFKnYInsshDXExuPwSF6NDWV9td8n0TCLThWlX/iSBld/3z0l42pJeGlg1?=
 =?us-ascii?Q?E7wWfucd7PSIR8ITimquDcRMEsxvzUq7WGH/YUT8zFY/209IC9L63P1SUvy8?=
 =?us-ascii?Q?Fb16tYhB+cVe8Um495xAYc3keXABckMbwzUeAoBPwiMGNF4pkciyRZMTpAmj?=
 =?us-ascii?Q?cb+NR3hyIu2APGVHQGsdWsxOGfpxqdN5WVgdYsu5fEgwYdG+i6RebfEFHELF?=
 =?us-ascii?Q?UTURTl92v10jEG/SG7j2K/IWO0cnKRagyPedrokG3tyDArGdtoAGDqda8SLY?=
 =?us-ascii?Q?sUMBtmZIWk10EzAjZSDyaEc7hAfJwYF6Gn17+LSDcVa4RXgFi5MDVGdHS1lH?=
 =?us-ascii?Q?SbD6da1FobkvqeFCnHmZ8Eqy1FBng5Gvv2iHm2us9KfWhIe+kkBkqqOR7meC?=
 =?us-ascii?Q?FNa+R5wjj5JBE7YPGs85WIiSnwUL9jSM7OfovIVCmd9Va/BnC7FCCpNs4oHQ?=
 =?us-ascii?Q?sa3kq1ufwuAUndRg6HOd+UJ68BWgswiOz3RBPrcYhdQR1N2NpWasr5qb+iOK?=
 =?us-ascii?Q?wiKFGT8pywTCKdPVPpMFq4ZA/HnietOcPw4nBvCpR7v34s+/QK38s8Zle4or?=
 =?us-ascii?Q?3WV1WFb7vfa5TX2hXHpmHMJfUSat4gSazpI1qFXkb1QtCvVzIrR2RHTWXpBu?=
 =?us-ascii?Q?qT8KMNM5TerkMKw6RMzgFxlOLZUHnazvtMjpUozbTl2ti75v7Xotel4WxJQY?=
 =?us-ascii?Q?Ug9rinDpCgK3QsORF5HG0JdPTiQP36U/uYXUgIEhlHhBC3+BEuo9bFRPevBq?=
 =?us-ascii?Q?an1JAngVd+2ghIbHRQAjLOqslmiIh7zk9iVMDkY/KhdJQMEQvIgHWSmbSxZ7?=
 =?us-ascii?Q?3r54X+4U3lrZzX8Bu8wZhn3hT75WZxbes7TvKfb0099Xgq2yH249tp3487se?=
 =?us-ascii?Q?qCuAMgBm4mPyqotJPVrNo5ytnoRM+grpEpXNvo8QyqLJVehhiJkIl02ROkmH?=
 =?us-ascii?Q?oyj8pL3YC6LzbOMAMb9IBAGvb0+3lX4b+82SgRzJRwvfndSqxRx2wYtQ8jVO?=
 =?us-ascii?Q?vtZ83jw+u7UkcT0dcQ+7jdjT59OFeCDE44OmH7DMEB2TrqB9H644JUvs6foY?=
 =?us-ascii?Q?iJ9MBfFmpp5kOy3c287yS3hpRBcZJtCPg7i+hysIOM2qKVWQQNIWnox2RxAN?=
 =?us-ascii?Q?b8Z+/g=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6f45a5-35e6-487b-47d5-08db5ec27d02
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 14:56:01.7936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QPT9hCTkKffsdKW13Fu5DDGttrDVXnjVEvs51qUpzMFENF7Q860IpHBgWV/b05ObGUBJWfN3FfpVVpyXBILXAQAmR1NEibQjoklV8cCsNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4555
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, May 27, 2023 at 08:49:53PM +0900, Juhee Kang wrote:
> Although rtl_get_hdr was added in commit 3dad618b7b92 ("rtlwifi: Change
> wifi.h for rtl8192se and rtl8192de"), it is currently not being utilized
> in some areas. This commit replaces the open code with the rtl_get_hdr()
> function.
> 
> Signed-off-by: Juhee Kang <claudiajkang@gmail.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

